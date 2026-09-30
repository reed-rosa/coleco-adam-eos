param(
    [string]$ReferenceRom = '',
    [string]$Z80Asm = ''
)

$ErrorActionPreference = 'Stop'
$expectedBankMd5 = '01df3140909f09aa9aac4f88890f676c'
$expectedU22Md5 = 'cf10b154f2e006a9740d7653cfc47cab'
$expectedAssembler = 'Z80 Macro Assembler 23854-4d530b6eb7-20251002'
$expectedAssemblerSha256 = '8b923061aae40d210c038e991ed5f4b88ff4291e282a823eae469c7764ff1558'

if ([string]::IsNullOrWhiteSpace($ReferenceRom)) {
    $ReferenceRom = Join-Path $PSScriptRoot 'rom_reference\eos 6 rev 57 08dd.u22'
}
if ([string]::IsNullOrWhiteSpace($Z80Asm)) {
    if (-not [string]::IsNullOrWhiteSpace($env:Z80ASM)) {
        $Z80Asm = $env:Z80ASM
    } elseif (Get-Command z80asm.exe -ErrorAction SilentlyContinue) {
        $Z80Asm = (Get-Command z80asm.exe).Source
    } else {
        $Z80Asm = 'C:\z88dk\bin\z80asm.exe'
    }
}
if (-not (Test-Path -LiteralPath $Z80Asm -PathType Leaf)) {
    throw "z80asm not found. Pass -Z80Asm or set the Z80ASM environment variable: $Z80Asm"
}
if (-not (Test-Path -LiteralPath $ReferenceRom -PathType Leaf)) {
    throw "Reference U22 is required for byte verification and bank-2 preservation: $ReferenceRom"
}

$assemblerVersion = ((& $Z80Asm -h 2>&1 | Select-Object -First 1) -as [string]).Trim()
if ($assemblerVersion -ne $expectedAssembler) {
    throw "Assembler version mismatch. Expected '$expectedAssembler'; got '$assemblerVersion'."
}
$assemblerSha256 = (Get-FileHash -Algorithm SHA256 -LiteralPath $Z80Asm).Hash.ToLowerInvariant()
if ($assemblerSha256 -ne $expectedAssemblerSha256) {
    throw "Assembler executable SHA256 mismatch: $assemblerSha256"
}

$src = Join-Path $PSScriptRoot 'EOS_6_ASSEMBLEABLE_SOURCE.asm'
$symbolsManifest = Join-Path $PSScriptRoot 'EOS_6_EXPECTED_SYMBOLS.json'
$bankOut = Join-Path $PSScriptRoot 'EOS_6_ASSEMBLEABLE_SOURCE.bin'
$u22Out = Join-Path $PSScriptRoot 'EOS_6_ASSEMBLEABLE_SOURCE.u22'
$listingOut = Join-Path $PSScriptRoot 'EOS_6_ASSEMBLEABLE_SOURCE.lis'
$addressListingOut = Join-Path $PSScriptRoot 'EOS_6_ASSEMBLEABLE_SOURCE.address.lst'
$mapOut = Join-Path $PSScriptRoot 'EOS_6_ASSEMBLEABLE_SOURCE.map'
$symbolReportOut = Join-Path $PSScriptRoot 'EOS_6_SYMBOL_VERIFICATION.md'
$verificationOut = Join-Path $PSScriptRoot 'EOS_6_VERIFICATION_RESULTS.md'
foreach ($required in @($src, $symbolsManifest)) {
    if (-not (Test-Path -LiteralPath $required -PathType Leaf)) { throw "Missing build input: $required" }
}

