# EOS 6 Comparison with Guy Cousineau's EOS Programmer's Manual

## Summary

Guy Cousineau's *Elementary Operating System Programmer's Guide* independently documents 89 EOS 6 jump vectors. All 89 documented entry addresses correspond to the reconstructed jump table, and all 89 destinations agree with the production ROM after using the manual's decimal values to resolve two malformed hexadecimal transcriptions. The manual omits 12 entries that are present in Coleco's complete 101-entry table.

No EOS instruction or symbol was changed for this comparison. The comparison is documentation and independent corroboration only.

### Sources and page numbering

- Manual edition inspected: *ADAM E.O.S. Programmers Manual - Updated*, Eric Pearson re-typesetting of Guy Cousineau's manual, PDF pages 115-116. The older HTML edition labels the equivalent pages 90-91; both page numbers are shown below as `PDF [original]`.
- Manual table introduction: PDF page 115 [original page 90].
- Local text extraction: `i-have-two-macadam-artifacts-for/ADAM_EOS_PROGRAMMERS_MANUAL_extracted.txt`.
- Manual PDF used for visual inspection: `ADAM E.O.S. Programmers Manual - Updated (Eric Pearson).pdf`, 1,121,387 bytes, SHA256 `f939ff0ecd35d3f38489f8f9aae9857174924239af4bd638216d65a1fd35c214`.
- Reconstructed symbols and addresses: `EOS_6_ASSEMBLEABLE_SOURCE.map` and `EOS_6_ASSEMBLEABLE_SOURCE.address.lst`.
- Actual JP destinations: decoded independently from `EOS_6_ASSEMBLEABLE_SOURCE.bin`, whose bytes match the reference EOS bank.

The entry-address column below is normalized to hexadecimal using the accompanying decimal address and the fixed three-byte table stride. This avoids propagating visible transcription substitutions such as `O` for `0`, `G` for `C`, and `l` for `1`. The manual destination column preserves consequential hexadecimal text and notes decimal resolution where needed.

## Documented entries

