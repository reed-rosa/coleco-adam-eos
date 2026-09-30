# EOS 6 OCR Source Preservation Report

## Status and authority

`EOS_6_ASSEMBLEABLE_SOURCE.asm` is a generated, human-readable preservation artifact. It is not the canonical hand-edited input. The maintained inputs are `EOS_REBUILD/all_lines.txt` and the source-line-anchored correction rules in `EOS_REBUILD/build_clean_z88_source.py`. The raw OCR artifact `EOS_6_ABSOLUTE_LISTING_OCR.txt` remains the evidence source.

The OCR listing controls structure, labels, comments, and intent. The production ROM controls shipped bytes. The source contains normal Z80 instructions and genuine data declarations; executable regions are not replaced with `DEFB` byte rows. Original overlapping-instruction/data techniques remain intact.

The supplied OCR text has listing source-line numbers but no recoverable scan-page metadata. References below therefore give OCR source-line numbers; page is reported as unavailable rather than invented.

## Reconstruction corrections

Classification meanings: **OCR repair** restores text supported by the scan's value/address/opcode columns or by an active definition elsewhere in the scan. **Assembler-dialect conversion** changes notation or layout without changing intended bytes. **Listing/ROM difference** is reserved for a genuine or unresolved conflict between surviving source text and shipped bytes.

| OCR line (page) | Original transcription | Corrected source | ROM address / supporting bytes | Classification |
|---|---|---|---|---|
| 98 (page unavailable) | `EOS_GLB_TBL EQU 0F8FFH` | `EOS_GLB_TBL EQU 0FBFFH` | Scan value `<FBFF>` | OCR repair |
| 200 | `_START_RD_CH_DEV EQU $ [VERIFY]` | marker resolved; entry retained | `$FCA5`, sequential 3-byte jump table | OCR repair |
| 320-321 | `MSNTOILSN`, `__MSNTOILSN` | `MSNTOLSN`, `__MSNTOLSN` | Scan text and `$FD4A: C3 69 E3` | OCR repair |
| 361-364 | uncertainty over `MEM_CNFGOO` | confirmed two-letter-`O` spelling; definitions remain commented | Active symbol `$FC17`; OCR 770-771 | OCR repair |
| 385-386 | second commented `MEM_CNFGO8` | commented `MEM_CNFGOB` | Active OCR 803, `$FC22: 0B` | OCR repair |
| 613 | active `SAVED_COUNT DEFS 2` | retained as a comment | Scan line is commented; revision note says removed | OCR repair |
| 848 | `DEFB 08FH` | `DEFB 0BFH` | `$FC29: BF` | OCR repair |
| 1088 | `RD_IP_STAT_ERR` | `RQ_TP_STAT_ERR` | Scan definition `<0015> RQTP_STAT_ERR`; use at `$ED7B: 3E 15` | OCR repair |
| 1207 | `PR_NAK EQU 80H` | `PR_NAK EQU 86H` | Scan value `<0086>` | OCR repair |
| 1854 | `LD BC,(DEL-00H+1)` | `LD BC,DEL-00H+1` | `$E150: 01 00 80` | Assembler-dialect conversion |
| 1981 | `LD A,(01148H)` | `LD A,(0114BH)` | `$E1A8: 3A 4B 11` | OCR repair |
| 2209 (line omitted by OCR text) | no instruction | `DI` | address gap after `$E209`; `$E20A: F3` | OCR repair |
| 2238 | `LD D,A` | `LD A,L` | `$E233: 7D`; scan mnemonic agrees | OCR repair |
| 2349 | missing `NOT_CONTROLLER_0` label | label restored before second controller test | `$E27E: CB 49` | OCR repair |
| 2404 (line omitted by OCR text) | no instruction | `LD (IX+0),A` | gap `$E29A-$E29C`; bytes `DD 77 00` | OCR repair |
| 2998 | `SOUNDS` | `__SOUNDS` | OCR 902 exports `__SOUNDS`; implementation `$E406` | OCR repair |
| 3277 | `LD (IX+ATN),0FH` | `LD (IX+ATN),0F0H` | `$E512: DD 36 04 F0` | OCR repair |
| 3294 | active `RET` | historical `RET` retained commented | Scan line is commented; `$E530` begins `3E FF` | OCR repair |
| 3513, 3717, 3804, 3866, 3875 | `FOUND_AVAIL_ENTRY` references | `FOUND_AVAIL_ENT` | Active definition OCR 549 at `$FDDB`; operands use `DB FD` | OCR repair |
| 5675-5676 | duplicate `MODE_CHECK` text | coincident `__MODE_CHECK` and `MODE_CHECK` labels | implementation `$F0D8`; export requires double underscore | OCR repair |
| 5778 | active `LD A,RENAME_ERR` | historical instruction retained commented | Scan line is commented; `$F148: B7` | OCR repair |
| 5908, 5910 | `RETRY_FOR_ERROR` | `RETRY_FOR_ERRORS` | printed label OCR 5899 at `$F19F`; bytes `28 F5`, `10 F3` | OCR repair |
| 5944 | `JR Z,_2ND_READ_ERROR` | `JR Z,RETRY_LIMIT_REACHED` | `$F1D0: 28 03` targets `$F1D6`, not the printed symbol | Listing/ROM difference; cause uncertain |
| 6348 | `DIR_ENT_LENGTH+3+VOL_DES_LENGTH` | `DIR_ENT_LENGTH*3+VOL_DES_LENGTH` | `$F33A: 01 68 00`; scan expression agrees | OCR repair |
| 6392 | `VOL_DES_LENGTH+DIR_ENT_LENGTH+2` | `VOL_DES_LENGTH+DIR_ENT_LENGTH*2` | `$F36D: 11 4E 00`; scan expression agrees | OCR repair |
| 6505 | `ATTR_SYS` | `ATTR_SYSTEM` | active definition OCR 1051; `$F400: 88` | OCR repair |
| 7162 | `PRTR_DCB_ACTIVE1` | `PRTR_DCB_ACTIVE` | `$F58F: 20 C7` targets `$F558` | OCR repair |
| 7363 | `CLR_TO_EOS EQU 1BH` | `CLR_TO_EOS EQU 18H` | scan value `<0018>` | OCR repair |
| 7371 | `BLANKING_CHAR EQU "-"` | `BLANKING_CHAR EQU 020H` | scan value `<0020>` | OCR repair |
| 7510 | active `CALL ERASE_THIS_LINE` | historical call retained commented | Scan line is commented; `$F664: CD 07 F7` is `PUT_OLD_ON_SCREEN` | OCR repair |
| 7838 | `LD HL,LINEBUFFER` | `LD HL,LINEBUFFER_` | `$F7CD: 21 7E FE`; active RAM symbol OCR 654 | OCR repair |
| 8111-8112, 8152, 8218 | `MEM_CNFG01/03` | `MEM_CNFGO1/03` | active configuration symbols OCR 773/779 | OCR repair |
| 8130 | `_EOS_START` | `__EOS_START` | OCR 8129 exports double-underscore implementation at `$F832` | OCR repair |
| 8158, 8164, 8173, 8177, 8185, 8189, 8197, 8201 | calls through single-underscore names | direct double-underscore implementation calls | scan opcode operands: `$F8F6`, `$EEEA`, `$F473`, `$F446` | OCR repair |
| 8218-8219 | active configuration-3 switch | historical lines retained commented | Scan lines are commented; `$F8C2: C3 E7 FC` | OCR repair |
| 8231 | `CALL _RD_1_BLOCK` | `CALL __RD_1_BLOCK` | `$F8D7: CD 9E FA` | OCR repair |
| 8293 | active short clear count | historical line retained commented | Scan line is commented; `$F90D: 01 3F 01` is OCR 8294 | OCR repair |

