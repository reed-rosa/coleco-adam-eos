$ErrorActionPreference = 'Stop'
$generator = Join-Path $PSScriptRoot 'EOS_REBUILD\build_clean_z88_source.py'
$outputs = @(
    (Join-Path $PSScriptRoot 'EOS_6_ASSEMBLEABLE_SOURCE.asm'),
    (Join-Path $PSScriptRoot 'build_eos_assembleable_source.ps1'),
    (Join-Path $PSScriptRoot 'EOS_6_ASSEMBLEABLE_SOURCE_REPORT.md'),
    (Join-Path $PSScriptRoot 'EOS_6_EXPECTED_SYMBOLS.json'),
    (Join-Path $PSScriptRoot 'EOS_6_EXPECTED_SYMBOLS_SOURCES.md')
)
python $generator
if ($LASTEXITCODE -ne 0) { throw "Generator failed with exit code $LASTEXITCODE" }
$first = @($outputs | ForEach-Object { (Get-FileHash -Algorithm SHA256 -LiteralPath $_).Hash })
python $generator
if ($LASTEXITCODE -ne 0) { throw "Second deterministic generator pass failed with exit code $LASTEXITCODE" }
$second = @($outputs | ForEach-Object { (Get-FileHash -Algorithm SHA256 -LiteralPath $_).Hash })
for ($i = 0; $i -lt $outputs.Count; $i++) {
    if ($first[$i] -ne $second[$i]) { throw "Nondeterministic regeneration: $($outputs[$i])" }
}
Write-Host 'Regeneration deterministic: True'