| Manual page | Manual name | Entry | Manual JP destination | Reconstructed symbol | Actual destination | Result |
|---|---|---:|---:|---|---:|---|
| 115 [90] | initialize EOS | `FC30` | `F832` | `_EOS_START` | `F832` | PASS |
| 115 [90] | console display (no special characters) | `FC33` | `F627` | `_CONS_DISP` | `F627` | PASS |
| 115 [90] | console initialization | `FC36` | `F5DG` / decimal 62940 = `F5DC` | `_CONS_INIT` | `F5DC` | PASS using decimal; invalid hex transcription |
| 115 [90] | display character on screen (process specials) | `FC39` | `F60A` | `_CONS_OUT` | `F60A` | PASS |
| 115 [90] | delay after hard reset | `FC3C` | `F95F` | `_DLY_AFT_HRD_RES` | `F95F` | PASS |
| 115 [90] | end print buffer | `FC3F` | `F5B8` | `_END_PR_BUFF` | `F5B8` | PASS |
| 115 [90] | end print character | `FC42` | `F57C` | `_END_PR_CH` | `F57C` | PASS |
| 115 [90] | end read one block | `FC45` | `FAE2` | `_END_RD_1_BLOCK` | `FAE2` | PASS |
| 115 [90] | end read printer | `FC48` | `FBA5` | `_END_RD_CH_DEV` | `FBA5` | PASS |
| 115 [90] | end read keyboard | `FC4B` | `F4E0` | `_END_RD_KBD` | `F4E0` | PASS |
| 115 [90] | end write one block | `FC4E` | `FB13` / decimal 64283 = `FB1B` | `_END_WR_1_BLOCK` | `FB1B` | DESTINATION PASS; original printed hex unresolved |
| 115 [90] | end write printer buffer | `FC51` | `FBE1` | `_END_WR_CH_DEV` | `FBE1` | PASS |
| 115 [90] | find DCB | `FC54` | `F446` | `_FIND_DCB` | `F446` | PASS |
| 115 [90] | get PCB address | `FC5A` | `FA4C` | `_GET_PCB_ADDR` | `FA4C` | PASS |
| 115 [90] | hard INIT | `FC5D` | `F8F6` | `_HARD_INIT` | `F8F6` | PASS |
| 115 [90] | hard reset net | `FC60` | `F94B` | `_HARD_RESET_NET` | `F94B` | PASS |
| 115 [90] | print buffer | `FC63` | `F515` | `_PR_BUFF` | `F515` | PASS |
| 115 [90] | print character | `FC66` | `F4FC` | `_PR_CH` | `F4FC` | PASS |
| 115 [90] | read one block | `FC69` | `FA9E` | `_RD_1_BLOCK` | `FA9E` | PASS |
| 115 [90] | read keyboard | `FC6C` | `F4BA` | `_RD_KBD` | `F4BA` | PASS |
| 115 [90] | read device-return code | `FC75` | `FA87` | `_RD_RET_CODE` | `FA87` | PASS |
| 115 [90] | relocate PCB | `FC7B` | `FA2F` | `_RELOC_PCB` | `FA2F` | PASS |
| 115 [90] | request status | `FC7E` | `F473` | `_REQUEST_STATUS` | `F473` | PASS |
| 115 [90] | keyboard status | `FC81` | `F4CB` | `_REQ_KBD_STAT` | `F4CB` | PASS |
| 115 [90] | printer status | `FC84` | `F5D2` | `_REQ_PR_STAT` | `F5D2` | PASS |
| 115 [90] | scan net for devices | `FC8A` | `F9CB` | `_SCAN_ACTIVE` | `F9CB` | PASS |
| 115 [90] | soft initialization | `FC8D` | `F922` | `_SOFT_INIT` | `F922` | PASS |
| 115 [90] | soft reset device | `FC90` | `FA5D` | `_SOFT_RES_DEV` | `FA5D` | PASS |
| 115 [90] | soft reset keyboard | `FC93` | `FA51` | `_SOFT_RES_KBD` | `FA51` | PASS |
| 115 [90] | soft reset printer | `FC96` | `FA55` | `_SOFT_RES_PR` | `FA55` | PASS |
| 115 [90] | start print buffer | `FC9C` | `F580` | `_START_PR_BUFF` | `F580` | PASS |
| 115 [90] | start print character | `FC9F` | `F56D` | `_START_PR_CH` | `F56D` | PASS |
| 115 [90] | start read one block | `FCA2` | `FAC6` | `_START_RD_1_BLOCK` | `FAC6` | PASS |
| 115 [90] | start read printer | `FCA5` | `FB86` | `_START_RD_CH_DEV` | `FB86` | PASS |
| 115 [90] | start read keyboard | `FCA8` | `F4D0` | `_START_RD_KBD` | `F4D0` | PASS |
| 115 [90] | start write 1 block | `FCAB` | `FAFF` | `_START_WR_1_BLOCK` | `FAFF` | PASS |
| 115 [90] | start write printer | `FCAE` | `FBC2` | `_START_WR_CH_DEV` | `FBC2` | PASS |
| 115 [90] | synchronize clocks | `FCB1` | `F970` | `_SYNC` | `F970` | PASS |
| 115 [90] | write 1 block | `FCB4` | `FAB2` | `_WR_1_BLOCK` | `FAB2` | PASS |
| 115 [90] | write printer | `FCB7` | `FB75` | `_WR_CH_DEV` | `FB75` | PASS |
| 116 [91] | initialize file manager | `FCBA` | `EEEA` | `_FMGR_INIT` | `EEEA` | PASS |
| 116 [91] | initialize directory | `FCBD` | `F323` | `_INIT_TAPE_DIR` | `F323` | PASS |
| 116 [91] | open file | `FCC0` | `EA00` | `_OPEN_FILE` | `EA00` | PASS |
| 116 [91] | close file | `FCC3` | `EB04` | `_CLOSE_FILE` | `EB04` | PASS |
| 116 [91] | reset file | `FCC6` | `EB6C` | `_RESET_FILE` | `EB6C` | PASS |
| 116 [91] | make file | `FCC9` | `E690` | `_MAKE_FILE` | `E690` | PASS |
| 116 [91] | find file 1 | `FCCC` | `E61B` | `_QUERY_FILE` | `E61B` | PASS |
| 116 [91] | update file in directory | `FCCF` | `E651` | `_SET_FILE` | `E651` | PASS |
| 116 [91] | read file | `FCD2` | `EC17` | `_READ_FILE` | `EC17` | PASS |
| 116 [91] | write file | `FCD5` | `ED8F` | `_WRITE_FILE` | `ED8F` | PASS |
| 116 [91] | put date | `FCD8` | `EEC5` | `_SET_DATE` | `EEC5` | PASS |
| 116 [91] | get date | `FCDB` | `EED4` | `_GET_DATE` | `EED4` | PASS |
| 116 [91] | rename file | `FCDE` | `F10F` | `_RENAME_FILE` | `F10F` | PASS |
| 116 [91] | delete file | `FCE1` | `F14E` | `_DELETE_FILE` | `F14E` | PASS |
| 116 [91] | get device status | `FCE4` | `F488` | `_RD_DEV_DEP_STAT` | `F488` | PASS |
| 116 [91] | exit to WP | `FCE7` | `FA94` | `_GOTO_WP` | `FA94` | PASS |
| 116 [91] | trim file | `FCED` | `F241` | `_TRIM_FILE` | `F241` | PASS |
| 116 [91] | find file in FCB | `FCF0` | `F089` | `_CHECK_FCB` | `F089` | PASS |
| 116 [91] | read block | `FCF3` | `F17B` | `_READ_BLOCK` | `F17B` | PASS |
| 116 [91] | write block | `FCF6` | `F1E6` | `_WRITE_BLOCK` | `F1E6` | PASS |
| 116 [91] | mode check | `FCF9` | `F0D9` | `_MODE_CHECK` | `F0D9` | PASS |
| 116 [91] | look up file in directory | `FCFC` | `EF0B` | `_SCAN_FOR_FILE` | `EF0B` | PASS |
| 116 [91] | find file 2 | `FCFF` | `E618` | `_FILE_QUERY` | `E618` | PASS |
| 116 [91] | set VDP port data | `FD11` | `E191` | `PORT_COLLECTION` | `E191` | PASS |
| 116 [91] | switch memory banks | `FD14` | `E185` | `SWITCH_MEM` | `E185` | PASS |
| 116 [91] | put ASC in VDP | `FD17` | `E153` | `PUT_ASCII` | `E153` | PASS |
| 116 [91] | write VRAM | `FD1A` | `E000` | `WRITE_VRAM` | `E000` | PASS |
| 116 [91] | read VRAM | `FD1D` | `E01A` | `READ_VRAM` | `E01A` | PASS |
| 116 [91] | write VDP register | `FD20` | `E034` | `WRITE_REGISTER` | `E034` | PASS |
| 116 [91] | read VDP register | `FD23` | `E04F` | `READ_REGISTER` | `E04F` | PASS |
| 116 [91] | fill VRAM | `FD26` | `E059` | `FILL_VRAM` | `E059` | PASS |
| 116 [91] | initialize VRAM tables | `FD29` | `E066` | `INIT_TABLE` | `E066` | PASS |
| 116 [91] | put VRAM | `FD2C` | `E0C9` | `PUT_VRAM` | `E0C9` | PASS |
| 116 [91] | get VRAM | `FD2F` | `E0CF` | `GET_VRAM` | `E0CF` | PASS |
| 116 [91] | calculate pattern position | `FD32` | `E10A` | `CALC_OFFSET` | `E10A` | PASS |
| 116 [91] | point to pattern position | `FD35` | `E129` | `PX_TO_PTRN_POS` | `E129` | PASS |
| 116 [91] | load default ASCII to VDP | `FD38` | `E149` | `LOAD_ASCII` | `E149` | PASS |
| 116 [91] | write sprite table | `FD3B` | `E1C5` | `WR_SPR_ATTRIBUTE` | `E1C5` | PASS |
| 116 [91] | read game controller | `FD3E` | `E253` | `POLLER` | `E253` | PASS |
| 116 [91] | update spinner | `FD41` | `E2A4` | `UPDATE_SPINNER` | `E2A4` | PASS |
| 116 [91] | decrement low nibble | `FD44` | `E355` | `DECLSN` | `E355` | PASS |
| 116 [91] | decrement high nibble | `FD47` | `E35F` | `DECMSN` | `E35F` | PASS |
| 116 [91] | move high nibble to low nibble | `FD4A` | `E369` | `MSNTOLSN` | `E369` | PASS |
| 116 [91] | add A + (HL) | `FD4D` | `E374` | `ADD816` | `E374` | PASS |
| 116 [91] | sound initialization | `FD50` | `E3AB` | `SOUND_INIT` | `E3AB` | PASS |
| 116 [91] | sound off | `FD53` | `E3D1` | `TURN_OFF_SOUND` | `E3D1` | PASS |
| 116 [91] | start sound | `FD56` | `E3E7` | `PLAY_IT` | `E3E7` | PASS |
| 116 [91] | play sound | `FD59` | `E406` | `SOUNDS` | `E406` | PASS |
| 116 [91] | end of sound | `FD5C` | `E4B8` | `EFFECT_OVER` | `E4B8` | PASS |

