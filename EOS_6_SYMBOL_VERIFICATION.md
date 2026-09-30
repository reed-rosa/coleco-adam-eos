# EOS 6 Symbol Verification

- Expected values: `EOS_6_EXPECTED_SYMBOLS.json`, transcribed independently from the surviving listing.
- Provenance: `EOS_6_EXPECTED_SYMBOLS_SOURCES.md`.
- Actual values: freshly generated `EOS_6_ASSEMBLEABLE_SOURCE.map`.
- Public jump-table entries: 101/101 matched (FC30-FD5C, stride 3).
- RAM/PCB definitions: 75/75 matched.
- Common configuration-table symbols: 17/17 matched.
- `_START_RD_CH_DEV`: `$FCA5`.
- `MEM_CNFGOO` / `SWITCH_TABLE`: `$FC17`.
- `MEM_CNFGOB`: `$FC22`.
- `TEMP_STACK` / `PTR_TO_LST_OF_SND_ADDRS`: intentional alias at `$FE6E`.
- `DEFAULT_BT_DEV` / `CURRENT_DEV`: intentional alias at `$FD6F`.
- `BLK_STRT_PTR` / `VOL_BLK_SZ`: intentional alias at `$FDDC`.
- `VRAM_ADDR_TABLE` / `SPRITEATTRTBL`: intentional alias at `$FD64`.

## Public jump table

Source: OCR lines 122-333; fixed three-byte entries beginning at `$FC30`.

