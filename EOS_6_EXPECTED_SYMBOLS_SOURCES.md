# Expected-Symbol Manifest Sources

`EOS_6_EXPECTED_SYMBOLS.json` is an independent expectation set. Its expected addresses are not extracted from the generated symbol map and are not inferred merely because the assembled ROM matches.

## Primary listing evidence

- `EOS_6_ABSOLUTE_LISTING_OCR.txt` is the primary surviving-listing evidence. Its printed source-line, address, opcode, value, label, and allocation columns supply the expected addresses.
- Memory-segment bases come from OCR source lines 97-101: code `$E000`, global table `$FBFF`, jump table `$FC30`, global RAM `$FD60`, and PCB/DCB `$FEC0`.
- The 101 public jump-table names and order come from OCR source lines 122-333. Entries are three-byte `JP` slots beginning at `$FC30`, so the independent expected sequence ends at `$FD5C`.
- RAM and PCB/DCB definitions come from OCR source lines 428-683. Printed addresses and declared allocation sizes establish the expected locations, including coincident aliases.
- Common-table symbols come from OCR source lines 694-848. The active configuration table at OCR source lines 768-816 establishes `SWITCH_TABLE` and `MEM_CNFGxx` at `$FC17-$FC26`.
- `EOS_REBUILD/all_lines.txt` is the line-anchored working transcription used to preserve ordering and normalized spellings. It is traceable to the same listing, so it is a transcription aid rather than a second independent artifact.

The supplied OCR text does not retain reliable scan-page identifiers. Source-line references are therefore used; page numbers are not invented.

## Independent production evidence

- `rom_reference/eos 6 rev 57 08dd.u22`, 16,384 bytes, MD5 `cf10b154f2e006a9740d7653cfc47cab`, independently corroborates emitted jump-table bytes, jump targets, and instruction operands that reference RAM/common-table addresses.
- The ROM is corroboration, not the origin of unused or alias symbol expectations. Symbols such as `TEMP_STACK` cannot be validated solely by whole-ROM identity.

## Deliberately excluded derivations

Expected values were not copied from `EOS_6_ASSEMBLEABLE_SOURCE.map`, derived from `EOS_6_ASSEMBLEABLE_SOURCE.bin`, or accepted solely because the binary checksum matches. The build parses the generated map only as the actual-value side of an expected-versus-actual comparison against the checked-in JSON manifest.