$work = Join-Path ([IO.Path]::GetTempPath()) ('eos6-preservation-' + [guid]::NewGuid().ToString('N'))
[IO.Directory]::CreateDirectory($work) | Out-Null
try {
    $tempSrc = Join-Path $work 'EOS_6_ASSEMBLEABLE_SOURCE.asm'
    Copy-Item -LiteralPath $src -Destination $tempSrc
    $prefix = Join-Path $work 'eos6_sections.bin'
    & $Z80Asm -b -split-bin -f255 -l -m -s "-o$prefix" $tempSrc
    if ($LASTEXITCODE -ne 0) { throw "z80asm failed with exit code $LASTEXITCODE" }

    $sections = @(
        @{ Name = 'code';         Start = 0xE000; Size = 0x1BFE },
        @{ Name = 'global_table'; Start = 0xFBFF; Size = 0x0031 },
        @{ Name = 'jump_table';   Start = 0xFC30; Size = 0x012F },
        @{ Name = 'global_ram';   Start = 0xFD60; Size = 0x0147 },
        @{ Name = 'pcb_dcb';      Start = 0xFEC0; Size = 0x0140 }
    )
    $bank = [byte[]]::new(8192)
    [Array]::Fill($bank, [byte]0xFF)
    $occupied = [bool[]]::new(8192)
    foreach ($section in $sections) {
        $sectionPath = Join-Path $work ('eos6_sections_' + $section.Name + '.bin')
        if (-not (Test-Path -LiteralPath $sectionPath -PathType Leaf)) { throw "Missing assembler section: $sectionPath" }
        $bytes = [IO.File]::ReadAllBytes($sectionPath)
        if ($bytes.Length -ne $section.Size) {
            throw ("Section {0} size changed: expected {1}, got {2}" -f $section.Name,$section.Size,$bytes.Length)
        }
        $offset = $section.Start - 0xE000
        if ($offset -lt 0 -or ($offset + $bytes.Length) -gt $bank.Length) { throw "Section outside EOS bank: $($section.Name)" }
        for ($i = 0; $i -lt $bytes.Length; $i++) {
            if ($occupied[$offset + $i]) { throw "Overlapping section byte at EOS offset $($offset + $i)" }
            $occupied[$offset + $i] = $true
        }
        [Array]::Copy($bytes, 0, $bank, $offset, $bytes.Length)
    }
    [IO.File]::WriteAllBytes($bankOut, $bank)

    $tempListing = Join-Path $work 'EOS_6_ASSEMBLEABLE_SOURCE.lis'
    $tempMap = Join-Path $work 'eos6_sections.map'
    $workForward = $work.Replace('\', '/')
    $listingText = [IO.File]::ReadAllText($tempListing).Replace($work, '.').Replace($workForward, '.')
    $mapText = [IO.File]::ReadAllText($tempMap).Replace($work, '.').Replace($workForward, '.')
    [IO.File]::WriteAllText($listingOut, $listingText, [Text.Encoding]::ASCII)
    [IO.File]::WriteAllText($mapOut, $mapText, [Text.Encoding]::ASCII)

    $sectionBases = @{
        jump_table = 0xFC30
        global_ram = 0xFD60
        pcb_dcb = 0xFEC0
        global_table = 0xFBFF
        code = 0xE000
    }
    $currentBase = 0
    $absoluteListing = [Collections.Generic.List[string]]::new()
    $absoluteListing.Add('; Absolute-address view of the z80asm listing.')
    $absoluteListing.Add('; Section offsets are rebased and displayed byte fields are replaced from the final verified EOS bank.')
    foreach ($rawListingLine in Get-Content -LiteralPath $tempListing) {
        $line = $rawListingLine.Replace($work, '.').Replace($workForward, '.')
        if ($line -match '\bSECTION\s+(jump_table|global_ram|pcb_dcb|global_table|code)\s*$') {
            $currentBase = $sectionBases[$Matches[1]]
        }
        if ($currentBase -ne 0 -and $line -match '^(\s*\d+\s+)([0-9A-Fa-f]{4})(\s+)([0-9A-Fa-f]+)(\s+.*)$') {
            $prefixText = $Matches[1]
            $absolute = $currentBase + [Convert]::ToInt32($Matches[2], 16)
            $spacing = $Matches[3]
            $listedBytes = $Matches[4]
            $suffixText = $Matches[5]
            $byteCount = [int]($listedBytes.Length / 2)
            $romOffset = $absolute - 0xE000
            if (($listedBytes.Length % 2) -ne 0 -or $romOffset -lt 0 -or ($romOffset + $byteCount) -gt $bank.Length) {
                throw "Cannot rebase assembler listing line: $line"
            }
            $linkedBytes = -join (0..($byteCount - 1) | ForEach-Object { '{0:x2}' -f $bank[$romOffset + $_] })
            $line = $prefixText + ('{0:X4}' -f $absolute) + $spacing + $linkedBytes + $suffixText
        } elseif ($currentBase -ne 0 -and $line -match '^(\s*\d+\s+)([0-9A-Fa-f]{4})(\s+.*)$') {
            $absolute = $currentBase + [Convert]::ToInt32($Matches[2], 16)
            $line = $Matches[1] + ('{0:X4}' -f $absolute) + $Matches[3]
        }
        $absoluteListing.Add($line)
    }
    [IO.File]::WriteAllLines($addressListingOut, $absoluteListing, [Text.Encoding]::ASCII)

    $mapSymbols = @{}
    foreach ($line in Get-Content -LiteralPath $tempMap) {
        if ($line -match '^([A-Za-z_][A-Za-z0-9_]*)\s+= \$([0-9A-Fa-f]+)') {
            $mapSymbols[$Matches[1]] = [Convert]::ToInt32($Matches[2], 16)
        }
    }
    function Assert-Symbol([string]$Name, [int]$Expected) {
        if (-not $mapSymbols.ContainsKey($Name)) { throw "Expected symbol absent from map: $Name" }
        if ($mapSymbols[$Name] -ne $Expected) {
            throw ('Symbol {0}: expected ${1:X4}, got ${2:X4}' -f $Name,$Expected,$mapSymbols[$Name])
        }
    }
    function Convert-Hex([string]$Text) { return [Convert]::ToInt32($Text.Substring(2), 16) }

    $manifest = Get-Content -Raw -LiteralPath $symbolsManifest | ConvertFrom-Json
    $jumpStart = Convert-Hex $manifest.jump_table.start
    $jumpRows = [Collections.Generic.List[string]]::new()
    $ramRows = [Collections.Generic.List[string]]::new()
    $tableRows = [Collections.Generic.List[string]]::new()
    $jumpCount = 0
    foreach ($name in $manifest.jump_table.entries) {
        $expected = $jumpStart + ($jumpCount * [int]$manifest.jump_table.stride)
        Assert-Symbol $name $expected
        $jumpRows.Add(('| `{0}` | `${1:X4}` | `${2:X4}` | PASS |' -f $name,$expected,$mapSymbols[$name]))
        $jumpCount++
    }
    $ramCount = 0
    foreach ($property in $manifest.ram.PSObject.Properties) {
        $expected = Convert-Hex $property.Value
        Assert-Symbol $property.Name $expected
        $ramRows.Add(('| `{0}` | `${1:X4}` | `${2:X4}` | PASS |' -f $property.Name,$expected,$mapSymbols[$property.Name]))
        $ramCount++
    }
    $tableCount = 0
    foreach ($property in $manifest.tables.PSObject.Properties) {
        $expected = Convert-Hex $property.Value
        Assert-Symbol $property.Name $expected
        $tableRows.Add(('| `{0}` | `${1:X4}` | `${2:X4}` | PASS |' -f $property.Name,$expected,$mapSymbols[$property.Name]))
        $tableCount++
    }

    $referenceBytes = [IO.File]::ReadAllBytes($ReferenceRom)
    if ($referenceBytes.Length -ne 16384) { throw "Unexpected reference U22 size: $($referenceBytes.Length)" }
    $referenceMd5 = (Get-FileHash -Algorithm MD5 -LiteralPath $ReferenceRom).Hash.ToLowerInvariant()
    if ($referenceMd5 -ne $expectedU22Md5) { throw "Reference U22 MD5 mismatch: $referenceMd5" }
    for ($i = 0; $i -lt 8192; $i++) {
        if ($bank[$i] -ne $referenceBytes[$i]) {
            throw ('EOS bank mismatch at offset {0:X4}: built {1:X2}, reference {2:X2}' -f $i,$bank[$i],$referenceBytes[$i])
        }
    }
    $bankMd5 = (Get-FileHash -Algorithm MD5 -LiteralPath $bankOut).Hash.ToLowerInvariant()
    if ($bank.Length -ne 8192 -or $bankMd5 -ne $expectedBankMd5) { throw "EOS bank verification failed: size $($bank.Length), MD5 $bankMd5" }

    $u22 = [byte[]]::new(16384)
    [Array]::Copy($bank, 0, $u22, 0, 8192)
    # The alternate second bank is not reconstructed by this project.
    [Array]::Copy($referenceBytes, 8192, $u22, 8192, 8192)
    [IO.File]::WriteAllBytes($u22Out, $u22)
    $u22Md5 = (Get-FileHash -Algorithm MD5 -LiteralPath $u22Out).Hash.ToLowerInvariant()
    if ($u22.Length -ne 16384 -or $u22Md5 -ne $expectedU22Md5) { throw "Packaged U22 verification failed: size $($u22.Length), MD5 $u22Md5" }
    for ($i = 0; $i -lt 16384; $i++) {
        if ($u22[$i] -ne $referenceBytes[$i]) { throw ('Complete U22 mismatch at offset {0:X4}' -f $i) }
    }

    $symbolReport = [Collections.Generic.List[string]]::new()
    @(
        '# EOS 6 Symbol Verification',
        '',
        '- Expected values: `EOS_6_EXPECTED_SYMBOLS.json`, transcribed independently from the surviving listing.',
        '- Provenance: `EOS_6_EXPECTED_SYMBOLS_SOURCES.md`.',
        '- Actual values: freshly generated `EOS_6_ASSEMBLEABLE_SOURCE.map`.',
        "- Public jump-table entries: $jumpCount/$jumpCount matched (FC30-FD5C, stride 3).",
        "- RAM/PCB definitions: $ramCount/$ramCount matched.",
        "- Common configuration-table symbols: $tableCount/$tableCount matched.",
        '- `_START_RD_CH_DEV`: `$FCA5`.',
        '- `MEM_CNFGOO` / `SWITCH_TABLE`: `$FC17`.',
        '- `MEM_CNFGOB`: `$FC22`.',
        '- `TEMP_STACK` / `PTR_TO_LST_OF_SND_ADDRS`: intentional alias at `$FE6E`.',
        '- `DEFAULT_BT_DEV` / `CURRENT_DEV`: intentional alias at `$FD6F`.',
        '- `BLK_STRT_PTR` / `VOL_BLK_SZ`: intentional alias at `$FDDC`.',
        '- `VRAM_ADDR_TABLE` / `SPRITEATTRTBL`: intentional alias at `$FD64`.',
        '',
        '## Public jump table',
        '',
        'Source: OCR lines 122-333; fixed three-byte entries beginning at `$FC30`.',
        '',
        '| Symbol | Expected | Actual | Result |',
        '|---|---:|---:|---|'
    ) | ForEach-Object { $symbolReport.Add($_) }
    foreach ($row in $jumpRows) { $symbolReport.Add($row) }
    @(
        '',
        '## RAM and PCB/DCB definitions',
        '',
        'Source: OCR lines 428-683, including printed addresses and allocation sizes.',
        '',
        '| Symbol | Expected | Actual | Result |',
        '|---|---:|---:|---|'
    ) | ForEach-Object { $symbolReport.Add($_) }
    foreach ($row in $ramRows) { $symbolReport.Add($row) }
    @(
        '',
        '## Common configuration table',
        '',
        'Source: active OCR definitions at lines 768-816.',
        '',
        '| Symbol | Expected | Actual | Result |',
        '|---|---:|---:|---|'
    ) | ForEach-Object { $symbolReport.Add($_) }
    foreach ($row in $tableRows) { $symbolReport.Add($row) }
    @(
        '',
        'See `EOS_6_ASSEMBLEABLE_SOURCE.map` for the complete absolute symbol map, `EOS_6_ASSEMBLEABLE_SOURCE.lis` for raw assembler output, and `EOS_6_ASSEMBLEABLE_SOURCE.address.lst` for the rebased/final-byte listing.'
    ) | ForEach-Object { $symbolReport.Add($_) }
    [IO.File]::WriteAllLines($symbolReportOut, $symbolReport, [Text.Encoding]::ASCII)

    $verification = @(
        '# EOS 6 Build Verification Results',
        '',
        "- Assembler: $assemblerVersion",
        "- Assembler executable SHA256: $assemblerSha256",
        '- Build isolation: fresh unique temporary directory; no prior binary/object/listing consumed.',
        '- Diagnostic path normalization: temporary-directory names removed from listing and map outputs.',
        '- Generated section sizes: code 7166, global table 49, jump table 303, global RAM 327, PCB/DCB 320 bytes.',
        "- EOS bank: 8192 bytes; MD5 $bankMd5; reference differences: 0.",
        "- Complete U22: 16384 bytes; MD5 $u22Md5; reference differences: 0.",
        "- Symbols: $jumpCount public jump entries, $ramCount RAM/PCB symbols, and $tableCount table symbols matched the independent manifest.",
        '- Second 8K bank: copied unchanged from the verified reference U22; it is not reconstructed from the EOS OCR listing.',
        '',
        'Result: PASS'
    )
    [IO.File]::WriteAllLines($verificationOut, $verification, [Text.Encoding]::ASCII)

    Write-Host "EOS bank: 8192 bytes, MD5 $bankMd5, exact first-bank match"
    Write-Host "Complete U22: 16384 bytes, MD5 $u22Md5, exact full-ROM match"
    Write-Host "Symbols: $jumpCount jump, $ramCount RAM/PCB, $tableCount table entries matched"
} finally {
    if (Test-Path -LiteralPath $work) { Remove-Item -LiteralPath $work -Recurse -Force }
}