| Symbol | Expected | Actual | Result |
|---|---:|---:|---|
| `_EOS_START` | `$FC30` | `$FC30` | PASS |
| `_CONS_DISP` | `$FC33` | `$FC33` | PASS |
| `_CONS_INIT` | `$FC36` | `$FC36` | PASS |
| `_CONS_OUT` | `$FC39` | `$FC39` | PASS |
| `_DLY_AFT_HRD_RES` | `$FC3C` | `$FC3C` | PASS |
| `_END_PR_BUFF` | `$FC3F` | `$FC3F` | PASS |
| `_END_PR_CH` | `$FC42` | `$FC42` | PASS |
| `_END_RD_1_BLOCK` | `$FC45` | `$FC45` | PASS |
| `_END_RD_CH_DEV` | `$FC48` | `$FC48` | PASS |
| `_END_RD_KBD` | `$FC4B` | `$FC4B` | PASS |
| `_END_WR_1_BLOCK` | `$FC4E` | `$FC4E` | PASS |
| `_END_WR_CH_DEV` | `$FC51` | `$FC51` | PASS |
| `_FIND_DCB` | `$FC54` | `$FC54` | PASS |
| `_GET_DCB_ADDR` | `$FC57` | `$FC57` | PASS |
| `_GET_PCB_ADDR` | `$FC5A` | `$FC5A` | PASS |
| `_HARD_INIT` | `$FC5D` | `$FC5D` | PASS |
| `_HARD_RESET_NET` | `$FC60` | `$FC60` | PASS |
| `_PR_BUFF` | `$FC63` | `$FC63` | PASS |
| `_PR_CH` | `$FC66` | `$FC66` | PASS |
| `_RD_1_BLOCK` | `$FC69` | `$FC69` | PASS |
| `_RD_KBD` | `$FC6C` | `$FC6C` | PASS |
| `_RD_KBD_RET_CODE` | `$FC6F` | `$FC6F` | PASS |
| `_RD_PR_RET_CODE` | `$FC72` | `$FC72` | PASS |
| `_RD_RET_CODE` | `$FC75` | `$FC75` | PASS |
| `_RD_TAPE_RET_CODE` | `$FC78` | `$FC78` | PASS |
| `_RELOC_PCB` | `$FC7B` | `$FC7B` | PASS |
| `_REQUEST_STATUS` | `$FC7E` | `$FC7E` | PASS |
| `_REQ_KBD_STAT` | `$FC81` | `$FC81` | PASS |
| `_REQ_PR_STAT` | `$FC84` | `$FC84` | PASS |
| `_REQ_TAPE_STAT` | `$FC87` | `$FC87` | PASS |
| `_SCAN_ACTIVE` | `$FC8A` | `$FC8A` | PASS |
| `_SOFT_INIT` | `$FC8D` | `$FC8D` | PASS |
| `_SOFT_RES_DEV` | `$FC90` | `$FC90` | PASS |
| `_SOFT_RES_KBD` | `$FC93` | `$FC93` | PASS |
| `_SOFT_RES_PR` | `$FC96` | `$FC96` | PASS |
| `_SOFT_RES_TAPE` | `$FC99` | `$FC99` | PASS |
| `_START_PR_BUFF` | `$FC9C` | `$FC9C` | PASS |
| `_START_PR_CH` | `$FC9F` | `$FC9F` | PASS |
| `_START_RD_1_BLOCK` | `$FCA2` | `$FCA2` | PASS |
| `_START_RD_CH_DEV` | `$FCA5` | `$FCA5` | PASS |
| `_START_RD_KBD` | `$FCA8` | `$FCA8` | PASS |
| `_START_WR_1_BLOCK` | `$FCAB` | `$FCAB` | PASS |
| `_START_WR_CH_DEV` | `$FCAE` | `$FCAE` | PASS |
| `_SYNC` | `$FCB1` | `$FCB1` | PASS |
| `_WR_1_BLOCK` | `$FCB4` | `$FCB4` | PASS |
| `_WR_CH_DEV` | `$FCB7` | `$FCB7` | PASS |
| `_FMGR_INIT` | `$FCBA` | `$FCBA` | PASS |
| `_INIT_TAPE_DIR` | `$FCBD` | `$FCBD` | PASS |
| `_OPEN_FILE` | `$FCC0` | `$FCC0` | PASS |
| `_CLOSE_FILE` | `$FCC3` | `$FCC3` | PASS |
| `_RESET_FILE` | `$FCC6` | `$FCC6` | PASS |
| `_MAKE_FILE` | `$FCC9` | `$FCC9` | PASS |
| `_QUERY_FILE` | `$FCCC` | `$FCCC` | PASS |
| `_SET_FILE` | `$FCCF` | `$FCCF` | PASS |
| `_READ_FILE` | `$FCD2` | `$FCD2` | PASS |
| `_WRITE_FILE` | `$FCD5` | `$FCD5` | PASS |
| `_SET_DATE` | `$FCD8` | `$FCD8` | PASS |
| `_GET_DATE` | `$FCDB` | `$FCDB` | PASS |
| `_RENAME_FILE` | `$FCDE` | `$FCDE` | PASS |
| `_DELETE_FILE` | `$FCE1` | `$FCE1` | PASS |
| `_RD_DEV_DEP_STAT` | `$FCE4` | `$FCE4` | PASS |
| `_GOTO_WP` | `$FCE7` | `$FCE7` | PASS |
| `_READ_EOS` | `$FCEA` | `$FCEA` | PASS |
| `_TRIM_FILE` | `$FCED` | `$FCED` | PASS |
| `_CHECK_FCB` | `$FCF0` | `$FCF0` | PASS |
| `_READ_BLOCK` | `$FCF3` | `$FCF3` | PASS |
| `_WRITE_BLOCK` | `$FCF6` | `$FCF6` | PASS |
| `_MODE_CHECK` | `$FCF9` | `$FCF9` | PASS |
| `_SCAN_FOR_FILE` | `$FCFC` | `$FCFC` | PASS |
| `_FILE_QUERY` | `$FCFF` | `$FCFF` | PASS |
| `_POSIT_FILE` | `$FD02` | `$FD02` | PASS |
| `_EOS_1` | `$FD05` | `$FD05` | PASS |
| `_EOS_2` | `$FD08` | `$FD08` | PASS |
| `_EOS_3` | `$FD0B` | `$FD0B` | PASS |
| `_CV_A` | `$FD0E` | `$FD0E` | PASS |
| `PORT_COLLECTION` | `$FD11` | `$FD11` | PASS |
| `SWITCH_MEM` | `$FD14` | `$FD14` | PASS |
| `PUT_ASCII` | `$FD17` | `$FD17` | PASS |
| `WRITE_VRAM` | `$FD1A` | `$FD1A` | PASS |
| `READ_VRAM` | `$FD1D` | `$FD1D` | PASS |
| `WRITE_REGISTER` | `$FD20` | `$FD20` | PASS |
| `READ_REGISTER` | `$FD23` | `$FD23` | PASS |
| `FILL_VRAM` | `$FD26` | `$FD26` | PASS |
| `INIT_TABLE` | `$FD29` | `$FD29` | PASS |
| `PUT_VRAM` | `$FD2C` | `$FD2C` | PASS |
| `GET_VRAM` | `$FD2F` | `$FD2F` | PASS |
| `CALC_OFFSET` | `$FD32` | `$FD32` | PASS |
| `PX_TO_PTRN_POS` | `$FD35` | `$FD35` | PASS |
| `LOAD_ASCII` | `$FD38` | `$FD38` | PASS |
| `WR_SPR_ATTRIBUTE` | `$FD3B` | `$FD3B` | PASS |
| `POLLER` | `$FD3E` | `$FD3E` | PASS |
| `UPDATE_SPINNER` | `$FD41` | `$FD41` | PASS |
| `DECLSN` | `$FD44` | `$FD44` | PASS |
| `DECMSN` | `$FD47` | `$FD47` | PASS |
| `MSNTOLSN` | `$FD4A` | `$FD4A` | PASS |
| `ADD816` | `$FD4D` | `$FD4D` | PASS |
| `SOUND_INIT` | `$FD50` | `$FD50` | PASS |
| `TURN_OFF_SOUND` | `$FD53` | `$FD53` | PASS |
| `PLAY_IT` | `$FD56` | `$FD56` | PASS |
| `SOUNDS` | `$FD59` | `$FD59` | PASS |
| `EFFECT_OVER` | `$FD5C` | `$FD5C` | PASS |