## Systematic assembler conversions

- HP logical operators (`.OR.`, `.AND.`, `.NOT.`, `.NT.`) are converted to z88dk-z80asm syntax only in code fields; historical comments are untouched.
- HP bracketed memory operands become z80asm parenthesized operands. Bare labels gain colons. `GLB`, `EXT`, `NAME`, `SKIP`, and documentation-only macros are retained as comments because z80asm does not accept the original directives in this form.
- Six bit-index equates are emitted early because z80asm requires them before use; their historical definitions remain visible but commented as duplicate definitions.
- Five named sections preserve the OCR block order despite descending/non-contiguous `ORG` values. The build overlays linked section binaries at their declared absolute origins into an `$FF`-filled 8K bank.
- String literal quoting is converted to z80asm-compatible quoting. These conversions are notation/layout changes, not ROM-byte substitutions.

## Verification markers resolved

No `[VERIFY]` markers remain. `_START_RD_CH_DEV` is `$FCA5`. `MEM_CNFGOO` intentionally uses two letter `O` characters. The later commented `MEM_CNFGO8` was an OCR ambiguity for `MEM_CNFGOB`. The entire early common-definition block remains commented because the active `SWITCH_TABLE`/`MEM_CNFGxx` definitions are emitted later at OCR lines 768-816; activating the historical declarations would create duplicate symbols and would not better preserve the listing.

## Reproducibility

Required assembler: `Z80 Macro Assembler 23854-4d530b6eb7-20251002`; executable SHA256 `8b923061aae40d210c038e991ed5f4b88ff4291e282a823eae469c7764ff1558`. The build script accepts `-Z80Asm` or `Z80ASM` and rejects a different build. It assembles in a new temporary directory, checks fixed section bounds, constructs the EOS bank, verifies every byte, verifies public and RAM symbols from `EOS_6_EXPECTED_SYMBOLS.json`, and removes the temporary directory.

The reference input is `rom_reference/eos 6 rev 57 08dd.u22`, exactly 16,384 bytes, MD5 `cf10b154f2e006a9740d7653cfc47cab`. The source reconstructs only its first 8K EOS bank. The second 8K bank is copied unchanged from that verified reference ROM and is explicitly not reconstructed from this OCR listing.

Use `regenerate_eos_assembleable_source.ps1` to regenerate twice and prove deterministic output, then `build_eos_assembleable_source.ps1` to build and verify. Actual results are written to `EOS_6_VERIFICATION_RESULTS.md`; symbol results are written to `EOS_6_SYMBOL_VERIFICATION.md`.

## Remaining ambiguity

The only unresolved scan/source ambiguity affecting a source operand is OCR line 5944: the printed branch target appears to be `_2ND_READ_ERROR`, while the printed opcode `28 03` and production ROM target the local cleanup at `$F1D6`. The maintained source names that actual target `RETRY_LIMIT_REACHED` and classifies it as a listing-versus-ROM difference of uncertain cause, not as a proven OCR error.