## Entries omitted from the manual

The jump-table introduction on PDF page 115 [original page 90] explains: "The ones which serve no purpose and those which are disabled have been omitted." The manual does not identify which explanation applies to each omitted entry. The following 12 entries are present in Coleco's complete 101-entry table but absent from Cousineau's 89-entry table:

| Manual page reference | Entry | Reconstructed symbol | Actual destination | Comparison |
|---|---:|---|---:|---|
| 115 [90], omission statement | `FC57` | `_GET_DCB_ADDR` | `F446` | Not documented; aliases `_FIND_DCB` destination |
| 115 [90], omission statement | `FC6F` | `_RD_KBD_RET_CODE` | `FA7B` | Not documented |
| 115 [90], omission statement | `FC72` | `_RD_PR_RET_CODE` | `FA7F` | Not documented |
| 115 [90], omission statement | `FC78` | `_RD_TAPE_RET_CODE` | `FA83` | Not documented |
| 115 [90], omission statement | `FC87` | `_REQ_TAPE_STAT` | `F5D7` | Not documented |
| 115 [90], omission statement | `FC99` | `_SOFT_RES_TAPE` | `FA59` | Not documented |
| 115 [90], omission statement | `FCEA` | `_READ_EOS` | `FA9D` | Not documented |
| 115 [90], omission statement | `FD02` | `_POSIT_FILE` | `F442` | Not documented |
| 115 [90], omission statement | `FD05` | `_EOS_1` | `F442` | Not documented; aliases disabled/default destination |
| 115 [90], omission statement | `FD08` | `_EOS_2` | `F442` | Not documented; aliases disabled/default destination |
| 115 [90], omission statement | `FD0B` | `_EOS_3` | `F442` | Not documented; aliases disabled/default destination |
| 115 [90], omission statement | `FD0E` | `_CV_A` | `F442` | Not documented; aliases disabled/default destination |

