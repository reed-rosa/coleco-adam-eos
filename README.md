# Coleco ADAM EOS 6 Preservation Build

## Maintained source

`EOS_6_ASSEMBLEABLE_SOURCE.asm` is generated and should not be hand-edited. The maintained reconstruction consists of:

- `EOS_REBUILD/all_lines.txt`: line-anchored working transcription.
- `EOS_REBUILD/build_clean_z88_source.py`: deterministic converter and all scoped corrections.
- `EOS_6_ABSOLUTE_LISTING_OCR.txt`: raw OCR evidence used to classify corrections.

Run `regenerate_eos_assembleable_source.ps1` to regenerate twice and verify deterministic output. Corrections abort regeneration if their expected OCR source line or exact context changes.

The expected-symbol manifest's independent evidence trail is documented in `EOS_6_EXPECTED_SYMBOLS_SOURCES.md`. Expected values come from the surviving listing, with the production ROM used only as independent byte-level corroboration; generated map and binary files are not used to create the expectations.

The [independent comparison with Guy Cousineau's EOS Programmer's Manual](EOS_6_MANUAL_COMPARISON.md) checks all 89 vectors documented on manual pages 115-116, records the 12 omitted vectors, maps terminology differences, and keeps the unresolved original-print ambiguity at `FC4E` distinct from the verified `FB1B` ROM destination.

## Required tool and ROM input

Assembler: `Z80 Macro Assembler 23854-4d530b6eb7-20251002`

Assembler executable SHA256: `8b923061aae40d210c038e991ed5f4b88ff4291e282a823eae469c7764ff1558`

Regeneration requires Python 3.9 or later and was verified with Python 3.13.13. Build scripts require PowerShell and were verified with PowerShell 7.6.5.

The reference ROM is not included in the preservation package. Supply:

- Filename: `eos 6 rev 57 08dd.u22`
- Size: 16,384 bytes
- MD5: `cf10b154f2e006a9740d7653cfc47cab`

Place it at `rom_reference/eos 6 rev 57 08dd.u22`, or pass its path with `-ReferenceRom`. Pass the assembler with `-Z80Asm`, set `Z80ASM`, place it on `PATH`, or install the recorded build at `C:\z88dk\bin\z80asm.exe`.

## Build

```powershell
.\regenerate_eos_assembleable_source.ps1
.\build_eos_assembleable_source.ps1
```

Or with explicit inputs:

```powershell
.\build_eos_assembleable_source.ps1 `
  -ReferenceRom 'D:\path\eos 6 rev 57 08dd.u22' `
  -Z80Asm 'C:\z88dk\bin\z80asm.exe'
```

The build always assembles in a new temporary directory. It produces and verifies:

- `EOS_6_ASSEMBLEABLE_SOURCE.bin`: reconstructed 8K EOS bank, MD5 `01df3140909f09aa9aac4f88890f676c`.
- `EOS_6_ASSEMBLEABLE_SOURCE.u22`: complete 16K U22, MD5 `cf10b154f2e006a9740d7653cfc47cab`.
- `EOS_6_ASSEMBLEABLE_SOURCE.lis`: native z80asm listing.
- `EOS_6_ASSEMBLEABLE_SOURCE.address.lst`: listing with section offsets rebased to absolute ROM addresses.
- `EOS_6_ASSEMBLEABLE_SOURCE.map`: absolute linked symbol map.
- `EOS_6_EXPECTED_SYMBOLS.json`: independent expected-address manifest.
- `EOS_6_EXPECTED_SYMBOLS_SOURCES.md`: manifest construction sources and independence boundary.
- `EOS_6_SYMBOL_VERIFICATION.md`: complete expected-versus-actual results for all public jump-table, RAM/PCB, alias, and common-table checks.
- `EOS_6_MANUAL_COMPARISON.md`: independent 89-entry comparison with Guy Cousineau's EOS Programmer's Manual.
- `EOS_6_VERIFICATION_RESULTS.md`: actual size, checksum, byte-comparison, toolchain, and symbol results.
- `EOS_6_RELEASE_TEST_RESULTS.md`: clean extraction, regeneration, and build test procedure and results.

The release ZIP includes both the raw z80asm listing (`.lis`) and the processed absolute/final-byte listing (`.address.lst`), along with every maintained input, generator, build script, report, and reference-ROM requirement file. `RELEASE_SHA256SUMS.txt` records the contents independently of the ZIP container.

Only the first 8K bank is reconstructed from the EOS listing. The second 8K bank is copied unchanged from the checksum-verified reference U22. It is not reconstructed here.