## RAM and PCB/DCB definitions

Source: OCR lines 428-683, including printed addresses and allocation sizes.

| Symbol | Expected | Actual | Result |
|---|---:|---:|---|
| `CLEAR_RAM_START` | `$FD60` | `$FD60` | PASS |
| `REV_NUM` | `$FD60` | `$FD60` | PASS |
| `VDP_MODE_WORD` | `$FD61` | `$FD61` | PASS |
| `VDP_STATUS_BYTE` | `$FD63` | `$FD63` | PASS |
| `VRAM_ADDR_TABLE` | `$FD64` | `$FD64` | PASS |
| `SPRITEATTRTBL` | `$FD64` | `$FD64` | PASS |
| `SPRITEGENTBL` | `$FD66` | `$FD66` | PASS |
| `PATTRNNAMETBL` | `$FD68` | `$FD68` | PASS |
| `PATTRNGENTBL` | `$FD6A` | `$FD6A` | PASS |
| `COLORTABLE` | `$FD6C` | `$FD6C` | PASS |
| `CUR_BANK` | `$FD6E` | `$FD6E` | PASS |
| `DEFAULT_BT_DEV` | `$FD6F` | `$FD6F` | PASS |
| `CURRENT_DEV` | `$FD6F` | `$FD6F` | PASS |
| `CURRENT_PCB` | `$FD70` | `$FD70` | PASS |
| `DEVICE_ID` | `$FD72` | `$FD72` | PASS |
| `FILE_NAME_ADDR` | `$FD73` | `$FD73` | PASS |
| `KEYBOARD_BUFFER` | `$FD75` | `$FD75` | PASS |
| `PRINT_BUFFER` | `$FD76` | `$FD76` | PASS |
| `SECTORS_TO_INIT` | `$FD86` | `$FD86` | PASS |
| `SECTOR_NO` | `$FD87` | `$FD87` | PASS |
| `DCB_IMAGE` | `$FD8B` | `$FD8B` | PASS |
| `QUERY_BUFFER` | `$FDA0` | `$FDA0` | PASS |
| `FCB_BUFFER` | `$FDBA` | `$FDBA` | PASS |
| `FILE_COUNT` | `$FDD4` | `$FDD4` | PASS |
| `MOD_FILE_COUNT` | `$FDD5` | `$FDD5` | PASS |
| `RETRY_COUNT` | `$FDD6` | `$FDD6` | PASS |
| `FILE_NUMBR` | `$FDD7` | `$FDD7` | PASS |
| `FILENAME_CMPS` | `$FDD8` | `$FDD8` | PASS |
| `DIR_BLOCK_NO` | `$FDD9` | `$FDD9` | PASS |
| `FOUND_AVAIL_ENT` | `$FDDB` | `$FDDB` | PASS |
| `BLK_STRT_PTR` | `$FDDC` | `$FDDC` | PASS |
| `VOL_BLK_SZ` | `$FDDC` | `$FDDC` | PASS |
| `EOS_YEAR` | `$FDE0` | `$FDE0` | PASS |
| `EOS_MONTH` | `$FDE1` | `$FDE1` | PASS |
| `EOS_DAY` | `$FDE2` | `$FDE2` | PASS |
| `FMGR_DIR_ENT` | `$FDE3` | `$FDE3` | PASS |
| `FCB_HEAD_ADDR` | `$FDFD` | `$FDFD` | PASS |
| `FCB_DATA_ADDR` | `$FDFF` | `$FDFF` | PASS |
| `FNUM` | `$FE01` | `$FE01` | PASS |
| `BYTES_REQ` | `$FE02` | `$FE02` | PASS |
| `BYTES_TO_GO` | `$FE04` | `$FE04` | PASS |
| `USER_BUF` | `$FE06` | `$FE06` | PASS |
| `BUF_START` | `$FE08` | `$FE08` | PASS |
| `BUF_END` | `$FE0A` | `$FE0A` | PASS |
| `BLOCKS_REQ` | `$FE0C` | `$FE0C` | PASS |
| `USER_NAME` | `$FE10` | `$FE10` | PASS |
| `START_BLOCK` | `$FE12` | `$FE12` | PASS |
| `NEW_HOLE_START` | `$FE16` | `$FE16` | PASS |
| `NEW_HOLE_SIZE` | `$FE1A` | `$FE1A` | PASS |
| `STACK_START` | `$FE1C` | `$FE1C` | PASS |
| `EOS_STACK` | `$FE58` | `$FE58` | PASS |
| `SPIN_SW0_CT` | `$FE58` | `$FE58` | PASS |
| `SPIN_SW1_CT` | `$FE59` | `$FE59` | PASS |
| `PERSONAL_DEBOUNCE_TABLE` | `$FE5A` | `$FE5A` | PASS |
| `TEMP_STACK` | `$FE6E` | `$FE6E` | PASS |
| `PTR_TO_LST_OF_SND_ADDRS` | `$FE6E` | `$FE6E` | PASS |
| `PTR_TO_S_ON_0` | `$FE70` | `$FE70` | PASS |
| `PTR_TO_S_ON_1` | `$FE72` | `$FE72` | PASS |
| `PTR_TO_S_ON_2` | `$FE74` | `$FE74` | PASS |
| `PTR_TO_S_ON_3` | `$FE76` | `$FE76` | PASS |
| `SAVE_CTRL` | `$FE78` | `$FE78` | PASS |
| `OLDCHAR_` | `$FE79` | `$FE79` | PASS |
| `X_MIN` | `$FE7A` | `$FE7A` | PASS |
| `X_MAX` | `$FE7B` | `$FE7B` | PASS |
| `Y_MIN` | `$FE7C` | `$FE7C` | PASS |
| `Y_MAX` | `$FE7D` | `$FE7D` | PASS |
| `LINEBUFFER_` | `$FE7E` | `$FE7E` | PASS |
| `NUM_LINES` | `$FE9F` | `$FE9F` | PASS |
| `NUM_COLUMNS` | `$FEA0` | `$FEA0` | PASS |
| `UPPER_LEFT` | `$FEA1` | `$FEA1` | PASS |
| `PTRN_NAME_TBL` | `$FEA3` | `$FEA3` | PASS |
| `CURSOR` | `$FEA5` | `$FEA5` | PASS |
| `PCB` | `$FEC0` | `$FEC0` | PASS |
| `DCBS` | `$FEC4` | `$FEC4` | PASS |
| `RESERVED_BYTE` | `$FFFF` | `$FFFF` | PASS |