Absence from the manual is not evidence that an entry is absent from EOS 6. These entries remain exactly as established by the Coleco listing and production ROM.

## Terminology mappings

The manual generally uses functional descriptions while Coleco's source uses compact internal symbols. The following differences refer to the same vectors and destinations:

| Manual terminology | Reconstructed symbol | Entry | Note |
|---|---|---:|---|
| console display | `_CONS_DISP` | `FC33` | Display without special-character processing |
| console initialization | `_CONS_INIT` | `FC36` | Same routine |
| display character on screen | `_CONS_OUT` | `FC39` | Console output with special processing |
| end/start read printer | `_END_RD_CH_DEV`, `_START_RD_CH_DEV` | `FC48`, `FCA5` | Printer is the documented character device |
| end/start/write printer | `_END_WR_CH_DEV`, `_START_WR_CH_DEV`, `_WR_CH_DEV` | `FC51`, `FCAE`, `FCB7` | Manual specializes the generic character-device symbols |
| initialize directory | `_INIT_TAPE_DIR` | `FCBD` | Same vector despite narrower source name |
| find file 1 | `_QUERY_FILE` | `FCCC` | Same vector and destination |
| update file in directory | `_SET_FILE` | `FCCF` | Same vector and destination |
| put date | `_SET_DATE` | `FCD8` | Same vector and destination |
| get device status | `_RD_DEV_DEP_STAT` | `FCE4` | Read device-dependent status |
| exit to WP | `_GOTO_WP` | `FCE7` | WP means SmartWriter in the routine description |
| find file in FCB | `_CHECK_FCB` | `FCF0` | Same vector and destination |
| look up file in directory | `_SCAN_FOR_FILE` | `FCFC` | Same vector and destination |
| find file 2 | `_FILE_QUERY` | `FCFF` | Same vector and destination |
| set VDP port data | `PORT_COLLECTION` | `FD11` | Same vector and destination |
| put ASC in VDP | `PUT_ASCII` | `FD17` | Same vector and destination |
| initialize VRAM tables | `INIT_TABLE` | `FD29` | Same vector and destination |
| calculate/point to pattern position | `CALC_OFFSET`, `PX_TO_PTRN_POS` | `FD32`, `FD35` | Functional descriptions of the graphics helpers |
| write sprite table | `WR_SPR_ATTRIBUTE` | `FD3B` | Source comment also records an older sprite-table name |
| read game controller | `POLLER` | `FD3E` | Same vector and destination |
| decrement low/high nibble | `DECLSN`, `DECMSN` | `FD44`, `FD47` | Compact source names describe nibble operations |
| move high nibble to low nibble | `MSNTOLSN` | `FD4A` | Same vector and destination |
| add A + (HL) | `ADD816` | `FD4D` | Adds signed 8-bit A to a 16-bit value |
| sound off/start/play/end | `TURN_OFF_SOUND`, `PLAY_IT`, `SOUNDS`, `EFFECT_OVER` | `FD53`-`FD5C` | Same four sound vectors |