## Common configuration table

Source: active OCR definitions at lines 768-816.

| Symbol | Expected | Actual | Result |
|---|---:|---:|---|
| `SWITCH_TABLE` | `$FC17` | `$FC17` | PASS |
| `MEM_CNFGOO` | `$FC17` | `$FC17` | PASS |
| `MEM_CNFGO1` | `$FC18` | `$FC18` | PASS |
| `MEM_CNFGO2` | `$FC19` | `$FC19` | PASS |
| `MEM_CNFGO3` | `$FC1A` | `$FC1A` | PASS |
| `MEM_CNFGO4` | `$FC1B` | `$FC1B` | PASS |
| `MEM_CNFGO5` | `$FC1C` | `$FC1C` | PASS |
| `MEM_CNFGO6` | `$FC1D` | `$FC1D` | PASS |
| `MEM_CNFGO7` | `$FC1E` | `$FC1E` | PASS |
| `MEM_CNFGO8` | `$FC1F` | `$FC1F` | PASS |
| `MEM_CNFGO9` | `$FC20` | `$FC20` | PASS |
| `MEM_CNFGOA` | `$FC21` | `$FC21` | PASS |
| `MEM_CNFGOB` | `$FC22` | `$FC22` | PASS |
| `MEM_CNFGOC` | `$FC23` | `$FC23` | PASS |
| `MEM_CNFGOD` | `$FC24` | `$FC24` | PASS |
| `MEM_CNFGOE` | `$FC25` | `$FC25` | PASS |
| `MEM_CNFGOF` | `$FC26` | `$FC26` | PASS |

See `EOS_6_ASSEMBLEABLE_SOURCE.map` for the complete absolute symbol map, `EOS_6_ASSEMBLEABLE_SOURCE.lis` for raw assembler output, and `EOS_6_ASSEMBLEABLE_SOURCE.address.lst` for the rebased/final-byte listing.