## FC4E visual-inspection finding

The available 2018 updated PDF was rendered at high resolution and PDF page 115 was visually inspected. That page clearly displays `FB13:64283` for the `FC4E` row. It is not an image of the original manual page: PDF metadata identifies Microsoft Word 2016 as creator and producer, and the page is re-typeset text. The local archive and located online copies provide the same updated PDF or derivative HTML/OCR text, not an original scan.

Therefore:

- The available updated edition contains a hexadecimal/decimal inconsistency: printed/transcribed `FB13`, decimal `64283`.
- Decimal `64283` equals hexadecimal `FB1B`.
- Production bytes at `FC4E` are `C3 1B FB`, which decode as `JP FB1B`.
- The reconstructed source resolves `_END_WR_1_BLOCK` to `FB1B`.
- The actual destination is conclusively `FB1B`.
- Whether Guy Cousineau's original page printed `FB1B` and was later mistranscribed, or originally printed `FB13`, remains an unresolved scan ambiguity because the original page image was unavailable.

This is not classified as a proven OCR error in the original manual. It is classified as an unresolved original-print ambiguity and a confirmed internal inconsistency in the available updated edition.

## Baseline preservation

Before this documentation pass:

- `EOS_6_ASSEMBLEABLE_SOURCE.asm` SHA256: `87cda81dbe8f4dbfc7c04cb008f3489df6ee9e2c050b3cc1947e68b11d753313`
- `EOS_6_ASSEMBLEABLE_SOURCE.bin` SHA256: `cd012db8816fcebf0790fbc30f16d003ecd9ccfea844451c04b4a78c631cced3`
- `EOS_6_ASSEMBLEABLE_SOURCE.u22` SHA256: `a49928fbac56380917134b54961ece2e90073022f3e04a6023d26cdbbd9c3356`

The release verification repeats these hashes after documentation and packaging. The expected MD5 identities remain `01df3140909f09aa9aac4f88890f676c` for the 8K EOS bank and `cf10b154f2e006a9740d7653cfc47cab` for the complete 16K U22.
