; ==================================================================
; MODERN RECONSTRUCTION HEADER (not historical Coleco source text)
; ==================================================================
; Coleco ADAM EOS 6 reconstructed z88dk-z80asm source.
; Generated deterministically from EOS_REBUILD/all_lines.txt by
; EOS_REBUILD/build_clean_z88_source.py. Do not hand-edit this file.
; The raw scan transcription EOS_6_ABSOLUTE_LISTING_OCR.txt is the
; authority for source structure, labels, comments, and intent. The
; production U22 ROM is the byte oracle. This is not a ROM-byte dump.
; OCR source-line anchors are retained in the generator and correction
; report, rather than repeated in this readable assembly file.
; ==================================================================

MODE_REMAINDER_BIT EQU 5 ; [RECON assembler] forward bit equate for z80asm
MODE_DIRTY_BIT EQU 6 ; [RECON assembler] forward bit equate for z80asm
MODE_LAST_BLOCK_BIT EQU 7 ; [RECON assembler] forward bit equate for z80asm
ATTR_DEL_BIT EQU 2 ; [RECON assembler] forward bit equate for z80asm
ATTR_HOLE_BIT EQU 0 ; [RECON assembler] forward bit equate for z80asm
CMND_COMPLETE_BIT EQU 7 ; [RECON assembler] forward bit equate for z80asm

; ==================================================================
; BEGIN PRESERVED COLECO LISTING TEXT
; ==================================================================
;Z80*
;  NAME "Rev 06.1 - TF"
; Project: EOS 6 Absolute Listing
;
;                EOS ABSOLUTE LISTING
;                Electronic Development Group
;                Coleco Industries Inc.
;                999 Quaker Lane South
;                West Hartford, Connecticut
;                06110
; This absolute listing was generated to ease software
; development on ADAM. This listing provides the location
; of both released and unreleased entry points. Released
; entry points begin immediately in this file with the jump
; table and end before the first code segment listed.
; Released entry points include the jump table, common data
; areas(EOS_COMM), common data tables, and equates which
; describe the released data structures. Direct access
; to code segments is STRONGLY DISCOURAGED and may make
; your application incompatible with some ADAMs. There is
; more than one version of EOS on the market at this time
; and updates are planned.
; For further information on ADAM or EOS consult the
; ADAM Technical Reference Manual or send your questions
; in writing to:
;                         Coleco Software Support
;
;     at the above address.
;
; COLECO MAKES NO REPRESENTATIONS OR WARRANTIES WHATSOEVER, INCLUDING
; WITHOUT LIMITATION ANY IMPLIED WARRANTIES OR MERCHANTABILITY AND
; FITNESS FOR A PARTICULAR PURPOSE, IN CONNECTION WITH THE MATERIALS
; CONTAINED HEREIN, AND SUCH MATERIALS ARE DISCLOSED AS IS. COLECO
; SHALL HAVE NO LIABILITY FOR ANY LOSSES CAUSED TO RECIPIENTS OF THESE
; MATERIALS BY REASON OF ANY CHANGES OR MODIFICATIONS MADE BY COLECO IN
; THESE MATERIALS AFTER THEIR DISCLOSURE HEREIN. IN ADDITION, COLECO
; SHALL HAVE NO LIABILITY FOR ANY CONSEQUENTIAL, SPECIAL, INDIRECT OR
; INCIDENTAL DAMAGES OR LOSSES WHATSOEVER, INCLUDING LOSS OF PROFITS, IN
; CONNECTION WITH THE USE OF THE MATERIALS DISCLOSED HEREIN.
;***************************************************************
;
;        Rev History
;        Rev.  Date        Name        Change
;        6.1   21jun0844   af          Merge sources for absolute listing.  [AS-SCAN]
;                                      No changes made to code.
;        6.0   08oct1545   jkl         Code released for production.        [AS-SCAN]
;
;{ code commented out by ';***' was removed before EOS      }
;{ was grouped into one file. code commented out by simple  }
;{ ';' was removed in the process of grouping EOS in order  }
;{ to avoid assembler complaints or LOCAL/GLOBAL conflicts  }
;{ ';============...' separates code segments which were    }
;{ originally in separate files                              }
;===============================================================
;===============================================================
;===============================================================
;  NAME ^Rev 11 - RPD^
;
; Rev  Date       Made by     Change
; 11   15oct425p  RPD         changed EOS_4 to CV_A
; 10   13oct1000p RPD         made only OS7 jump entries conditionally assembled
; 9    12oct2300  vsb         Added __SCAN_FOR_FILE, __POSIT_FILE, __FILE_QUERY plus __EOS1 thru __EOS4
; 8    07oct1710  rfj         __EFXOVER changed to __EFFECT_OVER
;                              Added __UPDATE_SPINNER
; 7    05oct1725  rfj         Renamed WR_SPR_*_TBL to WR_SPR_ATTRIBUTE
; 6    03oct1207  rfj         Increased TEMP_STACK to 12 bytes.
;                              Removed SAVED_COUNT
; 5    30sept825p RPD         replaced CONS_OUT data area with new CONS_OUT2
; 4    29sept235p RPD         replaced PLAY_SONGS with SOUNDS
; 3    26sept1005a RPD        added conditional assembly stuff for super games
; 2    25sept850a RPD         merged all of EOS ram together into this file
; 1    20sept1005a RPD        new memory mapping
; 0    mid-sept   VB          original map @ E800H
;
TRUE             EQU         0FFFFH
FALSE            EQU         00000H

IN_EOS           EQU         TRUE
SUPERGAME        EQU         FALSE
;
; CURRENT EOS MEMORY MAPPING
;
;FCB_S          EQU         0D390H                  ;FCB area
;THREE1K_BLKS   EQU         0D400H                  ;3 FCB 1K buffers
 EOS_CODE        EQU         0E000H;address of EOS code segment
 EOS_GLB_TBL     EQU         0FBFFH;address of EOS global tables ; [RECON] OCR 98: scan value column is <FBFF>.
 EOS_JMP_TBL     EQU         0FC30H;address of EOS jump table
EOS_GLB_RAM     EQU         0FD60H;address of EOS global data area
EOS_PCB_DCB     EQU         0FEC0H;address of EOS PCB/DCB areas

;
;   These are key record sizes, used in various EOS routines.
;   See "INCLUDE FMGR_EQUS" AND "INCLUDE P_DCB_EQU" for details.
;

DIR_ENT_LENGTH: DEFL        26
P_SIZE: DEFL        4; THE NUMBER OF BYTES IN THE PCB
D_SIZE: DEFL        21; THE NUMBER OF BYTES IN THE DCB
;
;
; jump table area
;
;***************************************************************

; [RECON assembler] Named section preserves OCR block order for z80asm.
        SECTION jump_table
        ORG     EOS_JMP_TBL

;***************************************************************

_EOS_START                                     EQU $
        JP      __EOS_START
_CONS_DISP                                     EQU $
        JP      __CONS_DISP
_CONS_INIT                                     EQU $
        JP      __CONS_INIT
_CONS_OUT                                      EQU $
        JP      __CONS_OUT
_DLY_AFT_HRD_RES                               EQU $
        JP      __DLY_AFT_HRD_RES
_END_PR_BUFF                                   EQU $
        JP      __END_PR_BUFF
_END_PR_CH                                     EQU $
        JP      __END_PR_CH
_END_RD_1_BLOCK                                EQU $
        JP      __END_RD_1_BLOCK
_END_RD_CH_DEV                                 EQU $
        JP      __END_RD_CH_DEV
_END_RD_KBD                                    EQU $
        JP      __END_RD_KBD
_END_WR_1_BLOCK                                EQU $
        JP      __END_WR_1_BLOCK
_END_WR_CH_DEV                                 EQU $
        JP      __END_WR_CH_DEV
_FIND_DCB                                      EQU $
        JP      __FIND_DCB
_GET_DCB_ADDR                                  EQU $
        JP      __GET_DCB_ADDR
_GET_PCB_ADDR                                  EQU $
        JP      __GET_PCB_ADDR
_HARD_INIT                                     EQU $
        JP      __HARD_INIT
_HARD_RESET_NET                                EQU $
        JP      __HARD_RESET_NET
_PR_BUFF                                       EQU $
        JP      __PR_BUFF
_PR_CH                                         EQU $
        JP      __PR_CH
_RD_1_BLOCK                                    EQU $
        JP      __RD_1_BLOCK
_RD_KBD                                        EQU $
        JP      __RD_KBD
_RD_KBD_RET_CODE                               EQU $
        JP      __RD_KBD_RET_CODE
_RD_PR_RET_CODE                                EQU $
        JP      __RD_PR_RET_CODE
_RD_RET_CODE                                   EQU $
        JP      __RD_RET_CODE
_RD_TAPE_RET_CODE                              EQU $
        JP      __RD_TAPE_RET_CODE
_RELOC_PCB                                     EQU $
        JP      __RELOC_PCB
_REQUEST_STATUS                                EQU $
        JP      __REQUEST_STATUS
_REQ_KBD_STAT                                  EQU $
        JP      __REQ_KBD_STAT
_REQ_PR_STAT                                   EQU $
        JP      __REQ_PR_STAT
_REQ_TAPE_STAT                                 EQU $
        JP      __REQ_TAPE_STAT
_SCAN_ACTIVE                                   EQU $
        JP      __SCAN_ACTIVE
_SOFT_INIT                                     EQU $
        JP      __SOFT_INIT
_SOFT_RES_DEV                                  EQU $
        JP      __SOFT_RES_DEV
_SOFT_RES_KBD                                  EQU $
        JP      __SOFT_RES_KBD
_SOFT_RES_PR                                   EQU $
        JP      __SOFT_RES_PR
_SOFT_RES_TAPE                                 EQU $
        JP      __SOFT_RES_TAPE
_START_PR_BUFF                                 EQU $
        JP      __START_PR_BUFF
_START_PR_CH                                   EQU $
        JP      __START_PR_CH
_START_RD_1_BLOCK                              EQU $
        JP      __START_RD_1_BLOCK
_START_RD_CH_DEV                               EQU $; [RECON] Resolved: sequential public entry and ROM bytes place _START_RD_CH_DEV at $FCA5.
        JP      __START_RD_CH_DEV
_START_RD_KBD                                  EQU $
        JP      __START_RD_KBD
_START_WR_1_BLOCK                              EQU $
        JP      __START_WR_1_BLOCK
_START_WR_CH_DEV                               EQU $
        JP      __START_WR_CH_DEV
_SYNC                                          EQU $
        JP      __SYNC
_WR_1_BLOCK                                    EQU $
        JP      __WR_1_BLOCK
_WR_CH_DEV                                     EQU $
        JP      __WR_CH_DEV
;
; FILE MANAGER ENTRIES
;
_FMGR_INIT                                     EQU $
        JP      __FMGR_INIT
_INIT_TAPE_DIR                                 EQU $
        JP      __INIT_TAPE_DIR
_OPEN_FILE                                     EQU $
        JP      __OPEN_FILE
_CLOSE_FILE                                    EQU $
        JP      __CLOSE_FILE
_RESET_FILE                                    EQU $
        JP      __RESET_FILE
_MAKE_FILE                                     EQU $
        JP      __MAKE_FILE
_QUERY_FILE                                    EQU $
        JP      __QUERY_FILE
_SET_FILE                                      EQU $
        JP      __SET_FILE
_READ_FILE                                     EQU $
        JP      __READ_FILE
_WRITE_FILE                                    EQU $
        JP      __WRITE_FILE
_SET_DATE                                      EQU $
        JP      __SET_DATE
_GET_DATE                                      EQU $
        JP      __GET_DATE
_RENAME_FILE                                   EQU $
        JP      __RENAME_FILE
_DELETE_FILE                                   EQU $
        JP      __DELETE_FILE
_RD_DEV_DEP_STAT                               EQU $
        JP      __RD_DEV_DEP_STAT
_GOTO_WP                                       EQU $
        JP      __GOTO_WP
_READ_EOS                                      EQU $
        JP      __READ_EOS
_TRIM_FILE                                     EQU $
        JP      __TRIM_FILE
_CHECK_FCB                                     EQU $
        JP      __CHECK_FCB
_READ_BLOCK                                    EQU $
        JP      __READ_BLOCK
_WRITE_BLOCK                                   EQU $
        JP      __WRITE_BLOCK
_MODE_CHECK                                    EQU $
        JP      __MODE_CHECK
_SCAN_FOR_FILE                                 EQU $
        JP      __SCAN_FOR_FILE
_FILE_QUERY                                    EQU $
        JP      __FILE_QUERY
_POSIT_FILE                                    EQU $
        JP      __POSIT_FILE
_EOS_1                                         EQU $
        JP      __EOS_1
_EOS_2                                         EQU $
        JP      __EOS_2
_EOS_3                                         EQU $
        JP      __EOS_3
_CV_A                                          EQU $
        JP      __CV_A
PORT_COLLECTION                                EQU $
        JP      __PORT_COLLECTION
SWITCH_MEM                                     EQU $
        JP      __SWITCH_MEM
PUT_ASCII                                      EQU $
        JP      __PUT_ASCII

;
; micro OS7 entries
;

WRITE_VRAM                                     EQU $
        JP      __WRITE_VRAM
READ_VRAM                                      EQU $
        JP      __READ_VRAM
WRITE_REGISTER                                 EQU $
        JP      __WRITE_REGISTER
READ_REGISTER                                  EQU $
        JP      __READ_REGISTER
FILL_VRAM                                      EQU $
        JP      __FILL_VRAM
INIT_TABLE                                     EQU $
        JP      __INIT_TABLE
PUT_VRAM                                       EQU $
        JP      __PUT_VRAM
GET_VRAM                                       EQU $
        JP      __GET_VRAM
CALC_OFFSET                                    EQU $
        JP      __CALC_OFFSET
PX_TO_PTRN_POS                                 EQU $
        JP      __PX_TO_PTRN_POS
LOAD_ASCII                                     EQU $
        JP      __LOAD_ASCII
WR_SPR_ATTRIBUTE                               EQU $
        JP      __WR_SPR_ATTRIBUTE;same as wr_spr_nm_tbl
POLLER                                         EQU $
        JP      __POLLER
UPDATE_SPINNER                                 EQU $
        JP      __UPDATE_SPINNER
DECLSN                                         EQU $
        JP      __DECLSN
DECMSN                                         EQU $
        JP      __DECMSN
MSNTOLSN                                      EQU $; [RECON] OCR 320: scan spells MSNTOLSN.
        JP      __MSNTOLSN; [RECON] OCR 321: scan spells __MSNTOLSN.
ADD816                                         EQU $
        JP      __ADD816
SOUND_INIT                                     EQU $
        JP      __SOUND_INIT
TURN_OFF_SOUND                                 EQU $
        JP      __TURN_OFF_SOUND;not globalized in OS7?
PLAY_IT                                        EQU $
        JP      __PLAY_IT
SOUNDS                                         EQU $
        JP      __SOUNDS;equals calls to play_songs and sound_man
EFFECT_OVER                                    EQU $
        JP      __EFFECT_OVER
;
; NOTE:   See INTERRUPT_VECTORS
;
;                         ORG     EOS_GLB_TBL
;                         ;GLB    VECTOR_08H
;VECTOR_08H                EQU     $+0
;                         ;GLB    INT_VCTR_TBL
;INT_VCTR_TBL              EQU     VECTOR_08H
;                         ;GLB    VECTOR_10H
;VECTOR_10H                EQU     $+3
;                         ;GLB    VECTOR_18H
;VECTOR_18H                EQU     $+6
;                         ;GLB    VECTOR_20H
;VECTOR_20H                EQU     $+9
;                         ;GLB    VECTOR_28H
;VECTOR_28H                EQU     $+12
;                         ;GLB    VECTOR_30H
;VECTOR_30H                EQU     $+15
;                         ;GLB    VECTOR_38H
;VECTOR_38H                EQU     $+18
;                         ;GLB    VECTOR_66H
;VECTOR_66H                EQU     $+21
;
;     NOTE: See SWITCH_TABLE
;
;;                        ;GLB    MEM_CNFGOO ; [RECON] Resolved: historical spelling is MEM_CNFGOO (two letter O characters); kept commented.
;MEM_CNFGOO               EQU     $+24 ; [RECON] Resolved: historical spelling is MEM_CNFGOO (two letter O characters); kept commented.
;;                        ;GLB    SWITCH_TABLE
;SWITCH_TABLE              EQU     MEM_CNFGOO ; [RECON] Resolved: SWITCH_TABLE aliases MEM_CNFGOO; kept commented because active definitions follow at OCR 768-771.
;;                        ;GLB    MEM_CNFGO1
;MEM_CNFGO1               EQU     $+25
;;                        ;GLB    MEM_CNFGO2
;MEM_CNFGO2               EQU     $+26
;;                        ;GLB    MEM_CNFGO3
;MEM_CNFGO3               EQU     $+27
;;                        ;GLB    MEM_CNFGO4
;MEM_CNFGO4               EQU     $+28
;;                        ;GLB    MEM_CNFGO5
;MEM_CNFGO5               EQU     $+29
;;                        ;GLB    MEM_CNFGO6
;MEM_CNFGO6               EQU     $+30
;;                        ;GLB    MEM_CNFGO7
;MEM_CNFGO7               EQU     $+31
;;                        ;GLB    MEM_CNFGO8
;MEM_CNFGO8               EQU     $+32
;;                        ;GLB    MEM_CNFGO9
;MEM_CNFGO9               EQU     $+33
;;                        ;GLB    MEM_CNFGOA
;MEM_CNFGOA               EQU     $+34
;;                        ;GLB    MEM_CNFGOB ; [RECON] Resolved from active OCR 803 and ROM address $FC22; kept commented.
;MEM_CNFGOB               EQU     $+35 ; [RECON] Resolved from active OCR 803 and ROM address $FC22; kept commented.
;;                        ;GLB    MEM_CNFGOC
;MEM_CNFGOC               EQU     $+36
;;                        ;GLB    MEM_CNFGOD
;MEM_CNFGOD               EQU     $+37
;;                        ;GLB    MEM_CNFGOE
;MEM_CNFGOE               EQU     $+38
;;                        ;GLB    MEM_CNFGOF
;MEM_CNFGOF               EQU     $+39
;
;     NOTE: See PORT_TABLE
;
;;                        ;GLB    MEM_SWITCH_PORT
;MEM_SWITCH_PORT          EQU     $+40
;;                        ;GLB    PORT_TABLE
;PORT_TABLE                EQU     MEM_SWITCH_PORT
;;                        ;GLB    NET_RESET_PORT
;NET_RESET_PORT            EQU     $+41
;;                        ;GLB    VDP_CTRL_PORT
;VDP_CTRL_PORT             EQU     $+42
;;                        ;GLB    VDP_DATA_PORT
;VDP_DATA_PORT             EQU     $+43
;;                        ;GLB    CONTROLLER_0_PORT
;CONTROLLER_0_PORT         EQU     $+44
;;                        ;GLB    CONTROLLER_1_PORT
;CONTROLLER_1_PORT         EQU     $+45
;;                        ;GLB    STROBE_SET_PORT
;STROBE_SET_PORT           EQU     $+46
;;                        ;GLB    STROBE_RESET_PORT
;STROBE_RESET_PORT         EQU     $+47
;;                        ;GLB    SOUNDPORT
;SOUNDPORT                 EQU     $+48

;RAM DEFINITIONS FOR EOS

;REV 0              (V/D        8-24-83)


;***************************************************************

; [RECON assembler] Named section preserves OCR block order for z80asm.
        SECTION global_ram
        ORG     EOS_GLB_RAM

;***************************************************************

;GLB    CLEAR_RAM_START

CLEAR_RAM_START:

;
; EOS revision number initialized by EOS_START
;
;GLB    REV_NUM
REV_NUM:
        DEFS    1


        IF      !SUPERGAME
;
; OS7 equivalent global data structures
;
;GLB    VDP_MODE_WORD
VDP_MODE_WORD: DEFS    2
;GLB    VDP_STATUS_BYTE
VDP_STATUS_BYTE: DEFS    1
;GLB    VRAM_ADDR_TABLE
VRAM_ADDR_TABLE:
;GLB    SPRITEATTRTBL
SPRITEATTRTBL: DEFS    2
;GLB    SPRITEGENTBL
SPRITEGENTBL: DEFS    2
;GLB    PATTRNNAMETBL
PATTRNNAMETBL: DEFS    2
;GLB    PATTRNGENTBL
PATTRNGENTBL: DEFS    2
;GLB    COLORTABLE
COLORTABLE: DEFS    2
        ELSE
        DEFS    2+6+1
        ENDIF
;GLB    CUR_BANK
CUR_BANK: DEFS    1

;
; EOS global data structures
;
;GLB    DEFAULT_BT_DEV
;GLB    CURRENT_DEV

DEFAULT_BT_DEV:
CURRENT_DEV:
        DEFS    1

;GLB    CURRENT_PCB

CURRENT_PCB:
        DEFS    2; HOLDS THE START ADDRESS OF THE PCB
        IF      !SUPERGAME
;GLB    DEVICE_ID
        ENDIF
DEVICE_ID:
        DEFS    1; SAVE DEVICE ID

;GLB    FILE_NAME_ADDR
FILE_NAME_ADDR:
        DEFS    2

;GLB    KEYBOARD_BUFFER

KEYBOARD_BUFFER:
        DEFS    1; HOLDS THE KEY THAT IS READ FROM THE
; KEYBOARD

;GLB    PRINT_BUFFER

PRINT_BUFFER:
        DEFS    16; HOLDS THE STRING TO BE PRINTED

;GLB    SECTORS_TO_INIT,SECTOR_NO

SECTORS_TO_INIT:
        DEFS    1

SECTOR_NO:
        DEFS    4

;GLB    DCB_IMAGE

DCB_IMAGE:
        DEFS    21

;GLB    QUERY_BUFFER
QUERY_BUFFER:
        DEFS    DIR_ENT_LENGTH

;GLB    FCB_BUFFER
FCB_BUFFER:
        DEFS    DIR_ENT_LENGTH

;GLB    FILE_COUNT,MOD_FILE_COUNT
FILE_COUNT:
        DEFS    1

MOD_FILE_COUNT:
        DEFS    1

;GLB    RETRY_COUNT,FILE_NUMBR
RETRY_COUNT:
        DEFS    1

FILE_NUMBR:
        DEFS    1

;GLB    FILENAME_CMPS
FILENAME_CMPS:
        DEFS    1

;GLB    DIR_BLOCK_NO,FOUND_AVAIL_ENT
DIR_BLOCK_NO:
        DEFS    2

FOUND_AVAIL_ENT:
        DEFS    1

;GLB    VOL_BLK_SZ,BLK_STRT_PTR
BLK_STRT_PTR:
VOL_BLK_SZ:
        DEFS    4

; FILE MANAGER RAM STORAGE

;GLB    EOS_YEAR,EOS_MONTH,EOS_DAY
EOS_YEAR: DEFS    1;FMGR'S DATE STORAGE
EOS_MONTH: DEFS    1
EOS_DAY: DEFS    1

;GLB    FMGR_DIR_ENT
FMGR_DIR_ENT: DEFS    DIR_ENT_LENGTH;PLACE FOR FMGR TO PUT A DIR. ENTRY

;GLB    FCB_HEAD_ADDR,FCB_DATA_ADDR
FCB_HEAD_ADDR: DEFS    2;POINTER TO START OF FCB HEADS
FCB_DATA_ADDR: DEFS    2;POINTER TO START OF FCB BUFFERS

;GLB    FNUM,BYTES_REQ,BYTES_TO_GO,USER_BUF
;GLB    BUF_START,BUF_END,BLOCKS_REQ
;GLB    USER_NAME,START_BLOCK
FNUM: DEFS    1;FILE NUMBER GIVEN TO READ/WRITE ROUTINES
BYTES_REQ: DEFS    2;NUMBER OF BYTES REQUESTED BY CALLER
BYTES_TO_GO: DEFS    2;NUMBER OF BYTES STILL TO GIVE TO CALLER
USER_BUF: DEFS    2;ADDRESS OF CALLER'S BUFFER
BUF_START: DEFS    2;ADDRESS OF MY OWN BUFFER
BUF_END: DEFS    2;ADDRESS OF END + 1 OF MY BUFFER
BLOCKS_REQ: DEFS    4;NUMBER OF BLOCKS REQUESTED (MAKE_FILE)
USER_NAME: DEFS    2;POINTER TO USER'S NAME STRING
START_BLOCK: DEFS    4;START BLOCK # OF A FILE

;GLB    NEW_HOLE_START,NEW_HOLE_SIZE

NEW_HOLE_START:
        DEFS    4

NEW_HOLE_SIZE:
        DEFS    2

STACK_START:
        DEFS    60

;GLB    EOS_STACK
EOS_STACK:
;GLB    SAVED_COUNT                         ; controller data area

;GLB    SPIN_SW0_CT                          ; THESE TWO BYTES MUST BE IN THIS ORDER!!!
;GLB    SPIN_SW1_CT
;GLB    PERSONAL_DEBOUNCE_TABLE
;GLB    TEMP_STACK                           ; Used by put_ascii when bank switching
; sound data areas
;GLB    PTR_TO_LST_OF_SND_ADDRS
;GLB    PTR_TO_S_ON_0
;GLB    PTR_TO_S_ON_1
;GLB    PTR_TO_S_ON_2
;GLB    PTR_TO_S_ON_3
;GLB    SAVE_CTRL


; SAVED_COUNT    DEFS    2 ; [RECON] OCR 613 is commented in the scan; revision 6 removed it.
;
; controller data area
;
SPIN_SW0_CT: DEFS    1; THESE TWO BYTES MUST BE IN THIS ORDER!!!
SPIN_SW1_CT: DEFS    1
PERSONAL_DEBOUNCE_TABLE: DEFS    08
                DEFS    12; USED BY TEMP_STACK
TEMP_STACK     EQU     $; Used by put_ascii when bank switching

;
; sound data areas
;
PTR_TO_LST_OF_SND_ADDRS: DEFS    2
PTR_TO_S_ON_0: DEFS    2
PTR_TO_S_ON_1: DEFS    2
PTR_TO_S_ON_2: DEFS    2
PTR_TO_S_ON_3: DEFS    2
SAVE_CTRL: DEFS    1


;
; data area for CONS_OUT
;
;GLB    OLDCHAR_
;GLB    X_MIN
;GLB    X_MAX
;GLB    Y_MIN
;GLB    Y_MAX
;GLB    LINEBUFFER_
;GLB    NUM_LINES
;GLB    NUM_COLUMNS
;GLB    UPPER_LEFT
;GLB    PTRN_NAME_TBL
;GLB    CURSOR

OLDCHAR_: DEFS    1;Storage of char under cursor
X_MIN: DEFS    1;Absolute X coord of window
X_MAX: DEFS    1
Y_MIN: DEFS    1
Y_MAX: DEFS    1
LINEBUFFER_: DEFS    33
NUM_LINES: DEFS    1
NUM_COLUMNS: DEFS    1
UPPER_LEFT: DEFS    2
PTRN_NAME_TBL: DEFS    2
CURSOR: DEFS    2

;GLB    CLEAR_RAM_SIZE

CLEAR_RAM_SIZE          EQU     ($-CLEAR_RAM_START)
;
; this is the PCB/DCB area
;
;***************************************************************:

; [RECON assembler] Named section preserves OCR block order for z80asm.
        SECTION pcb_dcb
        ORG     EOS_PCB_DCB

;***************************************************************

;GLB    PCB

PCB:
        DEFS    P_SIZE; PCB

DCBS:
        DEFS    15*D_SIZE; 1 DCB PER NETWORK ADDRESS

RESERVED_BYTE:
        DEFS    1; SAVED IN CASE WE DO FAST DMA HERE
;
;===============================================================
;===============================================================
;===============================================================
; NAME ^Rev 00 - RPD^


;***************************************************************

; [RECON assembler] Named section preserves OCR block order for z80asm.
        SECTION global_table
        ORG     EOS_GLB_TBL

;***************************************************************
;
; NOTE: these are defined global in EOS_COMM
;
;                         ;GLB    VECTOR_08H
;                         ;GLB    VECTOR_10H
;                         ;GLB    VECTOR_18H
;                         ;GLB    VECTOR_20H
;                         ;GLB    VECTOR_28H
;                         ;GLB    VECTOR_30H
;                         ;GLB    VECTOR_38H
;                         ;GLB    VECTOR_66H
;
VECTOR_08H: RET;rst 8
                NOP
                NOP
VECTOR_10H: RET;rst 10
                NOP
                NOP
VECTOR_18H: RET;rst 18
                NOP
                NOP
VECTOR_20H: RET;rst 20
                NOP
                NOP
VECTOR_28H: RET;rst 28
                NOP
                NOP
VECTOR_30H: RET;rst 30
                NOP
                NOP
VECTOR_38H: RET;rst 38
                NOP
                NOP
VECTOR_66H: RETN;nmi vector
                NOP

;
; NOTE: these are defined global in EOS_COMM
;
;                         ;GLB    SWITCH_TABLE
;                         ;GLB    MEM_CNFGOO
;                         ;GLB    MEM_CNFGO1
;                         ;GLB    MEM_CNFGO2
;                         ;GLB    MEM_CNFGO3
;                         ;GLB    MEM_CNFGO4
;                         ;GLB    MEM_CNFGO5
;                         ;GLB    MEM_CNFGO6
;                         ;GLB    MEM_CNFGO7
;                         ;GLB    MEM_CNFGO8
;                         ;GLB    MEM_CNFGO9
;                         ;GLB    MEM_CNFGOA
;                         ;GLB    MEM_CNFGOB
;                         ;GLB    MEM_CNFGOC
;                         ;GLB    MEM_CNFGOD
;                         ;GLB    MEM_CNFGOE
;                         ;GLB    MEM_CNFGOF

LO_BOOT_ROM_N_ALPHA_MASK                  EQU     00000B
LO_INTRINSIC_RAM_0_TO_7FFFH_MASK          EQU     0001B
LO_EXPANSION_0_TO_7FFFH_MASK              EQU     0010B
LO_OS7_N_INTRINSIC_2000H_7FFFH_MASK       EQU     0011B

HI_INTRINSIC_8000H_TO_0FFFFH_MASK         EQU     0000B
HI_AUXILIARY_SLOT_8000H_0FFFFH            EQU     0100B
HI_EXPANSION_8000H_TO_0FFFFH_MASK         EQU     1000B
HI_COLECOVISION_CARTRIDGE_SLOT            EQU     1100B


SWITCH_TABLE:

MEM_CNFGOO:
        DEFB    HI_INTRINSIC_8000H_TO_0FFFFH_MASK | LO_BOOT_ROM_N_ALPHA_MASK

MEM_CNFGO1:
        DEFB    HI_INTRINSIC_8000H_TO_0FFFFH_MASK | LO_INTRINSIC_RAM_0_TO_7FFFH_MASK

MEM_CNFGO2:
        DEFB    HI_INTRINSIC_8000H_TO_0FFFFH_MASK | LO_EXPANSION_0_TO_7FFFH_MASK

MEM_CNFGO3:
        DEFB    HI_INTRINSIC_8000H_TO_0FFFFH_MASK | LO_OS7_N_INTRINSIC_2000H_7FFFH_MASK

MEM_CNFGO4:
        DEFB    HI_AUXILIARY_SLOT_8000H_0FFFFH | LO_BOOT_ROM_N_ALPHA_MASK

MEM_CNFGO5:
        DEFB    HI_AUXILIARY_SLOT_8000H_0FFFFH | LO_INTRINSIC_RAM_0_TO_7FFFH_MASK

MEM_CNFGO6:
        DEFB    HI_AUXILIARY_SLOT_8000H_0FFFFH | LO_EXPANSION_0_TO_7FFFH_MASK

MEM_CNFGO7:
        DEFB    HI_AUXILIARY_SLOT_8000H_0FFFFH | LO_OS7_N_INTRINSIC_2000H_7FFFH_MASK

MEM_CNFGO8:
        DEFB    HI_EXPANSION_8000H_TO_0FFFFH_MASK | LO_BOOT_ROM_N_ALPHA_MASK

MEM_CNFGO9:
        DEFB    HI_EXPANSION_8000H_TO_0FFFFH_MASK | LO_INTRINSIC_RAM_0_TO_7FFFH_MASK

MEM_CNFGOA:
        DEFB    HI_EXPANSION_8000H_TO_0FFFFH_MASK | LO_EXPANSION_0_TO_7FFFH_MASK

MEM_CNFGOB:
        DEFB    HI_EXPANSION_8000H_TO_0FFFFH_MASK | LO_OS7_N_INTRINSIC_2000H_7FFFH_MASK

MEM_CNFGOC:
        DEFB    HI_COLECOVISION_CARTRIDGE_SLOT | LO_BOOT_ROM_N_ALPHA_MASK

MEM_CNFGOD:
        DEFB    HI_COLECOVISION_CARTRIDGE_SLOT | LO_INTRINSIC_RAM_0_TO_7FFFH_MASK

MEM_CNFGOE:
        DEFB    HI_COLECOVISION_CARTRIDGE_SLOT | LO_EXPANSION_0_TO_7FFFH_MASK

MEM_CNFGOF:
        DEFB    HI_COLECOVISION_CARTRIDGE_SLOT | LO_OS7_N_INTRINSIC_2000H_7FFFH_MASK

;
; NOTE: these are defined global in EOS_COMM
;
;                         ;GLB    PORT_TABLE                  ;port value memory locations
;                         ;GLB    MEM_SWITCH_PORT
;                         ;GLB    NET_RESET_PORT
;                         ;GLB    VDP_CTRL_PORT
;                         ;GLB    VDP_DATA_PORT
;                         ;GLB    CONTROLLER_0_PORT
;                         ;GLB    CONTROLLER_1_PORT
;                         ;GLB    STROBE_SET_PORT
;                         ;GLB    STROBE_RESET_PORT
;                         ;GLB    SOUNDPORT
;
;        *******************************************************
;        *** VDP ports must remain next to each other        ***
;        ***   and in CTRL -> DATA order                    ***
;        *******************************************************

PORT_TABLE:

MEM_SWITCH_PORT:
                DEFB    07FH;MEM_SWITCH_PORT        defined here

NET_RESET_PORT:
                DEFB    03FH;Adam_net reset port    defined here

VDP_CTRL_PORT:
                DEFB    0BFH;VDP ctrl port          01D43H ; [RECON] OCR 848: scan opcode/data column is BF.

VDP_DATA_PORT:
                DEFB    0BEH;VDP data port          01D47H

CONTROLLER_0_PORT:
                DEFB    0FCH;Controller 0           01148H

CONTROLLER_1_PORT:
                DEFB    0FFH;Controller 1           01151H

STROBE_SET_PORT:
                DEFB    080H;Controller strobe set  01157H

STROBE_RESET_PORT:
                DEFB    0C0H;Controller strobe reset 01168H

SOUNDPORT:
                DEFB    0FFH;Sound port             0018EH
;
;===============================================================
;===============================================================
;===============================================================
;
;
; globals routines defined
;
;GLB    __WRITE_VRAM                         ;VDP support routines
;GLB    __READ_VRAM
;GLB    __WRITE_REGISTER
;GLB    __READ_REGISTER
;GLB    __FILL_VRAM
;GLB    __INIT_TABLE
;GLB    __PUT_VRAM
;GLB    __GET_VRAM
;GLB    __CALC_OFFSET
;GLB    __PX_TO_PTRN_POS
;GLB    __LOAD_ASCII
;GLB    __PUT_ASCII
;GLB    __WR_SPR_ATTRIBUTE

;GLB    __DECODER
;GLB    __POLLER                              ;controller support routines
;GLB    __UPDATE_SPINNER

;GLB    __DECLSN                              ;sound chip support routines
;GLB    __DECMSN
;GLB    __MSNTOLSN
;GLB    __ADD816
;GLB    __SOUND_INIT
;GLB    __TURN_OFF_SOUND
;GLB    __PLAY_IT
;GLB    __SOUNDS
;GLB    __EFFECT_OVER

;GLB    __SWITCH_MEM                          ;memory bank switch support routine
;GLB    __PORT_COLLECTION                     ;STORE THE PORT ADDRESSES FROM OS_7
;
; external data areas used
;
;EXT    VDP_MODE_WORD
;EXT    VDP_STATUS_BYTE
;EXT    VRAM_ADDR_TABLE
;EXT    SPRITEATTRTBL
;***    ;EXT    SPRITEGENTBL
;***    ;EXT    PATTRNNAMETBL
;EXT    PATTRNGENTBL
;***    ;EXT    COLORTABLE
;EXT    CUR_BANK

; controller data area
;EXT    SPIN_SW0_CT                         ;THESE TWO BYTES MUST BE IN THIS ORDER!!!
;***    ;EXT    SPIN_SW1_CT
;EXT    PERSONAL_DEBOUNCE_TABLE
;EXT    TEMP_STACK                          ;Used by put_ascii when bank switching
; sound data areas
;EXT    PTR_TO_LST_OF_SND_ADDRS
;EXT    PTR_TO_S_ON_0
;EXT    PTR_TO_S_ON_1
;EXT    PTR_TO_S_ON_2
;EXT    PTR_TO_S_ON_3
;EXT    SAVE_CTRL
;
;     Port address and bank select externals follow
;
;EXT    PORT_TABLE
;EXT    MEM_SWITCH_PORT
;***    ;EXT    NET_RESET_PORT
;EXT    VDP_CTRL_PORT
;***    ;EXT    VDP_DATA_PORT
;EXT    CONTROLLER_0_PORT
;***    ;EXT    CONTROLLER_1_PORT
;EXT    STROBE_SET_PORT
;***    ;EXT    STROBE_RESET_PORT
;EXT    SOUNDPORT

;***    ;EXT    SWITCH_TABLE
;EXT    MEM_CNFGOO
;***    ;EXT    MEM_CNFGO1
;***    ;EXT    MEM_CNFGO2
;***    ;EXT    MEM_CNFGO3
;***    ;EXT    MEM_CNFGO4
;***    ;EXT    MEM_CNFGO5
;***    ;EXT    MEM_CNFGO6
;***    ;EXT    MEM_CNFGO7
;***    ;EXT    MEM_CNFGO8
;***    ;EXT    MEM_CNFGO9
;***    ;EXT    MEM_CNFGOA
;***    ;EXT    MEM_CNFGO8
;***    ;EXT    MEM_CNFGOC
;***    ;EXT    MEM_CNFGOD
;***    ;EXT    MEM_CNFGOE
;***    ;EXT    MEM_CNFGOF
;
; externals used
;
;EXT    __WRITE_REGISTER
;***    ;EXT    __INIT_TABLE
;EXT    __SWITCH_MEM
;***    ;EXT    __PUT_VRAM
;EXT    __WRITE_VRAM
;EXT    __READ_VRAM
;
; local equates
;
LOC_IN_ALPHA    EQU     0102H;pointer to ascii gens in rev 28+ alpha
; Offsets into a volume descriptor (the first entry in the directory).
VOL_NAME        EQU     0;LOGICAL VOLUME NAME
VOL_DIRSIZE     EQU     12;*** 7 BITS ONLY *** # BLOCKS IN DIRECTORY
VOL_ATTR        EQU     12;*** TOP BIT ONLY *** SET FOR DELETE PROTECTION
VOL_DIR_CHECK   EQU     13; CONTAINS 4 UNIQUE BYTES FOR DIRECTORY EXISTENCE VERIFICATION
VOL_SIZE        EQU     17;VOLUME SIZE (IN BLOCKS) (4 BYTES)
VOL_YEAR        EQU     23;CREATION DATE -- YEAR
VOL_MONTH       EQU     24;                MONTH
VOL_DAY         EQU     25;                & DAY
VOL_DES_LENGTH  EQU     26

; Offsets into a directory entry.
DIR_NAME        EQU     0;FILE NAME
DIR_ATTR        EQU     12;FILE ATTRIBUTE BYTE
DIR_START_BLOCK EQU     13;STARTING BLOCK #
DIR_MAX_LENGTH  EQU     17;TOTAL # BLOCKS ALLOCATED
DIR_USED_LENGTH EQU     19;# OF BLOCKS USED (FULL + 1 PARTIAL)
DIR_LAST_COUNT  EQU     21;NUMBER OF BYTES IN LAST PARTIAL BLOCK
DIR_YEAR        EQU     23;CREATION DATE -- YEAR
DIR_MONTH      EQU     24;                MONTH
DIR_DAY        EQU     25;                & DAY
DIR_ENT_LENGTH: DEFL    26

ENT_PER_BLOCK  EQU     1024/26;NUMBER OF ENTRIES PER DIR BLOCK

; Offsets into an FCB header.

; Copy of DIR entry

FCB_NAME        EQU     0;FILE NAME
FCB_ATTR        EQU     12;FILE ATTRIBUTE BYTE
FCB_START_BLOCK EQU     13;STARTING BLOCK #
FCB_FIRST_BLOCK EQU     FCB_START_BLOCK
FCB_MAX_LENGTH  EQU     17;TOTAL # BLOCKS ALLOCATED
FCB_USED_LENGTH EQU     19;# OF BLOCKS USED (FULL + 1 PARTIAL)
FCB_LAST_COUNT  EQU     21;NUMBER OF BYTES IN LAST PARTIAL BLOCK

FCB_STORED_BYTES EQU    FCB_LAST_COUNT+1; NUMBER OF BYTES STORED ON DEVICE
; ... THE UPPER HALF OF THIS FCB EQU LIST

FCB_DEVICE      EQU     26-3;NUMBER OF DEVICE CONTAINING FILE
FCB_MODE        EQU     27-3;FILE MODE (UNUSED, READ, WRITE,APPEND)
FCB_BLOCK       EQU     28-3;BLOCK NUMBER CURRENTLY IN BUFFER
FCB_LAST_BLOCK  EQU     32-3;LAST BLOCK NUMBER IN FILE
FCB_POINTER     EQU     36-3;POINTER INTO BLOCK BUFFER
FCB_LENGTH      EQU     38-3

; Possible FCB modes.
;
; PROTECTED MODE EQUATES
;
MODE_UNUSED     EQU     0;MANY PEOPLE ASSUME THIS IS ZERO!
MODE_READ       EQU     MODE_UNUSED+1
MODE_WRITE      EQU     MODE_READ+1
MODE_UPDATE     EQU     MODE_WRITE+1
MODE_EXEC       EQU     MODE_UPDATE+1
MODE_MAX        EQU     MODE_EXEC+0
;
; duplicate historical definition: MODE_REMAINDER_BIT EQU   5           ; INDICATES TO ALLOCATE REST OF TAPE ; [RECON] Assembler dialect: active copy emitted in modern header.
; duplicate historical definition: MODE_DIRTY_BIT     EQU   6           ; TEST BIT 6 ; [RECON] Assembler dialect: active copy emitted in modern header.
MODE_DIRTY         EQU   01000000B; INDICATES MODIFIED BUFFER
; duplicate historical definition: MODE_LAST_BLOCK_BIT EQU  7           ; TEST BIT 7 ; [RECON] Assembler dialect: active copy emitted in modern header.
MODE_LAST          EQU   10000000B; INDICATES LAST BLOCK OF FILE
MODE_MODE          EQU   00000111B; BITS TO STORE MODES

; File attribute bits.
ATTR_PERMANENT    EQU   10000000B
ATTR_WRITE_PROT   EQU   01000000B
ATTR_READ_PROT    EQU   00100000B
ATTR_USER         EQU   00010000B
ATTR_SYSTEM       EQU   00001000B
ATTR_DELETED      EQU   00000100B
; duplicate historical definition: ATTR_DEL_BIT      EQU   2 ; [RECON] Assembler dialect: active copy emitted in modern header.
ATTR_EXECUTE      EQU   00000010B
; duplicate historical definition: ATTR_HOLE_BIT     EQU   0 ; [RECON] Assembler dialect: active copy emitted in modern header.
ATTR_HOLE         EQU   00000001B

; System-wide file name length.
NAME_LENGTH       EQU   12

; Numbers of things we have.
NUM_FCBS          EQU   3;1 FOR THE SYSTEM, 2 FOR THE USER
DCB_NOT_FOUND    EQU     1; THERE WAS NO DCB FOR THE DEVICE REQUESTED.
DCB_BUSY         EQU     2; DCB IS BUSY
DCB_IDLE_ERR     EQU     3; DCB IS IDLE

NO_DATE_ERR      EQU     4
NO_FILE_ERR      EQU     5
FILE_EXISTS_ERR  EQU     6
NO_FCB_ERR       EQU     7
MATCH_ERR        EQU     8
BAD_FNUM_ERR     EQU     9
EOF_ERR          EQU     10
TOO_BIG_ERR      EQU     11
FULL_DIR_ERR     EQU     12
FULL_TAPE_ERR    EQU     13
FILE_NM_ERR      EQU     14;DLS(8/28/83)
RENAME_ERR       EQU     15;DLS(8/30/83)
DELETE_ERR       EQU     16;DLS(8/30/83)
RANGE_ERR        EQU     17;DLS(8/31/83)

CANT_SYNC1       EQU     18
CANT_SYNC2       EQU     19
PRT_ERR          EQU     20

RQ_TP_STAT_ERR   EQU     21; [RECON] OCR 1088: restore printed symbol RQ_TP_STAT_ERR.
DEVICE_DEPD_ERR  EQU     22
PROG_NON_EXIST   EQU     23; PROGRAM DOES NOT CURRENTLY EXIST
NO_DIR_ERR       EQU     24; NO DIRECTORY ON TAPE
;THESE OUR EQUATES THAT ARE USED BY THE EOS PROGRAMS TO REFERENCE
;PCB AND DCB INFORMATION


;PCB EQUATES

P_COM_STAT      EQU     0; THIS IS THE COMMAND/STATUS BYTE

P_REL_ADDR      EQU     1; THIS IS THE RELOCATION ADDRESS
P_REL_ADDR_LO   EQU     P_REL_ADDR+0
P_REL_ADDR_HI   EQU     P_REL_ADDR+1

P_NUM_DCBS      EQU     3; THIS IS THE NUMBER OF DCBS DEFINED


P_SIZE: DEFL    4; THE NUMBER OF BYTES IN THE PCB



;DCB EQUATES

D_COM_STAT      EQU     0; THE COMMAND STATUS BYTE

D_BUF_ADR       EQU     1; ADDRESS OF THE DATA BUFFER
D_BUF_ADR_LO    EQU     D_BUF_ADR+0
D_BUF_ADR_HI    EQU     D_BUF_ADR+1

D_BUF_LEN       EQU     3; THE LENGTH OF THE DATA BUFFER
D_BUF_LEN_LO    EQU     D_BUF_LEN+0
D_BUF_LEN_HI    EQU     D_BUF_LEN+1

D_SECT_NUM      EQU     5; THE BLOCK DEVICE SECTOR NUMBER

D_SEC_DEV_ID    EQU     9; SECONDARY DEVICE ID

D_RET_COUNT     EQU     14; THE NUMBER OF TIMES A COMMAND WILL
; BE RETRIED.
D_RET_COUNT_LO  EQU     D_RET_COUNT+0
D_RET_COUNT_HI  EQU     D_RET_COUNT+1

D_DEV_ADDR      EQU     16; THE DEVICE ADDRESS (ID)

D_MAX_MSG_LEN   EQU     17; THE MAX LENGTH OF A DATA STRING
; FOR THE DEVICE
D_MAX_MSG_LN_LO EQU     D_MAX_MSG_LEN+0
D_MAX_MSG_LN_HI EQU     D_MAX_MSG_LEN+1

D_DEV_TYPE      EQU     19; THE DEVICE TYPE, BLOCKED OR CHARACTER

D_STATUS_FLAGS  EQU     20; DEVICE DEPENDENT STATUS FLAGS

D_SIZE: DEFL    21; THE NUMBER OF BYTES IN THE DCB



;DEVICE ID'S FOR THE KEYBOARD, PRINTER, AND TAPE DRIVE

KEYBOARD_ID     EQU     1; KYBD ID
PRINTER_ID      EQU     2; PRINTER ID
TAPE_ID         EQU     8; TAPE DRIVE ID

ERROR_RETRY     EQU     2; MAX RETRYS ON ERRORS, READ_BLOCK AND WRITE_BLOCK

MAX_DEV_ADDR    EQU     15; HIGEST POSSIBLE DEVICE ADDRESS
; ON NETWORK


;PCB COMMAND EQUATES


PCB_IDLE        EQU     0; THIS IS AN IDLE STATE

PCB_SYNC1       EQU     1; SYNC BYTE 1
PCB_SYNC1_ACK   EQU     PCB_SYNC1+80H

PCB_SYNC2       EQU     2; SYNC BYTE 2
PCB_SYNC2_ACK   EQU     PCB_SYNC2+80H

PCB_SNA         EQU     3; SET NEW PCB ADDRESS
PCB_SNA_ACK     EQU     PCB_SNA+80H

PCB_RESET       EQU     4; RESET ALL NODES
PCB_RESET_ACK   EQU     PCB_RESET+80H

PCB_WAIT        EQU     5
PCB_WAIT_ACK    EQU     PCB_WAIT+80H



;DCB COMMAND EQUATES

DCB_IDLE        EQU     00
DCB_STATUS      EQU     01; REQUEST STATUS
DCB_RESET       EQU     02; RESET NODE
DCB_WR          EQU     03; WRITE DATA TO DEVICE
DCB_RD          EQU     04; READ DATA FROM DEVICE



INIT_PCB_ADDR   EQU     0FEC0H; INITIAL ADDRESS OF THE PCB

FCB_S           EQU     0D390H; FCB HEADER AREA
THREE1K_BLKS    EQU     0D400H; 3K FCB DATA AREA


;GENERAL USAGE EQUATES FOR USE WITH DCB INFO

; duplicate historical definition: CMND_COMPLETE_BIT EQU   7       ; THIS IS THE BIT THAT INDICATES THE ; [RECON] Assembler dialect: active copy emitted in modern header.
; COMMAND HAS BEEN PROCESSED.
CMND_FIN_STATUS EQU     80H; THIS IS THE STATUS OF A COMMAND
; THAT COMPLETED WITH NO ERRORS
KBD_NAK         EQU     8CH; INDICATES NO KEY READY

PR_NAK          EQU     86H; INDICATES THE PRINTER IS BUSY ; [RECON] OCR 1207: scan value column is <0086>.

ETX             EQU     03H; END OF DATA STRING INDICATOR

TIMEOUT         EQU     9BH; DEVICE TIMED OUT
;
;===============================================================
;===============================================================
;===============================================================

; SKIP
; NAME ^Rev 07 - jkl^

; De_A_uOS_00 MACRO                         ;Header Rev. 5
;         .GOTO Ede_A_uOS_00

; Project:        ADAM, 83-101

;         ***************************************************************
;         ****                                                     ****
;         ****                A_uOS_00              RPD             ****
;         ****                                                     ****
;         ***************************************************************


;         Rev History
;         Rev.  Date        Name        Change
;         7     08oct1545   jkl         make __LOAD_ASCII load chars from 0 to 7F
;         6     08oct0003   rfj         fixed 100H bug with Bob Greenberg's
;                                     algorithm
;         5     07oct1708   rfj         __EFXOVER changed to __EFFECT_OVER
;         4     05oct10:40  rfj         Decoder now saves Acc before getting
;                                     interrupt data
;                                     Removed excess documentation on Put/Load Ascii
;                                     Commented out all unreferenced symbols with ;***
;                                     Renamed WR_SPR_NM_TBL to WR_SPR_ATTRIBUTE
;                                     globalized __UPDATE_SPINNER
;                                     new address for the ASCII table referenced
;         3     28sept1317  rfj         Multy changes after personal review
;                                     but not approved
;         2     25sept900a  RPD         made ram external
;         1     24sept1250p RPD         addition of more routines & new port accessing
;         0     24aug430p   RPD         Initial creation date (READ & WRITE VRAM)

; A_uOS_00 stands for ADAM micro Operating System version 0. This file
; contains a scaled down model of COLECOVISION OS 7. Primary routines from
; OS 7 are duplicated for ADAM application programs use. The functional areas
; that are supported by these routines are the VDP, the controllers, the sound
; chip, memory bank switch, port collection.


; ;***************************************************************

; [RECON assembler] Named section preserves OCR block order for z80asm.
        SECTION code
        ORG     EOS_CODE

;***************************************************************

; Name:          WRITE_VRAM
;
; Function:      Writes to VRAM the contents of the data in a buffer area.
;
; Entry:         BC - number of bytes to be written
;                DE - starting VRAM address to be written to
;                HL - address of buffer containing the data
;
; Exit:          None.
;
; Registers used: AF, BC, DE, HL
;
; Size:          ROM - 28 bytes
;                RAM - 0 bytes
;
; Comments:      This version of WRITE_VRAM is provided for EOS operation.
;                NOTE: The 100H bug found in OS 7 has been corrected.
;
; Comparison:    left out pascal entry point
;                code compacted
;                100H bug fixed
;                edited for documentation
;                reference port table

__WRITE_VRAM:
        PUSH    BC;BC has the number of bytes to xfer
        EX      DE,HL;HL<--vram addr,DE<--source address
        CALL    SET_WRITE;pump the vram addr to the vdp
        LD      L,C;save C (the data_port_addr)
        POP     BC;restore the xfer count
        EX      DE,HL;HL<--source address,port in E
        LD      A,C;Save low order of count in A
        LD      C,E; And get the port into C
        LD      D,B;Get HI order count in D
; to free up B for low order count
        INC     D;Increment HI count to cover
; for 0 in DEC D after low loop
        LD      B,A;Put low order in B for OUTI
        OR      A;Check if low order is zero the first time
        JR      Z,OUT_DEC_HI_BYTE;If so then decrement HI count before low loop
OUTPUT_LOOP:
        OUTI;DATA_PORT = buffer_data  write the data to the VDP
;for OUTI: (C) <- (HL), B = B - 1 and HL = HL + 1
        NOP;Delay for slow VDP
        NOP
        JR      NZ,OUTPUT_LOOP;until byte count low (B reg) = 0
OUT_DEC_HI_BYTE:
        DEC     D;byte count high = byte count high - 1
        JR      NZ,OUTPUT_LOOP;until byte count high (A reg) = 0
        RET
;
; Name:          READ_VRAM
;
; Function:      Reads from VRAM and puts the read data into a buffer area.
;
; Entry:         BC - number of bytes to be read
;                DE - starting VRAM address to be read from
;                HL - address of buffer to receive the read data
;
; Exit:          None.
;
; Registers used: AF, BC, DE, HL
;
; Size:          ROM - 22 bytes
;                RAM - 0 bytes
;
; Comments:      This version of READ_VRAM is provided for stand alone operation.
;                NOTE: The 100H bug found in OS 7 has been corrected.
;
; Comparison:    left out pascal entry point
;                code compacted
;                100H bug fixed
;                edited for documentation
;
__READ_VRAM:
        PUSH    BC;BC has the number of bytes to xfer
        EX      DE,HL;HL<--vram addr,DE<--source address
        CALL    SET_READ;pump the vram addr to the vdp
        LD      L,C;save C (the data_port_addr)
        POP     BC;restore the xfer count
        EX      DE,HL;HL<--source address,port in E
        LD      A,C;Save low order of count in A
        LD      C,E; And get the port into C
        LD      D,B;Get HI order count in D
; to free up B for low order count
        INC     D;Increment HI count to cover
; for 0 in DEC D after low loop
        LD      B,A;Put low order in B for OUTI
        OR      A;Check if low order is zero the first time
        JR      Z,IN_DEC_HI_BYTE;If so then decrement HI count before low loop
INPUT_LOOP:
        INI;DATA PORT = buffer data  read the data from to the VDP
;for INI: (C) <-- (HL), B = B - 1 and HL = HL + 1
        NOP;delay for slow VDP
        NOP
        JR      NZ,INPUT_LOOP;until byte count low (B reg) = 0
IN_DEC_HI_BYTE:
        DEC     D;byte count high = byte count high - 1
        JR      NZ,INPUT_LOOP;until byte count high (A reg) = 0
        RET
;
; Name:          WRITE_REGISTER
;
; Function:      Writes a data byte value to a desired VDP register
;
; Entry:         B - register number to write to
;                C - data byte value to be written
;
; Exit:          If register number = 0 or 1, the respective byte
;                of the VDP_MODE_WORD is updated.
;
; Registers used: A,BC,E
;
; Size:          ROM - 27 bytes
;                RAM - 0 bytes
;
; Comments:      This version of WRITE_REGISTER is provided for stand alone operation.
;
; Comparison:    left out pascal entry point
;                code compacted
;                edited for documentation
;
__WRITE_REGISTER:
        LD      E,C;Move data to E register
        LD      A,(VDP_CTRL_PORT);Get the control port value
        LD      C,A;Put in C
        OUT     (C),E;Output data value.
        LD      A,B;Get port # in A
        OR      80H;Set high bit for ???????
        OUT     (C),A;Out to VDP
        LD      A,B;Get back port value
        OR      A;Check for zero
        LD      A,E;Put data in accumulator

        JR      NZ,CHK_REG_1;If not zero then see if register 1
        LD      (VDP_MODE_WORD),A;If register zero was written to then
; save data in VDP_MODE_WORD
        RET;Exit

CHK_REG_1:
        DEC     B;Check for register 1 in B
        RET     NZ;If not then return
        LD      (VDP_MODE_WORD+1),A;If so then store data in VDP_MODE_WORD+1
        RET;Exit

;
; Name:          READ_REGISTER
;
; Function:      Reads a data byte value from the Colecovision CTRL_PORT.
;
; Entry:         None.
;
; Exit:          A - data byte value read in
;
; Registers used: A,C
;
; Size:          ROM - 3 bytes
;                RAM - 0 bytes
;
; Comments:      This version of READ_REGISTER is provided for stand alone operation.
;                This routine does a direct access to the COLECOVISION I/O ports.
;
; Comparison:    edited for documentation
;
__READ_REGISTER:
        LD      A,(VDP_CTRL_PORT)
        LD      C,A
        IN      A,(C);get the data from CTRL_PORT
        LD      (VDP_STATUS_BYTE),A;save a copy of VDP status data
        RET

;
; Name:          FILL_VRAM
;
; Function:      Fill a VRAM memory buffer with a constant byte value.
;
; Entry:         A  - constant byte value to be written
;                DE - number of bytes in the VRAM memory buffer
;                HL - starting VRAM address to be written to
;
; Exit:          None.
;
; Registers used: AF, C, DE
;
; Size:          ROM - 18 bytes
;                RAM - 0 bytes
;
; Comments:      This version of FILL_VRAM is provided for stand alone operation.
;                This routine does a direct access to the COLECOVISION I/O ports.
;
; Comparison:    edited for documentation
;                uneeded call to READ_REGISTER taken out
;
;
__FILL_VRAM:
        PUSH    AF;Save the data to fill with
        CALL    SET_WRITE;Sets the ctrl port data and
        POP     HL;popping AF into HL to restore the fill data
FILL:;repeat
; get back a copy of the saved constant
        OUT     (C),H; write the constant out to the VRAM buffer
        DEC     DE; byte count = byte count - 1
        LD      A,D;until byte count = 0
        OR      E
        JR      NZ,FILL
        RET;all done
;
;
; Name:          INIT_TABLE
;
; Function:      INIT_TABLE initializes the addresses of the VRAM tables.
;                The passed address is converted to the correct format needed
;                to setup the VDP address registers. The following table codes
;                are use to indentify which table address is being setup:
;
;                    0 - SPRITE ATTRIBUTE TABLE  (SAT)
;                    1 - SPRITE GENERATOR TABLE  (SGT)
;                    2 - PATTERN NAME TABLE      (PNT)
;                    3 - PATTERN GENERATOR TABLE (PGT)
;                    4 - PATTERN COLOR TABLE     (PCT)
;
; Entry:         A  - table code (see above)
;                HL - table address
;
; Exit:          None.
;
; Registers used: AF, BC, HL, IX, IY
;
; Size:          ROM - 99 bytes
;                RAM - 0 bytes
;
; Comments:      This version of INIT_TABLE is provided for stand alone operation.
;
; Comparison:    left out pascal entry point
;                code compacted
;                edited for documentation
;
__INIT_TABLE:

        LD      C,A;BC = index into VRAM_ADDR_TABLE  table code
        LD      B,0
        LD      IX,VRAM_ADDR_TABLE;point to start of VRAM_ADDR_TABLE
        ADD     IX,BC;add in the index
        ADD     IX,BC
        LD      (IX+0),L;save the address
        LD      (IX+1),H
;CHECK VDP GRAPHICS MODE
        LD      A,(VDP_MODE_WORD);if VDP_MODE_WORD bit 1  mode bit 3 = 1
        BIT     1,A
        JR      Z,INIT_TABLE80
; its graphics mode 2, look for PGT or PCT first
        LD      A,C; get the table code
        CP      3; if table code = PGT
        JR      Z,CASE_OF_GEN; then setup PGT address
        CP      4; if table code = PCT
        JR      Z,CASE_OF_COLOR; then setup PCT address
        JR      INIT_TABLE80; else not a special case, use normal setup
;
; special case: graphics mode 2, address of PGT
;
CASE_OF_GEN:
        LD      B,4;register number = PGT base address register
        LD      A,L;if PGT address = 0000H
        OR      H
        JR      NZ,CASE_OF_GEN10
        LD      C,3; data byte value for address 0000H
        JR      INIT_TABLE90
CASE_OF_GEN10:;else  PGT address <> 0000H
        LD      C,7; data byte value for address 2000H
        JR      INIT_TABLE90;endif
;
; special case: graphics mode 2, address of PCT
;
CASE_OF_COLOR:
        LD      B,3;register number = PCT base address register
        LD      A,L;if PCT address = 0000H
        OR      H
        JR      NZ,CASE_OF_CLR10
        LD      C,7FH; data byte value for address 0000H
        JR      INIT_TABLE90
CASE_OF_CLR10:;else  PCT address <> 0000H
        LD      C,0FFH; data byte value for address 2000H
        JR      INIT_TABLE90;endif
;
; not a special case (i.e. not mode 2, PGT or PCT)
;
INIT_TABLE80:;base address = table address / factor
        LD      IY,BASE_FACTORS;point to start of the the factor table
        ADD     IY,BC;Index into the table by the table code
        ADD     IY,BC
        LD      A,(IY+0);get the shift count
        LD      B,(IY+1);get the register number
DIVIDE:
        SRL     H;shift hi-byte
        RR      L;shift lo-byte
        DEC     A;shift count = shift count - 1
        JR      NZ,DIVIDE
        LD      C,L;get the data byte value
INIT_TABLE90:
        CALL    WRITE_REGISTER;setup the base register
        RET
;
; base factor table. used to calculate base addresses
;
BASE_FACTORS:
        DEFB    7;table code 0 base factor
        DEFB    5;register 5, SAT base address
        DEFB    11;table code 1 base factor
        DEFB    6;register 6, SGT base address
        DEFB    10;table code 2 base factor
        DEFB    2;register 2, PNT base address
        DEFB    11;table code 3 base factor
        DEFB    4;register 4, PGT base address
        DEFB    6;table code 4 base factor
        DEFB    3;register 3, PCT base address
;
; Name:          PUT_VRAM
;
; Function:      Gets a block of data from a user buffer and puts it into VRAM.
;                The following table codes are used to identify which VRAM table
;                is being referenced:
;
;                    0 - SPRITE ATTRIBUTE TABLE  (SAT)
;                    1 - SPRITE GENERATOR TABLE  (SGT)
;                    2 - PATTERN NAME TABLE      (PNT)
;                    3 - PATTERN GENERATOR TABLE (PGT)
;                    4 - PATTERN COLOR TABLE     (PCT)
;
; Entry:         A  - table code (see above)
;                DE - starting index into the table
;                HL - address of user buffer
;                IY - block size (or byte count)
;
; Exit:          None.
;
; Registers used: AF, DE, HL, IY
;
; Routines used: SET_COUNT
;
; Size:          ROM - 0 bytes
;                RAM - 0 bytes
;
; Comments:      This version of PUT_VRAM is provided for stand alone operation.
;
; Comparison:    left out pascal entry point
;                took out the mux sprites capability
;                code compacted
;                edited for documentation
;
__PUT_VRAM:
        CALL    SET_COUNT;setup the actual byte count and the absolute VRAM address
;       CALL    WRITE_VRAM                  ;VRAM data = user buffer
;       RET
        JP      WRITE_VRAM
;
; Name:          GET_VRAM
;
; Function:      Gets a block of data from VRAM and stores it into a user buffer.
;                The following table codes are used to identify which VRAM table
;                is being referenced:
;
;                    0 - SPRITE ATTRIBUTE TABLE  (SAT)
;                    1 - SPRITE GENERATOR TABLE  (SGT)
;                    2 - PATTERN NAME TABLE      (PNT)
;                    3 - PATTERN GENERATOR TABLE (PGT)
;                    4 - PATTERN COLOR TABEL     (PCT)
;
; Entry:         A  - table code (see above)
;                DE - starting index into the table
;                HL - address of user buffer
;                IY - block size (or byte count)
;
; Exit:          None.
;
; Registers used: AF, DE, HL, IY
;
; Routines used: SET_COUNT
;
; Size:          ROM - 0 bytes
;                RAM - 0 bytes
;
; Comments:      This version of GET_VRAM is provided for stand alone operation.
;
; Comparison:    left out pascal entry point
;                code compacted
;                edited for documentation
;
__GET_VRAM:
        CALL    SET_COUNT;setup the actual byte count and the absolute VRAM address
;       CALL    READ_VRAM                   ;user buffer = VRAM data
;       RET
        JP      READ_VRAM
;
; CALLED BY PUT_VRAM_ AND GET_VRAM_
;
; SETS BYTE COUNT AND INDEX FOR WRITES TO AND READS FROM VRAM.
;
; TABLE          BYTES/ITEM
; SPRITE_NAME    4
; SPRITE_GEN     8
; PATTERN_NAME   1
; PATTERN_GEN    8
; COLOR (MODE 1) 1
; COLOR (MODE 2) 8
;
SET_COUNT:
        PUSH    IY;Save count on stack
        LD      C,A;Get table code #
        CP      4;See if color table
        JR      NZ,NOT_COLOR_TBL_ACCESS;If not then check for name table
;Color Table
        LD      A,(VDP_MODE_WORD);Get mode word to check graphics type
        AND     02H;Bit 1 indicates mode 1 or 2
        JR      Z,ADD_TO_BASE;If mode 1 then start index is not modified
        LD      A,C;Get table code back
;Fall through to multiply by 8 for mode 2.
NOT_COLOR_TBL_ACCESS:
        CP      2;Check for Name table
        JR      Z,ADD_TO_BASE;If so then don't modify start index
;At this point the table code is:
; Sprite attribute table, Sprite gen table,
; Pattern gen table, or Color table in Mode 2

        EX      DE,HL;Get count in HL
        ADD     HL,HL;*2

        ADD     HL,HL;*4
        OR      A;Check for Sprite attr table
        JR      Z,HAVE_CNT;If so then index*4 is complete
        ADD     HL,HL;If not then index*8 is required
; this is for the pattern gen table,
; sprite gen table, or color gen table
; in mode 2.
HAVE_CNT:
        EX      DE,HL;Put updated index in DE
        EX      (SP),HL;Get count off stack
;Put address of RAM buffer on stack

;Now modify the count for:
; Sprite attribute table, Sprite gen table,
; Pattern gen table, or Color table in Mode 2
        ADD     HL,HL
        ADD     HL,HL
        JR      Z,HAVE_CNT2;If Sprite attr table then *4 is enough
; (the zero flag is still set from earlier)
        ADD     HL,HL;Count *8 for remaining tables
HAVE_CNT2:
        EX      (SP),HL;Save updated count on stack
;Restore RAM buffer off stack
ADD_TO_BASE:
        LD      A,C;Get table code back
        LD      BC,VRAM_ADDR_TABLE;Get top of address table
        PUSH    HL;Save RAM buffer on stack
        LD      H,00H;Put table code into HL
        LD      L,A
        ADD     HL,HL;*2 to offset for addresses in table
        ADD     HL,BC;Add to top of table
        LD      A,(HL);Low byte of VRAM table address
        INC     HL
        LD      H,(HL);High byte of VRAM table address
        LD      L,A
        ADD     HL,DE;Add offset from start of table
        EX      DE,HL;Absolute VRAM address in DE
        POP     HL;Restore RAM buffer address
        POP     BC;Restore Count into BC
;Registers are now ready for
; a call to the basic READ/WRITE VRAM routines
        RET;Exit
;*************** CALC_OFFSET ***************************************
;
;DESCRIPTION:   THIS ROUTINE CALCULATES THE PROPER OFFSET INTO THE NAME TABLE
;               FOR THE PATTERN POSITION GIVEN BY X_PAT_POS, Y_PAT_POS. THE
;               FORMULA USED IS: OFFSET = 32*Y_PAT_POS + X_PAT_POS
;
;INPUT:         D = Y_PAT_POS
;               E = X_PAT_POS
;
;OUTPUT:        DE = OFFSET
;
;********************************************************************
;
__CALC_OFFSET:
        PUSH    HL;Save HL
        BIT     7,D;If Y_PAT_POS is minus
        JR      Z,ELSE_11
        LD      H,0FFH; extend negative sign
        JR      END_IF_11
ELSE_11:;else
        LD      H,0; extend positive sign
END_IF_11:;endif

        LD      L,D;OFFSET = 32*Y_PAT_POS + X_PAT_POS
        ADD     HL,HL;HL=2*Y_PAT_POS
        ADD     HL,HL; 4* "
        ADD     HL,HL; 8* "
        ADD     HL,HL; 16* "
        ADD     HL,HL; 32* "

        BIT     7,E;If X_PAT_POS is minus
        JR      Z,ELSE_12
        LD      D,0FFH; extend negative sign
        JR      END_IF_12
ELSE_12:;else
        LD      D,0; extend positive sign
END_IF_12:;endif

        ADD     HL,DE;HL=32*Y_PAT_POS + X_PAT_POS
        EX      DE,HL
        POP     HL;restore HL intact
        RET
;******************* PX_TO_PTRN_POS *******************************
;DESCRIPTION:   DIVIDES REG DE BY 8. IF SIGNED RESULT > 127 THEN E := MAX SIGNED
;               POSITIVE NUMBER. IF RESULT < -128, THEN E := MIN NEGATIVE NUM
;INPUT:         DE = 16 BIT SIGNED NUMBER
;OUTPUT:        DE/8 < -128        E = -128
;              -128 <= DE/8 <= +127        E = DE/8
;              +127 < DE/8        E = +127
;********************************************************************
;
__PX_TO_PTRN_POS:

        PUSH    HL;HL USED TO TEST MAGNITUDE
;
        PUSH    BC;B WILL BE USED AS A COUNTER IN THE DIVIDE
        LD      B,3
PX_2_P_P_1:;(THIS IS THE START OF THE DIVIDE LOOP)
        SRA     D;16 BIT SHIFT LEFT
        RR      E
        DJNZ    PX_2_P_P_1;DIVIDE BY 8 LOOP
        POP     BC;RESTORE BC TO OLD VALUE
;
        LD      HL,0FF80H;SET HL TO -128
        BIT     7,D;IS RESULT OF DIVIDE NEGATIVE?
        JR      NZ,NEGTV
;
        ADD     HL,DE;IF DE-128 < 0 (Fnc) RETURN
        POP     HL;same as (IF DE<=127 RETURN)
        RET     NC
        LD      E,7FH;IF > 128, THEN E := MAX SIGNED + NUM.
        RET
;
NEGTV: LD      H,00H;SET HL TO 128
;
        ADD     HL,DE;IF DE+128 >= 0 RETURN
        POP     HL;same as (IF DE>=-128 RETURN)
        RET     C
        LD      E,80H;IF < -128, THE E := MIN SIGNED - NUM.
        RET
DEL            EQU     7FH;ASCII code for it
;ASCII_GEN      EQU     LOC_IN_ALPHA            ;1st byte of generator for NUL
;
;__LOAD_ASCII
;
;   Loads the ASCII character generators into VRAM at the
;   current pattern generator table (NOTE - INIT_TABLE must
;   have been called prior to this). Only the characters
;   from the space to the DEL (20h to 7Fh) are loaded.
;
;Input Parameters:
;   NONE
;
;Returns:
;   A, BC, HL, DE are destroyed
;
;   Falls into __PUT_ASCII
;
__LOAD_ASCII:
;LD     HL,(PATTRNGENTBL)            ;get base of current generator table
        LD      DE,(PATTRNGENTBL);get base of current generator table
;LD     DE,00H+8                     ;Offset into it where SPACE will be
;ADD    HL,DE
;EX     DE,HL                        ;leave VRAM address in DE
        LD      HL,00H;want to start with the null
        LD      BC,DEL-00H+1;load the entire ASCII set (0..7F) ; [RECON] Assembler dialect: parentheses are arithmetic grouping in the HP source.
;
; fall thru to PUT_ASCII
;
;
; __PUT_ASCII
;
;   Copys a specified number of ASCII character generators into VRAM.
;   Swaps to ROM that contains the generators then swaps back, keeps
;   track of callers stack and uses a local stack that is known to
;   be in RAM when the ROM is swapped in.
;
;Input Parameters:
;   HL - Character to 1st load (generally in range 0..FFH)
;   BC - Number of characters to load (Not the number of bytes)
;   DE - Address in VRAM to load the 1st generator
;
;   A, BC, HL, DE, IX  are destroyed
;
;   Calls WRITE_VRAM
;         SWITCH_MEM
;
__PUT_ASCII:
        ADD     HL,HL;multiply char to start loading by 8
        ADD     HL,HL;so can use it as an offset into the
        ADD     HL,HL;ASCII generator
        PUSH    BC;save number of chars desired
;LD     BC,ASCII_GEN
;LD     BC,(LOC_IN_ALPHA)
;ADD    HL,BC                       ;now HL points to the 1st generator desired
        EX      (SP),HL;get number of chars desired
        ADD     HL,HL;and multiply by 8
        ADD     HL,HL; since each generator is 8 bytes
        ADD     HL,HL; long
        EX      (SP),HL;get back pointer into ASCII generators
        POP     BC;get number of chars times 8

        LD      IX,0000H; to use to save callers SP
        ADD     IX,SP
        LD      SP,TEMP_STACK;set stack into known RAM
        PUSH    IX;save callers SP

        LD      A,(CUR_BANK);remember which bank setting we
        PUSH    AF; are in
        LD      A,(MEM_CNFGOO);get value to let us get at the ALPHA roms

        PUSH    BC;count would get destroyed by SWITCH_MEM
        CALL    SWITCH_MEM
        POP     BC

        PUSH    DE
        LD      DE,(LOC_IN_ALPHA)
        ADD     HL,DE
        POP     DE

        CALL    WRITE_VRAM

        POP     AF;get back callers mem configuration
        CALL    SWITCH_MEM

        POP     HL;get callers SP
        LD      SP,HL;and restore it
        RET; and back to caller
;
;   Switch_mem: memory bank switching routine
;
;   Inputs:
;       A = Appropriate input from SWITCH_TABLE
;
;       Example:
;   Switch Table Offset   Memory configuration
;   ---------------------------------------------------------------
;
;       0 -             Boot ROM and Alpha Roms
;       1 -             Intrinsic RAM (0000H thru 7FFFH)
;       2 -             Expansion memory (0000H thru 7FFFH)
;       3 -             OS_7 and intrinsic RAM (2000H thru 7FFFH)
;       4
;       .
;       D
;       E
;       F
;
;   ***Note: The values in the table are subject to change in future
;            releases of ADAM hardware.
;
;   For an example of the use of SWITCH_MEM see PORT_COLLECTION below.
;
;
;   Outputs:
;       CUR_BANK, a defined memory location will contain
;       the updated input parameter for applications and
;       EOS routines which need to determine which
;       memory space is currently active.
;
__SWITCH_MEM:
        LD      B,A;SAVE THE PORT DATA TO WRITE
        LD      A,(MEM_SWITCH_PORT);GET THE PORT NUMBER
        LD      C,A
        OUT     (C),B;SWITCH MEMORY BANKS
        LD      A,B
        LD      (CUR_BANK),A;REMEMBER WHAT WAS SWITCHED TO.
        RET
;
;   Port collection must be called during initialization
;   It switches to OS7 ROM grabs the ports and switches back
;

__PORT_COLLECTION:
        LD      A,(CUR_BANK);GET THE CURRENT BANK
        PUSH    AF
;
        LD      A,(MEM_CNFGO3);SWAP IN THE OS
        CALL    SWITCH_MEM
        LD      HL,PORT_TABLE+2;HL POINTS TO THE PORT TABLE
;
        LD      A,(01D43H);VDP CONTROL PORT
        LD      (HL),A
        INC     HL
;
        LD      A,(01D47H);VDP DATA PORT
        LD      (HL),A
        INC     HL
;
        LD      A,(0114BH);CONTROLLER 0 ; [RECON] OCR 1981: scan bytes are 3A 4B 11.
        LD      (HL),A
        INC     HL
;
        LD      A,(01151H);CONTROLLER 1
        LD      (HL),A
        INC     HL
;
        LD      A,(01157H);CONTROLLER STROBE SET
        LD      (HL),A
        INC     HL
;
        LD      A,(01168H);CONTROLLER STROBE RESET
        LD      (HL),A
        INC     HL
;
        LD      A,(0018EH);SOUND PORT
        LD      (HL),A
        POP     AF
        CALL    SWITCH_MEM
        RET
;
; Name:          WR_SPR_ATTRIBUTE
;
; Function:      Transfers the local copy of the sprite attribute table
;                to VRAM. WR_SPR_ATTRIBUTE will also reorder the
;                sprite table to reduce 5th sprite priority problems.
;
; Entry:         DE - address of Local Sprite Table
;                HL - address of Priority table
;                A  - number of sprites to be transfered (length of Local Sprite
;                     table divided by 4)
; Exit:          None.
;
; Registers used: AF, BC, DE, HL,
;
; Data structures accessed:
;                VRAM_ADDR_TABLE (SPRITEATTRTBL) for the starting address
;                of the sprite attribute table in VRAM.
;
;                PORT_PTR_TABLE (CTRL_PORT_PTR, DATA_PORT_PTR) for
;                VDP port access.
;
;                Local Sprite Table - User defined memory image of
;                the sprite attribute table
;
;                Priority Table - User defined sprite priority list
;                for the transfer of the sprite attributes
;
; Size:          ROM - xx bytes
;                RAM - xx bytes
;
; Comments:
;
; Comparison:    left out pascal entry point
;                added register parameters in place of defined memory pointers
;                code compacted
;                edited for documentation
;
__WR_SPR_ATTRIBUTE:
;Initialize VDP address pointer
        PUSH    AF
        PUSH    HL
        LD      HL,(SPRITEATTRTBL)
        CALL    SET_WRITE
        POP     HL
        POP     AF
        LD      B,A
;B = Sprite Count
;C = port address
;DE = address of Local Sprite Attribute Table
;HL = address of Priority table
;VDP is initialized to appropriate address
LOOP_EVERY_SPRITE:

;               Index to sprite with the next highest priority

        LD      A,(HL);Get current sprite as defined by the priority table
        ADD     A,A;*2 multiply by an attribute entry (4)
        ADD     A,A;*4

        INC     HL;Index to next location in priority table
        PUSH    HL;Save for next sprite

        LD      L,A;Offset into the Local Sprite Table by the current priority
        LD      H,0
        ADD     HL,DE


        LD      A,B;Save sprite count in Acc.
        LD      B,4;Set count for write to VRAM
;C has port address
;HL has the pointer to a sprite's attributes
LOOP_EVERY_BYTE:
        OUTI;Output a byte
        NOP;Wait for VDP to catch up (worst case)
        NOP
        JR      NZ,LOOP_EVERY_BYTE

        LD      B,A;Restore sprite count to B register
        POP     HL;Restore index into the priority table
        DJNZ    LOOP_EVERY_SPRITE; If more sprites left then loop back

        RET;Else exit
;
; Name:          SET_READ / SET_WRITE
;
; Function:      Initiates the VDP for reads or writes.
;
; Entry:         HL - VRAM address to start read / writes
;
; Exit:          C register contains the VDP_DATA_PORT value
;                HL remains unchanged
;
; Registers used: AF, BC, HL,
;
; Data structures accessed:
;
;                PORT_TABLE (CTRL_PORT_PTR, DATA_PORT_PTR) for
;                VDP port access.
;
; Size:          ROM - xx bytes
;                RAM - xx bytes
;
; Comments:
;
; Comparison:
;
SET_READ:
        XOR     A;Clear accumulator for later OR which
; determines a read or write

        DEFB    0C2H;This is the beginning of a JP NZ which
; will never be true but leaves the
; accumulator intact over the next
; two bytes ( the LD A,40H is decoded
; as the last two bytes of the jump
SET_WRITE:
        LD      A,40H;Set bit to tell VDP that write is requested

        LD      BC,(VDP_CTRL_PORT);Get BOTH port addresses
        OUT     (C),L;Output low 8 bits of address
        OR      H;OR read/write bit (Bit 6) into the high 8 bytes
        OUT     (C),A;Output result
        LD      C,B;Put DATA_PORT value into the C register

        RET;Exit to caller
;CONTROLLER SOFTWARE
;
;*********************DATA******************************
;
;  DECODER TABLE FOR THE KEYBOARD

;
DEC_KBD_TBL:
        DEFB    KBD_NULL; NULL ENTRY
        DEFB    6; '6'
        DEFB    1; '1'
        DEFB    3; '3'
        DEFB    9; '9'
        DEFB    0; '0'
        DEFB    10; '*'
        DEFB    12; Purple Action Controller key (third one down)
        DEFB    2; '2'
        DEFB    11; '#'
        DEFB    7; '7'
        DEFB    13; Blue Action Controller key (fourth (or last) one down
        DEFB    5; '5'
        DEFB    4; '4'
        DEFB    8; '8'
        DEFB    KBD_NULL; NULL ENTRY

KBD_NULL       EQU     0FH
KBD_MASK       EQU     0FH;MASK FOR INPUT DATA BYTE
FIRE_MASK      EQU     40H
ARM_MASK       EQU     40H
JOY_MASK       EQU     0FH

;
;__DECODER
;        Will read all the data, from both segments, for a given controller
;        All data is returned in registers
;        Segment 0 data is returned the same as with OS-7
;
;        NOTE - some operations are done in an odd order so that a certain
;        number of cycles (T states) pass between port addressing.
;        Turns off interrupts if they were on at entry time for
;        195 T states (approx. 54.5 micro secs), the interupts
;        are reenabled after this time if they were on before.
;
;        Callers  -  The input parameters are different than OS-7 and
;                    both segments are returned so only one call is required
;                    for all the data from a given controller.
;                    The values returned are the same for segment 0 (H, L, E)
;                    but segment 1 values are returned in B and D.
;
;Stack Usage:
; Uses 2 words (pushes only)
;
;Input Parameters:
; A  - controller number, 0 or 1
;
;Returns:
; H  - fire button data
; L  - joystick data
; B  - arm button data
; C  - raw data for segment 0, (joystick, fire)
; D  - keyboard data
; E  - spinner count data
; A  - raw data for segment 1, (keyboard, arm, super controller buttons)
;
; SPIN_SWx_CT  - reset to 0 after read
;
; strobe port left in the reset condition
;
;Date:
; 9/24/83   11:14   JKL
;
__DECODER:
        LD      C,A;Save controller #
        LD      A,I;get current state of interupts, on/off, into P/V flag
        PUSH    AF;and save for later so can turn them back on if needed
        DI ; [RECON] OCR address gap at 2209 and ROM byte F3 restore DI at $E20A.
        LD      A,C;Restore controller #
        LD      BC,(STROBE_SET_PORT);C<--SET PORT, B<--RST PORT
        OUT     (C),A;STROBE TO SEGMENT 1 (SET)
        LD      D,B;SAVE RESET PORT
        LD      HL,SPIN_SW0_CT;point at spinner count for controller 0
        LD      BC,(CONTROLLER_0_PORT);C<--PORT_0, B<--PORT_1
        OR      A;A contains controller number
        JR      NZ,GOT_CORRECT_CONTROLLER_IN_C
        INC     HL;Point to spinner for ctrlr 1
        LD      C,B;C--PORT_1

GOT_CORRECT_CONTROLLER_IN_C:
        XOR     A
        LD      E,(HL);HAVE SPIN SWITCH COUNT
        LD      (HL),A;RESET COUNT
        LD      B,D;B<--RST PORT
        IN      A,(C);READ DATA FROM SEG 1
        CPL
;
        LD      H,0
        LD      L,A;HL<--offset into DEC_KBD_TBL
        LD      A,C;swap RST_PORT/DATA_PORT
        LD      C,B
        OUT     (C),A;STOBE TO SEG_0 (reset)
        LD      C,A;C<--DATA PORT
        POP     AF;get back entry state of interupt reg
        JP      PO,LEAVE_THEM_OFF
        EI;turn interupts back on only if they were on entry
LEAVE_THEM_OFF:
        LD      A,L;restore raw data segment 1 ; [RECON] OCR 2238: scan bytes are 7D and mnemonic is LD A,L.
        PUSH    AF
        AND     ARM_MASK;Test sleeve
        LD      B,A;HAVE ARM DATA    (in B)
        LD      A,L
        AND     KBD_MASK;isolate KBD data
        LD      L,A
        PUSH    DE;Save spin switch count on stack (reg E)
        LD      DE,DEC_KBD_TBL;Get top of keypad decoder table
        ADD     HL,DE;point to DEC_KBD_TBL entry
        POP     DE;Restore Spinner count (reg E)
        LD      D,(HL);HAVE KEYBOARD DATA
        IN      A,(C);segment 0 data
        CPL
;
        PUSH    AF;save raw data
        LD      L,A
        AND     FIRE_MASK;isolate fire data
        LD      H,A;HAVE FIRE_DATA
        LD      A,L
        AND     JOY_MASK;isolate joystick data
        LD      L,A;HAVE JOY DATA
        POP     AF;get back raw data for seg 0
        LD      C,A;C = raw data segment 0
        POP     AF
        RET;A = raw data segment 1
;
;__POLLER
;
;   Used to fill a table of values for the 2 controllers
;   Does some debouncing if called twice in succession
;
;   NOTE - Does not return at bottom of code, return is in middle
;          interupts will be off for a while when call to DECODE is performed
;
;   Callers - This has different input parameters than OS-7 and
;             the controller map is ordered differently.
;
;
;Stack Usage:
; will use 4 words (2 pushes, 2 call)
;
;Calls:
;   __DECODER
;   DEBOUNCE
;   READ_N_DEBOUNCE  (a routine that is nested in __POLLER)
;
;Input Parameters:
;  IX - pointer to 1st byte of users controller map (10 bytes)
;  A  - controller enabled and spinner enable
;       bit 0 - set if want controller 0 enabled
;       bit 1 - set if want controller 1 enabled
;       bit 7 - set if want spinner enabled for controllers which are enabled
;
;Returns:
;
;  Data in users controller map is like this off of entry IX value
;             IX+0  - joystick 0
;             IX+1  - fire 0
;             IX+2  - arm 0
;             IX+3  - keyboard 0
;             IX+4  - spinner count 0
;             IX+5  - joystick 1
;             IX+6  - fire 1
;             IX+7  - arm 1
;             IX+8  - keyboard 1
;             IX+9  - spinner count 1
;
;  IX - points to 1 byte past users data table of highest enabled controller
;

;  all but IY - destroyed
;
;Date:
;  9/24/83   11:14   JKL
;

CONTROLLER_0_MASK      EQU     01H
CONTROLLER_1_BIT       EQU     1
SPINNER_ENABLE_BIT     EQU     7
__POLLER:
        LD      HL,PERSONAL_DEBOUNCE_TABLE;point to controller 0 debounce buffer
        LD      C,A;save enabled controller input
        AND     CONTROLLER_0_MASK;see if controller 0 is enabled
        JR      Z,NOT_CONTROLLER_0;If not then check to see if controller 1 is
        DEC     A;to 0 for parameter to __DECODER
        CALL    READ_N_DEBOUNCE;get the data and debounce it
        BIT     CONTROLLER_1_BIT,C;see if controller 1 is active
        RET     Z;return if not
POLL_CONTROLLER_1:;get data for controller 1
        LD      A,01H
READ_N_DEBOUNCE:
        PUSH    BC;save input parameter
        PUSH    HL;save debounce buffer ptr
        CALL    __DECODER
        LD      C,H;copy over raw data
        LD      A,L; with fire and joystick data
        POP     HL;get pointer to debounce buffer
        CALL    DEBOUNCE;debounce the data (on second call)
        POP     BC;get back input parameter
        BIT     SPINNER_ENABLE_BIT,C;see if spinners are enabled
        JR      Z,NEXT_IX
        LD      A,E;if so add
        ADD     A,(IX+0); new data to that in
        LD      (IX+0),A; users buffer
NEXT_IX:
        INC     IX;point to next users buffer
        RET
NOT_CONTROLLER_0: ; [RECON] OCR address flow places the missing branch label at $E27E.
        BIT     CONTROLLER_1_BIT,C;see if controller 1 is enabled
        RET     Z;return if not
        LD      DE,0004H
        ADD     HL,DE;point to next debounce buffer
        INC     DE
        ADD     IX,DE;point to next user buffer
        JP      POLL_CONTROLLER_1
;
;DEBOUNCE
;        This will check for equal data on two passes, and if
;        the data is the same then the users buffer is updated.
;
;        This is done by check for equal data, if the data is
;        different on each call then the data on this call is
;        stored so that the next call can use this new data.
;        If the data is equal then the data is stored with the
;        hi bit (bit 7) set so that the next call will yield
;        different data (If there could never be a match on the
;        next call).
;
;Stack Usage:
; 1 word (subroutine call)
;
;Input Parameters:
;   HL - Pointer to debounce buffer
;   IX - Pointer to users controller map
;   A  - joystick data
;   B  - arm data
;   C  - fire data
;   D  - keyboard data
;
;Returns:
;   HL - Pointing to next buffer (entry value + 4)
;   IX - Pointing to next data area (entry value + 4)
;   A is changed
;   No others are modified
;
; Calls self as a nested subroutine CHECK
;
;Date:
; 9/24/83   11:14   JKL
;
;
DEBOUNCE:
        CALL    CHECK;debounce joystick data
        LD      A,C;debounce fire data
        CALL    CHECK
        LD      A,B;debounce arm data
        CALL    CHECK
        LD      A,D;debounce keyboard data
;fall thru to check (return implied)
CHECK:
        CP      (HL);see if data was the same as last time
        JR      NZ,NOT_SAME
        LD      (IX+0),A ; [RECON] OCR address gap at 2404 and ROM bytes DD 77 00 restore the store at $E29A.
        OR      80H;set hi_order bit if same, so not equal on next call

NOT_SAME:
        LD      (HL),A;update local debounce buffer
        INC     IX;point to next buffer location
        INC     HL; in debounce buffer as well
        RET
;
;Update_Spinner - Controller spin switch interrupt service routine
;
; This routine processes the spinner switch interrupt and updates
; the data needed by both DECODER and POLLER
;
; Ram area used: Updates SPIN_SW0_CNT and SPIN_SW1_CNT
;
; The spinner switch maskable interrupt is RST 38H
;
; Destroys AF, BC, HL
;
DIR_MASK       EQU     00100000B;bit 5 tells us the direction
INT_BIT        EQU     4;bit that tells which spinner interrupted

__UPDATE_SPINNER:
        LD      BC,(CONTROLLER_0_PORT);Get port values for both controllers
        IN      A,(C);Input data from controller 0
        LD      HL,SPIN_SW0_CT;Point to spinner update data
        BIT     INT_BIT,A;Was this the controller that interrupted ?
        JR      NZ,GET_CONTROLLER_1;If not then check controller 1
        AND     DIR_MASK;Check direction bit
        JR      NZ,INCREMENT_0_DIRECTION;If set then increment direction
        DEC     (HL);Else decrement direction
        DEC     (HL);Decrement once more to fall through increment

INCREMENT_0_DIRECTION:
        INC     (HL);Increment direction

GET_CONTROLLER_1:
        LD      C,B;Get controller 1 port into C
        IN      A,(C);Get controller 1 data
        INC     HL;Point HL to controller 1 update area
        BIT     INT_BIT,A;Is this the controller that interrupted me?
        RET     NZ;Return if not. Also don't assume
; either controller if no bit is set
        AND     DIR_MASK;Check direction bit
        JR      NZ,INCREMENT_1_DIRECTION;If set then go increment direction
        DEC     (HL);Else decrement direction
        RET;Then return

INCREMENT_1_DIRECTION:
        INC     (HL);Increment direction
        RET;Exit

;********************************************************************
;
;                         NOTES TO SOUND PROGRAMMERS
;
; The only differences between the OS7 version and this ADAM version
; are transparent to the game programmer and important to the
; sound programmer. Formerly CALL'S to PLAY_SONGS and SND_MANAGER
; were necessary to update the sounds. Now a CALL to SOUNDS runs
; the same code. Formerly CALL'S to LEAVE_EFFECT and EFXOVER were
; needed to end a SPECIAL_EFFECT. Now EFFECT_OVER runs the same code.
; Independent CALL'S to PLAY_SONGS, SND_MANAGER, LEAVE_EFFECT and
; EFXOVER do not run in this module as before!!!!!
;
;********************************************************************
;
;        Operating system sound routine EQUATES

OFF             EQU     0FH;Off, no sound

;        Special byte 0 codes

INACTIVE        EQU     0FFH
;*** SEFFECT    EQU     62
ENOSDATA        EQU     0

;        Offsets within an SxDATA song data area

;*** CH         EQU     0
;*** SONGNO     EQU     0
;*** NEXTNOTEPTR EQU    1
FREQ            EQU     3
ATN             EQU     4
CTRL            EQU     4
NLEN            EQU     5
;*** FPS        EQU     6
FPSV            EQU     6
FSTEP           EQU     7
;*** ALEN       EQU     8
ASTEP           EQU     8
;*** APS        EQU     9
APSV            EQU     9

;        song end codes

;*** CH0END     EQU     00010000B
;*** CH1END     EQU     01010000B
;*** CH2END     EQU     10010000B
;*** CH3END     EQU     11010000B
;*** CH0REP     EQU     00011000B
;*** CH1REP     EQU     01011000B
;*** CH2REP     EQU     10011000B
;*** CH3REP     EQU     11011000B

;        channel numbers, B7 -B6

;*** CH0        EQU     0
;*** CH1        EQU     01000000B
;*** CH2        EQU     10000000B
;*** CH3        EQU     11000000B


;*****************************
;*        FREQ_SWEEP         *
;*****************************

;See Users' Manual for description
;RET Z SET:  if note over
;RET Z RESET: if sweep in progress or note not over

FREQ_SWEEP:

;        * if freq not swept, dec NLEN and RET [setting Z flag]

        LD      A,(IX+FSTEP);check  for no sweep code
        OR      A;SET Z flag if FSTEP = 0
        JR      NZ,L20;if PSW is zero note not to be swept
        LD      A,(IX+NLEN);dec NLEN and
        DEC     A;SET Z flag if NLEN = 0
        RET     Z;leave if note over with Z flag SET
        LD      (IX+NLEN),A;store decremented NLEN
        RET;RET with Z flag RESET [note not over]

;        ENDIF

;        * sweep going, so dec FPSV

L20:
        PUSH    IX;point HL to FPSV
        POP     HL
        LD      DE,FPSV
        ADD     HL,DE
        CALL    LOCL_DECLSN;dec FPSV
;****   JR      NZ,L21                     ;if PSW is zero FPSV has timed out
        RET     NZ;Added uOS

;        * dec NLEN and leave if sweep is over

        CALL    LOCL_MSNTOLSN;reload FPSV from FPS
        DEC     HL;point to NLEN (# steps in the sweep)
        LD      A,(HL);dec NLEN and
        DEC     A;SET Z flag if NLEN = 0
        RET     Z;leave if sweep over with Z flag SET

;        * sweep not over, so add FSTEP to FREQ

        LD      (HL),A;store decremented NLEN
        DEC     HL;point HL
        DEC     HL;to FREQ
        LD      A,(IX+FSTEP);A = FSTEP (two's complement step size)
        CALL    LOC_ADD816;FREQ = FREQ + FSTEP
        INC     HL;point HL to hi FREQ
        RES     2,(HL);RESET B2 in hi FREQ in case add caused > 10 bit FREQ
        OR      0FFH;RESET Z flag. sweep not over yet

;        ENDIF
;*** L21
        RET
;        END FREQSWE

;*****************************
;*        ATN_SWEEP          *
;*****************************

;See User's Manual for description
;RET Z SET:  if byte 8 is 0 [means sweep is over, or note was never swept]
;RET Z RESET: if sweep in progress

ATN_SWEEP:

;        * RET with Z SET if byte 8 = 00

        LD      A,(IX+8);check byte 8 for no sweep code
        OR      A;Z is set if byte 8 = 0
        RET     Z;leave if Z set, sweep not going

;        * sweep going, so dec APSV

        PUSH    IX;point HL to APSV
        POP     HL
        LD      DE,APSV
        ADD     HL,DE
        CALL    LOCL_DECLSN;dec APSV (LSN of byte 9)
;****   JR      NZ,L22                     ;if PSW is zero APSV has timed out
        RET     NZ;Added uOS

;        * dec ALEN to see if sweep over

        CALL    LOCL_MSNTOLSN;reload APSV from APS
        DEC     HL;point to ALEN (# of steps in the sweep)
        CALL    LOCL_DECLSN;dec ALEN (LSN byte 8)
        JR      Z,L23;if PSW is non-zero sweep not over yet

;        * add ASTEP to ATN

        LD      A,(HL);MSN A = ASTEP
        AND     0F0H;mask LSN
        LD      E,A;E = ASTEP   0
        DEC     HL;point HL to ATN
        DEC     HL
        DEC     HL
        DEC     HL
        LD      A,(HL);MSN A = ATN
        AND     0F0H;A = ATN     0
        ADD     A,E;MSN A = (ASTEP + ATN)   0
        LD      E,A;E = (ASTEP + ATN)       0
        LD      A,(HL);A = ATN freq or CTRL
        AND     0FH;mask old ATN A = 0 freq or CTRL
        OR      E;OR in new ATN
        LD      (HL),A;store updated value back into song data area
        OR      0FFH;RESET Z flag. sweep not over yet
;****   JR      L22
        RET;Added uOS

;        ELSE   Z flag is SET: sweep over

L23:
        LD      (HL),0;set byte 8 to 0 to indicate end sweep

;        ENDIF
;        ENDIF

;*** L22
        RET

;        END ATNSWEE


;*****************************
;*        UPAINCTRL          *
;*****************************

;Perform single byte update of the snd chip noise control register or any
;attenuation register. IX is passed pointing to byte 0 of a song data area, MSN
;register C = formatted channel attenuation code.

UPAINCTRL:
        LD      A,(IX+4);MSN A = ATN. LSN may be CTRL data
        BIT     4,C;test for ATN
;If PSW is non-zero ATN is to be sent,
; move it to the LSN
        JR      Z,L24
        RRCA;swap nibbles
        RRCA
        RRCA
        RRCA;LSN A = ATN

;        ENDIF

L24:
        AND     0FH;mask MSN
        OR      C;A = formatted register#  ATN or CTRL
;****   CALL    OUT_TO_SOUND_PORT           ;output ATN or CTRL data
;****   RET
        JP      OUT_TO_SOUND_PORT;output ATN or CTRL data


;*****************************
;*        UPFREQ             *
;*****************************

;Perform double byte update of a sound chip frequency register.  IX is passed
;pointing to byte0 of a song data area. MSN register D = formatted channel
;frequency code.

UPFREQ:
        LD      A,(IX+FREQ);A = F2 F3 F4 F5 F6 F7 F8 F9
        AND     0FH;A = 0  0  0  0  F6 F7 F8 F9
        OR      D;A = formatted reg#  F6 F7 F8 F9
        CALL    OUT_TO_SOUND_PORT;output first freq byte
        LD      A,(IX+FREQ);A = F2 F3 F4 F5 F6 F7 F8 F9 again
        AND     0F0H;A = F2 F3 F4 F5 0  0  0  0
        LD      D,A;save in D
        LD      A,(IX+FREQ+1);LSN A = 0  0  F0 F1
        AND     0FH;A = 0  0  0  0  0  0  F0 F1
        OR      D;A = F2 F3 F4 F5 0  0  F0 F1
        RRCA;swap nibbles
        RRCA
        RRCA
        RRCA;A = 0  0  F0 F1 F2 F3 F4 F5
;****   CALL    OUT_TO_SOUND_PORT           ;output 2nd (most significant) freq byte
;****   RET
        JP      OUT_TO_SOUND_PORT;output 2nd (most significant) freq byte


;*****************************
;*        LOCL_DECLSN        *
;*****************************

;Without affecting the MSN, decrement the LSN of the byte pointed to by HL.
;HL remains the same.
;RET with Z flag set if dec LSN results in 0, reset otherwise.
;RET with C flag set if dec LSN results in -1, reset otherwise.

__DECLSN:
LOCL_DECLSN:
        XOR     A
        RRD;A = 0    LSN (HL)
        SUB     1;Z flag set if dec to 0. C flag if dec to -1
        PUSH    AF;save Z and C flags
        RLD;(HL) = old MSN    new LSN
        POP     AF;restore Z and C flags. A = 0    new LSN
        RET


;*****************************
;*        LOCL_DECMSN        *
;*****************************

;Without affecting the LSN, decrement the MSN of the byte pointed to by HL.
;HL remains the same.
;RET with Z flag set if dec MSN results in 0, reset otherwise.
;RET with C flag set if dec MSN results in -1, reset otherwise.

__DECMSN:
LOCL_DECMSN:
        XOR     A
        RLD;A = 0    MSN (HL)
        SUB     1;Z flag set if dec to 0, C flag set if dec -1
        PUSH    AF;save Z and C flags
        RRD;(HL) = new MSN    old LSN
        POP     AF;restore Z and C flags, A = 0    new MSN
        RET


;*****************************
;*        LOCL_MSNTOLSN      *
;*****************************

;Copy MSN of the byte pointed to by HL to the LSN of that byte.  HL remains
;the same.

__MSNTOLSN:
LOCL_MSNTOLSN:
        LD      A,(HL);A = MSN   LSN to be changed
        AND     0F0H;A = MSN   0
        LD      B,A;save in B
        RRCA;swap nibbles
        RRCA
        RRCA
        RRCA;A = 0     MSN
        OR      B;A = MSN   MSN
        LD      (HL),A;(HL) = MSN   MSN
        RET


;*****************************
;*        LOC_ADD816         *
;*****************************

;Adds 8 bit two's complement signed value passed in A to the 16 bit location
;pointed to by HL.

__ADD816:
LOC_ADD816:
        LD      B,0;set B for positive value in A
        BIT     7,A;if A is positive
        JR      Z,POS;skip
;****   LD      B,0FFH                      ;A is neg: extend sign bit thru B
        DEC     B;Added uOS
POS:
        ADD     A,(HL);do 8 bit add [and set Carry]
        LD      (HL),A;store result into LSB 16 bit number
        INC     HL;put MSB
        LD      A,(HL);into A
        ADC     A,B;A = MSB + Carry + B [B is 0 or FF]
        LD      (HL),A;store result into MSB
        DEC     HL;re-point HL to LSB 16 bit number
        RET


;*****************************
;*        PT_IX_TO_SxDATA    *
;*****************************

;SONGNO passed in B.
;Point IX to byte 0 in SONGNO's song data area.
;RET with both DE and IX pointing to SxDATA,
;HL pointing to MSB SxDATA entry in LST_OF_SND_ADDRS.

PT_IX_TO_SxDATA:

;        * IX & DE := addr of byte 0 in SONGNO's song  data area.
;          HL pointing to MSB SxDATA entry in LST_OF_SND_ADDRS.

        LD      HL,(PTR_TO_LST_OF_SND_ADDRS);point HL to start LST_OF_SND_ADDRS
        DEC     HL;init HL for addition
        DEC     HL
        LD      C,B;form 4 * SONGNO in C
        LD      B,0
        RLC     C
        RLC     C
        ADD     HL,BC;HL pts to SxDATA's entry in LST_OF_SND_ADDRS
        LD      E,(HL);move addr SxDATA to IX thru DE
        INC     HL
        LD      D,(HL)
        PUSH    DE
        POP     IX
        RET


;*****************************
;*        AREA_SONG_IS       *
;*****************************

;The address of byte 0 of a song data area is passed in IX.  The song number of
;the song using that area is returned in A (0FFH if inactive).  If a special
;effect was using that area, 62 is returned in A and HL is returned with the
;address of the special sound effect routine.

AREA_SONG_IS:
        LD      A,(IX+0);A := CH#   SONGNO or 62, or A := FF
        CP      0FFH
        RET     Z;leave with A = FF if area inactive
        AND     00111111B;mask CH#
        CP      62
        RET     NZ;leave with A = SONGNO if not a special effect (62)

;        special effect. so set HL to addr effect, stored in bytes 1&2

        PUSH    IX;point HL to byte 1
        POP     HL
        INC     HL
        LD      E,(HL);save LSB effect addr in E
        INC     HL;HL to byte 2
        LD      D,(HL);save MSB effect addr in D
        EX      DE,HL;HL := addr special effect
        RET

;        END UTIL


;*****************************
;*        INIT_SOUND         *
;*****************************

;See Users' Manual for description; includes ENTRY POINT ALL_OFF
;addr LST_OF_SND_ADDRS passed in HL
;n = # of song data areas to init, passed in B

;        *** Sound chip register code EQUATES ***

;        Tone generator frequency and attenuation formatted register codes

SR1FRQ          EQU     10000000B;BIT7 = 1, BIT6-4 = TONE GEN 1 FREQ CODE
SR1ATN          EQU     10010000B;BIT7 = 1, BIT6-4 = TONE GEN 1 ATN CODE
SR2FRQ          EQU     10100000B;BIT7 = 1, BIT6-4 = TONE GEN 2 FREQ CODE
SR2ATN          EQU     10110000B;BIT7 = 1, BIT6-4 = TONE GEN 2 ATN CODE
SR3FRQ          EQU     11000000B;BIT7 = 1, BIT6-4 = TONE GEN 3 FREQ CODE
SR3ATN          EQU     11010000B;BIT7 = 1, BIT6-4 = TONE GEN 1 ATN CODE

;        Noise generator control and attenuation formatted register codes

SRNCTL          EQU     11100000B;BIT7 = 1, BIT6-4 = NOISE GEN CONTROL CODE
SRNATN          EQU     11110000B;BIT7 = 1, BIT6-4 = NOISE GEN ATN CODE

__SOUND_INIT:
;*** INIT_SOUND

;        * initialize PTR_TO_LST_OF_SND_ADDRS with value passed in HL

        LD      (PTR_TO_LST_OF_SND_ADDRS),HL

;        * store inactive code at byte 0 of each of the n data areas (B = n)

        INC     HL;pt HL to song 1 data area entry in LST_OF_SND_ADDRS
        INC     HL
        LD      E,(HL);pt DE to byte 0 in first song data area
        INC     HL
        LD      D,(HL)
        EX      DE,HL;pt HL to byte 0 in first song data area
        LD      DE,10;set DE for 10 byte increment
        LD      A,0FFH;Added uOS
B1:
        LD      (HL),A;deactivate area  *** Added uOS
        ADD     HL,DE;pt HL to byte 0 next area (10 bytes away)
        DJNZ    B1;do this for the n (passed in B) data areas

;        * store end of data area code (0) at first byte after last song data area

        LD      (HL),0;store end of data area code in byte 0 data area n + 1

;        * set the 4 channel data area pointers to a dummy, inactive data area

        LD      HL,DUMAREA;point HL to inactive byte below [after the RET]
        LD      (PTR_TO_S_ON_0),HL;store addr DUMAREA at PTR_TO_S_ON_0
        LD      (PTR_TO_S_ON_1),HL;store addr DUMAREA at PTR_TO_S_ON_1
        LD      (PTR_TO_S_ON_2),HL;store addr DUMAREA at PTR_TO_S_ON_2
        LD      (PTR_TO_S_ON_3),HL;store addr DUMAREA at PTR_TO_S_ON_3

;        * initialize SAVE_CTRL

;****   LD      A,0FFH                      ;note: this is only time MSN SAVE_CTRL will be non zero,
;****                                      ;Out uOS (loaded earlier)

        LD      (SAVE_CTRL),A;thus ensuring PLAY_SONGS will output 1st real CTRL data
__TURN_OFF_SOUND:
;*** ALL_OFF

;        * turn off all 4 sound generators

        LD      A,(SOUNDPORT);Added uOS
        LD      C,A;Added uOS
        LD      A,OFF+SR1ATN;form off code for tone generator 1
        OUT     (C),A;send it out
        LD      A,OFF+SR2ATN;form off code for tone generator 2
        OUT     (C),A;send it out
        LD      A,OFF+SR3ATN;form off code for tone generator 3
        OUT     (C),A;send it out
        LD      A,OFF+SRNATN;form off code for noise generator, N
        OUT     (C),A;send it out
        RET

DUMAREA: DEFB    INACTIVE

;        END INITSOU


;*****************************
;*        JUKE_BOX           *
;*****************************

;See Users' Manual for description
;SONGNO passed in B

__PLAY_IT:
JUKE_BOX:

;        * RET if song already in progress

        PUSH    BC;save SONGNO on stack
        CALL    PT_IX_TO_SxDATA;point IX to SONGNO's song data area
        LD      A,(IX+0);A := CH# [if any]   SONGNO [if any]
        AND     3FH;A := 0 0 SONGNO
        POP     BC;B := SONGNO
        CP      B;test if already in progress
        RET     Z;if so, leave

;        * load first note and set NEXT_NOTE_PTR [thru LOAD_NEXT_NOTE]

        LD      (IX+0),B;store SONGNO in byte 0
        DEC     HL;HL left by PT_IX_TO_SxDATA pointing to MSB SxDATA
        DEC     HL;entry in LST_OF_SND_ADDRS point HL to note list
        LD      D,(HL);starting addr entry in LST_OF_SND_ADDRS and save this
        DEC     HL;addr in DE
        LD      E,(HL);DE now has the initial value for NEXT_NOTE_PTR
        LD      (IX+1),E;set NEXT_NOTE_PTR for first note in song
        LD      (IX+2),D
        CALL    LOAD_NEXT_NOTE;load note. byte 0 := CH# SONGNO, set new NEXT_NOTE_PTR
        JR      UP_CH_DATA_PTRS;new song. so update channel data ptrs

;        END JUKEBOX


;*****************************
;*        PLAY_SONGS_        *
;*****************************

;        *** Sound chip register code EQUATES

;*** WHITE      EQU     00000100B           ;BIT2 = 1, white noise code
;*** PERIOD     EQU     00000000B           ;BIT2 = 0, periodic noise code
;*** NSRH1      EQU     00000000B           ;BIT0-1 Set for highest noise shift rate (N/512)
;*** NSRMED     EQU     00000001B           ;BIT0-1 Set for medium noise shift rate (N/1024)
;*** NSRLOW     EQU     00000010B           ;BIT0-1 Set for lowest noise shift rate (N/2048)
;*** NSRTG3     EQU     00000011B           ;BIT0-1 Set for shift from tone gen 3 output

__SOUNDS:; [RECON] OCR 902/2998: exported implementation label restored.
;*** PLAY_SONGS_

;        * output CH1 attenuation and frequency

        LD      A,OFF+SR1ATN;format CH1 OFF byte into A
        LD      C,SR1ATN;format MSN C for CH1 attenuation
        LD      D,SR1FRQ;format MSN D for CH1 frequency
        LD      IX,(PTR_TO_S_ON_1);point IX to byte 0 data area of song for CH1
        CALL    TONE_OUT

;        * output CH2 attenuation and frequency

        LD      A,OFF+SR2ATN;format CH2 OFF byte into A
        LD      C,SR2ATN;format MSN C for CH2 attenuation
        LD      D,SR2FRQ;format MSN D for CH2 frequency
        LD      IX,(PTR_TO_S_ON_2);point IX to byte 0 data area of song for CH2
        CALL    TONE_OUT

;        * output CH3 attenuation and frequency

        LD      A,OFF+SR3ATN;format CH3 OFF byte into A
        LD      C,SR3ATN;format MSN C for CH3 attenuation
        LD      D,SR3FRQ;format MSN D for CH3 frequency
        LD      IX,(PTR_TO_S_ON_3);point IX to byte 0 data area of song for CH3
        CALL    TONE_OUT

;        * output CH0 [noise] ATN [and CTRL, if different from last time]

        LD      A,OFF+SRNATN;format CH0 OFF byte into A
        LD      C,SRNATN;format MSN C for CH0 attenuation
        LD      IX,(PTR_TO_S_ON_0);point IX to byte 0 data area of song for CH0
        LD      E,(IX+0);look for inactive code, OFFH
        INC     E;this sets Z flag if E = OFFH
        JR      NZ,L5;if PSW is zero song data area is inactive
        CALL    OUT_TO_SOUND_PORT; turn off CH0
        JR      L6;SND_MANAGER

;        ELSE

L5:
        CALL    UPAINCTRL;send out current ATN
        LD      A,(IX+CTRL);LSN A = current CTRL data
        AND     0FH;mask MSN
        LD      HL,SAVE_CTRL;point to last CTRL data sent
        CP      (HL);compare
        JR      Z,L6;if PSW is zero CTRL has not changed (done)
        LD      (HL),A;SAVE_CTRL = new CTRL data
        LD      C,SRNCTL;send new CTRL data
        CALL    UPAINCTRL
        JR      L6;SND_MANAGER

;        ENDIF
;        ENDIF

TONE_OUT:
        LD      E,(IX+0);look for inactive code, OFFH
        INC     E;this sets Z flag if E = OFFH
        JR      NZ,L7;if PSW is zero song data area is inactive
;****   CALL    OUT_TO_SOUND_PORT           ;turn off CHx
;****   JR      L8
        JP      OUT_TO_SOUND_PORT;turn off CHx

;        ELSE send out current ATN and FREQ

L7:
        CALL    UPAINCTRL;send out attenuation
        JP      UPFREQ;send out frequency
;****   CALL    UPFREQ                      ;send out frequency
L8:
;****   RET
;        ENDIF
;*****************************
;*        SND_MANAGER        *
;*****************************

;See Users' Manual for description

L6:
SND_MANAGER:

;        * IX := addr of song #1 data area [S1DATA]

        LD      B,1;pt IX to byte 0 song data area for song # 1
        CALL    PT_IX_TO_SxDATA

L1:;LOOP until end of song data areas
        LD      A,ENOSDATA;check for end of song data areas
        CP      (IX+0);set Z flag if inactive
        RET     Z;leave [Z set], if all data areas have been processed

;        * process active song data areas

        CALL    PROCESS_DATA_AREA;update counters or call effect get next note

;        * point IX to byte 0 next song data area

        LD      DE,10
        ADD     IX,DE
        JR      L1;REPEAT LOOP


;*****************************
;*        UP_CH_DATA_PTRS     *
;*****************************

;For each active data area, starting with S1DATA and proceeding in order, load
;the associated channel data area pointer [PTR_TO_S_ON_x] with the address of
;byte 0. This routine is called by JUKE_BOX, when a song starts and
;PROCESS_DATA_AREA when the channel using a data area has changed as a result of
;calling LOAD_NEXT_NOTE [this happens when a song finishes and when it switches
;back and forth between noise and tone notes].

UP_CH_DATA_PTRS:
        PUSH    IX;save curent IX
        LD      HL,DUMAREA;set all 4 ch data ptrs to dummy inactive area
        LD      (PTR_TO_S_ON_0),HL
        LD      (PTR_TO_S_ON_1),HL
        LD      (PTR_TO_S_ON_2),HL
        LD      (PTR_TO_S_ON_3),HL
        LD      B,1;set IX to byte 0 S1DATA
        CALL    PT_IX_TO_SxDATA;RETs with IX addr byte 0 song 1

L2:;LOOP until end of song data areas
        LD      A,(IX+0);test for end of song data areas
        OR      A;**** CP      ENOSDATA
        JR      Z,DONE_SNDMAN;leave loop if all data areas checked



        INC     A;**** CP      INACTIVE     ;check for inactive data area: don't update ptr if so
        JR      Z,L9;if PSW is non-zero area is active: update channel data ptrs
        LD      A,(IX+0);get CH# in A
        AND     0C0H;B7 - B6 in A = CH#
        RLCA;form CH# * 2 in A, i.e., the offset from
        RLCA;PTR_TO_S_ON_0 of the channel data area pointer
        RLCA;that points to channel CH#
        LD      E,A;add offset to addr of PTR_TO_S_ON_0
        LD      D,0
        LD      HL,PTR_TO_S_ON_0
        ADD     HL,DE;HL points to proper channel data area pointer
        PUSH    IX;store this song data area's byte 0 addr there
        POP     DE
        LD      (HL),E
        INC     HL
        LD      (HL),D

;        ENDIF

;        * point IX to byte 0 next song data area

L9:
        LD      DE,10
        ADD     IX,DE
        JR      L2;REPEAT LOOP

DONE_SNDMAN:
        POP     IX;restore IX
;*** L12
        RET


;*****************************
;*        LEAVE_EFFECT       *
;*****************************

;LEAVE_EFFECT, called by a special sound effect routine when it's finished,
;restores the SONGNO of the song to which the effect note belongs to B5 - B0 of
;byte 0 in the effect's data area, and loads bytes 1 and 2 with the address of
;the next note in the song.  The address of the 1 byte SONGNO (saved by the
;effect when first called) is passed in DE.  The 2 byte address of the next note
;in the song, also saved by the effect, is passed in HL.  IX is assumed to be
;pointing to byte 0 of the data area to which the song number is to be restored.
;Bits 7 and 6 of the saved SONGNO are ignored, and therefore may be used by the
;effect to store flag information during the course of the note.

__EFFECT_OVER:
;*** LEAVE_EFFECT
        LD      (IX+1),L;LSB NEXT_NOTE_PTR := LSB addr next note in song
        LD      (IX+2),H;MSB NEXT_NOTE_PTR := MSB addr next note in song
        LD      A,(DE);A := x x SONGNO (i.e., the saved, original SONGNO)
        AND     03FH;A := 0 0 SONGNO
        LD      B,A;B := 0 0 SONGNO (B now = original SONGNO)
        LD      A,(IX+0);A := CH#   62 (all effect notes have SONGNO = 62)
        AND     0C0H;A := CH# 0 0 0 0 0 0
        OR      B;A := CH# SONGNO
        LD      (IX+0),A;restore the song number
        JR      EFXOVER


;*****************************
;*        PROCESS_DATA_AREA  *
;*****************************

;See Users' Manual for description
;Terminology: SFX = address of sound effect routine

PROCESS_DATA_AREA:
        CALL    AREA_SONG_IS;return area's SONGNO in A [and addr SFX in HL]
        CP      INACTIVE;test for inactive code
        RET     Z;RET, no processing if area inactive

;        * if special effect, call it to process the data area

        CP      62;test for special sound effect
        JR      NZ,L10;if PSW is zero data area used by sound effect
        LD      DE,7;pt HL to SFX+7, starting adr of the effect's code
        ADD     HL,DE
        JP      (HL);do 1 pass thru effect, RET from effect

;        ENDIF

;        * else process a non-effect note

L10:
        CALL    ATN_SWEEP;process atn sweep data, if any
        CALL    FREQ_SWEEP;proc frq sweep data, if any, & note dura timer s
;****   JR      NZ,L12                     ;if PSW is zero note is over
        RET     NZ
EFXOVER:
        LD      A,(IX+0);A := CH#   SONGNO this note
        PUSH    AF;save on stack
        CALL    LOAD_NEXT_NOTE;load data for next note
        POP     BC;B := CH#   SONGNO previous note
        LD      A,(IX+0);A := CH#   SONGNO new note [may be inactive]
        CP      B;check against new note's CH#   SONGNO
;****   JR      Z,L12                      ;if PSW is non-zero change to/from tone/efx/noise
        RET     Z
        JR      UP_CH_DATA_PTRS;to maintain data area priority system

;        ENDIF
;        END SNDMAN

;*****************************
;*        LOAD_NEXT_NOTE     *
;*****************************

;see Users' Manual for description
;SFX refers to the beginning address of a special sound effect routine

LOAD_NEXT_NOTE:

;        * deactivate area, save SONGNO on stack

        LD      A,(IX+0);A := byte 0
        AND     00111111B;mask CH#, if any
        PUSH    AF;save SONGNO on stack
        LD      (IX+0),INACTIVE;deactivate area

;        * A := header new note

        LD      L,(IX+1);HL := addr new note in ROM
        LD      H,(IX+2)
        LD      A,(HL);A := header new note

;        * save header of new note in song on stack and load its data CASE note type

        LD      B,A;save header new note in B
        BIT     5,A;test for rest
        JR      Z,L13;if PSW is non-zero note is a rest

;*** REST
        PUSH    BC;save header on stack
        AND     00011111B;mask all but duration bits

;        * set up NEXT_NOTE_PTR

        INC     HL;HL = address of the header of the note after this note
        LD      (IX+1),L;store in NEXT_NOTE_PTR
        LD      (IX+2),H

;        * move this note's data and fill in bytes where necessary

        LD      (IX+ATN),0F0H;set atn off ; [RECON] OCR 3277: scan bytes are DD 36 04 F0.
        LD      (IX+NLEN),A;NLEN := 5 bit duration
        LD      (IX+FSTEP),0;indicate freq not to be swept
        LD      (IX+ASTEP),0;indicate atn not to be swept
        JP      MODBO

;        ENDIF

L13:
        BIT     4,A;test for end
        JR      Z,L14;if PSW is non-zero end of song
        BIT     3,A;test for repeat
        JR      Z,ENDNOREP;if PSW is non-zero repeat song
;*** ENDREP
        POP     BC;B := SONGNO
        JP      JUKE_BOX;to reload 1st note of this song

;         RET                                 ;to PROCESS_DATA_AREA, don't save header ; [RECON] OCR 3294 is a commented historical instruction, not executable code.
;        ENDIF

ENDNOREP:
        LD      A,INACTIVE
        PUSH    AF;save inactive code to end song
        JP      MODBO;to load byte 0

;        ENDIF
;        - test for special sound effect

L14:
        AND     00111100B;mask irrelevant bits
        CP      00000100B;test for B5 - B2 = 0001
        JR      NZ,L15;if PSW is zero note is a special effect
;*** EFFECT
        POP     IY;IY := SONGNO
        PUSH    IY;put SONGNO back on stack
        PUSH    BC;save header on stack NEXT_NOTE_PTR := SFX, DE := SFX
        INC     HL;pt HL to next byte [LSB addr SFX]
        LD      E,(HL);E := LSB SFX
        LD      (IX+1),E;put LSB of SFX in byte 1 of SxDATA [NEXT_NOTE_PTR]
        INC     HL;pt HL to MSB SFX
        LD      D,(HL);D := MSB SFX
        LD      (IX+2),D;put MSB SFX in byte 2 of SxDATA
        INC     HL;point HL to next note [after this new note]
        PUSH    IY;A := SONGNO
        POP     AF
        PUSH    DE;IY := SFX
        POP     IY
        LD      DE,PASS1;create "CALL (IY)" with RET to PASS1 by storing
        PUSH    DE;PASS1 on the stack
        JP      (IY);1st 7 bytes SFX will save addr next note & SONGNO
PASS1:
        LD      DE,7;in same fashion, create a "CALL (IY+7)"
        ADD     IY,DE;to allow SFX to load initial values
        LD      DE,MODBO;RET to MODBO
        PUSH    DE
        JP      (IY)

;        ENDIF

;        - if here, note is type 0 - 3

L15:
        PUSH    BC;save header on stack
        LD      A,B;A := fresh copy header
        AND     00000011B;mask all but type number
        OR      A;test for type 0
        JR      NZ,L16;if PSW is zero note is type 0: fixed freq and atn

;*** TYPE0                         ;set up NEXT_NOTE_PTR
        INC     HL;next note [after this new note] is 4 bytes away,
        INC     HL;point HL to it
        INC     HL
        INC     HL
        LD      (IX+1),L;put addr in NEXT_NOTE_PTR
        LD      (IX+2),H

;        * move new note data and fill in bytes where necessary

        DEC     HL;point HL back to 1st ROM data to move, NLEN
        LD      DE,05;point DE to destination: bytes 5, 4, and 3
        CALL    DE_TO_DEST
        LD      BC,3;move 3 bytes
        LDDR
        LD      (IX+FSTEP),0;set for no freq sweep
        LD      (IX+ASTEP),0;set for no atn sweep
        JR      MODBO

;        ENDIF

L16:
        CP      1;test for type 1
        JR      NZ,L17;if PSW is zero note is type 1: swept
; freq, fixed attenuation
;*** TYPE1                         ;set up NEXT_NOTE_PTR
        LD      DE,6;note after this note is 6 bytes away,
        ADD     HL,DE;pt HL to it
        LD      (IX+1),L;store in NEXT_NOTE_PTR
        LD      (IX+2),H

;        * move new note data and fill in bytes where necessary

        DEC     HL;point HL back to 1st ROM data to move, FSTEP
        INC     E;E: point DE to destination: bytes 7 - 3
        CALL    DE_TO_DEST
        LD      BC,5;move 5 bytes
        LDDR
        LD      (IX+ASTEP),0;set for no atn sweep
        JR      MODBO

;        ENDIF

L17:
        CP      2;test for type 2
        JR      NZ,TYPE3;if PSW is zero note is type 2: fixed freq, swept attenuation
;*** TYPE2                         ;set up NEXT_NOTE_PTR
        LD      DE,6;pt HL to note after this note, since it's 6 bytes away.
        ADD     HL,DE;pt HL to it by adding 6
        POP     AF;A := header this note [CH#   SONGNO]
        PUSH    AF;put back on stack
        AND     11000000B;mask SONGNO, leaving CH#
        JR      NZ,L18;if PSW is zero this is a noise note, which is only 5 ROM bytes long
        DEC     HL;so move HL back 1 byte

;        ENDIF

L18:
        LD      (IX+1),L;put addr in NEXT_NOTE_PTR
        LD      (IX+2),H

;        * move new note data and fill in bytes where necessary

        DEC     HL;point HL back to 1st ROM data to move, APS
        LD      E,9;point DE to destination: bytes 9,8,5 - 3
        CALL    DE_TO_DEST
        LD      BC,2;move 2 bytes
        LDDR;when done, DE points to FSTEP, HL to ROM NLEN
        XOR     A
        LD      (DE),A;FSTEP := 0 for no freq sweep
        DEC     DE;pt DE to RAM NLEN
        DEC     DE
        LD      C,3;move last 3 ROM bytes if this is a noise note, garbage
        LDDR;will be loaded into byte 3, buts that's OK
        JR      MODBO

;        ENDIF

;        if here, note is type 3: swept freq, swept attenuation

TYPE3:;set up NEXT_NOTE_PTR
        LD      DE,8;note after this note is 8 bytes away.
        ADD     HL,DE;pt HL to it
        LD      (IX+1),L;put addr in NEXT_NOTE_PTR
        LD      (IX+2),H

;        * move new note data and fill in bytes where necessary

        DEC     HL;point HL back to 1st ROM data to move, APS
        PUSH    IX;point DE to destination: bytes 9 - 3
        POP     IY;IY := addr byte 0 [and DE = 6]
        INC     E;DE := 9
        ADD     IY,DE;IY := addr byte 9 [APS]
        PUSH    IY
        POP     DE;DE := addr APS
        LD      BC,7;move 7 bytes
        LDDR

;        * modify byte 0 basis header new note

MODBO:
        PUSH    IX;pt HL to byte 0
        POP     HL
        POP     AF;A := header new note
        POP     BC;B := SONGNO
        CP      INACTIVE;test for inactive [song over, as detected above]
        RET     Z
        LD      D,A;save header in D
        AND     3FH;Rid channel bits
        CP      04;Special effect
        JR      NZ,L20_LOAD_NEX
        LD      B,62

L20_LOAD_NEX:
        LD      A,D;restore A to header
        AND     0C0H;A := CH# 0 0 0 0 0 0
        OR      B;A := new CH#   SONGNO
        LD      (HL),A;store back in byte 0

;        ENDIF

;*** L19
        RET

DE_TO_DEST:
        PUSH    IX;DE passed = offset from byte 0, RETed w addr byte offset
        POP     IY;IY := addr byte 0 [and DE = offset]
        ADD     IY,DE;IY := addr byte 0 + offset
        PUSH    IY
        POP     DE;DE := addr of destination byte in SxDATA
        RET

;        END LOADNEX

;--------------------------------------------------------------------
;
; Out_to_sound_port
;             input:   a=sound port data to output
;             register usage:  n.a.
;
OUT_TO_SOUND_PORT:
        PUSH    BC;SAVE BC
        LD      B,A;THE IDEA IS TO GET THE
        LD      A,(SOUNDPORT);INDIRECT PORT ADDRESSING
        LD      C,A;THRU THE PORT TABLE IN EOS
        OUT     (C),B
        LD      A,B
        POP     BC
        RET
;
;====================================================================
;====================================================================
;====================================================================
;

;GLB    __QUERY_FILE,__SET_FILE,__MAKE_FILE
;GLB    __FILE_QUERY
;EXT    FCB_HEAD_ADDR,FCB_DATA_ADDR
;EXT    SCAN_FOR_FILE
;EXT    BLOCKS_REQ,USER_BUF,USER_NAME
;EXT    BUF_START,BUF_END
;EXT    STRCMP,BASECMP
;EXT    NEW_HOLE_SIZE,NEW_HOLE_START,HOLE_FILE_NAME
;EXT    EOS_YEAR,EOS_MONTH,EOS_DAY
;EXT    BLK_STRT_PTR,VOL_BLK_SZ      ;DLS(8/29/83)
;EXT    READ_BLOCK,WRITE_BLOCK_CHECK_IF_DIRECTORY
;EXT    DIR_BLOCK_NO,FOUND_AVAIL_ENT ; [RECON] Identifier repair: active OCR definition at 549 is FOUND_AVAIL_ENT.
;EXT    FILENAME_CMPS

;--------------------------------------------------------------------
;
; __QUERY_FILE -- Read the file's directory entry. (USES STRCMP FOR FILE NAME COMPARISIONS)
; __FILE_QUERY -- SAME AS ABOVE BUT SETS UP SCAN_FOR_FILE FOR BASE COMPARES ( USES BASECMP)
;
; CALLING PARAMETERS: Device number in A
;                     address of name string in DE
;                     address of buffer in HL
;
; EXIT PARAMETERS: if no errors -- Z = 1; A = 0; BCDE = file's start block;
;                  directory entry in caller's buffer
;                  if errors -- Z = 0; A = error code; DE = junk;
;                  caller's buffer undefined
;
;--------------------------------------------------------------------

__FILE_QUERY:
        SCF; THIS ENTRY DOES NOTHING MORE THAN SET CARRY FLAG
        JR      QUEER

__QUERY_FILE:
        SCF; THIS ENTRY CLEARS CARRY FLAG
        CCF
QUEER:
        PUSH    HL;SAVE REG'S
        PUSH    IX

        PUSH    AF

        JR      C,SET_UP_A; DID WE COME IN AT FILE_QUERY

        XOR     A; USE STRCMP FOR FILE NAME COMPARE
SET_UP_A:
        LD      (FILENAME_CMPS),A; 0 = COMPARE COMPLETE FILE NAME
; NOT 0 - COMPARE ONLY THE BASE
        POP     AF

        LD      (USER_BUF),HL;SAVE USER'S DATA ADDRESS

        LD      IX,(FCB_HEAD_ADDR);POINT TO SYSTEM'S FCB
        LD      H,D;GET NAME POINTER IN HL
        LD      L,E
        CALL    SCAN_FOR_FILE;LOOK IN TH' 'RECTORY
        JR      NZ,Q_ERROR;BRANCH IF ERROR RETURNED

        PUSH    DE;SAVE START BLOCK OF FILE
        PUSH    BC

        LD      DE,(USER_BUF);GET BUFFER ADDRESS IN DE
        LD      L,(IX+FCB_POINTER);GET ADDR OF ENTRY IN HL
        LD      H,(IX+FCB_POINTER+1)
        LD      BC,DIR_ENT_LENGTH-3;SET BYTE COUNT TO LOAD ONLY VALID INFO THAT
;THAT WAS STORED ON THE DEVICE

        LDIR;COPY DATA TO CALLER'S BUFFER

        POP     BC;GET FILE'S START BLOCK
        POP     DE

        XOR     A;SHOW NO ERROR
        LD      (FILENAME_CMPS),A; DEFAULT FOR SCAN FOR FILE
Q_ERROR:
        POP     IX;RESTORE REG'S
        POP     HL
        RET

;--------------------------------------------------------------------
;
; __SET_FILE -- Re-write the file's directory entry.
;
; CALLING PARAMETERS: Device number in A
;                     address of name string in DE
;                     address of buffer in HL
;
; EXIT PARAMETERS: if no errors -- Z = 1; A = 0;
;                  directory entry updated
;                  if errors -- Z = 0; A = error code;
;                  directory entry unchanged
;
;--------------------------------------------------------------------

__SET_FILE:
        PUSH    BC;SAVE REG'S
        PUSH    DE
        PUSH    HL
        PUSH    IX
        LD      (USER_BUF),HL;SAVE ADDR OF USER'S DATA

        LD      IX,(FCB_HEAD_ADDR);POINT TO SYSTEM'S FCB

        LD      H,D;GET STRING ADDRESS IN HL
        LD      L,E
        CALL    SCAN_FOR_FILE;GET THE DIR ENTRY
        JR      NZ,S_ERROR;BRANCH IF ERROR

        LD      HL,(USER_BUF);GET BUFFER ADDRESS
        LD      E,(IX+FCB_POINTER);GET ENTRY ADDR IN DE
        LD      D,(IX+FCB_POINTER+1)
        LD      BC,DIR_ENT_LENGTH-3;SET BYTE COUNT
        LDIR;COPY THEIR BUFFER TO BLOCK BUFFER

TAPE_TIMED_OUT:
        LD      A,(IX+FCB_DEVICE);SET DEVICE NUMBER
        LD      HL,(FCB_DATA_ADDR);GET ADDR OF MY BUFFER
        LD      E,(IX+FCB_BLOCK);GET BLOCK ADDRESS IN BCDE
        LD      D,(IX+FCB_BLOCK+1)
        LD      C,(IX+FCB_BLOCK+2)
        LD      B,(IX+FCB_BLOCK+3)
        CALL    WRITE_BLOCK;RE-WRITE THE DIRECTORY BLOCK

        JR      NZ,WRITE_ERRORS
        XOR     A;SHOW NO ERRORS

WRITE_ERRORS:
S_ERROR:

        POP     IX;RESTORE REG'S
        POP     HL
        POP     DE
        POP     BC
        RET

;--------------------------------------------------------------------
;
; __MAKE_FILE: creates a file in the directory.
;
; ENTRY PARAMETERS: called with device ID in A; address of name
;                   string in HL; file size (in bytes) in BC DE.
;
; NOTE:  IF FILE SIZE = 0 (BC DE), THEN THE REMAINDER OF THE TAPE IS
;        ALLOCATED TO THE FILE
;
; EXIT PARAMETERS: CONDITION FLAGS
;                  Z  -   NO ERRORS
;                  NZ -   ERRORS
;                         A = ERROR CODE
;
;        ALL REGISTERS ARE PRESERVED EXCEPT AF
;
;--------------------------------------------------------------------

FOUND_ENTRY     EQU     0; BIT INDICATING DELETED FILE FOUND FOR OVERLAYING

__MAKE_FILE:
        PUSH    IY;SAVE REGISTERS
        PUSH    IX
        PUSH    HL
        PUSH    DE
        PUSH    BC

        LD      IX,(FCB_HEAD_ADDR);POINT TO SYSTEM FCB
        LD      (IX+FCB_MODE),0; INIT IT IN CASE IT WAS SET

        LD      (IX+FCB_DEVICE),A;SAVE DEVICE NUMBER
        LD      (USER_NAME),HL;SAVE POINTER TO NAME

        LD      A,B; CHECK IF TO ALLOCATE REST OF TAPE
        OR      C
        JR      NZ,GOT_FILE_SIZE; NOPE, GOT SIZE

        LD      A,E
        OR      D
        JR      NZ,GOT_FILE_SIZE
        SET     MODE_REMAINDER_BIT,(IX+FCB_MODE); FLAG IT

        JR      SET_UP_DIR


; SINCE WE ARE CALLED WITH A BYTE COUNT, DIVIDE IT BY 1024
; (SHIFT RIGHT 10 BITS) TO GET A BLOCK COUNT.

GOT_FILE_SIZE:
        LD      E,D;DO A QUICK SHIFT BY 8
        LD      D,C
        LD      C,B
        LD      B,0
        SRL     C;SHIFT ONE MORE
        RR      D
        RR      E
        SRL     C;THEN ONE LAST TIME
        RR      D
        RR      E

; FOR THIS TO BE A LEGAL FILE SIZE, IT MUST FIT INTO DE.

        LD      A,C;CHECK FOR TOO BIG
        OR      A
        JP      NZ,TOO_BIG;JUMP IF TOO BEEG, SENOR
        INC     DE;ROUND UP IN CASE THERE WAS A FRACTION
        LD      A,E;CHECK FOR TOO BIG AGAIN
        OR      D
        JP      Z,TOO_BIG
        LD      (BLOCKS_REQ),DE;ELSE SAVE THE BLOCK COUNT

SET_UP_DIR:
        LD      DE,0; ZERO OUT HI ADDRESS
        LD      (BLOCKS_REQ+2),DE
        LD      (DIR_BLOCK_NO),DE
        XOR     A
        LD      (FOUND_AVAIL_ENT),A; [RECON] Identifier repair: operand bytes address FOUND_AVAIL_ENT at $FDDB.

        LD      (IX+FCB_BLOCK),1;INIT NUMBER OF FIRST DIR BLOCK
        LD      (IX+FCB_BLOCK+1),A; ZERO IT OUT
        LD      (IX+FCB_BLOCK+2),A
        LD      (IX+FCB_BLOCK+3),A

        LD      (IX+FCB_START_BLOCK),1;INIT NUMBER OF FIRST DIR BLOCK
        LD      (IX+FCB_START_BLOCK+1),A
        LD      (IX+FCB_START_BLOCK+2),A
        LD      (IX+FCB_START_BLOCK+3),A

        LD      DE,(FCB_DATA_ADDR);INIT POINTER TO BUFFER
        LD      (IX+FCB_POINTER),E
        LD      (IX+FCB_POINTER+1),D

        LD      (BUF_START),DE;ALSO INIT HERE WITH SAME
        LD      HL,1024;CALC ADDR OF END OF BUFFER TOO
        ADD     HL,DE
        LD      (BUF_END),HL;AND SAVE IT

;THIS LABEL NOT USED IN THIS ROUTINE, NOT DECLARED GLOBAL
;REMOVED BECAUSE IT CONFLICTS WITH IDENTICAL LABEL ELSEWHERE
;READ_TIMEOUT:
        LD      A,(IX+FCB_DEVICE);GET PARAMETERS FROM FCB
        LD      L,(IX+FCB_POINTER)
        LD      H,(IX+FCB_POINTER+1)
        LD      E,(IX+FCB_BLOCK)
        LD      D,(IX+FCB_BLOCK+1)
        LD      C,(IX+FCB_BLOCK+2)
        LD      B,(IX+FCB_BLOCK+3)
        CALL    READ_BLOCK;THEN READ THE FIRST BLOCK

        JP      NZ,MAKE_ERROR;BRANCH IF ERROR

SET_UP_FCB:
        LD      IY,(FCB_DATA_ADDR);POINT     THE BUFFER
;
        LD      A,(IY+VOL_DIRSIZE);GET THE DIR SIZE BYTE
        AND     7FH;ZERO THE PERM BIT
;       INC     A                       ;BECAUSE WE START IN BLOCK 1
;       DEC     A                       ;TO SOLVE PICKET FENCE PROBLEM
        LD      (IX+FCB_LAST_BLOCK),A;SET THE LAST BLOCK #
        LD      (IX+FCB_LAST_BLOCK+1),0;OTHER BYTES WILL BE ZERO
        LD      (IX+FCB_LAST_BLOCK+2),0
        LD      (IX+FCB_LAST_BLOCK+3),0

        CALL    CHECK_IF_DIRECTORY; CHECK IF DIRECTORY EXISTS
        JP      NZ,MAKE_ERROR

        LD      B,ENT_PER_BLOCK-1;INIT ENTRY COUNT, ALLOW FOR VOL ID

NEXT_ENT:
        LD      L,(IX+FCB_POINTER);GET CURRENT POINTER
        LD      H,(IX+FCB_POINTER+1)
        LD      DE,DIR_ENT_LENGTH;GET LENGTH OF AN ENTRY
        ADD     HL,DE;ADVANCE POINTER TO NEXT ENTRY
        LD      (IX+FCB_POINTER),L;AND SAVE IT AGAIN
        LD      (IX+FCB_POINTER+1),H

CHECK_ENT:
        LD      L,(IX+FCB_POINTER);GET POINTER INTO IY THE LONG WAY
        LD      H,(IX+FCB_POINTER+1)
        PUSH    HL
        POP     IY;!!!

        LD      A,(IY+DIR_ATTR);GET THE ATTRIBUTE BYTE FOR THIS ENTRY
        LD      C,A;SAVE IT HERE FOR NOW
        BIT     ATTR_HOLE_BIT,A;CHECK IF HOLE
        JP      NZ,FOUND_HOLE;BRANCH IF IT'S A HOLE!!! <<------

        BIT     MODE_REMAINDER_BIT,(IX+FCB_MODE); DO WE ALLOCATE REST OF TAPE?
        JR      NZ,D_FILE;YUP. DON'T BOTHER CHECKING

        BIT     ATTR_DEL_BIT,C;IS IT A DELETED FILE?
        JR      Z,ACTIVE_FILE;NOPE. AN ACTIVE ONE

;       LET'S LOOK FOR DELETED FILE TO USE

        LD      L,(IY+DIR_MAX_LENGTH); GET ALLOCATED SIZE
        LD      H,(IY+DIR_MAX_LENGTH+1)

        LD      DE,(BLOCKS_REQ); MIN NO OF BLOCKS NEEDED
        OR      A;clear carry flag
        SBC     HL,DE; WILL WE FIT?
        JR      C,D_FILE; NOPE. LOOK FOR ANOTHER ENTRY

        LD      HL,FOUND_AVAIL_ENT; FLAG BYTE ; [RECON] Identifier repair: operand bytes address FOUND_AVAIL_ENT at $FDDB.
        BIT     FOUND_ENTRY,(HL); DO WE ALREADY HAVE FIRST FIT?
        JR      NZ,D_FILE; YUP. DON'T EVEN CONSIDER THIS ONE

        SET     FOUND_ENTRY,(HL)
        LD      E,(IX+FCB_BLOCK);GET BLOCK NO OF THIS DIRECTORY
        LD      D,(IX+FCB_BLOCK+1)

        LD      (DIR_BLOCK_NO),DE; SAVE IT
        JR      D_FILE


; IF THIS IS A REAL FILE, WE CAN SEE IF ITS NAME MATCHES THE
; ONE WE ARE ABOUT TO MAKE -- IT'S AN ERROR IF SO.

ACTIVE_FILE:
        LD      E,(IX+FCB_POINTER);POINT TO THIS ENTRY
        LD      D,(IX+FCB_POINTER+1)
        LD      HL,(USER_NAME);POINT TO DESIRED NAME
        CALL    BASECMP;COMPARE THE BASE OF THE FILENAMES
        JP      Z,FILE_EXISTS;BRANCH IF THEY'RE THE SAME
D_FILE:
        DJNZ    NEXT_ENT;ELSE GO TO NEXT ENTRY (IF IT EXISTS)

        LD      HL,(BUF_START);IF NOT RESET FCB FOR NEXT BLOCK
        LD      (IX+FCB_POINTER),L
        LD      (IX+FCB_POINTER+1),H
        INC     (IX+FCB_BLOCK);INC THE BLOCK -- NO CARRY OUT

; DO 4-BYTE COMPARE OF FCB_BLOCK VS FCB_LAST_BLOCK TO SEE
; IF THERE'S MORE FILE LEFT.

        LD      A,(IX+FCB_LAST_BLOCK+3);COMPARE MS BYTES
        CP      (IX+FCB_BLOCK+3)
        JP      C,FULL_DIR;BRANCH IF BLOCK IS LARGER
        LD      A,(IX+FCB_LAST_BLOCK+2);COMPARE NEXT BYTES
        CP      (IX+FCB_BLOCK+2)
        JP      C,FULL_DIR;BRANCH IF BLOCK IS LARGER
        LD      A,(IX+FCB_LAST_BLOCK+1);COMPARE NEXT BYTES
        CP      (IX+FCB_BLOCK+1)
        JP      C,FULL_DIR;BRANCH IF BLOCK IS LARGER
        LD      A,(IX+FCB_LAST_BLOCK+0);COMPARE LS BYTES
        CP      (IX+FCB_BLOCK+0)
        JP      C,FULL_DIR;BRANCH IF BLOCK IS LARGER
; IF WE FALL OUT, FCB_BLOCK <= FCB_LAST_BLOCK.
DO_READ_AGAIN:

        LD      A,(IX+FCB_DEVICE);SET UP THE PARAMETERS
        LD      L,(IX+FCB_POINTER)
        LD      H,(IX+FCB_POINTER+1)
        LD      E,(IX+FCB_BLOCK)
        LD      D,(IX+FCB_BLOCK+1)
        LD      C,(IX+FCB_BLOCK+2)
        LD      B,(IX+FCB_BLOCK+3)
        CALL    READ_BLOCK;AND READ THE NEXT BLOCK OF ENTRIES
        JP      NZ,MAKE_ERROR; NOPE, A REAL ERROR

NO_TIMEOUT:
        LD      B,ENT_PER_BLOCK;SET THE ENTRY COUNTER
        JP      CHECK_ENT;AND GO CHECK THE NEW ENTRY

FULL_DIR:
        LD      HL,FOUND_AVAIL_ENT; [RECON] Identifier repair: operand bytes address FOUND_AVAIL_ENT at $FDDB.
        BIT     FOUND_ENTRY,(HL); HAVE WE FOUND AN ENTRY?
        JP      Z,FULL_DIR_EXIT; NOPE, EXIT
        JR      USE_ENTRY; YUP, CREATE NEW ENTRY THERE

; ARRIVE HERE WHEN WE'VE FOUND THE HOLE ENTRY IN THE DIRECTORY.
; IY IS STILL POINTING TO THE ENTRY IN THE BUFFER.

FOUND_HOLE:
        LD      HL,FOUND_AVAIL_ENT; [RECON] Identifier repair: operand bytes address FOUND_AVAIL_ENT at $FDDB.
        BIT     FOUND_ENTRY,(HL); HAVE WE FOUND A DELETED ENTRY WE COULD USE?
        JR      Z,USE_HOLE; NOPE, STICK IT IN THE END

USE_ENTRY:
        RES     FOUND_ENTRY,(HL); RESET FOR NEXT TIME

        LD      L,(IX+FCB_BLOCK); GET THE CURRENT BLOCK
        LD      H,(IX+FCB_BLOCK+1)

        LD      DE,(DIR_BLOCK_NO); BLOCK NO WHERE WE HAVE ENTRY TO USE
        OR      A;clear carry flag
        SBC     HL,DE; SAME BLOCK?

        LD      HL,(BUF_START); POINT TO START OF BLOCK
        LD      (IX+FCB_POINTER),L
        LD      (IX+FCB_POINTER+1),H

        JR      Z,GOT_BLOCK; YUP, DON'T NEED TO READ IN ANOTHER BLOCK

        LD      (IX+FCB_BLOCK),E; GET THIS BLOCK
        LD      (IX+FCB_BLOCK+1),D

        LD      BC,0
        LD      A,(IX+FCB_DEVICE); DEVICE ID

        CALL    READ_BLOCK
        JP      NZ,MAKE_ERROR
        JR      GOT_BLOCK; READ IN NEW DIRECTORY

NEXT_DIR:
TOO_SMALL:
        LD      L,(IX+FCB_POINTER); GET POINTER TO DIR ENTRY
        LD      H,(IX+FCB_POINTER+1)

        LD      DE,DIR_ENT_LENGTH; LENGTH OF ENTRY

        ADD     HL,DE; POINT TO NEXT ENTRY

        LD      (IX+FCB_POINTER),L
        LD      (IX+FCB_POINTER+1),H

GOT_BLOCK:
        PUSH    HL
        POP     IY

        BIT     ATTR_DEL_BIT,(IY+DIR_ATTR); IS IT DELETED?
        JR      Z,NEXT_DIR; NOPE, LOOK FOR ANOTHER DELETED ENTRY

        LD      L,(IY+DIR_MAX_LENGTH); GET ALLOCATED AMOUNT OF DELETED FILE
        LD      H,(IY+DIR_MAX_LENGTH+1)

        LD      DE,(BLOCKS_REQ); MIN AMOUNT NEEDED

        PUSH    HL
        OR      A;clear carry flag
        SBC     HL,DE; WILL IT FIT?
        POP     HL

        JR      C,TOO_SMALL; NOPE, TRY ANOTHER ONE

        LD      (BLOCKS_REQ),HL; FORCE ALLOCATED AMOUNT

        CALL    LOAD_NEW_ENTRY_INFO

        JP      NZ,MAKE_ERROR

        JP      TIME_TO_WRITE

; COMPARE FCB_BLOCK TO FCB_LAST_BLOCK.  GO TO MORE_BLOCKS
; IF FCB_LAST_BLOCK > FCB_BLOCK.

USE_HOLE:
        LD      A,(IX+FCB_BLOCK+3)
        CP      (IX+FCB_LAST_BLOCK+3)
        JR      C,MORE_BLOCKS
        LD      A,(IX+FCB_BLOCK+2)
        CP      (IX+FCB_LAST_BLOCK+2)
        JR      C,MORE_BLOCKS
        LD      A,(IX+FCB_BLOCK+1)
        CP      (IX+FCB_LAST_BLOCK+1)
        JR      C,MORE_BLOCKS
        LD      A,(IX+FCB_BLOCK)
        CP      (IX+FCB_LAST_BLOCK)
        JR      C,MORE_BLOCKS

; FALL THROUGH IF THIS IS THE LAST BLOCK OF THE FILE.

        LD      A,B;LOOK AT ENTRY COUNTER
        CP      1
        JP      Z,TAPE_FULL;ERROR IF NO ENTRIES LEFT VACANT

MORE_BLOCKS:
        LD      L,(IY+DIR_MAX_LENGTH);GET THE SIZE OF THE HOLE
        LD      H,(IY+DIR_MAX_LENGTH+1)

        BIT     MODE_REMAINDER_BIT,(IX+FCB_MODE); NEED TO ALLOCATE REST OF TAPE?
        JR      Z,CHECK_HOLE_SIZE; NOPE

        LD      A,H; YUP. CHECK IF THERE ARE ANY BLOCKS LEFT
        OR      L
        JP      Z,TAPE_FULL; TAPE FULL

        LD      (BLOCKS_REQ),HL; NOT FULL. REQUEST REST OF TAPE
        RES     MODE_REMAINDER_BIT,(IX+FCB_MODE)

CHECK_HOLE_SIZE:
        LD      DE,(BLOCKS_REQ);GET THE REQUESTED SIZE
        OR      A
        SBC     HL,DE;COMPARE THEM
        JP      C,TAPE_FULL;BRANCH IF THE HOLE IS TOO SMALL
        LD      (NEW_HOLE_SIZE),HL;ELSE SAVE THE RESULT


; ADD BLOCKS_REQ TO DIR_START_BLOCK TO FIND THE HOLE'S NEW
; START BLOCK.  NOTICE HOW STOOOPID THE Z80 IS WITH ADDITION!
        LD      HL,BLOCKS_REQ;POINT TO THE NUMBER TO ADD
        LD      A,(IY+DIR_START_BLOCK)
        ADD     A,(HL)
        INC     HL
        LD      (NEW_HOLE_START),A
        LD      A,(IY+DIR_START_BLOCK+1)
        ADC     A,(HL)
        INC     HL
        LD      (NEW_HOLE_START+1),A
        LD      A,(IY+DIR_START_BLOCK+2)
        ADC     A,(HL)
        INC     HL
        LD      (NEW_HOLE_START+2),A
        LD      A,(IY+DIR_START_BLOCK+3)
        ADC     A,(HL)
        INC     HL
        LD      (NEW_HOLE_START+3),A

        PUSH    BC;SAVE ENTRY COUNT (IN B)

        CALL    LOAD_NEW_ENTRY_INFO

        POP     BC;RESTORE ENTRY COUNT

        JP      NZ,MAKE_ERROR

        LD      L,(IX+FCB_POINTER);GET CURRENT POINTER


        LD      H,(IX+FCB_POINTER+1)
        LD      DE,DIR_ENT_LENGTH;GET LENGTH OF AN ENTRY
        ADD     HL,DE;ADVANCE POINTER TO NEXT ENTRY
        LD      (IX+FCB_POINTER),L;AND SAVE IT AGAIN
        LD      (IX+FCB_POINTER+1),H

        DJNZ    NOT_END;JUMP IF THERE ARE MORE ENTRIES

;THIS LABEL NOT USED IN THIS ROUTINE, NOT DECLARED GLOBAL
;REMOVED BECAUSE IT CONFLICTS WITH IDENTICAL LABEL ELSEWHERE
;WRITE_AGAIN:
        LD      A,(IX+FCB_DEVICE);GET PARAMETERS FROM FCB
        LD      HL,(BUF_START)
        LD      E,(IX+FCB_BLOCK)
        LD      D,(IX+FCB_BLOCK+1)
        LD      C,(IX+FCB_BLOCK+2)
        LD      B,(IX+FCB_BLOCK+3)

        CALL    WRITE_BLOCK

        JP      NZ,MAKE_ERROR; NOPE, A REAL LIVE ERROR


RESET_THE_POINTER:
        LD      HL,(BUF_START);RESET THE POINTER
        LD      (IX+FCB_POINTER),L
        LD      (IX+FCB_POINTER+1),H

        INC     (IX+FCB_BLOCK);INC BLOCK -- NO CARRY OUT

TIMEOUT_IN_READ:
        LD      A,(IX+FCB_DEVICE);GET PARAMETERS FROM FCB
        LD      L,(IX+FCB_POINTER)
        LD      H,(IX+FCB_POINTER+1)
        LD      E,(IX+FCB_BLOCK)
        LD      D,(IX+FCB_BLOCK+1)
        LD      C,(IX+FCB_BLOCK+2)
        LD      B,(IX+FCB_BLOCK+3)
        CALL    READ_BLOCK;AND READ THE NEXT BLOCK

        JR      NZ,MAKE_ERROR; NOPE, ERROR!!!!!!


        LD      L,(IX+FCB_POINTER);GET POINTER INTO IY THE LONG WAY
        LD      H,(IX+FCB_POINTER+1)

NOT_END:
        PUSH    HL
        POP     IY;!!!!

;
; STILL TRYING TO CALC THE NEW START ADDR
;
        LD      HL,(NEW_HOLE_SIZE)
        LD      (IY+DIR_MAX_LENGTH),L; BLOCKS LEFT ON TAPE
        LD      (IY+DIR_MAX_LENGTH+1),H

        LD      A,(NEW_HOLE_START)
        LD      (IY+DIR_START_BLOCK),A
        LD      A,(NEW_HOLE_START+1)
        LD      (IY+DIR_START_BLOCK+1),A
        LD      A,(NEW_HOLE_START+2)
        LD      (IY+DIR_START_BLOCK+2),A
        LD      A,(NEW_HOLE_START+3)
        LD      (IY+DIR_START_BLOCK+3),A

        LD      (IY+DIR_ATTR),ATTR_HOLE; SET HOLE UP

        PUSH    IY
        POP     DE

        LD      HL,HOLE_FILE_NAME
        LD      BC,12
        LDIR

TIME_TO_WRITE:
        LD      A,(IX+FCB_DEVICE);GET PARAMETERS FROM FCB
        LD      HL,(BUF_START)
        LD      E,(IX+FCB_BLOCK)
        LD      D,(IX+FCB_BLOCK+1)
        LD      C,(IX+FCB_BLOCK+2)
        LD      B,(IX+FCB_BLOCK+3)
        CALL    WRITE_BLOCK;WRITE THE BLOCK OUT

        JR      NZ,MAKE_ERROR; IT'S A BOO BOO!!
        XOR     A;SHOW NO ERROR

LETS_GET_OUT:
MAKE_ERROR:
;RESTORE THE REGISTERS
        OR      A
        POP     BC
        POP     DE
        POP     HL
        POP     IX
        POP     IY
        RET

TOO_BIG:
        LD      A,TOO_BIG_ERR;SHOW AN ERROR
        JR      MAKE_ERROR


FILE_EXISTS:
        LD      A,FILE_EXISTS_ERR
        JR      MAKE_ERROR

FULL_DIR_EXIT:
        LD      A,FULL_DIR_ERR
        JR      MAKE_ERROR

TAPE_FULL:
        LD      A,FULL_TAPE_ERR
        JR      MAKE_ERROR
;
;
; SUBROUTINE NAME: GET FILE NAME LENGTH
;
;   ENTRY: HL- POINTS TO TEXT STRING
;   EXIT:  Z=1=FOUND AND PROPER SIZE (1-12)
;          BC=BYTE COUNT
;          A=TRASHED
;
;          Z=0=ERROR
;          BC=TRASH
;          A=FILE_NAME_TOO_LONG
; DLS(8/28/83)
;
GET_FILE_NM_LEN:
        PUSH    HL;SAVE THE POINTER TO FILE NAME
        LD      B,12;SCAN UP TO 12 BYTE
        LD      C,1;SET COUNT TO 1
SRCH_LOOP:
        LD      A,(HL);GET FN()
        CP      03;ETX
        JR      Z,GOT_IT
;
        INC     C
        INC     HL;ADVANCE POINTER TO FILE NAME STRING
        DJNZ    SRCH_LOOP
;
ERR_GFN:
        LD      A,FILE_NM_ERR
        OR      A;SHOW ERROR
        POP     HL
        RET
;
GOT_IT:
        LD      A,C
        CP      1;ETX ALONE IS NOT VALID
        JR      Z,ERR_GFN
        LD      B,0
        XOR     A;SHOW OK
        POP     HL
        RET



LOAD_NEW_ENTRY_INFO:
        PUSH    IY;GET NAME ADDRESS INTO DE
        POP     DE

        LD      HL,(USER_NAME);GET USER'S STRING ADDRESS
;
        CALL    GET_FILE_NM_LEN; DLS(8/28/83)
        JP      NZ,MAKE_ERR_1
;
        LDIR;COPY USER'S NAME INTO DIR ENTRY

        LD      A,ATTR_USER;SET THE DEFAULT ATTRIBUTE
        LD      (IY+DIR_ATTR),A

        LD      BC,(BLOCKS_REQ);GET NEW FILE'S MAX SIZE
        LD      (IY+DIR_MAX_LENGTH),C;PUT INTO DIR
        LD      (IY+DIR_MAX_LENGTH+1),B


        LD      (IY+DIR_USED_LENGTH),1;INIT COUNT OF BLOCKS USED
        LD      (IY+DIR_USED_LENGTH+1),0

        LD      (IY+DIR_LAST_COUNT),0;INIT BYTECOUNT IN LAST BLOCK
        LD      (IY+DIR_LAST_COUNT+1),0

        LD      A,(EOS_YEAR);INSERT THE DATE
        LD      (IY+DIR_YEAR),A
        LD      A,(EOS_MONTH)
        LD      (IY+DIR_MONTH),A
        LD      A,(EOS_DAY)
        LD      (IY+DIR_DAY),A

        XOR     A

MAKE_ERR_1:
        RET

;
;===============================================================
;===============================================================
;===============================================================
;

;GLB    __OPEN_FILE,__CLOSE_FILE,__RESET_FILE
;EXT    FCB_HEAD_ADDR,FCB_DATA_ADDR
;EXT    BUF_START,FMGR_DIR_ENT
;EXT    __QUERY_FILE,MODE_CHECK,READ_BLOCK,WRITE_BLOCK
;EXT    __SET_FILE
;EXT    FILE_NAME_ADDR

;----------------------------------------------------------------
;
; __OPEN_FILE -- Sets up an FCB for the caller to access a file.
;
; CALLING PARAMETERS: device number in A; address of name string
;                     in HL; mode in B.
;
; EXIT PARAMETERS: if no error -- Z = 1; A = file number
;                  if error -- Z = 0; A = error code; B = junk
;
;----------------------------------------------------------------

; NEXT_FCB CHANGED TO O_NEXT_FCB TO PREVENT CONFLICT WITH
; IDENTICAL LABEL ELSEWHERE

__OPEN_FILE:
        PUSH    IY;SAVE REGISTERS
        PUSH    HL
        PUSH    IX
        PUSH    DE

        PUSH    AF;SAVE DEVICE NUMBER
        PUSH    BC;SAVE MODE

; FIRST, WE HAVE TO LOCATE A FREE FCB.
        LD      IX,(FCB_HEAD_ADDR);GET POINTER TO FIRST FCB'S HEAD
        LD      DE,FCB_LENGTH
        ADD     IX,DE; SKIP OVER IT -- BELONGS TO SYSTEM

        LD      IY,(FCB_DATA_ADDR);GET POINTER TO FIRST FCB'S BODY
        LD      DE,1024
        ADD     IY,DE; SKIP OVER IT TOO

        LD      B,1;SET FCB NUMBER
O_NEXT_FCB:
        LD      A,(IX+FCB_MODE);GET THE MODE BYTE FROM FCB
        OR      A;CHECK IT
        JR      Z,GOT_ONE;BRANCH IF THIS ONE IS FREE

        LD      DE,FCB_LENGTH;ELSE SKIP OVER IT
        ADD     IX,DE
        LD      DE,1024
        ADD     IY,DE

        INC     B;INC THE FCB NUMBER
        LD      A,B
        CP      NUM_FCBS;ARE THERE MORE FCBS TO CHECK?
        JR      C,O_NEXT_FCB;LOOP UNTIL WE'VE SEEN THEM ALL
NO_FCBS:
        POP     BC;RESTORE MODE
        POP     AF
        POP     DE
        POP     IX
        POP     HL
        POP     IY

        LD      A,NO_FCB_ERR;SET THE ERROR CODE
        OR      A;SET THE CONDITIONS
        RET

GOT_ONE:
        LD      (BUF_START),IY;SAVE THE FCB BUFFER'S ADDRESS

        POP     AF;GET THE MODE
        LD      (IX+FCB_MODE),A;PUT IT INTO FCB
        POP     AF;GET THE DEVICE
        LD      (IX+FCB_DEVICE),A;PUT IT INTO FCB

        PUSH    BC;SAVE THE FCB NUMBER

        PUSH    HL
        POP     DE; ADDRESS OF NAME STRING

        PUSH    IX;POINT TO FCB NAME (ASSUME OFFSET = 0)
        POP     HL
        LD      A,(IX+FCB_DEVICE);GET DEVICE NUMBER
        CALL    __QUERY_FILE;GET THE FILE'S DIR ENTRY
        JP      NZ,OP_ERR;BRANCH IF THERE WAS AN ERROR
;*** SET PARAMS ***
        CALL    MODE_CHECK;SEE IF MODE MATCHES ATTRIBUTES
        JP      NZ,OP_ERR;BRANCH IF NOT

        LD      A,(IX+FCB_USED_LENGTH);CALC. & SET LAST BLOCK
        ADD     A,(IX+FCB_FIRST_BLOCK)
        LD      (IX+FCB_LAST_BLOCK),A
        LD      A,(IX+FCB_FIRST_BLOCK+1)
        ADC     A,(IX+FCB_USED_LENGTH+1)
        LD      (IX+FCB_LAST_BLOCK+1),A
        LD      A,(IX+FCB_FIRST_BLOCK+2)
        ADC     A,0
        LD      (IX+FCB_LAST_BLOCK+2),A
        LD      A,(IX+FCB_FIRST_BLOCK+3)
        ADC     A,0
        LD      (IX+FCB_LAST_BLOCK+3),A

        LD      A,(IX+FCB_LAST_BLOCK+0)
        SUB     1
        LD      (IX+FCB_LAST_BLOCK+0),A

        LD      A,(IX+FCB_LAST_BLOCK+1)
        SBC     A,0
        LD      (IX+FCB_LAST_BLOCK+1),A

        LD      A,(IX+FCB_LAST_BLOCK+2)
        SBC     A,0
        LD      (IX+FCB_LAST_BLOCK+2),A

        LD      A,(IX+FCB_LAST_BLOCK+3)
        SBC     A,0
        LD      (IX+FCB_LAST_BLOCK+3),A

        LD      DE,(BUF_START);INIT BUFFER POINTER
        LD      (IX+FCB_POINTER),E
        LD      (IX+FCB_POINTER+1),D

        LD      A,(IX+FCB_FIRST_BLOCK);SET BLOCK TO FIRST_BLOCK
        LD      (IX+FCB_BLOCK),A
        LD      A,(IX+FCB_FIRST_BLOCK+1)
        LD      (IX+FCB_BLOCK+1),A
        LD      A,(IX+FCB_FIRST_BLOCK+2)
        LD      (IX+FCB_BLOCK+2),A
        LD      A,(IX+FCB_FIRST_BLOCK+3)
        LD      (IX+FCB_BLOCK+3),A

        LD      A,(IX+FCB_MODE);LOOK AT THE MODE
        AND     MODE_MODE
        CP      MODE_WRITE;IS IT WRITE MODE?
        JR      Z,OPEN5;JUMP IF SO -- NO PRE-READ NECESSARY

READ_TIMEOUT:
;       If FCB_USED_LENGTH = 1 (file size of one block)
        XOR     A;Load Acc with zero
        CP      (IX+FCB_USED_LENGTH+1);High order must be zero
        JR      NZ,NOT_SIZE_1;If not then past bitset
        INC     A;Inc Acc to a 1
        CP      (IX+FCB_USED_LENGTH);Compare with low order
        JR      NZ,NOT_SIZE_1;If not equal then exit

;       Then set last block bit in mode
        SET     MODE_LAST_BLOCK_BIT,(IX+FCB_MODE);Set it
;       Endif
NOT_SIZE_1:

        LD      A,(IX+FCB_DEVICE);GET THE DEVICE NUMBER
        LD      HL,(BUF_START);GET BUFFER ADDRESS
        LD      E,(IX+FCB_BLOCK);GET BLOCK NUMBER
        LD      D,(IX+FCB_BLOCK+1)
        LD      C,(IX+FCB_BLOCK+2)
        LD      B,(IX+FCB_BLOCK+3)
        CALL    READ_BLOCK;READ THE FIRST BLOCK

        JR      NZ,OP_ERR; IT'S AN ERROR

OPEN5:
        XOR     A;SHOW NO ERROR
        POP     BC;GET THE FILE NUMBER IN B
        LD      A,B

        JR      REST_REGS
;       POP     DE                     ;RESTORE REGISTERS
;       POP     IX
;       POP     HL
;       POP     IY
;       RET

OP_ERR:
        LD      (IX+FCB_MODE),MODE_UNUSED;MAKE THE FCB UNUSED AGAIN

        POP     BC;RESTORE REGISTERS
REST_REGS:
        POP     DE
        POP     IX
        POP     HL
        POP     IY
        RET

;----------------------------------------------------------------
;
; __CLOSE_FILE -- does the necessary clean-up and marks the FCB
;                 as unused.
;
; ENTRY PARAMETERS -- file number in A.
;
; EXIT PARAMETERS -- if no error -- Z = 1; A = 0
;                   if error -- Z = 0; A = error code
;
;----------------------------------------------------------------

__CLOSE_FILE:
        PUSH    IX;SAVE REGISTERS
        PUSH    HL
        PUSH    DE
        PUSH    BC

        OR      A;CHECK FILE NUMBER
        JR      Z,C_ERROR;BRANCH IF ZERO
        CP      NUM_FCBS;CHECK FOR MAX RANGE
        JR      NC,C_ERROR;BRANCH IF TOO LARGE

        LD      B,A;PUT IT INTO B
        LD      IX,(FCB_HEAD_ADDR);GET ADDRESS OF 0TH FCB
        LD      HL,(FCB_DATA_ADDR);GET ADDRESS OF 0TH BUFFER
CLOSE2:
        LD      DE,FCB_LENGTH;SET OFFSET
        ADD     IX,DE;ADVANCE POINTER TO NEXT FCB
        LD      DE,1024
        ADD     HL,DE;ADVANCE POINTER TO NEXT BUFFER
        DJNZ    CLOSE2;UNTIL WE GET TO THE ONE WE WANT

        LD      A,(IX+FCB_MODE);LOOK AT THE MODE BYTE
        OR      A
        JR      Z,C_ERROR;BRANCH IF FCB NOT IN USE

        AND     MODE_DIRTY;ZERO UNWANTED BITS
        JR      Z,CLOSE3;BRANCH IF BUFFER NOT DIRTY

        LD      (FILE_NAME_ADDR),IX; POINTER TO FILE NAME IN FCB
WRITE_TIMEOUT:
        LD      A,(IX+FCB_DEVICE); GET THE DEVICE NUMBER
        LD      E,(IX+FCB_BLOCK);GET THE BLOCK NUMBER
        LD      D,(IX+FCB_BLOCK+1)
        LD      C,(IX+FCB_BLOCK+2)
        LD      B,(IX+FCB_BLOCK+3)
;HL STILL HAS ADDRESS OF BUFFER
        CALL    WRITE_BLOCK;FLUSH THE BLOCK TO TAPE
        JR      NZ,C_ERROR2;BRANCH IF ERROR

CLOSE4:
        LD      A,(IX+FCB_DEVICE); GET DEVICE ID
        PUSH    IX
        POP     HL
        LD      DE,(FILE_NAME_ADDR)

        CALL    __SET_FILE

CLOSE3:
        LD      (IX+FCB_MODE),MODE_UNUSED;MARK THE FCB EMPTY

        POP     BC;RESTORE REGISTERS
        POP     DE
        POP     HL
        POP     IX
        RET
C_ERROR:
        POP     BC;RESTORE REGISTERS
        POP     DE
        POP     HL
        POP     IX
        LD      A,BAD_FNUM_ERR;SET THE ERROR
        OR      A;SET THE CONDITIONS
        RET
C_ERROR2:
        POP     BC;RESTORE REGISTERS
        POP     DE
        POP     HL
        POP     IX
        OR      A;SET CONDITIONS
        RET

;----------------------------------------------------------------
;
; __RESET_FILE -- rewinds the file back to the first byte.
;
; ENTRY PARAMETERS: file number in A
;
; EXIT PARAMETERS: no error -- Z = 1; A = 0
;                  if error -- Z = 0; A = error code
;
;----------------------------------------------------------------

__RESET_FILE:
        PUSH    IX;SAVE REGISTERS
        PUSH    DE
        PUSH    BC
        PUSH    HL

        OR      A;CHECK FILE NUMBER
        JP      Z,R_ERROR;BRANCH IF ZERO
        CP      NUM_FCBS;CHECK FOR MAX RANGE
        JP      NC,R_ERROR;BRANCH IF TOO LARGE

        LD      B,A;PUT IT INTO B
        LD      IX,(FCB_HEAD_ADDR);GET ADDRESS OF 0TH FCB
        LD      HL,(FCB_DATA_ADDR);GET ADDRESS OF 0TH BUFFER
RES1:
        LD      DE,FCB_LENGTH;SET OFFSET
        ADD     IX,DE;ADVANCE POINTER TO NEXT FCB
        LD      DE,1024;SET BUFFER SIZE
        ADD     HL,DE;ADVANCE POINTER TO NEXT BUFFER
        DJNZ    RES1;UNTIL WE GET TO THE ONE WE WANT

        LD      A,(IX+FCB_MODE);LOOK AT THE MODE BYTE
        OR      A
        JR      Z,R_ERROR;BRANCH IF FCB NOT IN USE

        AND     MODE_DIRTY;ZERO UNWANTED BITS
        JR      Z,RES2;BRANCH IF BUFFER NOT DIRTY

TIMED_OUT:
        LD      A,(IX+FCB_DEVICE);GET THE DEVICE NUMBER
        LD      E,(IX+FCB_BLOCK);GET THE BLOCK NUMBER
        LD      D,(IX+FCB_BLOCK+1)
        LD      C,(IX+FCB_BLOCK+2)
        LD      B,(IX+FCB_BLOCK+3)
;HL STILL HAS ADDRESS OF BUFFER
        CALL    WRITE_BLOCK;FLUSH THE BLOCK TO TAPE
        JR      NZ,R_ERROR2;BRANCH IF ERROR

RESET_BIT:
        RES     MODE_DIRTY_BIT,(IX+FCB_MODE);CLEAR THE DIRTY BIT
RES2:
        RES     MODE_LAST_BLOCK_BIT,(IX+FCB_MODE); BACK TO FIRST BLOCK
        LD      A,(IX+FCB_FIRST_BLOCK);SET BLOCK TO FIRST_BLOCK
        LD      (IX+FCB_BLOCK),A
        LD      A,(IX+FCB_FIRST_BLOCK+1)
        LD      (IX+FCB_BLOCK+1),A
        LD      A,(IX+FCB_FIRST_BLOCK+2)
        LD      (IX+FCB_BLOCK+2),A
        LD      A,(IX+FCB_FIRST_BLOCK+3)
        LD      (IX+FCB_BLOCK+3),A

        LD      (IX+FCB_POINTER+0),L;reset pointer for new (first) block
        LD      (IX+FCB_POINTER+1),H

        LD      A,(IX+FCB_MODE);GET THE MODE AGAIN
        AND     MODE_MODE;LOOK AT MODE TYPE ONLY
        CP      MODE_WRITE;ARE WE WRITING?
        JR      NZ,READ_IT;NOPE, NEED TO PRE-READ

        LD      (IX+FCB_LAST_COUNT),0
        LD      (IX+FCB_LAST_COUNT+1),0

        LD      (IX+FCB_USED_LENGTH),1
        LD      (IX+FCB_USED_LENGTH+1),0

        JR      NO_READ

READ_IT:
        LD      A,(IX+FCB_DEVICE);GET THE DEVICE NUMBER
        LD      E,(IX+FCB_BLOCK);GET THE BLOCK NUMBER
        LD      D,(IX+FCB_BLOCK+1)
        LD      C,(IX+FCB_BLOCK+2)
        LD      B,(IX+FCB_BLOCK+3)
;HL STILL HAS ADDRESS OF BUFFER
        CALL    READ_BLOCK;READ THE FIRST BLOCK

        JR      NZ,R_ERROR2;BRANCH ON ERROR

NO_READ:
        POP     HL;RESTORE THE REGISTERS
        POP     BC
        POP     DE
        POP     IX
        XOR     A;SHOW NO ERROR
        RET

R_ERROR:
        POP     HL;RESTORE THE REGISTERS
        POP     BC
        POP     DE
        POP     IX
        LD      A,BAD_FNUM_ERR;SHOW THE ERROR
        OR      A;SET CONDITIONS
        RET
R_ERROR2:
        POP     HL;RESTORE REGISTERS
        POP     BC
        POP     DE
        POP     IX
        OR      A;SET CONDITION
        RET
;
;===============================================================
;===============================================================
;===============================================================
;


;Packed some code to allow room for

;GLB    __READ_FILE,__WRITE_FILE
;EXT    BUF_START,BUF_END,USER_BUF,BYTES_REQ,BYTES_TO_GO
;EXT    FNUM
;EXT    FCB_HEAD_ADDR,FCB_DATA_ADDR
;EXT    READ_BLOCK,WRITE_BLOCK
;EXT    MODE_CHECK

;----------------------------------------------------------------
;
; __READ_FILE -- read some data from a file into the user's buffer.
;
; ENTRY PARAMETERS: device number in A; buffer address in HL;
;                   desired number of bytes in BC.
;
; EXIT PARAMETERS: no errors -- Z = 1; A = 0
;                  if errors -- Z = 0; A = error code;
;                  BC = number of bytes transferred
;
;----------------------------------------------------------------

; GET_OUT CHANGED TO R_GET_OUT TO PREVENT CONFLICT WITH
; IDENTICAL LABEL ELSEWHERE

__READ_FILE:
        PUSH    BC;SAVE REGISTERS
        PUSH    DE
        PUSH    HL
        PUSH    IX

        LD      (USER_BUF),HL;SAVE USER'S BUFFER ADDRESS
        LD      (BYTES_REQ),BC;SAVE REQUESTED COUNT
        LD      (FNUM),A;SAVE FILE NUMBER
        LD      (BYTES_TO_GO),BC;INIT COUNTER (COUNTS DOWN)

        OR      A;CHECK FILE NUMBER
        JP      Z,READ_ERR2;BRANCH IF ZERO
        CP      NUM_FCBS;CHECK FOR MAX RANGE
        JP      NC,READ_ERR2;BRANCH IF TOO LARGE

        LD      B,A;PUT IT INTO B
        LD      IX,(FCB_HEAD_ADDR);GET ADDRESS OF 0TH FCB
        LD      HL,(FCB_DATA_ADDR);GET ADDRESS OF 0TH BUFFER
READ1:
        LD      DE,FCB_LENGTH;ADVANCE POINTER TO NEXT FCB
        ADD     IX,DE
        LD      DE,1024;ADVANCE POINTER TO NEXT BUFFER
        ADD     HL,DE
        DJNZ    READ1;UNTIL WE GET TO THE ONE WE WANT

        LD      (BUF_START),HL;SAVE ADDRESS OF MY BUFFER
        ADD     HL,DE;POINT HL PAST END OF MY BUFFER
        LD      (BUF_END),HL;SAVE IT TOO

;*** CHECK FOR MODE ***
        PUSH    IX
        POP     HL

        CALL    MODE_CHECK;SEE IF THE MODE IS OK
        JP      NZ,READ_ERR1;BRANCH IF NOT

READ3:
        BIT     MODE_LAST_BLOCK_BIT,(IX+FCB_MODE);LOOK AT LAST BLOCK BIT
        JP      NZ,READ_LAST;BRANCH IF THIS IS THE LAST FILE BLOCK

        LD      HL,(BUF_END);GET END ADDRESS OF BUFFER
        LD      E,(IX+FCB_POINTER);GET POINTER INTO BUFFER
        LD      D,(IX+FCB_POINTER+1)
        OR      A
        SBC     HL,DE;CALC. BYTES LEFT IN BUFFER
        JR      Z,_O_BYTES_LEFT2

        LD      B,H;SAVE BYTES LEFT IN CASE WE NEED IT
        LD      C,L

        LD      DE,(BYTES_TO_GO);GET BYTES LEFT TO SEND
        OR      A
        SBC     HL,DE;COMPARE TO WHAT WE HAVE
        JP      NC,ENOUGH;BRANCH IF WE HAVE ENOUGH DATA HERE

; IF WE FALL THROUGH HERE, WE KNOW WE WILL HAVE TO GET ANOTHER
; BLOCK AFTER THIS ONE.  FIRST, LET'S TRANSFER WHAT WE HAVE.

        LD      HL,(BYTES_TO_GO);UPDATE NUMBER OF BYTES TO GO
        OR      A
        SBC     HL,BC;SUBTRACT NUM OF BYTES WE ARE SENDING HERE
        LD      (BYTES_TO_GO),HL

        LD      L,(IX+FCB_POINTER);POINT INTO MY BUFFER
        LD      H,(IX+FCB_POINTER+1)
        LD      DE,(USER_BUF);POINT INTO THE CALLER'S BUFFER
;BC HAS COUNT FROM ABOVE
        LDIR;GIVE WHAT WE HAVE

        LD      (USER_BUF),DE;POINT TO NEXT SPOT

_O_BYTES_LEFT2:
        LD      HL,(BUF_START);RESET THE POINTER
        LD      (IX+FCB_POINTER),L
        LD      (IX+FCB_POINTER+1),H

        INC     (IX+FCB_BLOCK);INC THE BLOCK NUMBER
        JR      NZ,READ4;BRANCH IF NO CARRY OUT
        INC     (IX+FCB_BLOCK+1)
        JR      NZ,READ4
        INC     (IX+FCB_BLOCK+2)
        JR      NZ,READ4
        INC     (IX+FCB_BLOCK+3)

READ4:

        LD      A,(IX+FCB_DEVICE);DEVICE ID
        LD      HL,(BUF_START); GET ADDRESS OF USERS BUFFER
        LD      E,(IX+FCB_BLOCK); GET BLOCK NUMBER
        LD      D,(IX+FCB_BLOCK+1)
        LD      C,(IX+FCB_BLOCK+2)
        LD      B,(IX+FCB_BLOCK+3)

        CALL    READ_BLOCK; READ THE NEXT BLOCK

        JP      NZ,READ_ERR1; BRANCH IF ERROR

NOT_TAPE1:
        LD      A,(IX+FCB_LAST_BLOCK+3); SEE IF THIS IS THE LAST BLOCK
        CP      (IX+FCB_BLOCK+3)
        JR      NZ,JP_TO_READ3; BRANCH IF NOT
        LD      A,(IX+FCB_LAST_BLOCK+2)
        CP      (IX+FCB_BLOCK+2)
        JR      NZ,JP_TO_READ3
        LD      A,(IX+FCB_LAST_BLOCK+1)
        CP      (IX+FCB_BLOCK+1)
        JR      NZ,JP_TO_READ3
        LD      A,(IX+FCB_LAST_BLOCK)
        CP      (IX+FCB_BLOCK)
        JR      NZ,JP_TO_READ3
        SET     MODE_LAST_BLOCK_BIT,(IX+FCB_MODE); ELSE SET THE LAST BLOCK BIT
JP_TO_READ3:
        JP      READ3; AND DEAL WITH THE NEXT BLOCK

; ARRIVE HERE IF THIS BLOCK CONTAINS ENOUGH BYTES TO SATISFY
; THIS CALL.

ENOUGH:
        LD      A,(IX+FCB_LAST_BLOCK+3); SEE IF THIS IS THE LAST BLOCK
        CP      (IX+FCB_BLOCK+3)
        JR      NZ,READ_LAST1; BRANCH IF NOT
        LD      A,(IX+FCB_LAST_BLOCK+2)
        CP      (IX+FCB_BLOCK+2)
        JR      NZ,READ_LAST1
        LD      A,(IX+FCB_LAST_BLOCK+1)
        CP      (IX+FCB_BLOCK+1)
        JR      NZ,READ_LAST1
        LD      A,(IX+FCB_LAST_BLOCK)
        CP      (IX+FCB_BLOCK)
        JR      Z,LAST_BLOCK

READ_LAST1:
        LD      BC,(BYTES_TO_GO); GET BYTE COUNT TO MOVE


        LD      L,(IX+FCB_POINTER); POINT INTO MY BUFFER
        LD      H,(IX+FCB_POINTER+1)
        LD      DE,(USER_BUF); POINT TO THE USER'S BUFFER
        LDIR; MOVE THE DATA

        LD      (IX+FCB_POINTER),L; UPDATE MY POINTER
        LD      (IX+FCB_POINTER+1),H


        POP     IX; RESTORE REGISTERS
        POP     HL
        POP     DE
        POP     BC
        XOR     A; SHOW NO ERROR
        RET

; ARRIVE HERE IF THIS IS THE LAST BLOCK OF THE FILE.
LAST_BLOCK:
        SET     MODE_LAST_BLOCK_BIT,(IX+FCB_MODE)

READ_LAST:
        LD      HL,(BUF_START); POINT TO MY BUFFER
        LD      E,(IX+FCB_LAST_COUNT); GET # BYTES IN IT
        LD      D,(IX+FCB_LAST_COUNT+1)
        ADD     HL,DE; CALC ADDR OF LAST BYTE + 1
        LD      E,(IX+FCB_POINTER); GET CURRENT POINTER
        LD      D,(IX+FCB_POINTER+1)
        OR      A; CLEAR CARRY
        SBC     HL,DE; CALC # BYTES LEFT IN BUFFER
        LD      B,H; SAVE IT IN CASE IT'S NEEDED
        LD      C,L
        JR      Z,_0_BYTES_LEFT

        LD      DE,(BYTES_TO_GO); GET REQUESTED COUNT
        OR      A; CLEAR CARRY (UGLY Z80)
        SBC     HL,DE; SEE IF WE HAVE ENOUGH BYTES
        JR      NC,READ_LAST1; BRANCH IF SO -- NO SWEAT

        LD      HL,(BYTES_TO_GO); UPDATE NUMBER OF BYTES TO GO
        OR      A
        SBC     HL,BC; SUBTRACT NUM OF BYTES WE ARE SENDING HERE
        LD      (BYTES_TO_GO),HL

        LD      L,(IX+FCB_POINTER); GET POINTER TO MY BUFFER
        LD      H,(IX+FCB_POINTER+1)
        LD      DE,(USER_BUF); GET POINTER TO USER'S BUFFER
; BC HAS COUNT FROM ABOVE
        LDIR; MOVE WHAT WE HAVE TO USER

        LD      HL,(BYTES_REQ); GET # BYTES REQUESTED
        LD      BC,(BYTES_TO_GO); GET # BYTES WE DIDN'T DO
        OR      A
        SBC     HL,BC; CALC. # OF BYTES WE DID DO
        LD      B,H; PUT IT INTO BC
        LD      C,L

_0_BYTES_LEFT:
        LD      A,EOF_ERR; SHOW AN ERROR
R_GET_OUT:
        POP     IX; RESTORE REGISTERS
        POP     HL
        POP     DE
        INC     SP; DISCARD OLD BC
        INC     SP

        OR      A
        RET

RQ_STAT_ERR:
        POP     IX
        POP     HL
        POP     DE
        POP     BC

        LD      A,RQ_TP_STAT_ERR
        OR      A
        RET

READ_ERR2:
        LD      A,BAD_FNUM_ERR

READ_ERR1:
        LD      HL,(BYTES_REQ); GET # BYTES REQUESTED
        LD      BC,(BYTES_TO_GO); GET # BYTES WE DIDN'T DO
        OR      A
        SBC     HL,BC; CALC. # OF BYTES WE DID DO
        LD      B,H; PUT IT INTO BC
        LD      C,L

        JR      R_GET_OUT

;       POP     IX                         ; RESTORE REGISTERS
;       POP     HL
;       POP     DE
;       INC     SP                         ; DISCARD OLD BC
;       INC     SP
;       OR      A                          ; SET CONDITION CODES
;       RET

;READ_ERR2
;       LD      HL,(BYTES_REQ)             ; GET # BYTES REQUESTED
;       LD      BC,(BYTES_TO_GO)           ; GET # BYTES WE DIDN'T DO
;       OR      A
;       SBC     HL,BC                      ; CALC. # OF BYTES WE DID DO
;       LD      B,H                        ; PUT IT INTO BC
;       LD      C,L
;
;       POP     IX                         ; RESTORE REGISTERS
;       POP     HL
;       POP     DE
;       INC     SP                         ; DISCARD OLD BC
;       INC     SP
;       LD      A,BAD_FNUM_ERR             ; SET THE ERROR CODE
;       OR      A                          ; SET CONDITIONS
;       RET

;-----------------------------------------------------------------------
;
; __WRITE_FILE -- write some bytes to a file.
;
; ENTRY PARAMETERS: file number in A; byte count in BC; pointer
;                   to data in HL.
;
; EXIT PARAMETERS: no errors -- Z = 1; A = 0
;                  if errors -- Z = 0; A = error code
;
;-----------------------------------------------------------------------

__WRITE_FILE:
        PUSH    BC; SAVE REGISTERS
        PUSH    DE
        PUSH    HL
        PUSH    IX

        LD      (USER_BUF),HL; SAVE USER'S BUFFER ADDRESS
        LD      (BYTES_REQ),BC; SAVE REQUESTED COUNT
        LD      (FNUM),A; SAVE FILE NUMBER
        LD      (BYTES_TO_GO),BC; INIT COUNTER (COUNTS DOWN)

        OR      A; CHECK FILE NUMBER
        JP      Z,WRITE_ERR2; BRANCH IF ZERO
        CP      NUM_FCBS; CHECK FOR MAX RANGE
        JP      NC,WRITE_ERR2; BRANCH IF TOO LARGE

        LD      B,A; PUT IT INTO B
        LD      IX,(FCB_HEAD_ADDR); GET ADDRESS OF 0TH FCB
        LD      DE,FCB_LENGTH; SET OFFSET
WRITE1:
        ADD     IX,DE; ADVANCE POINTER TO NEXT FCB
        DJNZ    WRITE1; UNTIL WE GET TO THE ONE WE WANT

        LD      B,A; POINT HL AT MY BUFFER
        LD      DE,1024
        LD      HL,(FCB_DATA_ADDR)
WRITE2:
        ADD     HL,DE
        DJNZ    WRITE2

        LD      (BUF_START),HL; SAVE ADDRESS OF MY BUFFER
        ADD     HL,DE; POINT HL PAST END OF MY BUFFER
        LD      (BUF_END),HL; SAVE IT TOO

; *** CHECK FOR MODE ***
        PUSH    IX
        POP     HL

        CALL    MODE_CHECK
        JP      NZ,WRITE_ERR1; JUMP IF WRONG MODE

WRITE3:
        LD      A,(IX+FCB_USED_LENGTH+1)
        CP      (IX+FCB_MAX_LENGTH+1)
        JR      C,SET_UP
        LD      A,(IX+FCB_USED_LENGTH+0)
        CP      (IX+FCB_MAX_LENGTH)
        JR      C,SET_UP

        SET     MODE_LAST_BLOCK_BIT,(IX+FCB_MODE)
SET_UP:
        LD      HL,(BUF_END); GET LAST ADDR + 1 OF BUFFER
        LD      E,(IX+FCB_POINTER); GET CURRENT POINTER
        LD      D,(IX+FCB_POINTER+1)
        OR      A; CLEAR CARRY
        SBC     HL,DE; CALC. ROOM LEFT IN BUFFER
        LD      B,H; SAVE IT IN CASE WE NEED IT
        LD      C,L
        LD      DE,(BYTES_TO_GO); GET BYTES LEFT TO TRANSFER
        OR      A
        SBC     HL,DE; SEE IF WE HAVE ROOM FOR IT ALL
        JP      NC,ROOM_OK; BRANCH IF YES

; WE FALL THROUGH HERE IF THE NUMBER OF BYTES TO BE WRITTEN
; IS MORE THAN THE SPACE WE HAVE IN THE CURRENT BLOCK.
; FILL THE BLOCK. WRITE IT OUT. THEN DECIDE WHAT TO DO.

        LD      A,B; CHECK IF ANY BYTES AVAILABLE
        OR      C
        JR      Z,CHECK_LAST_BLOCK; NOPE. EMPTY BUFFER FIRST

        LD      HL,(BYTES_TO_GO); GET THE COUNT
        OR      A
        SBC     HL,BC; SUB THE ROOM IN BUFFER TO UPDATE IT
        LD      (BYTES_TO_GO),HL

        LD      E,(IX+FCB_POINTER); GET POINTER INTO BUFFER
        LD      D,(IX+FCB_POINTER+1)
        LD      HL,(USER_BUF); GET POINTER TO USER DATA
; BC STILL HAS COUNT FROM ABOVE
        LDIR; MOVE DATA INTO THE BUFFER

        LD      (USER_BUF),HL; SAVE WHERE WE LEFT OFF


        SET     MODE_DIRTY_BIT,(IX+FCB_MODE); SET THE DIRTY BIT

CHECK_LAST_BLOCK:
        BIT     MODE_LAST_BLOCK_BIT,(IX+FCB_MODE); CHECK FOR LAST BLOCK
        JR      Z,MORE_FILE; JUMP IF THIS ISN'T LAST BLOCK

; IF THIS IS THE LAST BLOCK (AND IT'S NOW FULL) THERE'S NOTHING
; MORE WE CAN DO.  WE LEAVE THE DATA IN PLACE (IT WILL GET
; FLUSHED WHEN THE FILE IS CLOSED) AND REPORT AN EOF ERROR,
; MEANING THAT WE COULDN'T WRITE ALL THE DATA.

        POP     IX; RESTORE REGISTERS
        POP     HL
        POP     DE
        POP     BC
        LD      A,EOF_ERR; SHOW THE ERROR
        OR      A; SET CONDITIONS
        RET

; WE COME HERE IF WE HAVE A FULL BUFFER AND THERE'S MORE
; DATA TO WRITE AND THERE ARE MORE BLOCKS TO THE FILE.

MORE_FILE:
        INC     (IX+FCB_USED_LENGTH); INCREMENT SECTORS WRITTEN TO
        JR      NZ,MORE_FILE1
        INC     (IX+FCB_USED_LENGTH+1)
MORE_FILE1:
        LD      A,(IX+FCB_DEVICE); GET THE DEVICE NUMBER
        LD      HL,(BUF_START); GET BUFFER ADDRESS
        LD      E,(IX+FCB_BLOCK); GET BLOCK NUMBER
        LD      D,(IX+FCB_BLOCK+1)
        LD      C,(IX+FCB_BLOCK+2)
        LD      B,(IX+FCB_BLOCK+3)
        CALL    WRITE_BLOCK; WRITE OUT THE FULL BLOCK

        JP      NZ,WRITE_ERR1; BRANCH IF ERROR

CLEAR_DIRTY_BIT:
        RES     MODE_DIRTY_BIT,(IX+FCB_MODE); CLEAR THE DIRTY BIT
        LD      HL,(BUF_START); RESET THE BUFFER POINTER
        LD      (IX+FCB_POINTER),L
        LD      (IX+FCB_POINTER+1),H

        LD      (IX+FCB_LAST_COUNT),0
        LD      (IX+FCB_LAST_COUNT+1),0

        INC     (IX+FCB_BLOCK); INC THE BLOCK NUMBER
        JR      NZ,WRITE4; BRANCH IF NO CARRY OUT
        INC     (IX+FCB_BLOCK+1)
        JR      NZ,WRITE4
        INC     (IX+FCB_BLOCK+2)
        JR      NZ,WRITE4
        INC     (IX+FCB_BLOCK+3)

WRITE4:
        LD      A,(IX+FCB_MODE); LOOK AT THE MODE BYTE
        AND     MODE_MODE; GET RID OF EXTRA BITS
        CP      MODE_UPDATE; DO WE HAVE TO PRE-READ THE NEXT BLOCK?
        JP      NZ,WRITE3; LOOP TO TOP IF NOT

WRITE_AGAIN:
        LD      A,(IX+FCB_DEVICE); GET THE DEVICE NUMBER
        LD      HL,(BUF_START); GET BUFFER ADDRESS
        LD      E,(IX+FCB_BLOCK); GET BLOCK NUMBER
        LD      D,(IX+FCB_BLOCK+1)
        LD      C,(IX+FCB_BLOCK+2)
        LD      B,(IX+FCB_BLOCK+3)
        CALL    READ_BLOCK; PRE-READ THE NEXT FILE BLOCK

        JR      NZ,WRITE_ERR1; BRANCH IF ERROR


; ARRIVE HERE IF THE DATA BEING WRITTEN WILL NOT FILL THE BUFFER.
; EVERYTHING IS VERY EASY -- JUST COPY IT FROM USER'S ADDRESS
; INTO THE BUFFER AND GO AWAY.

ROOM_OK:
        LD      BC,(BYTES_TO_GO); GET THE BYTE COUNT
        LD      L,(IX+FCB_LAST_COUNT)
        LD      H,(IX+FCB_LAST_COUNT+1)
        ADD     HL,BC
        LD      (IX+FCB_LAST_COUNT),L
        LD      (IX+FCB_LAST_COUNT+1),H
        LD      E,(IX+FCB_POINTER); GET POINTER INTO BUFFER
        LD      D,(IX+FCB_POINTER+1)
        LD      HL,(USER_BUF); GET POINTER TO USER'S DATA
        LDIR; MOVE THE DATA

        LD      (IX+FCB_POINTER),E; UPDATE THE POINTER
        LD      (IX+FCB_POINTER+1),D
        SET     MODE_DIRTY_BIT,(IX+FCB_MODE); SET THE DIRTY BIT

ROOM1_OK:
        XOR     A
        JR      PAST_WRITE_ERR
WRITE_ERR2:
        LD      A,BAD_FNUM_ERR
WRITE_ERR1:
        OR      A
PAST_WRITE_ERR:
        POP     IX; RESTORE REGISTERS
        POP     HL
        POP     DE
        POP     BC
        RET
;WRITE_ERR1
;       POP     IX                         ; RESTORE REGISTERS
;       POP     HL
;       POP     DE
;       POP     BC
;       OR      A                          ; SET CONDITIONS
;       RET
;WRITE_ERR2
;       POP     IX                         ; RESTORE REGISTERS
;       POP     HL
;       POP     DE
;       POP     BC
;       LD      A,BAD_FNUM_ERR             ; SHOW AN ERROR
;       OR      A                          ; SET CONDITIONS
;       RET

;=======================================================================
;=======================================================================
;=======================================================================
;


;GLB    __SET_DATE,__GET_DATE
;EXT    EOS_YEAR,EOS_MONTH,EOS_DAY


;-----------------------------------------------------------------------
;
; __SET_DATE -- Set the current date.
;
; ENTRY PARAMETERS: B = day (1..31)
;                   C = month (1..12)
;                   D = year (83..99)
;
; EXIT PARAMETERS: none
;
;-----------------------------------------------------------------------

__SET_DATE:
        PUSH    AF; SAVE THE CURRENT A

        LD      A,B; STORE THE DAY
        LD      (EOS_DAY),A
        LD      A,C; STORE THE MONTH
        LD      (EOS_MONTH),A
        LD      A,D; STORE THE YEAR
        LD      (EOS_YEAR),A

        POP     AF; RESTORE A
        RET

;-----------------------------------------------------------------------
;
; __GET_DATE -- Reads the current date.
;
; ENTRY PARAMETERS: none
;
; EXIT PARAMETERS: no errors -- Z = 1; A = 0
;                  B = day
;                  C = month
;                  D = year
;
;                  error (date never set) -- Z = 0; A = error code
;                  B = 0
;                  C = 0
;                  D = 0
;
;-----------------------------------------------------------------------

__GET_DATE:
        LD      A,(EOS_DAY)
        LD      B,A; GET THE DAY
        LD      A,(EOS_MONTH)
        LD      C,A; GET THE MONTH
        LD      A,(EOS_YEAR)
        LD      D,A; GET THE YEAR

        OR      B
        OR      C; CHECK FOR ALL = 0
        JR      Z,GET_ERROR; BRANCH IF ERROR
        XOR     A; SHOW NO ERROR
        RET

GET_ERROR:
        LD      A,NO_DATE_ERR; SHOW AN ERROR OCCURRED
        OR      A; CLEAR Z FLAG
        RET
;
;=======================================================================
;=======================================================================
;=======================================================================
;


;
; Rev. 1   07oct515p  RPD  made __DELETE_FILE check for protected file
;

;GLB    __FMGR_INIT,SCAN_FOR_FILE,STRCMP,MODE_CHECK
;GLB    READ_BLOCK,WRITE_BLOCK,BASECMP,__WRITE_BLOCK
;GLB    __MODE_CHECK,__READ_BLOCK,SCAN_FOR_FILE
;EXT    __RD_1_BLOCK,__WR_1_BLOCK,__REQUEST_STATUS
;EXT    __QUERY_FILE,__SET_FILE
;EXT    QUERY_BUFFER,FILENAME_CMPS
;EXT    FCB_HEAD_ADDR,FCB_DATA_ADDR
;EXT    USER_NAME,BUF_START
;EXT    RETRY_COUNT
;EXT    FILE_COUNT,MOD_FILE_COUNT


;-----------------------------------------------------------------------
;
; __FMGR_INIT: sets up everything to start with.
;
; ENTRY PARAMETERS: DE contains address to place FCB buffers.
;                   and HL contains address to place FCB headers.
;
; EXIT PARAMETERS: none.
;
;-----------------------------------------------------------------------

__FMGR_INIT:
        LD      (FCB_DATA_ADDR),DE; SAVE BUFFER ADDRESS
        LD      (FCB_HEAD_ADDR),HL; SAVE HEADER ADDRESS

        PUSH    BC; SAVE REGISTERS
        PUSH    DE
        PUSH    IX

        LD      B,NUM_FCBS; SET TO # FCBS
        LD      DE,FCB_LENGTH; SET FOR ADDITION
        LD      IX,(FCB_HEAD_ADDR); GET ADDR OF 0TH FCB

INIT_LOOP:
        LD      (IX+FCB_MODE),MODE_UNUSED; SHOW THE FCB IS EMPTY
        ADD     IX,DE; ADVANCE POINTER TO NEXT FCB
        DJNZ    INIT_LOOP; LOOP FOR ALL FCBS

        POP     IX; RESTORE REGISTERS
        POP     DE
        POP     BC
        RET

;-----------------------------------------------------------------------
;
; SCAN_FOR_FILE -- Look in the directory for a file name.
;                  Reads each block of the directory into a buffer
;                  (in the system's FCB) and scans through for a
;                  match with the caller's string.
;
; ENTRY PARAMETERS: address of name string in HL; device # in A
;                   ASSUMES FILENAME_CMP SET UP FOR FILE COMPARES
;                   0 - USE STRCMP .  NOT 0 - USE BASECMP  FOR FILE NAME COMPARISONS
;
; EXIT PARAMETERS: if match found -- Z = 1; A = 0; file's start
;                  block in BCDE; directory block left in buffer.
;                  address of entry left in FCB_POINTER.
;
;                  if no match found -- Z = 0; A = error code;
;                  BCDE = junk; other stuff = junk.
;
;-----------------------------------------------------------------------

__SCAN_FOR_FILE:
SCAN_FOR_FILE:
        PUSH    HL; SAVE REGISTERS
        PUSH    IX
        PUSH    IY

        LD      (USER_NAME),HL; SAVE USER'S STRING ADDRESS

        LD      IX,(FCB_HEAD_ADDR); GET ADDRESS OF SYSTEM'S FCB

; First, set up as much of the FCB as we can.
        LD      (IX+FCB_DEVICE),A; SET THE DEVICE ADDRESS PASSED TO US

        LD      (IX+FCB_BLOCK),1; SET BLOCK TO 1
        LD      (IX+FCB_BLOCK+1),0
        LD      (IX+FCB_BLOCK+2),0
        LD      (IX+FCB_BLOCK+3),0

        LD      DE,(FCB_DATA_ADDR); SET BUFFER ADDRESS
        LD      (IX+FCB_POINTER),E
        LD      (IX+FCB_POINTER+1),D

RD_TIMEOUT:
        LD      HL,FILE_COUNT
        LD      (HL),0

        LD      A,(IX+FCB_DEVICE); GET THE DEVICE NUMBER
        LD      HL,(FCB_DATA_ADDR); GET BUFFER ADDRESS
        LD      E,(IX+FCB_BLOCK); GET BLOCK NUMBER
        LD      D,(IX+FCB_BLOCK+1)
        LD      C,(IX+FCB_BLOCK+2)
        LD      B,(IX+FCB_BLOCK+3)
        CALL    READ_BLOCK; READ FIRST BLOCK OF DIRECTORY
        JP      NZ,SCAN_ERROR; BRANCH IF ERROR

GET_BUFF_ADDR:

        PUSH    HL; GET BUFFER ADDRESS INTO IY TOO
        POP     IY

        LD      A,(IY+VOL_DIRSIZE); GET THE DIRECTORY SIZE
        AND     07FH; ZERO PERM BIT
;       INC     A                           ; ADD 1 'CAUSE WE START IN BLOCK 1
;       DEC     A                           ; SUB 1 'CAUSE OF PICKET FENCE PROBLEM
        LD      (IX+FCB_LAST_BLOCK),A; SET LAST BLOCK IN FCB
        LD      (IX+FCB_LAST_BLOCK+1),0; (ALL MSBYTES WILL BE 0)
        LD      (IX+FCB_LAST_BLOCK+2),0
        LD      (IX+FCB_LAST_BLOCK+3),0

        CALL    CHECK_IF_DIRECTORY; CHECK IF DIRECTORY EXIST
        JP      NZ,SCAN_ERROR

        LD      A,(IX+FCB_POINTER); ADVANCE POINTER TO NEXT ENTRY
        ADD     A,DIR_ENT_LENGTH
        LD      (IX+FCB_POINTER),A
        LD      A,(IX+FCB_POINTER+1)
        ADC     A,0
        LD      (IX+FCB_POINTER+1),A

        LD      HL,FILE_COUNT
        INC     (HL)

        LD      B,ENT_PER_BLOCK-1; SET DIR ENTRY COUNT FOR FIRST BLOCK
        JR      SCAN2; JUMP INTO THE LOOP

SCAN1:
        INC     (IX+FCB_BLOCK); INC THE BLOCK NUMBER
; WE CAN ASSUME THERE'S NO CARRY OUT

; SEE IF THERE IS MORE DIRECTORY: I.E. IS FCB_BLOCK > FCB_LAST_BLOCK?
; IF TRUE. GO TO NO_ENT.

        LD      A,(IX+FCB_LAST_BLOCK+3)
        CP      (IX+FCB_BLOCK+3)
        JP      C,NO_ENT; BRANCH IF NO MORE DIRECTORY
        LD      A,(IX+FCB_LAST_BLOCK+2)
        CP      (IX+FCB_BLOCK+2)
        JP      C,NO_ENT; BRANCH IF NO MORE DIRECTORY
        LD      A,(IX+FCB_LAST_BLOCK+1)
        CP      (IX+FCB_BLOCK+1)
        JP      C,NO_ENT; BRANCH IF NO MORE DIRECTORY
        LD      A,(IX+FCB_LAST_BLOCK)
        CP      (IX+FCB_BLOCK)
        JP      C,NO_ENT; BRANCH IF NO MORE DIRECTORY

RD_TIMEOUT1:
        LD      A,(IX+FCB_DEVICE); GET THE DEVICE NUMBER
        LD      HL,(FCB_DATA_ADDR); GET BUFFER ADDRESS
        LD      E,(IX+FCB_BLOCK); GET BLOCK NUMBER
        LD      D,(IX+FCB_BLOCK+1)
        LD      C,(IX+FCB_BLOCK+2)
        LD      B,(IX+FCB_BLOCK+3)
        CALL    READ_BLOCK; READ THE NEXT BLOCK
        JP      NZ,SCAN_ERROR; BRANCH IF ERROR

GET_BUFF_ADDR1:


        LD      DE,(FCB_DATA_ADDR); GET BUFFER ADDRESS
        LD      (IX+FCB_POINTER),E; PUT IT INTO THE FCB
        LD      (IX+FCB_POINTER+1),D

        LD      B,ENT_PER_BLOCK; SET ENTRY COUNT

SCAN2:
        LD      HL,FILE_COUNT
        INC     (HL)

        LD      E,(IX+FCB_POINTER); GET POINTER INTO DE
        LD      D,(IX+FCB_POINTER+1)

        LD      L,DIR_ATTR; OFFSET (FOR ATTR) INTO DIR ENTRY
        LD      H,0; NOT USED
        ADD     HL,DE; SET UP HL TO POINT TO IT
        BIT     ATTR_HOLE_BIT,(HL); IS IT THE HOLE?
        JR      NZ,NO_ENT; YUP. DON'T BOTHER SEARCHING ANY MORE
        BIT     ATTR_DEL_BIT,(HL); IS THIS FILE DELETED?
        JR      NZ,FILE_DELETED; YUP. DON'T EVEN BOTHER CHECK FILE NAMES

        LD      HL,(USER_NAME)

        LD      A,(FILENAME_CMPS)
        OR      A; IS IT ZERO?
        JR      Z,FULL_FILENAME; YUP. COMPARE THE FULL FILE NAME
        CALL    BASECMP; NOPE. COMPARE JUST THE BASE
        JR      ERROR_CHECK
FULL_FILENAME:
        CALL    STRCMP; COMPARE THE FULL FILE NAME (BASE PLUS EXTENSION)
ERROR_CHECK:
        JR      Z,SCAN3; BRANCH IF YES

FILE_DELETED:
        LD      A,(IX+FCB_POINTER); ADVANCE POINTER TO NEXT ENTRY
        ADD     A,DIR_ENT_LENGTH
        LD      (IX+FCB_POINTER),A
        LD      A,(IX+FCB_POINTER+1)
        ADC     A,0
        LD      (IX+FCB_POINTER+1),A

        DJNZ    SCAN2; LOOP IF MORE ENTRIES TO CHECK IN THIS BLOCK

        JP      SCAN1; ELSE GET NEXT BLOCK

SCAN3:
        PUSH    DE; GET DIR ENTRY PTR INTO IY
        POP     IY

        LD      E,(IY+DIR_START_BLOCK+0)
        LD      D,(IY+DIR_START_BLOCK+1)
        LD      C,(IY+DIR_START_BLOCK+2)
        LD      B,(IY+DIR_START_BLOCK+3)

        POP     IY; RESTORE REGISTERS
        POP     IX
        POP     HL
        XOR     A; SHOW NO ERROR
        RET

SCAN_ERROR:
        POP     IY; RESTORE REGISTERS
        POP     IX
        POP     HL
        RET

NO_ENT:
        POP     IY; RESTORE REGISTERS
        POP     IX
        POP     HL
        LD      A,NO_FILE_ERR
        OR      A
        RET




;***************************************************************
;***************************************************************
;
;     CHECK_IF_DIRECTORY VERIFIES THE EXISTENCE OF A DIRECTORY
;             ON THE MEDIA IN THE DEVICE
;
;     INPUT:   IY  -  POINTS TO THE VOLUME ENTRY (FIRST ENTRY INTO THE DIRECTORY)
;
;     OUTPUT:  CONDITION FLAGS
;             Z  - DIRECTORY EXISTS
;             NZ - NO DIRECTORY
;                  A = ERROR CODE
;
;
;             ALL REGISTERS PRESERVED EXCEPT AF
;
;***************************************************************
;***************************************************************

;GLB    CHECK_IF_DIRECTORY
;EXT    DIRECTORY_CHECK

CHECK_IF_DIRECTORY:
        PUSH    IY
        PUSH    BC
        PUSH    HL

        LD      HL,DIRECTORY_CHECK; 4 UNIQUE BYTES PLACE IN VOLUME ENTRY
; AT CREATION TIME (BYTES DEFINED IN EOS_MKDIR)

        LD      B,4; COMPARE 4 BYTES
NEXT_CHECK:
        LD      A,(HL); GET THE FIRST UNIQUE BYTE
        CP      (IY+VOL_DIR_CHECK); SAME AS ON TAPE?
        JR      NZ,NOT_DIR; NOPE

        INC     HL; YUP, CHECK NEXT BYTE
        INC     IY
        DJNZ    NEXT_CHECK

        XOR     A; DIRECTORY EXISTS

GET_OUT_HERE:
        POP     HL
        POP     BC
        POP     IY

        RET

NOT_DIR:
        LD      A,NO_DIR_ERR
        JR      GET_OUT_HERE

;---------------------------------------------------------------
;
; STRCMP -- compare two strings (file names).
;
; ENTRY PARAMETERS: address of name string in HL; address of
;                   name within dir entry in DE. NOTE: string
;                   pointed to by HL must be terminated with ETX.
;                   Maximum of NAME_LENGTH characters are compared.
;
; EXIT PARAMETERS:  Z = 1; A = 0 if match or
;                   Z = 0; A = error code if no match.
;
;---------------------------------------------------------------

BASECMP: EQU     $+1; EXECUTES SCF (37H) - COMPARE ONLY THE BASE
; OF THE FILE NAME
STRCMP:; "AND" INSTRUCTION CLEARS CARRY - COMPARE BASE &
        AND     037H; EXTENSION
        PUSH    HL; PRESERVE REG'S
        PUSH    DE
        PUSH    BC
        PUSH    AF; SAVE CARRY FLAGGING EXECUTED ABOVE

        LD      B,NAME_LENGTH; INIT MAX COUNT
NEXT_CHAR:
        LD      A,(HL); GET CHAR FROM STRING
        CP      ETX; HAVE WE REACHED END OF STRING?
        JR      Z,EOS; BRANCH IF YES
        LD      A,(DE); GET CHAR FROM DIR ENTRY
        CP      (HL); COMPARE TO STRING
        JR      NZ,MATCHLESS; BRANCH IF DIFFERENT
        INC     HL; ELSE INC. POINTERS
        INC     DE
        DJNZ    NEXT_CHAR; LOOP IF MORE CHARS TO LOOK AT
        POP     BC; POP AF INTO BC
        JR      MATCH; ALL 12 MATCH IF WE GET HERE!
MATCHLESS:
        POP     AF; COMPARE BASE OR BASE&EXTENSION
        JR      NC,NO_MATCH; NEEDED TO COMPARE THE WHOLE FILE NAME
; ONLY COMPARE THE BASE
        INC     HL; POINT TO NEXT CHAR OF NAME STRING
        INC     DE; AND DIR ENTRY NAME
        LD      A,(HL)
        CP      ETX; IS IT ETX?
        JR      NZ,NO_MATCH; NOPE, DOES NOT MATCH
        JR      AROUND_POP

EOS:
        POP     BC; AF INTO BC TO PRESERVE AF
AROUND_POP:
        LD      A,(DE); LOOK AT CHAR IN DIR ENTRY
; DLS(8/29/83) CHANGED SPACE TO ETX.
        CP      ETX; END OF FILE NAME?
        JR      NZ,NO_MATCH; BRANCH IF NOT
MATCH:
        POP     BC; RESTORE REG'S
        POP     DE
        POP     HL
        XOR     A; SHOW THE MATCH
        RET
NO_MATCH:
        POP     BC; RESTORE REG'S
        POP     DE
        POP     HL
        LD      A,MATCH_ERR
        OR      A
        RET; RETURN WITH NZ CONDITION


;***************************************************************
;
;
; THIS ROUTINE CHECKS TO SEE IF THE FILENAME (POINTED TO BY HL)
; IS ALREADY OPEN AND EXIST IN THE FCB
;
;             INPUT:   HL        POINTER TO FILENAME (ETX TERMINATED)
;
;             OUTPUT:  CONDITION FLAGS
;                      NZ        NOT IN FCB (NOT OPENED)
;                                A = ERROR CODE
;                                HL = ORIGINAL POINTER TO FILENAME
;                      Z         IN FCB
;                                A = FILE NUMBER
;                                B = MODE
;                                HL = POINTER TO START OF FCB
;
;***************************************************************
;
; GET_OUT                  U_GET_OUT
; NEXT_FCB CHANGED TO U_NEXT_FCB TO PREVENT CONFLICT WITH
; IDENTICAL LABEL ELSEWHERE

;GLB    __CHECK_FCB
;EXT    FILE_NUMBR

__CHECK_FCB:
        PUSH    IX
        PUSH    DE
;       PUSH    BC
        PUSH    HL

        LD      HL,(FCB_HEAD_ADDR)
        XOR     A; ZERO OUT A
U_NEXT_FCB:
        INC     A; CONTAINS THE FILE NUMBER
        LD      (FILE_NUMBR),A; (THE POSITION ON THE TAPE)

        LD      DE,FCB_LENGTH; NUMBER OF BYTES IN EACH FCB
        ADD     HL,DE; POINT TO NEXT FCB ENTRY

        PUSH    HL
        POP     IX; IX POINTS TO START OF FCB

        LD      A,(IX+FCB_MODE); GET MODE
        AND     MODE_MODE
        CP      0; IT IS UNUSED?

        JR      Z,END_FCB; YUP, LOOK AT NEXT FCB
        EX      DE,HL; DE = POINTER TO FCB NAME STRING
        POP     HL
        PUSH    HL; HL = POINTER TO FILENAME TO SEARCH FOR


        PUSH    DE; DE = POINTER TO FCB FILE NAME

        LD      BC,NAME_LENGTH; NO. OF CHARACTERS IN NAME
; HL = FILE NAME STRING
NEXT_CHAR1:
        LD      A,(DE); DE = FCB FILE NAME
        CP      ETX; IS IT ETX?

        JR      Z,ITS_ETX1; YUP

        CPI; DO CHARS MATCH ((HL) = A)?

        INC     DE
        JR      Z,NEXT_CHAR1; YUP,CHECK NEXT CHAR OF FILE NAME

        POP     HL; pointer to FCB
END_FCB:
        LD      A,(FILE_NUMBR); ARE WE AT 2ND FILE(FCB)?
        CP      NUM_FCBS-1; NO. OF FCB'S - SYSTEM FCB

        JR      NZ,U_NEXT_FCB; NOPE, NOT YET,

NO_MATCH1:
        POP     HL; HL = ORIGINAL POINTER TO FILE NAME

        LD      A,NO_FILE_ERR; NO MATCH FOUND
        OR      A
        JR      GET_OUT_ERR

ITS_ETX1:
        LD      A,(HL); GET ASCII CHAR
        CP      ETX; IS IT ETX?
        POP     HL; *pointer to FCB
        JR      NZ,NO_MATCH1; NOPE

;       PUSH    HL                       ; copy pointer to FCB so can index to mode
;       POP     IX

        LD      A,(IX+FCB_MODE); GET MODE THIS FILE WAS ORIGINALLY
        AND     MODE_MODE; OPENED FOR AND MASK OFF FLAG BITS
        LD      B,A; PASS IT BACK IN B

        XOR     A; INDICATE Z CONDITION
        LD      A,(FILE_NUMBR); GET FILE NUMBER

U_GET_OUT:
        POP     DE; *Clear off pointer to name
;       POP     BC
GET_OUT_ERR:
        POP     DE
        POP     IX

        RET


;---------------------------------------------------------------
;
; MODE_CHECK: sees if an attribute byte matches a permission request.
;
; ENTRY PARAMETERS: IX- FCB POINTER
;                   HL- DIR ENTRY
; EXIT PARAMETERS:   Z=1=OK
;                    Z=0=NO WAY
;                    A=TRASH
;                    IX AND HL PRESERVED
; DLS(8/30/83)
;---------------------------------------------------------------

; OK CHANGED TO U_OK TO PREVENT CONFLICT WITH IDENTICAL
;LABEL ELSEWHERE

;MODE_CHECK:
__MODE_CHECK:; [RECON] OCR 5675-5676 prints two coincident labels; exported implementation label restored.
MODE_CHECK: ; [RECON] Preserved coincident historical local label from OCR 5675-5676.

        PUSH    IY; SAVE REG IY
        PUSH    HL; SAVE DIR ENTRY
        LD      A,(IX+FCB_MODE); GET THE MODE THE USER PASSED IN
;
; RANGE CHECK THIS REQUEST
;
        AND     MODE_MODE; AND OFF TEST BITS
        CP      0; MAKE SURE HE'S IN RANGE
        JR      Z,RANGE_NONO
        CP      MODE_MAX+1
        JR      NC,RANGE_NONO
;
        LD      HL,ATTRIB_TBL; INDEX INTO THE MASK TABLE
        ADD     A,L
        LD      L,A
        JR      NC,ADJUST
        INC     H
ADJUST:
        POP     IY; GET THE DIR ENTRY POINTER INTO IY
        PUSH    IY
        LD      A,(IY+DIR_ATTR); GRAB HIS ATTRIBUTE BYTE
        AND     (HL); COMPARE IT TO THE USER'S REQUEST
        JR      NZ,PROTECT_FAULT
U_OK:
        POP     HL
        POP     IY
        XOR     A; INDICATE ALL IS WELL
        RET
PROTECT_FAULT:
        LD      A,PRT_ERR
        JR      PROTECT
RANGE_NONO:
        LD      A,RANGE_ERR
PROTECT:
        POP     HL
        POP     IY
        OR      A; INDICATE ERROR
        RET
ATTRIB_TBL     EQU     $-1
        DEFB    ATTR_READ_PROT
        DEFB    ATTR_WRITE_PROT
        DEFB    ATTR_PERMANENT
        DEFB    ATTR_EXECUTE



;***************************************************************
;******************** EOS_RENAME_FILE ***************************
;
; ON ENTRY:   A  = DEVICE NUMBER (8=TAPE1)
;             DE = POINTER TO OLD FILENAME
;             HL = POINTER TO NEW FILENAME
;
; ON EXIT:    Z = 1, FILE RENAMED.  A = 0
;             Z = 0, FILE NOT RENAMED. A = ERROR CODE
;

;GLB    __RENAME_FILE

__RENAME_FILE:
        PUSH    BC
        PUSH    AF; AF = DEVICE ID
        PUSH    DE; DE = POINTER TO OLD FILENAME
        PUSH    HL; HL = POINTER TO NEW FILENAME
        EX      DE,HL; FIRST CHECK IF A FILE EXIST W/NEW FILE NAME
        LD      HL,QUERY_BUFFER
        CALL    __QUERY_FILE
        JR      Z,NOT_RENAMED; YUP, THE NEW FILE NAME ALREADY EXISTS
        POP     HL
        POP     DE
        POP     AF
        PUSH    AF
        PUSH    DE
        PUSH    HL

        LD      HL,QUERY_BUFFER
        CALL    __QUERY_FILE; NOW CHECK IF OLD FILE EXISTS
        JR      NZ,NOT_RENAMED; NOPE
        LD      DE,QUERY_BUFFER; DE = DESTINATION
        POP     HL; HL = PTR TO NEW FILENAME
        PUSH    HL
        LD      BC,12; NUMBER OF BYTES TO REPLACE
        LDIR
        POP     HL
        POP     DE; DE = POINTER TO OLD FILENAME
        POP     AF; A = DEVICE ID
        PUSH    AF
        PUSH    DE; RESTORE STACK
        PUSH    HL
        LD      HL,QUERY_BUFFER
        CALL    __SET_FILE; CHANGE FILENAME
        JR      NZ,NOT_RENAMED
        XOR     A; GOOD RETURN
        POP     HL
        POP     DE
        POP     BC; REALLY AF BUT NEED TO PRESERVE FLAGS FOR RET
        POP     BC
        RET
NOT_RENAMED:
;         LD      A,RENAME_ERR             ; ERROR RETURN ; [RECON] OCR 5778 is commented; production preserves the error already in A.
        OR      A
        POP     HL
        POP     DE
        POP     BC; REALLY AF BUT NEED TO PRESERVE ERR MSG.
        POP     BC
        RET


;
;***************************************************************
;******************** EOS_DELETE_FILE ***************************
;
; ON ENTRY:   A  = DEVICE NUMBER (8=TAPE1)
;             HL = POINTER TO FILENAME
;
; ON EXIT:    Z = 1, FILE DELETED. A = 0
;             Z = 0, FILE NOT DELETED. A = ERROR CODE
;

;GLB    __DELETE_FILE

__DELETE_FILE:
        PUSH    DE
        PUSH    HL; HL = POINTER TO FILENAME
        PUSH    AF; A = DEVICE ID
        EX      DE,HL; DE = POINTER TO FILENAME
        LD      HL,QUERY_BUFFER; HL = POINTER TO BUFFER
        CALL    __QUERY_FILE
        JR      NZ,OTHER_ERR
        LD      A,(QUERY_BUFFER+FCB_ATTR); GET ATTRIBUTE BYTE
        BIT     7,A; see if permanent protected
        JR      NZ,NOT_DELETED
        OR      ATTR_DELETED; SET "DELETED" BIT
        LD      (QUERY_BUFFER+FCB_ATTR),A
        POP     AF; DEVICE ID
        POP     DE; GET FILENAME POINTER
        PUSH    DE
        PUSH    AF
        CALL    __SET_FILE
        JR      NZ,OTHER_ERR
        XOR     A; GOOD RETURN
        POP     HL; REALLY AF BUT PRESERVE NEW AF
        POP     HL
        POP     DE
        RET
NOT_DELETED:
        LD      A,DELETE_ERR; ERROR RETURN
        OR      A
OTHER_ERR:
        POP     HL; REALLY AF BUT PRESERVE ERR CONDITION
        POP     HL
        POP     DE
        RET


;***************************************************************
;***************************************************************
;
;
;     READ_BLOCK:
;             1)  READS 1 BLOCK OFF OF SPECIFIED DEVICE
;             2)  REQUESTS FOR THE STATUS
;             3)  AND SENDS ANOTHER READ TO THE DEVICE
;
;     INPUT:  SAME AS FOR __RD_1_BLOCK
;             A       DEVICE ID
;                     LOW NIBBLE - DEVICE ADDRESS
;                     HI NIBBLE  - SECONDARY DEVICE ID
;
;             HL      DESTINATION IN RAM
;
;             REGISTER PAIR  BC DE
;                            SECTOR NUMBER ON DEVICE
;
;
;     OUTPUT: CONDITION FLAGS
;                     Z:  NO ERRORS
;                    NZ:  ERROR OCCURED
;                         A - ERROR CODE
;
;     ALL REGISTERS ARE PRESERVED EXCEPT FOR AF
;
;***************************************************************
;***************************************************************

__READ_BLOCK:
READ_BLOCK:
        PUSH    BC
        PUSH    DE
        PUSH    HL
        PUSH    IX
        PUSH    IY
        PUSH    AF

        LD      A,ERROR_RETRY; RETRY COUNT FOR ERRORS
        LD      (RETRY_COUNT),A
READ_LOOP:
        POP     AF; GET DEVICE ID BACK IN A
        PUSH    AF

        CALL    __RD_1_BLOCK

        JR      Z,NO_READ_ERRORS; READ WENT OK

        CP      TIMEOUT; WAS IT A TIMEOUT?

        JR      Z,NO_READ_ERRORS; YUP,

        PUSH    HL
        LD      HL,RETRY_COUNT
        DEC     (HL); DEC THE NO OF RETRY'S LEFT
        POP     HL
        JR      Z,READ_ERROR; NO RETRY'S LEFT
        JR      READ_LOOP; TRY AGAIN

NO_READ_ERRORS:
        LD      B,ERROR_RETRY; NUMBER OF TIMES TO RETRY

RETRY_FOR_ERRORS:
        POP     AF; RESTORE DEVICE ID
        PUSH    AF

        CALL    __REQUEST_STATUS; GET STATUS

        JR      Z,READ_COMMAND_COMPLETED; READ ALL DONE

        CP      TIMEOUT; WAS IT A TIMEOUT?
        JR      Z,RETRY_FOR_ERRORS; NOT A REAL ERROR, DON'T NEED TO DEC COUNTER ; [RECON] Identifier repair: branch targets printed label RETRY_FOR_ERRORS at OCR 5899.

        DJNZ    RETRY_FOR_ERRORS; IT'S A REAL ERROR, TRY AGAIN ; [RECON] Identifier repair: branch targets printed label RETRY_FOR_ERRORS at OCR 5899.

        JR      READ_ERROR; CAN'T GET STATUS, GET OUT

READ_COMMAND_COMPLETED:
        POP     AF; RESTORE DEVICE ID
        PUSH    AF

        CALL    GET_STATUS_FLAG; GET THE STATUS FOR THE PROPER
; DEVICE IN THE A REGISTER

        CP      0; ANY ERRORS WITH DRIVE?

        JR      NZ,READ_ERROR; YUP

        LD      A,ERROR_RETRY
        LD      (RETRY_COUNT),A

        POP     AF
        POP     IY
        POP     IX
        POP     HL
        POP     DE
        POP     BC
        PUSH    BC
_2ND_READ:
        PUSH    AF

        CALL    __RD_1_BLOCK; SEND ANOTHER READ COMMAND
        JR      Z,NO_ERRORS
        PUSH    HL
        LD      HL,RETRY_COUNT
        DEC     (HL); THE NO OF RETRY'S
        POP     HL
        JR      Z,RETRY_LIMIT_REACHED; NO RETRY'S LEFT ; [RECON] Uncertain listing/ROM discrepancy: bytes 28 03 target local cleanup at $F1D6.
        POP     AF

        JR      _2ND_READ; GO TRY AGAIN

RETRY_LIMIT_REACHED: ; [RECON] ROM branch at $F1D0 targets this cleanup at $F1D6; printed target is unresolved.
        OR      A; NZ CONDITION
NO_ERRORS:
        POP     BC
        POP     BC

        RET

READ_ERROR:
        POP     IY; POP AF INTO IY TO PRESERVE FLAGS
        POP     IY
        POP     IX
        POP     HL
        POP     DE
        POP     BC

        LD      A,DEVICE_DEPD_ERR; INDICATE ERROR, LET APPL. HANDLE IT

        RET



;***************************************************************
;***************************************************************
;
;
;     WRITE_BLOCK:
;             1)  WRITES A BLOCK OUT TO TAPE
;             2)  AND CHECKS STATUS AFTER WRITE IS COMPLETED
;
;     INPUT:  SAME AS FOR __WR_1_BLOCK
;
;             A       DEVICE ID
;                     LOW NIBBLE - DEVICE ADDRESS
;                     HI NIBBLE  - SECONDARY DEVICE ID
;
;             HL      SOURCE ADDRESS OF BUFFER
;
;             REGISTER PAIR  BC DE
;                            SECTOR NUMBER ON DEVICE
;
;
;     OUTPUT: CONDITION FLAGS
;                     Z:  NO ERRORS
;                    NZ:  ERRORS OCCURED
;                         A - ERROR CODE
;
;     ALL REGISTERS PRESERVED EXCEPT FOR AF
;
;***************************************************************
;***************************************************************



__WRITE_BLOCK:
WRITE_BLOCK:
        PUSH    BC
        PUSH    IY
        PUSH    AF

        LD      A,ERROR_RETRY
        LD      (RETRY_COUNT),A
TRY_WRITE_AGAIN:
        POP     AF
        PUSH    AF

        CALL    __WR_1_BLOCK

        JR      Z,NO_WRITE_ERRORS; NO ERRORS

        CP      TIMEOUT

        JR      Z,NO_WRITE_ERRORS; ERROR OCCURED IN TRANSMISSION

        PUSH    HL
        LD      HL,RETRY_COUNT
        DEC     (HL)
        POP     HL
        JR      Z,WRITE_ERROR

        JR      TRY_WRITE_AGAIN

NO_WRITE_ERRORS:

        LD      B,ERROR_RETRY; MAX NO OF RETRIES

RETRY_WRITE:
        POP     AF; RESTORE DEVICE ID
        PUSH    AF

        CALL    __REQUEST_STATUS

        JR      Z,WRITE_COMMAND_COMPLETE; STATUS BACK

        CP      TIMEOUT; CHECK FOR TIMEOUT

        JR      Z,RETRY_WRITE; TIMEOUT. NOT A 'REAL' ERROR

        DJNZ    RETRY_WRITE; REAL ERROR, TRY AGAIN

        JR      WRITE_ERROR; DONE RETRYING, IT'S AN ERROR

WRITE_COMMAND_COMPLETE:
        POP     AF; RESTORE DEVICE ID
        PUSH    AF

        CALL    GET_STATUS_FLAG; GET STATUS FOR SPECIFIED DEVICE

        CP      0; WRITE OK?
        JR      Z,WRITE_OK; YUP

WRITE_ERROR:
        LD      A,DEVICE_DEPD_ERR

WRITE_OK:
        POP     BC; REALLY AF, BUT PRESERVE CURRENT FLAGS
        POP     IY
        POP     BC


        RET



GET_STATUS_FLAG:

        SRL     A; GET SECONDARY DEVICE ID (HI NIBBLE)
        SRL     A
        SRL     A
        SRL     A

        CP      0; WAS IT UNIT 0?

        LD      A,(IY+D_STATUS_FLAGS); BY THE WAY, GET THE STATUS

        JR      NZ,UNIT1; NOPE, UNIT 1

        AND     0FH; MASK OUT STATUS OF UNIT 1

        JR      CHECK_STATUS

UNIT1:
        SRL     A
        SRL     A
        SRL     A
        SRL     A

CHECK_STATUS:; RETURN WITH THE STATUS NIBBLE IN A

        RET

;***************************************************************
;***************************************************************
;
;
;     TRIM_FILE RELEASES THE UNUSED BLOCKS IN THE SPECIFIED FILE
;
; NOTE:  IF FILE BEING TRIMMED IS THE LAST FILE, THE UNUSED BLOCKS ARE
;        ALLOCATED AS PART OF THE REMAINING AVAILABLE BLOCKS (RETURNED
;        TO THE HOLE).
;
;     INPUT:  A       DEVICE ID
;             DE      POINTER TO FILE NAME STRING
;
;     OUTPUT:
;             CONDITION FLAGS
;             Z:      NO ERRORS
;             NZ:     ERRORS
;                     A - ERROR CODE
;
;***************************************************************
;***************************************************************

;GLB    __TRIM_FILE

;EXT    FCB_BUFFER
;EXT    NEW_HOLE_SIZE
;EXT    HOLE_FILE_NAME

__TRIM_FILE:

        PUSH    HL
        PUSH    IX
        PUSH    IY
        PUSH    DE
        PUSH    AF

        LD      HL,FCB_BUFFER

        CALL    __QUERY_FILE; FIND FILE IN DIRECTORY

        JP      NZ,ERROR; HAD TROUBLE FINDING IT

        LD      IX,FCB_BUFFER; POINT TO THE BUFFER

        LD      E,(IX+FCB_USED_LENGTH)
        LD      D,(IX+FCB_USED_LENGTH+1); GET THE NO OF USED BLOCKS

        LD      L,(IX+FCB_MAX_LENGTH)
        LD      H,(IX+FCB_MAX_LENGTH+1); GET THE NO ALLOCATED

        OR      A
        SBC     HL,DE; FIND OUT HOW MANY EMPTY

        LD      A,H
        OR      L

        JP      Z,NO_TRIM; ALL USED

        LD      (NEW_HOLE_SIZE),HL; SAVE THE NUMBER OF EMPTY BLOCKS
        LD      (IX+FCB_MAX_LENGTH),E; ALLOCATED = USED,  NOW
        LD      (IX+FCB_MAX_LENGTH+1),D

        LD      A,(FILE_COUNT); FILE ENTRY POSITION IN DIRECTORY
        LD      B,ENT_PER_BLOCK
TRY_AGAIN:
        SUB     B; IS IT THE LAST ENTRY IN THIS BLOCK
        JR      Z,LAST_ENTRY; YUP
        JR      NC,TRY_AGAIN; NOPE, MUST BE IN NEXT BLOCK

NOT_LAST_ENTRY:
        LD      IX,(FCB_HEAD_ADDR); GET START OF FCB'S
        LD      E,(IX+FCB_POINTER); GET ADDRESS OF THE MODIFIED FCB
        LD      D,(IX+FCB_POINTER+1)
        PUSH    DE

        LD      BC,DIR_ENT_LENGTH; OFFSET TO NEXT DIR ENTRY'S ATTR BYTE
        PUSH    BC

        LD      HL,FCB_BUFFER
        LDIR

        POP     DE
        POP     HL

        ADD     HL,DE; POINT TO ATTR BYTE

        PUSH    HL
        POP     IY

        BIT     ATTR_HOLE_BIT,(IY+DIR_ATTR); IS IT A HOLE?
        JR      Z,NOT_HOLE; NOPE

        JR      ITS_HOLE


LAST_ENTRY:
        LD      A,(FILE_COUNT)
        LD      (MOD_FILE_COUNT),A; SAVE IT

        POP     AF
        POP     DE

        PUSH    DE
        PUSH    AF

        LD      HL,FCB_BUFFER

        CALL    __SET_FILE; PUT CHANGED DIRECTORY AWAY

        JR      NZ,ERROR

        POP     AF
        POP     DE

        LD      DE,HOLE_FILE_NAME; NAME OF HOLE

        PUSH    DE
        PUSH    AF; SAVE DEVICE ID

        LD      HL,FCB_BUFFER

        CALL    __QUERY_FILE
        LD      IX,(FCB_HEAD_ADDR)
        LD      L,(IX+FCB_POINTER); GET ADDRESS OF HOLE IN DIR BLOCK
        LD      H,(IX+FCB_POINTER+1)

        PUSH    HL
        POP     IY

        BIT     ATTR_HOLE_BIT,(IY+DIR_ATTR); WAS IT A HOLE
        JR      Z,ERROR

        LD      HL,FILE_COUNT
        LD      A,(MOD_FILE_COUNT)

        INC     A

        CP      (HL)
        JR      NZ,NO_TRIM


ITS_HOLE:
        LD      L,(IY+DIR_MAX_LENGTH); GET CURRENT HOLE SIZE
        LD      H,(IY+DIR_MAX_LENGTH+1)

        LD      DE,(NEW_HOLE_SIZE); BLOCKS TO BE RETURNED TO HOLE
        ADD     HL,DE; NEW HOLE SIZE

        LD      (IY+DIR_MAX_LENGTH),L
        LD      (IY+DIR_MAX_LENGTH+1),H

        LD      L,(IY+DIR_START_BLOCK)
        LD      H,(IY+DIR_START_BLOCK+1)

        OR      A
        SBC     HL,DE

        LD      (IY+DIR_START_BLOCK),L
        LD      (IY+DIR_START_BLOCK+1),H

NOT_HOLE:

        LD      A,(IX+FCB_DEVICE); DEVICE NUMBER
        LD      HL,(FCB_DATA_ADDR); GET ADDR OF MY BUFFER
        LD      E,(IX+FCB_BLOCK); GET BLOCK ADDRESS IN BCDE
        LD      D,(IX+FCB_BLOCK+1)
        LD      C,(IX+FCB_BLOCK+2)
        LD      B,(IX+FCB_BLOCK+3)

        CALL    WRITE_BLOCK; RE-WRITE THE DIRECTORY BLOCK
        JR      NZ,ERROR

NO_TRIM:
        POP     DE; REALLY WAS AF
        POP     DE
        POP     IY
        POP     IX
        POP     HL

        XOR     A

        RET

ERROR:
        OR      A
        POP     DE; REALLY AF
        POP     DE
        POP     IY
        POP     IX
        POP     HL

        RET


;***************************************************************
;
;     __INIT_TP_DIR INITIALIZES THE TAPE DIRECTORY
;
;     INPUT:  A       DEVICE ID
;                     LOW NIBBLE - DEVICE ADDRESS
;                     HI NIBBLE  - SECONDARY DEVICE ID
;
;             C       NUMBER OF SECTORS IN DIRECTORY
;             DE      NUMBER OF SECTORS ON DEVICE
;
;             HL      POINTER TO ASCII ETX TERMINATED STRING
;                     ( VOLUME ID) (SHOULD BE BLANK-PADDED IF
;                     LESS THAN 12 CHARACTERS)
;     OUTPUT:
;             CONDITION FLAGS
;             Z       NO ERROR
;             NZ      ERROR
;                     A = ERROR CODE
;
;***************************************************************

;GLB    __INIT_TAPE_DIR
;GLB    HOLE_FILE_NAME
;GLB    DIRECTORY_CHECK

;EXT    SECTOR_NO
;EXT    DEVICE_ID
;EXT    FCB_DATA_ADDR
;EXT    SECTORS_TO_INIT
;EXT    WRITE_BLOCK

__INIT_TAPE_DIR:

        PUSH    IY
        PUSH    BC
        PUSH    DE
        PUSH    HL

        LD      (DEVICE_ID),A; SAVE THE DEVICE ID

        LD      A,C
        LD      (SECTORS_TO_INIT),A; NO OF SECTORS TO INITIALIZE

        PUSH    HL

        CALL    ZERO_OUT_BUFFER; ZERO OUT THE 1K BUFFER

        LD      HL,INITIAL_DIRECTORY; POINTER TO INITIAL SETUP
        LD      DE,(FCB_DATA_ADDR); ADDRESS OF 1K BUFFER
        LD      BC,DIR_ENT_LENGTH*3+VOL_DES_LENGTH; # BYTES TO MOVE INTO BUFFER ; [RECON] OCR 6348: scan bytes are 01 68 00.
        LDIR

        POP     HL; GET ADDR OF ETX TERMINATED ASCII STRING

        LD      DE,(FCB_DATA_ADDR); GET ADDRESS OF 1K BUFFER
        LD      B,12; MAX OF 12 BYTES IN STRING

LOAD_DIR:
        LD      A,(HL); GET ASCII CHAR OF VOLUME ID
        CP      ETX; IS IT ETX?

        JR      Z,ITS_AN_ETX; YUP

        LD      (DE),A; NOPE,PUT IN THE 1K BUFFER

        INC     HL
        INC     DE

        DJNZ    LOAD_DIR

        LD      A,ETX
        DEC     DE

ITS_AN_ETX:
        LD      (DE),A; ETX TERMINATED DIRECTORY NAME
        LD      IY,(FCB_DATA_ADDR); POINTER TO 1K BUFFER

        LD      A,(SECTORS_TO_INIT); GET THE NO OF SECTORS TO INITIALIZE
        OR      080H; SET HI BIT
        LD      (IY+VOL_DIRSIZE),A; SAVE IN FIRST BYTE OF BUFFER

        POP     HL
        POP     DE
        POP     BC

        PUSH    BC
        PUSH    DE
        PUSH    HL

        LD      (IY+VOL_SIZE+0),E
        LD      (IY+VOL_SIZE+1),D

        PUSH    DE; GET TO FIRST DIR ENTRY
        LD      DE,VOL_DES_LENGTH+DIR_ENT_LENGTH*2; POINT TO FIRST FILE ENTRY ; [RECON] OCR 6392: scan bytes are 11 4E 00.
        ADD     IY,DE
        POP     DE

        LD      (IY+DIR_MAX_LENGTH-DIR_ENT_LENGTH),C; BLOCKS ALLOCATED FOR DIRECTORY
        LD      (IY+DIR_USED_LENGTH-DIR_ENT_LENGTH),C; MAKE USED BLOCKS AS LARGE AS POSSIBLE

        INC     C; FIRST "FILE" STARTS AFTER
        LD      (IY+DIR_START_BLOCK),C; LAST SECTOR OF DIR

        LD      B,0; WANT BC = # SECTORS USED
; (# DIR SECT + 1 TO COVER
; SECT 0)

        EX      DE,HL; HL = # SECTORS ON DEVICE
        OR      A; CLEAR CARRY
        SBC     HL,BC; HL = # SECTORS LEFT FOR FILES ?????

        LD      (IY+DIR_MAX_LENGTH+0),L
        LD      (IY+DIR_MAX_LENGTH+1),H

        LD      A,1; FIRST SECTOR
        LD      (SECTOR_NO),A

        CALL    WRITE_1_BLOCK; WRITE BLOCK TO TAPE

        JR      NZ,WE_GOT_ERRORS; CAME BACK WITH ERROR

        LD      A,(SECTORS_TO_INIT); GET NO OF SECTORS TO INITIALIZE

        LD      B,A
        DEC     B; ONE LESS BECAUSE ONE WAS JUST INITIALIZED

        JR      Z,NO_SECTORS_TO_INIT; WAS ONLY ONE TO INIT

        CALL    ZERO_OUT_BUFFER; CLEAR 1K BUFFER

SECT_INIT_LOOP:
        LD      HL,SECTOR_NO; SECTOR NO.
        INC     (HL); NEXT SECTOR

        CALL    WRITE_1_BLOCK; WRITE BLOCK OF ZEROS OUT
        JR      NZ,WE_GOT_ERRORS; GOT A ERROR IN WRITE

        DJNZ    SECT_INIT_LOOP

NO_SECTORS_TO_INIT:

        XOR     A; ZERO CONDITION

WE_GOT_ERRORS:

        POP     HL
        POP     DE
        POP     BC
        POP     IY

        RET



ZERO_OUT_BUFFER:

        PUSH    BC
        PUSH    DE
        PUSH    HL

        LD      HL,(FCB_DATA_ADDR); POINTER TO 1K BUFFER
        LD      DE,(FCB_DATA_ADDR)
        INC     DE
        LD      BC,1023

        LD      (HL),0; ZERO IT OUT

        LDIR

        POP     HL
        POP     DE
        POP     BC

        RET


WRITE_1_BLOCK:
        PUSH    BC

        LD      HL,(FCB_DATA_ADDR); ADDRESS OF 1K BUFFER
        LD      A,(SECTOR_NO); GET SECTOR NUMBER
        LD      E,A
        LD      D,0
        LD      BC,0

        LD      A,(DEVICE_ID)

        CALL    WRITE_BLOCK; WRITE IT OUT

        POP     BC

        RET


INITIAL_DIRECTORY:
        DEFB    "            "
        DEFB    10000000B
DIRECTORY_CHECK:
        DEFB    055H,0AAH,000H,0FFH
        DEFB    0,0
        DEFB    0,0
        DEFB    0,0
        DEFB    0,0,0

        DEFB    "BOOT",ETX,"       "
        DEFB    ATTR_PERMANENT | ATTR_SYSTEM; [RECON] Identifier repair: OCR definition at 1051 is ATTR_SYSTEM.
        DEFB    0,0,0,0
        DEFW    1
        DEFW    1
        DEFW    0
        DEFB    0,0,0

        DEFB    "DIRECTORY",ETX,"  "
        DEFB    ATTR_PERMANENT | ATTR_WRITE_PROT | ATTR_SYSTEM
        DEFB    1,0,0,0
        DEFW    128
        DEFW    1
        DEFW    1024
        DEFB    0,0,0

HOLE_FILE_NAME:
        DEFB    "BLOCKS LEFT",ETX
        DEFB    ATTR_HOLE
        DEFB    0,0,0,0
        DEFB    0,0
        DEFB    0,0
        DEFB    0,0
        DEFB    57H,07H,11H

INIT_INFO_SIZE EQU $-INITIAL_DIRECTORY
;
;================================================================
;================================================================
;================================================================
;


; NAME "REV 1 - RPD"
;
;       RETURN ERROR CODES UNTIL THESE ROUTINES ARE WRITTEN
;
;       10/12/83  VSB
;       10/14/83  RPD changed __EOS_4 to __CV_A
;

;GLB    __POSIT_FILE,__EOS_1,__EOS_2,__EOS_3,__CV_A
__POSIT_FILE:
__EOS_1:
__EOS_2:
__EOS_3:
__CV_A:
        LD      A,PROG_NON_EXIST; SIGNIFY PROGRAM DOES NOT EXIST
        OR      A; NZ CONDITION
        RET
;
;================================================================
;================================================================
;================================================================
;


;REV 0  (V/D 8/24/83)


;****************************************************************
; THIS ROUTINE WILL FIND THE DCB FOR THE DEVICE DESIRED
;
;       INPUT:  A ==> POINTS TO THE DEVICE ID
;       OUTPUT:
;               CONDITION FLAG:
;                       Z : NO ERRORS
;                           IY ==> POINTS TO THE START OF THE DEVICE DCB
;                       NZ: ERROR OCCURED
;                           IY ==> IS DESTROYED
;
;****************************************************************


;GLB    __GET_DCB_ADDR
        GLOBAL  __FIND_DCB
;EXT    CURRENT_PCB

__GET_DCB_ADDR:
__FIND_DCB:
        PUSH    BC
        PUSH    DE

        LD      C,A; SAVE THE DEVICE ID
        LD      IY,(CURRENT_PCB); GET THE START ADDRESS OF PCB
        LD      B,(IY+P_NUM_DCBS); GET THE NUMBER OF DCB'S
        XOR     A
        CP      B; ARE THERE ZERO DCBS?
        JR      Z,DCB_NO_FIND; YES
; NO
        LD      DE,P_SIZE; GET THE SIZE OF THE PCB
        ADD     IY,DE; ADD TO IY TO GET TO THE START OF THE DCB
        LD      DE,D_SIZE; GET THE DCB SIZE
        LD      A,C; RELOAD THE DEVICE ID
        AND     0FH; AND OF THE HIGH BITS TO GET ONLY
; THE DEVICE ID

DCB_LOOP:
        CP      (IY+D_DEV_ADDR); IS THIS THE CORRECT DEVICE DCB?
        JR      Z,FOUND_IT; YES
; NO
        ADD     IY,DE; GET TO THE NEXT DCB AND CHECK IT
        DJNZ    DCB_LOOP; GO CHECK THEM ALL UNTIL ONE IS FOUND

        JR      DCB_NO_FIND


FOUND_IT:
        LD      A,C; RESTORE A TO ITS ORIGINAL STATE
        JR      FINISHED

DCB_NO_FIND:
        LD      A,DCB_NOT_FOUND
        OR      A

FINISHED:
        POP     DE
        POP     BC

        RET




;****************************************************************
; THIS ROUTINE WILL INITIATE A STATUS REQUEST COMMAND, AND WILL RETURN
; THE RESULT OF THE COMMAND.
;       INPUT:  A ==> DEVICE ID
;       OUTPUT: CONDITION BITS
;               Z :     NO ERRORS
;                       IY CONTAINS START ADDRESS OF DCB
;               NZ:     ERROR OCCURED
;                       A ==> ERROR CODE
;                       IY IS DESTROYED (MAY BE ADDRESS OF DCB
;                       UNDER CERTAIN ERROR CONDITIONS)
;
;****************************************************************

;GLB    __REQUEST_STATUS


__REQUEST_STATUS:
        CALL    __FIND_DCB; GET THE CORRECT DEVICE DCB

        JR      NZ,END_R_S

        LD      (IY+D_COM_STAT),DCB_STATUS; SEND THE COMMAND TO REQUEST
; A STATUS

REQUEST_LOOP:
        BIT     CMND_COMPLETE_BIT,(IY+D_COM_STAT); HAS THE COMMAND COMPLETED?
        JR      Z,REQUEST_LOOP; NO LOOP TILL IT DOES

        LD      A,(IY+D_COM_STAT); CHECK THE STATUS
        CP      CMND_FIN_STATUS; DID IT FINISH WITH NO ERRORS?
; IF ZERO EVERYTHING IS OK
; IF NZ THERE WAS AN ERROR

END_R_S:
        RET




;GLB    __RD_DEV_DEP_STAT

__RD_DEV_DEP_STAT:
        PUSH    IY; SAVE THIS REGISTER
        CALL    __FIND_DCB; GET THE CORRECT DEVICE DCB

        JR      NZ,END_R_D_D_S

        XOR     A; NO ERROR

        LD      A,(IY+D_STATUS_FLAGS); READ DEVICE-DEPENDENT STATUS FLAGS

END_R_D_D_S:
        POP     IY; RESTORE THE REGISTER
        RET


;****************************************************************
; THIS ROUTINE WILL CHECK AND SEE IF THE DEVICE DCB IS CURRENTLY ACTIVE.
; IF IT IS THEN A NZ CONDITION WILL BE SENT BACK TO THE CALLING PROGRAM
;       INPUT:  IY ===> POINTS TO START OF DEVICE DCB
;       OUTPUT: CONDITION FLAGS
;               Z :     DCB IS INACTIVE, IN OTHERWORDS IT IS AVAILABLE
;                       A ===> IS PRESERVED
;               NZ:     DCB IS ACTIVE
;                       A ===> ERROR CODE
;
;****************************************************************

; OK CHANGED TO G_OK TO PREVENT CONFLICT WITH IDENTICAL
; LABEL ELSEWHERE

;GLB    CHK_IF_INACTIVE

CHK_IF_INACTIVE:
        PUSH    BC

        LD      C,A; PRESERVE A
        LD      A,(IY+D_COM_STAT); IS THE DCB AVAILABLE?
        CP      DCB_IDLE
        JR      Z,G_OK; YES IT IS INACTIVE
; NO IT IS NOT
        BIT     CMND_COMPLETE_BIT,(IY+D_COM_STAT); HAS THE COMMAND BEEN
; PROCESSED
        JR      Z,DEVICE_BUSY; NO, THE DEVICE IS STILL BUSY
; YES, THE DCB IS AVAILABLE
G_OK:
        XOR     A; INSURE ZERO CONDITION
        LD      A,C; RESTORE A
        JR      DONE

DEVICE_BUSY:
        INC     A; INSURE A NON_ZERO CONDITION FOR FLAG
        LD      A,DCB_BUSY; SEND BACK THE ERROR CODE

DONE:
        POP     BC
        RET




;****************************************************************
;
;       CHK_FOR_IDLE CHECKS IF THE REQUESTED DEVICE IS IDLE
;       SENDING BACK AN ERROR CODE
;
;       INPUT:  IY       POINTER TO THE DCB
;
;       OUTPUT: CONDITION FLAGS
;               Z        DEVICE NOT IDLE
;               NZ       DEVICE IDLE
;
;****************************************************************


;GLB    CHK_IF_IDLE

CHK_IF_IDLE:

        LD      A,(IY+D_COM_STAT); GET STATUS BYTE

        OR      A; IS IT IDLE(ZERO)?
        JR      NZ,NOT_IDLE; NOPE

        LD      A,DCB_IDLE_ERR; ERROR CODE FOR DEVICE IDLE

        OR      A; CREATE NZ CONDITION

        RET

NOT_IDLE:
        XOR     A; CLEAR ZERO FLAG

        RET
;
;================================================================
;================================================================
;================================================================
;


;REV 0                  (V/D  8-24-83)

;****************************************************************
; THIS ROUTINE WILL READ A CHARACTER FROM THE KEYBOARD
;
;       INPUT:  NOTHING
;       OUTPUT: CONDITION FLAGS
;               Z :     NO ERRORS
;                       A ===> CONTAINS THE KEY READ
;               NZ:     ERROR OCCURED
;                       A ===> ERROR CODE
;
;
;****************************************************************

        GLOBAL  __RD_KBD
;EXT    KEYBOARD_BUFFER
;EXT    __RD_CH_DEV

__RD_KBD:
        PUSH    BC
        PUSH    DE

RD_KBD_LOOP:

        CALL    __START_RD_KBD

        JR      NZ,ERROR_OCCURED

        LD      C,A; PRESERVE THE DEVICE ID

WAITING:
        LD      A,C; RESTOR THE DEVICE ID
; BC IS SAVED IN ALL CALLED MODULES
        CALL    __END_RD_KBD

        JR      NC,WAITING; THE OPERATION HAS NOT COMPLETED YET
; AT THIS POINT WE EITHER HAVE THE
; KEY OR AN ERROR CODE IN A
ERROR_OCCURED:
        POP     DE
        POP     BC

        RET


;****************************************************************
; THIS ROUTINE WILL REQUEST A STATUS ON THE KEYBOARD
;       INPUT:  NOTHING
;       OUTPUT: CONDITION FLAG
;               Z :     NO ERRORS
;               NZ:     ERROR OCCURED
;                       A ===> ERROR CODE
;
;****************************************************************

        GLOBAL  __REQ_KBD_STAT

;EXT    __REQUEST_STATUS

__REQ_KBD_STAT:
        LD      A,KEYBOARD_ID; WANT STATUS ON THE KEYBOARD
        JP      __REQUEST_STATUS


;****************************************************************
; THIS ROUTINE WILL START A READ DATA COMMNAD ON THE KEYBOARD
;       INPUT:  NOTHING
;       OUTPUT: CONDITION FLAGS
;               Z :     NO ERROR
;               NZ:     ERROR OCCURED
;                       A ===> ERROR CODE
;****************************************************************

;GLB    __START_RD_KBD

;EXT    __START_RD_CH_DEV

__START_RD_KBD:
        PUSH    BC
        PUSH    DE

STRT_RD_KBD_LOOP:
        LD      A,KEYBOARD_ID
        LD      DE,KEYBOARD_BUFFER; DESTINATION OF WHERE TO PLACE KEY
        LD      BC,1; GET 1 CHARACTER
        CALL    __START_RD_CH_DEV; GO INITIATE THE COMMAND

        POP     DE
        POP     BC

        RET


;****************************************************************
; THIS ROUTINE WILL CHECK THE RESULT OF A COMMAND THAT WAS SENT.  IF THE
; RESULT IS A NAK THEN THE ROUTINE WILL ISSUE A NEW READ COMMAND.
;       INPUT:  NOTHING
;       OUTPUT: CONDITION FLAG
;               C :     COMMAND HAS FINISHED
;               NC:     COMMAND HAS NOT BEEN FINISHED
;               Z :     NO ERROR OCCURED
;               NZ:     ERROR OCCURED
;                       A ===> ERROR CODE
;****************************************************************

;GLB    __END_RD_KBD
;EXT    __END_RD_CH_DEV

__END_RD_KBD:
        LD      A,KEYBOARD_ID; SEND THIS PARM TO __EN_RD_CH_DEV
        CALL    __END_RD_CH_DEV; CHECK THE RESULT

        JR      NC,ROUTINE_DONE; CARRY FLAG IS CLEARED, CMND IS NOT COMPLETE
; THE COMMAND IS COMPLETE
        JR      Z,HAVE_THE_KEY; ROUTINE COMPLETED WITH NO ERRORS,
; CARRY FLAG IS SET, ZERO CONDITION
; THERE WAS AN ERROR
        CP      KBD_NAK; WAS THE ERROR A NAK?
        JR      NZ,NO_NAK; NO, GO SET C FLAG TO SHOW COMMAND COMPLETED
; YES, TRY THE COMMAND AGAIN
        CALL    __START_RD_KBD
        JR      Z,SHOW_COMPLETE
; THERE WAS AN ERROR IN THE COMMAND RETRY
; SET THE CARRY FLAG TO SHOW THAT THE
; OPERATION COMPLETED. THE FLAG
; CONDITION WILL BE NON-ZERO TO
; INDICATE AN ERROR OCCURED. A CONTAINS
; THE ERROR CODE
NO_NAK:
        SCF
        JR      ROUTINE_DONE

HAVE_THE_KEY:
        LD      A,(KEYBOARD_BUFFER); PUT THE KEY IN THE KEYBOARD BUFFER
        JR      ROUTINE_DONE

SHOW_COMPLETE:
        OR      A; CLEAR CARRY FLAG BECAUSE THE RETRY WAS STARTED
; WITH NO PROBLEMS. THE COMMAND IS NOT COMPLETE
ROUTINE_DONE:
        RET
;
;================================================================
;================================================================
;================================================================
;



;REV 1                  (V/D  8-24-83)
;****************************************************************
; PRINT_CHAR ALLOWS THE CALLER TO PRINT ONE CHARACTER
;       INPUT:  A ===> CHARACTER TO BE PRINTED
;       OUTPUT: CONDITION FLAGS
;               Z :     NO ERROR
;               NZ:     ERROR OCCURED
;                       A ===> ERROR CODE
;
;****************************************************************

;GLOBAL __PR_CH
;EXT    PRINT_BUFFER
;EXT    CHK_IF_INACTIVE

__PR_CH:
        PUSH    BC
        PUSH    DE
        PUSH    HL
        PUSH    IY

        LD      (PRINT_BUFFER),A
        LD      A,ETX; TERMINATE STRIN W/ETX
        LD      (PRINT_BUFFER+1),A
        LD      HL,PRINT_BUFFER; ADDRESS OF PRINT BUFFER

        CALL    __PR_BUFF

        POP     IY
        POP     HL
        POP     DE
        POP     BC

        RET


;****************************************************************
; PRINT_BUFFER ALLOWS THE CALLER TO PRINT AN ASCII ETX-TERMINATED STRING
;       INPUT:  HL ===> ADDRESS OF ETX-TERMINATED STRING
;       OUTPUT: CONDITION FLAGS
;               Z :     NO ERROR
;               NZ:     ERROR OCCURED
;                       A ===> ERROR CODE
;
;****************************************************************

        GLOBAL  __PR_BUFF

;EXT    __FIND_DCB,__WR_CH_DEV

__PR_BUFF:
        PUSH    BC
        PUSH    DE
        PUSH    HL
        PUSH    IY

PR_BUFF2:
        LD      A,PRINTER_ID; WANT THE PRINTERS DCB
        CALL    __FIND_DCB; GET THE DEVICE'S DCB

        JR      NZ,END_PRINT_ROUTINE; THERE WAS A PROBLEM FINDING THE DCB

        CALL    CHK_IF_INACTIVE
        JR      NZ,PRTR_DCB_ACTIVE

CHECK_FOR_ETX:
        LD      BC,0; CHARACTER COUNT
        LD      E,L; SAVE THE STRING
        LD      D,H; DE=HL= PTR TO UNPRINTED STRING

GET_NEXT_ASCII:
        LD      A,ETX
        CP      (HL); IS IT AN ETX?
        JR      Z,ITS_ETX; YES

; NO
        INC     HL; POINT TO NEXT CHARACTER
        INC     C; INC COUNT
        LD      A,C; HAVE WE LOOKED AT 16 BYTES?
        CP      16
        JR      NZ,GET_NEXT_ASCII; YES
;                                           DE = PTR TO UNPRINTED STRING, DE=PTR TO UNPRNTED+16
        EX      DE,HL; HL = PTR TO UNPRINTED STRING, DE=PTR TO UNPRNTED+16

WRITE_COMMAND_AGAIN:

        LD      A,PRINTER_ID
        CALL    __WR_CH_DEV

        JR      Z,WRITE_DONE; WRITE COMPLETED WITH NO ERRORS

        CP      PR_NAK; IT A NAK?
        JR      NZ,PRINT_CMND_FAILED; AN ERROR

        JR      WRITE_COMMAND_AGAIN; SEND ANOTHER WRITE COMMAND

WRITE_DONE:
        EX      DE,HL; DE = PTR TO UNPRINTED STRNG, HL=PTR TO UNPRNTED+16
        JR      CHECK_FOR_ETX; GO CHECK THE NEXT CHARACTER


ITS_ETX:
        EX      DE,HL
        XOR     A; ZERO OUT A
        CP      C; WAS THE FIRST CHARACTER CHECKED
; AN ETX?
        JR      Z,END_PRINT_ROUTINE; YUP, DON'T BOTHER PRINTING IT

SEND_ANOTHER_WRITE:
        LD      A,PRINTER_ID; WILL WRITE TO THE PRINTER
        CALL    __WR_CH_DEV; WRITE CHARACTERS

        JR      Z,COMMAND_FINISHED_SUCCESSFULLY; ALL DONE

        CP      PR_NAK; DO WE HAVE A NAK?
        JR      Z,SEND_ANOTHER_WRITE; YUP

; NOPE, MUST BE AN ERROR


COMMAND_FINISHED_SUCCESSFULLY:
PRINT_CMND_FAILED:
PRNT_CMND_FAILED:
PRTR_DCB_ACTIVE:
END_PRINT_ROUTINE:
        POP     IY
        POP     HL
        POP     DE
        POP     BC; ON ERROR, ZERO FLAG SET AND A
; CONTAINS THE ERROR CODE
        RET


;****************************************************************
;
; __SETUP_PR_BUFF SETS UP PRINT_BUFFER AND THE HL REGISTER AND
; CALLS __START_PR_BUFF
;       INPUT:  A = ASCII CHARACTER
;       OUTPUT: CONDITION FLAGS
;               Z:      NO ERROR
;               NZ:     ERROR OCCURED
;                       A = ERROR CODE
;
;****************************************************************

;GLB    __SETUP_PR_BUFF

__SETUP_PR_BUFF:
        LD      (PRINT_BUFFER),A
        LD      A,ETX
        LD      (PRINT_BUFFER+1),A

        LD      HL,PRINT_BUFFER

        CALL    __START_PR_BUFF

        RET




;****************************************************************
;
; __START_PR_CH SETS UP PRINT_BUFFER AND THE HL REGISTER AND
; CALLS __START_PR_BUFF
;       INPUT:  A = ASCII CHARACTER
;       OUTPUT: CONDITION FLAGS
;               Z:      NO ERROR
;               NZ:     ERROR OCCURED
;                       A = ERROR CODE
;
;****************************************************************

;GLB    __START_PR_CH

__START_PR_CH:
        LD      (PRINT_BUFFER),A
        LD      A,ETX
        LD      (PRINT_BUFFER+1),A

        LD      HL,PRINT_BUFFER

        CALL    __START_PR_BUFF

        RET




;****************************************************************
;
;       __END_PR_CH    CALLS __END_PR_BUFF TO CHECK THE DCB STATUS BYTE AND
;       RETURNS THE RESULT TO THE CALLER
;
;       INPUT:  NONE
;
;       OUTPUT: CONDITION FLAGS
;               C:      COMMAND COMPLETED
;               NC:     COMMAND NOT COMPLETED
;               Z:      NO ERRORS OCCURED
;               NZ:     ERRORS
;                       A = ERROR CODE
;
;       ALL     REGISTERS ARE PRESERVED
;
;****************************************************************

;GLB    __END_PR_CH
__END_PR_CH:
        CALL    __END_PR_BUFF

        RET



;***************************************************************
; __START_PR_BUFF ALLOWS THE CALLER TO PRINT AN ASCII ETX-TERMINATED STRING
;        INPUT:   HL ==>  ADDRESS OF ETX-TERMINATED STRING
;        OUTPUT:  CONDITION FLAGS
;                 Z :    NO ERROR
;                 NZ:    ERROR OCCURED
;                        A ==>  ERROR CODE
;
;***************************************************************

;GLB    __START_PR_BUFF

;EXT    __START_WR_CH_DEV

__START_PR_BUFF:
        PUSH    BC
        PUSH    DE
        PUSH    HL
        PUSH    IY

        LD      A,PRINTER_ID; WANT THE PRINTERS DCB
        CALL    __FIND_DCB; GET THE DEVICE'S DCB

        JR      NZ,NO_DCB_FOUND1; THERE WAS A PROBLEM FINDING THE DCB

        CALL    CHK_IF_INACTIVE
        JR      NZ,PRTR_DCB_ACTIVE; [RECON] Identifier repair: scan's trailing mark is not part of the label.

        LD      BC,0; CHARACTER COUNT
        LD      E,L; SAVE THE STRING
        LD      D,H; DE=HL= PTR TO UNPRINTED STRING

GET_NEXT_ASCII2:
        LD      A,ETX
        CP      (HL); IS IT AN ETX?
        JR      Z,ITS_ETX2; YES

; NO
        INC     HL; POINT TO NEXT CHARACTER
        INC     C; INC COUNT
        LD      A,C; HAVE WE LOOKED AT 16 BYTES?
        CP      16
        JR      NZ,GET_NEXT_ASCII2; YES
;                                       DE = PTR TO UNPRINTED STRNG, DE=PTR TO UNPRNTED+16
        EX      DE,HL; HL = PTR TO UNPRINTED STRNG, DE=PTR TO UNPRNTED+16
        LD      A,PRINTER_ID
        CALL    __START_WR_CH_DEV

        JR      WRITE_CMND_SENT

ITS_ETX2:
        EX      DE,HL
        XOR     A; ZERO OUT A
        CP      C; WAS THE FIRST CHARACTER CHECKED
; AN ETX?

        LD      A,PRINTER_ID; WILL WRITE TO THE PRINTER
        CALL    NZ,__START_WR_CH_DEV; NOPE, WRITE CHARACTER
; IS PASSED BACK TO CALLER
NO_DCB_FOUND1:
WRITE_CMND_SENT:

        POP     IY
        POP     HL
        POP     DE
        POP     BC

        RET




;***************************************************************
;
; __END_PR_BUFF CHECKS THE DCB COMM/STATUS BYTE AND RETURNS THE RESULT
; OF THE CHECK
;
;        INPUT:   NONE
;
;        OUTPUT:  CONDITION FLAGS
;                 C:     COMMAND COMPLETED
;                 NC:    COMMAND NOT COMPLETED
;                 Z:     NO ERRORS OCCURED
;                 NZ:    ERRORS
;                        A = ERROR CODE
;
;        ALL      REGISTERS ARE PRESERVED
;
;***************************************************************

;GLB    __END_PR_BUFF
;EXT    __END_WR_CH_DEV

__END_PR_BUFF:

        PUSH    IY

        LD      A,PRINTER_ID
        CALL    __FIND_DCB
        CALL    __END_WR_CH_DEV; CHECK STATUS BYTE

        JR      NC,CMND_NOT_PROCESSED; COMMAND NOT COMPLETED

        JR      Z,FINISHED_WO_ERROR; COMMAND COMPLETED, NO ERROR

        CP      PR_NAK; WAS IT A NAK?

        JR      NZ,NOT_PR_NAK; NOPE, MUST BE AN ERROR

        LD      (IY+D_COM_STAT),DCB_WR; SEND ANOTHER WRITE COMMAND

        OR      A; CLEAR CARRY TO INDICATE COMMAND
; HAS NOT BEEN FINISHED

NOT_PR_NAK:
CMND_NOT_PROCESSED:
FINISHED_WO_ERROR:

        POP     IY

        RET


;***************************************************************
; THIS ROUTINE REQUESTS THE STATUS ON THE PRINTER
;        INPUT:   NONE
;        OUTPUT:
;                 CONDITION FLAGS
;                 Z :     NO ERROR
;                 NZ:     ERROR OCCURRED
;                         A ===>  ERROR CODE
;
;***************************************************************
        GLOBAL  __REQ_PR_STAT

;EXT    __REQUEST_STATUS

__REQ_PR_STAT:
        LD      A,PRINTER_ID
        JP      __REQUEST_STATUS
;
;===============================================================
;===============================================================
;===============================================================
;



;REV 0                 (V/D    8-24-83)

        GLOBAL  __REQ_TAPE_STAT

;EXT    __REQUEST_STATUS

;***************************************************************
; THIS ROUTINE REQUESTS THE STATUS ON THE TAPE DRIVE
;        INPUT:   NONE
;        OUTPUT:
;                 CONDITION FLAGS
;                 Z :     NO ERROR
;                 NZ:     ERROR OCCURED
;                         A ===> ERROR CODE
;
__REQ_TAPE_STAT:
        LD      A,TAPE_ID
        JP      __REQUEST_STATUS
;
;===============================================================
;===============================================================
;===============================================================
;

; NAME    "Rev 18  - RPD"
;
;                        Rev History
;                        Rev   Date        Name       Change
;                        18    30sept400p  RPD        extracted RAM areas and put into EOS_COMM
;                        17    21Sept83_1440 JKL      take out stuff that EOS does not need. put CR back to normal
;                                                     take out flashing cursor
;                        16    19Sept83_1730 JKL      CR now does a clear to EOL and LF
;                        15    18Sept83_1800 JKL      CR now does a CLEAR to EOL
;                        14    15Sept83_1600 JKL      added routine to flash cursor
;                        13    15Sept83    JKL        XOR cursor with char that is under. take out print screen
;                        12    14Sept83    JKL        include print screen
;                        11    14Sept83    JKL        return cursor position in DE
;                        10    06Sept83    JKL        added routine to return cursor position in window
;                        9     05Sept83    JKL        fix for SHIFT LOCK back space. to be removed later
;                        8     04Sept83    JKL        added delete char and shift left
;                        7     04Sept83    JKL        added insert blank, made LINEBUFFER_ 33 chars long
;                        6     03Sept83    JKL        INIT will set cursor pos
;                        5     03Sept83    JKL        Added return cursor pos routine
;                        4     01Sept83    JKL        Fixes and speedups, Major rewrite
;                        3     27Aug83     RPD        new case implementation (jump table)
;                        2     27Aug83     RPD        added scroll
;                        1     26Aug83     RPD        moved to EOS. contains window and XY logic
;                        0     26Aug83     RPD        copied from old EOS. uses WRITE and READ VRAM
;                        - - - - - - - - - - - - -

;
;External Routines
;
;EXT    WRITE_VRAM       ;OS-7
;EXT    READ_VRAM        ;OS-7
;
;External data structures used
;
;EXT    OLDCHAR_
;EXT    X_MIN
;EXT    X_MAX
;EXT    Y_MIN
;EXT    Y_MAX
;EXT    LINEBUFFER_
;EXT    NUM_LINES
;EXT    NUM_COLUMNS
;EXT    UPPER_LEFT
;EXT    PTRN_NAME_TBL
;EXT    CURSOR


;
;Local Equates
;
LF              EQU     0AH
FF              EQU     0CH
BS              EQU     08H
CR              EQU     0DH
CLR_TO_EOL      EQU     16H
CLR_TO_EOS      EQU     18H; [RECON] OCR 7363: scan value column is <0018>.
GOTO_XY_CHAR    EQU     1CH
HOME            EQU     80H
UP              EQU     0A0H
RIGHT           EQU     0A1H
DOWN            EQU     0A2H
LEFT            EQU     0A3H
CURSOR_CHAR     EQU     05FH;Char to emit as cursor
BLANKING_CHAR   EQU     020H;Char used when scrolling to fill screen ; [RECON] OCR 7371: scan value column is <0020> (space).
CURSOR_X        EQU     CURSOR+1


;
;__CONS_INIT
;
;       Sets up the window sizes for the CONSOLE_OUT routine
;
;Input parameters:
; B - number of columns in the window - 1, 0..31
; C - number of lines in the window - 1, 0..23
; D - Absolute (0 based) X coord of upper left corner of window, 0..31
; E - Absolute (0 based) Y coord of upper left corner of window, 0..23
; HL - Pattern Name Table (PNT) starting address
;
;NOTE- User must initialize the VDP
;
;GLB    __CONS_INIT
__CONS_INIT:
        INC     B;Adjust for old calling convention
        INC     C
        LD      (NUM_LINES),BC;Set num lines, cols in window
        LD      (UPPER_LEFT),DE;Set upper left corner of window
        LD      (CURSOR),DE
        LD      (PTRN_NAME_TBL),HL;Save address of Pattern name table

        LD      A,D;Calc min/max coords of window
        LD      (X_MIN),A
        ADD     A,B
        DEC     A
        LD      (X_MAX),A
        LD      A,E
        LD      (Y_MIN),A
        ADD     A,C
        DEC     A
        LD      (Y_MAX),A

        LD      A,BLANKING_CHAR
        LD      (OLDCHAR_),A
        LD      A,CURSOR_CHAR
        CALL    PUT_CHAR_ON_SCREEN

        RET

;
;__CONS_OUT  - This entry point will check special chars such as
;              Carriage Return and performs their normal functions
;              all other, printable, chars are put onto the screen
;
;__CONS_DISP - This entry point will put all chars onto the screen
;              no matter what, no checking is done for control chars
;
;
;Input Parameters:
; A - character to emit
;
; optionally
; E - Y location to goto (must be in window)
; D - X location to goto (must be in window)
;
;
; Saves all registers
;
;GLB    __CONS_OUT
;GLB    __CONS_DISP
__CONS_OUT:
        PUSH    AF
        PUSH    BC
        PUSH    HL
        PUSH    IX
        PUSH    IY
        PUSH    DE;This may contain the X-Y coord of goto xy

        LD      HL,SPECIAL_CHARS
        LD      BC,NUM_SPCL_CHARS
        CPIR
        JR      NZ,NOT_SPECIAL

        LD      HL,SPCL_VECTOR_TBL
        ADD     HL,BC
        ADD     HL,BC

        LD      B,A;Save char in B

        LD      A,(HL)
        INC     HL
        LD      H,(HL)
        LD      L,A
        JP      (HL);Vector to special char handler

__CONS_DISP:
        PUSH    AF
        PUSH    BC
        PUSH    HL
        PUSH    IX
        PUSH    IY
        PUSH    DE
NOT_SPECIAL:
        CALL    PUT_CHAR_ON_SCREEN;Display char where cursor is at
        LD      HL,(CURSOR)
        INC     H;Move cursor to right (+1)
        LD      A,(X_MAX); but check for going out of
        CP      H; the window
        JR      NC,SAVE_CURSOR;If taken then stayed in window
        LD      A,(X_MIN);Went out of window so set X
        LD      H,A; to left edge
        INC     L; and move down one line
        LD      A,(Y_MAX); but check to see if still
        CP      L; in the window
        JR      NC,SAVE_CURSOR
        DEC     L; Put back into window
        PUSH    HL
        CALL    GET_CHAR_UNDER_CURSOR
        CALL    SCROLL_UP
        POP     HL

SAVE_CURSOR: LD      (CURSOR),HL
NEW_CURSOR: CALL    GET_CHAR_UNDER
PUT_CURSOR_ON:
        LD      A,CURSOR_CHAR
        CALL    PUT_CHAR_ON_SCREEN

EXIT: POP     DE
        POP     IY
        POP     IX
        POP     HL
        POP     BC
        POP     AF
        RET

;
;Special Character Handlers
;

; RETURN_WITH_ERASE - moves cursor to right edge of window on current line
;                     after clearing to end of line
;
RETURN_WITH_ERASE:
;         CALL    ERASE_THIS_LINE ; [RECON] OCR 7510 is commented in the scan.
RETURN: CALL    PUT_OLD_ON_SCREEN;Display char cursor was hiding
        LD      A,(X_MIN)
        LD      (CURSOR_X),A
        LD      HL,(CURSOR)
        JP      NEW_CURSOR

;
; MOVE_UP - Moves the cursor up if not at top of window
;
MOVE_UP:
        LD      HL,(CURSOR)
        LD      A,(Y_MIN)
        CP      L
        JR      Z,EXIT;Forget request
        DEC     L;Move up

RESTORE_OLD: CALL    PUT_OLD_ON_SCREEN;Display char cursor was hiding
        JP      SAVE_CURSOR;Display cursor in new spot

;
; MOVE_DOWN - Moves the cursor down if will stay in window, except
;             if used by linefeed when the screen is scrolled
;
MOVE_DOWN:

        LD      HL,(CURSOR)
        LD      A,(Y_MAX);See if at bottom of window
        CP      L
        JR      Z,SCROLL_POSSIBLE
        INC     L;Move down
        JP      RESTORE_OLD
;
SCROLL_POSSIBLE: LD      A,LF;See if linefeed, and if it is
        CP      B; then scroll up. else leave
        JR      NZ,EXIT; cursor and screen as is
        CALL    SCROLL_UP
        LD      HL,(CURSOR)
        JP      NEW_CURSOR

;
; MOVE_RIGHT - Moves the cursor to the right, and if at window's
;              edge will move down a line to the left edge, unless
;              at the lower right corner of the window in which case
;              nothing is down
;
MOVE_RIGHT:
        LD      HL,(CURSOR)
        LD      A,(X_MAX)
        CP      H
        JR      Z,TRY_MOVE_DOWN
        INC     H;Move to right
        JP      RESTORE_OLD
;
TRY_MOVE_DOWN: LD      A,(Y_MAX)
        CP      L
        JR      Z,EXIT;At bottom of window so abort
        INC     L
        LD      A,(X_MIN)
        LD      H,A
        JP      RESTORE_OLD

;
; MOVE_LEFT - Moves the cursor to the left and if at left edge of
;             window will move up a line an to right edge if not
;             at upper left corner of window
;
MOVE_LEFT: LD      HL,(CURSOR)
        LD      A,(X_MIN)
        CP      H
        JR      Z,TRY_SCROLL_UP
        DEC     H;Move to left
        JP      RESTORE_OLD
;
TRY_SCROLL_UP: LD      A,(Y_MIN)
        CP      L
        JR      Z,EXIT;Abort if at upper left corner
        DEC     L
        LD      A,(X_MAX)
        LD      H,A
        JP      RESTORE_OLD

;
; MOVE_HOME - Moves cursor to the upper left corner of the window
;

; FORM_FEED - Clears the screen and puts the cursor at the upper left
;             corner of the window
FORM_FEED:
        LD      A,(NUM_LINES)
        LD      B,A
        LD      HL,(UPPER_LEFT)

        CALL    BLANK_SCREEN

        LD      A,BLANKING_CHAR
        LD      (OLDCHAR_),A

MOVE_HOME: CALL    PUT_OLD_ON_SCREEN;Needed only for MOVE_HOME not FORM_FEED
        LD      HL,(UPPER_LEFT)
        JP      SAVE_CURSOR

;
; ERASE_TO_EOL - From cursor position fills rest of line
;                with BLANKING_CHAR, to end of window only
;                Will blank char under cursor always.
;
ERASE_TO_EOL:
        CALL    ERASE_THIS_LINE
        JP      PUT_CURSOR_ON

;
; ERASE_TO_EOS - Will erase the screen (window) from the current
;                cursor position to the end of the window. The
;                cursor position is also blanked.
;
;
ERASE_TO_EOS:
        CALL    ERASE_THIS_LINE;Erase to end of current line
        LD      HL,(CURSOR)
        INC     L;Move down
        LD      A,(Y_MIN)
        LD      C,A
        LD      A,(NUM_LINES)
        ADD     A,C
        SUB     L;Number of lines left to blank
        JP      Z,PUT_CURSOR_ON
        LD      B,A
        LD      A,(X_MIN)
        LD      H,A
        CALL    BLANK_SCREEN
        JP      PUT_CURSOR_ON

;
; GOTO_XY - Puts cursor to desired X-Y coord if in window
;
;Input Parameters:
; D - X location
; E - Y location
;
GOTO_XY:
        LD      A,(X_MIN)
        CP      D
        JR      Z,CHK_X_WITH_MAX
        JP      NC,EXIT
CHK_X_WITH_MAX: LD      A,(X_MAX)
        CP      D
        JR      Z,CHK_Y_COORD
        JP      C,EXIT
CHK_Y_COORD: LD      A,(Y_MIN)
        CP      E
        JR      Z,CHK_Y_WITH_MAX
        JP      NC,EXIT
CHK_Y_WITH_MAX: LD      A,(Y_MAX)
        CP      E
        JR      Z,SET_CURSOR
        JP      C,EXIT
SET_CURSOR: EX      DE,HL
        JP      RESTORE_OLD

;
;Internal Subroutines
;

; Subroutine
; BLANK_PORTION - Fills LINEBUFFER_ with number of chars in B
;                 from where HL points
;
; Input Parameters:
; HL - Pointer into LINEBUFFER
; B  - Number of the BLANKING_CHAR's to stuff in
;
; A is destroyed
;
BLANK_PORTION:
        PUSH    HL
        PUSH    BC
        JR      BLANK_REST

;
; Subroutine
; BLANKS        - Fills LINEBUFFER_ with 32 BLANKING_CHAR's
;
; A is destroyed
;
BLANKS:
        PUSH    HL
        PUSH    BC
        LD      HL,LINEBUFFER_
        LD      B,32
BLANK_REST: LD      A,BLANKING_CHAR
BLANK_FILL: LD      (HL),A
        INC     HL
        DJNZ    BLANK_FILL
        POP     BC
        POP     HL
        RET

;
; Subroutine
; BLANK_SCREEN  - Will blank a given number of lines on the screen
;
; Input Parameters:
; B  - Number of lines to blank
; HL - Absolute X-Y coords of start position of 1st line to blank
;
; Destroys C, A, DE
; User must reset cursor
;
BLANK_SCREEN:
        CALL    BLANKS;Fill buffer with BLANKING_CHAR
        LD      A,(NUM_COLUMNS)
        LD      C,A

BLNK_SCRN_LOOP: PUSH    BC
        PUSH    HL;Save X-Y coord of line
        CALL    CONVERT_XY
        LD      B,00H;C has number of bytes to read
        LD      HL,LINEBUFFER_
        CALL    WRITE_VRAM
        POP     HL
        INC     L;To next line below
        POP     BC
        DJNZ    BLNK_SCRN_LOOP
        RET

;
; Subroutine
; ERASE_THIS_LINE - This routine will erase the current line
;                   from the cursor position to the right edge
;                   of the window, the char under the cursor is
;                   also blanked.
;
;Input Parameters:
; None
;
; Destroys all registers
; Sets OLDCHAR_ to BLANKING_CHAR
;
ERASE_THIS_LINE:
        CALL    READ_FROM_CURSOR_TO_EOL
        PUSH    HL
        PUSH    BC
        LD      B,C
        CALL    BLANK_PORTION
        POP     BC
        POP     HL

        LD      A,BLANKING_CHAR
        LD      (OLDCHAR_),A

        JP      WRITE_VRAM;Write line with blanks, return thru WRITE_VRAM

;
;Subroutine
;READ_FROM_CURSOR_TO_EOL - reads the line on screen from the
;                          cursor position to the right edge of the
;                          screen
;
;Input Parameters:
; None
;
;Returns:
; BC - number of chars read
; HL - address of LINEBUFFER_
; DE - VRAM address of place cursor is
;
READ_FROM_CURSOR_TO_EOL:
        LD      HL,(CURSOR)
        LD      A,(X_MAX)
        INC     A;Calc # chars to read
        SUB     H
        LD      C,A
        CALL    CONVERT_XY
        LD      HL,LINEBUFFER_
        LD      B,00H
        PUSH    BC
        PUSH    HL
        PUSH    DE
        CALL    READ_VRAM
        POP     DE
        POP     HL
        POP     BC
        RET
;:
;:
;:Subroutine
;: SCROLL_UP     - Scrolls the entire window up 1 line and puts a line
;:                 of BLANKING_CHAR's on the last line
;:
;:   Caller must restore cursor to screen
;:
SCROLL_UP:
                CALL    PUT_OLD_ON_SCREEN
                LD      HL,(UPPER_LEFT)
                PUSH    HL
                CALL    CONVERT_XY
                POP     HL
                LD      A,(NUM_LINES)
                LD      B,A
                DEC     B
;:
SCROLL_LOOP: PUSH    BC;Save number of remaining lines
                PUSH    DE;Save next write location
                INC     L;Point to next line below
                PUSH    HL
                CALL    CONVERT_XY
                PUSH    DE;Save address of this read
                LD      A,(NUM_COLUMNS)
                LD      C,A
                LD      B,00H
                PUSH    BC;Save number of chars in line
                LD      HL,LINEBUFFER_
                CALL    READ_VRAM
                POP     BC;Get number of bytes that were read
                POP     DE;Get address of last read
                POP     HL;Get X-Y coords
                EX      (SP),HL;Swap prev read address with X-Y coords
                EX      DE,HL;Swap last read with previous address
                PUSH    HL;  and save previous
                LD      HL,LINEBUFFER_
                CALL    WRITE_VRAM;Write line one line up
                POP     DE;Get address of next write
                POP     HL;Get starting X-Y of last read
                POP     BC
                DJNZ    SCROLL_LOOP
;:
                CALL    BLANKS
                LD      HL,LINEBUFFER_; [RECON] Identifier repair: scan operand and active RAM symbol include the trailing underscore.
                LD      A,(NUM_COLUMNS)
                LD      C,A;B is 0 from DJNZ
                JP      WRITE_VRAM;Return thru WRITE_VRAM

;:
;: Subroutines
;: PUT_OLD_ON_SCREEN  - This entry point puts the char that the
;:                      cursor was on back onto the screen
;:
;: PUT_CHAR_ON_SCREEN - This entry point will put the char in A
;:                      onto the screen where the cursor currently is
;:
;:
PUT_OLD_ON_SCREEN:
                LD      A,(OLDCHAR_)
;:
PUT_CHAR_ON_SCREEN:
                PUSH    HL
                LD      HL,(CURSOR);Get location to put char
                CALL    CONVERT_XY;Convert to a VRAM address
                LD      HL,LINEBUFFER_
                LD      (HL),A
                LD      BC,0001H
                CALL    WRITE_VRAM
                POP     HL
                RET
;:
;:
;: Subroutine
;: GET_CHAR_UNDER_CURSOR - This entry loads HL from CURSOR before
;:                         falling into GET_CHAR_UNDER
;:
;: GET_CHAR_UNDER - Reads the char where the cursor will go
;:                  and saves it in the variable OLDCHAR_
;:
;:Input Parameters:
;: HL - Cursor position
;:
;: Destroys - HL, BC, DE, A
;:
GET_CHAR_UNDER_CURSOR:
                LD      HL,(CURSOR)
;:
GET_CHAR_UNDER:
                CALL    CONVERT_XY
                LD      BC,0001H
                LD      HL,OLDCHAR_
                JP      READ_VRAM;Return thru READ_VRAM

;:
;: Subroutine
;:
;: CONVERT_XY - Converts X-Y coordinates on the screen to a
;:              VRAM address for that char position
;:              Calculates ((( Y * 32) + X ) + base of pattern name table
;:              to yield the absolute address in VRAM of the char
;:
;:Input Parameters:
;: H - X coord
;: L - Y coord
;:
Returns:
;: DE - VRAM address
;: HL - Address of Pattern Name Table (side effect)
;: No Others are altered
;:
CONVERT_XY:
                LD      E,H;Save X coord
                LD      H,00H
                ADD     HL,HL;Calc Y coord * 32
                ADD     HL,HL
                ADD     HL,HL
                ADD     HL,HL
                ADD     HL,HL
                LD      D,00H
                ADD     HL,DE;Add in X coord
                LD      DE,(PTRN_NAME_TBL)
                ADD     HL,DE
                EX      DE,HL
                RET

;:
;: This is a table of chars that perform some function rather
;: than being printed out to the screen as is. There is a
;: jump table that is associated with this table, but NOTE that
;: it has its entrys in reverse order of this table. It would
;: be best to add to the end of this table and to the beginning
;: of the jump table.
;:
SPECIAL_CHARS:
                DEFB    BS
                DEFB    CR
                DEFB    LF
                DEFB    FF
                DEFB    HOME
                DEFB    CLR_TO_EOL
                DEFB    CLR_TO_EOS
                DEFB    GOTO_XY_CHAR
                DEFB    UP
                DEFB    DOWN
                DEFB    LEFT
                DEFB    RIGHT
;:
NUM_SPCL_CHARS EQU $-SPECIAL_CHARS
;:

;:
;:NOTE - This table is in the reverse order of the chars so
;:       any additions to the end of the chars goes at the top
;:       of this table
;:
SPCL_VECTOR_TBL:
                DEFW    MOVE_RIGHT
                DEFW    MOVE_LEFT
                DEFW    MOVE_DOWN
                DEFW    MOVE_UP
                DEFW    GOTO_XY
                DEFW    ERASE_TO_EOS
                DEFW    ERASE_TO_EOL
                DEFW    MOVE_HOME
                DEFW    FORM_FEED
                DEFW    MOVE_DOWN
                DEFW    RETURN
                DEFW    MOVE_LEFT
;:
;:
;: CODE FROM HERE TO END OF CONS_OUT WAS INSERTED AFTER THE
;: REV. 06 ROM WAS BURNED AND HAS BEEN COMMENTED OUT TO MAINTAIN
;: COMPATIBILITY WITH THAT ROM.
;:
;               END
;       SKIP
;;
;; RETURN_CURSOR  -  Will return the current cursor position
;;                   to the caller.  It is in absolute screen
;;                   coordinates (0 based).
;;
;;Input Parameters:
;; None
;;
;;Returns:
;; D - X coord of cursor, absolute based on upper left of screen not window
;; E - Y coord of cursor
;;
;               GLB     RETURN_CURSOR
;RETURN_CURSOR:
;               LD      DE,(CURSOR)
;               RET
;       SKIP
;;
;; RETURN_RELATIVE_CURSOR - Returns the current cursor position relative
;;                          to the window.  0,0 will be returned for the
;;                          upper left corner of the window.
;;
;;Input Parameters:
;; NONE
;;
;;Returns:
;; D - X cursor position relative to window
;; E - Y cursor position relative to window
;;
;; Destroys A
;;
;
;               GLB     RETURN_RELATIVE_CURSOR
;
;RETURN_RELATIVE_CURSOR:
;               LD      DE,(CURSOR)     ;get absolute position
;               LD      A,(X_MIN)
;               NEG
;               ADD     A,D
;               LD      D,A
;               LD      A,(Y_MIN)
;               NEG
;               ADD     A,E
;               LD      E,A
;               RET
;;
;;=====================================================================
;;=====================================================================
;;=====================================================================
;;


; NAME ^Rev 07 - rfj^

; Do_EOS_START MACRO                  ;Header Rev. 4
;                 .GOTO   Ede_EOS_START

; Project:        EOS, 83-101

; ;&k1S                                      ;&k0S
; ;&k1S                                      ;&k0S
; ;&k1S  EOS_START              DLS          ;&k0S
; ;&k1S                                      ;&k0S
; ;&k1S                                      ;&k0S

;             Rev History
;             Rev.  Date        Name        Change
;              7    24Oct1951   rfj         Changed value for REV_NUM to 06
;              6    13Oct1045a  RPD         added init of REV_NUM
;              5    10Oct1005a  RPD         took out memory bank switch logic for GOTO_WP
;              4    25sept1000a RPD         reworked for new boot from tape logic
;              3    24sept1110a RPD         moved clear ram logic
;              2    23sept1255p RPD         moved FCB's and added calls A_uOS routines
;              1    03SEP1445   DLS         MORE CODE
;              0    02SEP0630   DLS         CODE

; Ede_EOS_START MEND

;**********************************************************************
;                                                                     *
;  MODULE NAME:                                                       *
;                                                                     *
;    EOS_START                                                        *
;                                                                     *
;  INPUTS:                                                            *
;                                                                     *
;    NONE                                                             *
;                                                                     *
;  FUNCTION(S):                                                       *
;      0. SET STACK.                                                   *
;      1. TO BANK SELECT OS7 AND 24K RAM.                              *
;      2. CALL INIT_EOS TO ALLOW THE 1) THE Z80/6801 SYNCH_UP,         *
;         POLL FOR NET DEVICES AND ESTABLISH DCB'S.                   *
;      3. CHECK FOR THE PRESENCE OF A TAPE. IF PRESENT THEN            *
;         LOAD IN A COLD_START LOADER AND EXECUTE FROM THERE.          *
;      4. IF NO TAPE, THEN BRING UP THE ROM RESIDENT WORD              *
;         PROCESSOR BY JUMPING TO OS7.                                  *
;                                                                     *
;  OUTPUTS:                                                           *
;                                                                     *
;    DEVICE ADDR _ REG B                                               *
;                                                                     *
;  CALLS:                                                             *
;                                                                     *
;    EOS_INIT                                                         *
;    EOS_QUERY_DEVICE                                                 *
;    EOS_READ_BLOCK                                                    *
;                                                                     *
;  CALLED BY:                                                         *
;                                                                     *
;    INVOKED BY EOS_BOOT                                               *
;                                                                     *
;  NOTES:                                                             *
;                                                                     *
;    NONE.                                                            *
;                                                                     *
;**********************************************************************


;:
;: external routines used
;:
;EXT    _FIND_DCB
;EXT    _REQUEST_STATUS
;EXT    _HARD_INIT
;EXT    _RD_1_BLOCK
;EXT    _FMGR_INIT
;EXT    _GOTO_WP
;EXT    FILL_VRAM
;EXT    TURN_OFF_SOUND
;EXT    SWITCH_MEM
;EXT    PORT_COLLECTION
;:
;: external data structures used
;:
;EXT    REV_NUM
;EXT    CLEAR_RAM_START
;EXT    CLEAR_RAM_SIZE
;EXT    EOS_STACK
;EXT    DEFAULT_BT_DEV
;EXT    MEM_CNFGO1 ; [RECON] Identifier repair: restore letter-O configuration-table symbol.
;EXT    MEM_CNFGO3 ; [RECON] Identifier repair: restore letter-O configuration-table symbol.
;:
;: local equates
;:
EOS_REV         EQU     005H;current EOS revision number
;--NOTE-- this is actually rev.
;06 but to match the production ROM
;which was labeled rev. 05 we fudge
;just a bit (two bits actually)

COLD_START_ADDR EQU     0C800H
DSK4            EQU     4
DSK5            EQU     5
ONE_BLOCK       EQU     1
BLOCK_ZERO      EQU     0


;GLB    _EOS_START
__EOS_START:; [RECON] OCR 8129 exports __EOS_START; scan loses underscores in the label image.
                LD      SP,EOS_STACK; SET THE STACK

                LD      BC,CLEAR_RAM_SIZE; clear EOS ram
                LD      DE,CLEAR_RAM_START+1
                LD      HL,CLEAR_RAM_START
                XOR     A
                LD      (HL),A
                LDIR

                LD      A,EOS_REV; init REV_NUM
                LD      (REV_NUM),A

                CALL    PORT_COLLECTION; collect the port addresses from OS7

                CALL    TURN_OFF_SOUND; KILL SOUNDS

                LD      A,0; CLEAR VRAM
                LD      HL,0
                LD      DE,16*1024
                CALL    FILL_VRAM

                LD      A,(MEM_CNFGO1);get the data for configuration 1 (64K RAM) ; [RECON] Identifier repair: restore letter-O configuration-table symbol.
                CALL    SWITCH_MEM;select this configuration
;:
;: EOS_INIT WILL PERFORM THE 6801/Z80 SYNCH_UP, PERFORM A ROLL_CALL
;: POLL ON THE NET, AND ESTABLISH THE DCB'S
;:
                CALL    __HARD_INIT; [RECON] OCR 8158 bytes CD F6 F8 call the implementation directly.
;:
;: setup the FCB's

                LD      DE,THREE1K_BLKS; START ADDRESS OF THREE 1K BLOCKS
                LD      HL,FCB_S; START ADDRESS OF 3 FCB BLOCKS
                CALL    __FMGR_INIT; TELL THE FILE MANAGER ; [RECON] OCR 8164 bytes CD EA EE call the implementation directly.

;:
;:     CHECK FOR BOOT LOADER IN ANY MASS STORAGE DEVICE
;:
                LD      A,TAPE_ID;set the default boot device to tape
                LD      (DEFAULT_BT_DEV),A

                LD      A,DSK4;check for DISK 4 device active
                CALL    __REQUEST_STATUS; [RECON] OCR 8173 bytes CD 73 F4 call the implementation directly.
                JR      NZ,CHK_D5

                LD      A,DSK4
                CALL    __FIND_DCB; [RECON] OCR 8177 bytes CD 46 F4 call the implementation directly.
                LD      A,(IY+D_STATUS_FLAGS)
                AND     0FH
                CP      3
                LD      A,DSK4
                JR      C,DEV1_OK

CHK_D5: LD      A,DSK5;check for DISK 5 device active
                CALL    __REQUEST_STATUS; [RECON] OCR 8185 bytes CD 73 F4 call the implementation directly.
                JR      NZ,CHK_TAPE

                LD      A,DSK5
                CALL    __FIND_DCB; [RECON] OCR 8189 bytes CD 46 F4 call the implementation directly.
                LD      A,(IY+D_STATUS_FLAGS)
                AND     0FH
                CP      3
                LD      A,DSK5
                JR      C,DEV1_OK
CHK_TAPE:
                LD      A,TAPE_ID;check if TAPE device active
                CALL    __REQUEST_STATUS; [RECON] OCR 8197 bytes CD 73 F4 call the implementation directly.
                JR      NZ,CALL_WP

                LD      A,TAPE_ID
                CALL    __FIND_DCB; [RECON] OCR 8201 bytes CD 46 F4 call the implementation directly.
                LD      A,(IY+D_STATUS_FLAGS)
                PUSH    AF
                AND     0FH
                CP      3
                JR      C,DEV0_OK

                POP     AF
                SRL     A
                SRL     A
                SRL     A
                SRL     A
                CP      3
                LD      A,TAPE_ID+10H
                JR      C,DEV1_OK

CALL_WP:;devices disk 4, 5 and tape are not active
;                 LD      A,(MEM_CNFGO3)          ;get the data for configuration 3 (8K OS7 and 56K RAM) ; [RECON] OCR 8218 is commented in the scan.
;                 CALL    SWITCH_MEM              ;select this configuration ; [RECON] OCR 8219 is commented in the scan.
                JP      _GOTO_WP;default to ALPHA
DEV0_OK:
                POP     AF
                LD      A,TAPE_ID
DEV1_OK:
                LD      (DEFAULT_BT_DEV),A
READ_AGAIN:
                LD      HL,COLD_START_ADDR
                LD      BC,0
                LD      A,(DEFAULT_BT_DEV)
                LD      DE,BLOCK_ZERO
                CALL    __RD_1_BLOCK; [RECON] OCR 8231 bytes CD 9E FA call the implementation directly.
                JP      Z,GO_TO_TAPECODE
                LD      C,A
                LD      A,(DEFAULT_BT_DEV)
                AND     0FH
                CP      TAPE_ID
                JR      NZ,READ_AGAIN
                LD      A,C
                CP      TIMEOUT
                JR      Z,READ_AGAIN
                JP      CALL_WP
GO_TO_TAPECODE:

                LD      A,(DEFAULT_BT_DEV)
                LD      B,A
                JP      COLD_START_ADDR
;:
;:=====================================================================
;:=====================================================================
;:=====================================================================
;:

;
;       Rev History
;       Rev.  Date        Name        Change
;       3     5oct1135a   RPD         wp equate changed to 100H
;       2     2oct155p    RPD         added initialization of reserved byte
;       0     aug/sept    VB          original
;


; ENTRY:        __HARD_INIT
; NEEDS:        NOTHING
; RETURNS:      DEFAULT PCB ADDRESS SET UP FOR USE ((CURRENT_PCB) = PCB)
;               HARD RESET APPLIED TO NETWORK
;               NETWORK MASTER NODE IN SYNC WITH Z80
;               1 DCB ALLOTTED FOR EACH DEVICE ANSWERING A STATUS REQUEST
;               CORRECTLY
;               MASTER NODE SCANNING EACH OF THESE DCB'S FOR WORK TO DO

;GLB    __HARD_INIT

;EXT    CURRENT_PCB
;EXT    PCB

__HARD_INIT:
        PUSH    BC; SAVE BC
        PUSH    DE;      DE
        PUSH    HL;      HL
        PUSH    IY;      IY

        LD      HL,PCB; INIT OUR IDEA OF CURRENT_PCB
        LD      (CURRENT_PCB),HL

        CALL    __HARD_RESET_NET; HARD RESET NETWORK

        CALL    __DLY_AFT_HRD_RES; GOOD DELAY AFTER HARD
; NET RESET

        LD      HL,PCB; ZERO OUT PCB/DCB'S
        LD      DE,PCB+1
;         LD      BC,P_SIZE+(15*D_SIZE)-1 ; [RECON] OCR 8293 is commented; OCR 8294 is the active full-size clear.
        LD      BC,P_SIZE+(15*D_SIZE); this byte count will zero out PCB, DCB'S and the reserved byte
        LD      (HL),0
        LDIR

REPEAT_SYNC1:
        CALL    __SYNC
        JR      NZ,REPEAT_SYNC1

        CALL    __SCAN_ACTIVE; FIND ALL THE ACTIVE DEVICES ON THE NET

        POP     IY; RESTORE IY
        POP     HL;         HL
        POP     DE;         DE
        POP     BC;         BC

        RET

;
; ENTRY:        __SOFT_INIT
; NEEDS:        HL = PCB ADDRESS SET UP FOR USE
; RETURNS:      (CURRENT_PCB) = HL
;               HARD RESET APPLIED TO NETWORK
;               NETWORK MASTER NODE IN SYNC WITH Z80
;               1 DCB ALLOTTED FOR EACH DEVICE ANSWERING A STATUS REQUEST
;               CORRECTLY
;               MASTER NODE SCANNING EACH OF THESE DCB'S FOR WORK TO DO

;GLB    __SOFT_INIT

__SOFT_INIT:
        PUSH    BC; SAVE BC
        PUSH    DE;      DE
        PUSH    HL;      HL
        PUSH    IY;      IY

        LD      (CURRENT_PCB),HL; ESTABLISH CURRENT_PCB ADDR

        CALL    __HARD_RESET_NET; HARD RESET NETWORK

        CALL    __DLY_AFT_HRD_RES

        LD      HL,(CURRENT_PCB); ZERO OUT PCB/DCB'S
        LD      E,L
        LD      D,H
        INC     DE
        LD      BC,P_SIZE+(15*D_SIZE)-1
        LD      (HL),0
        LDIR

REPEAT_SYNC2:
        CALL    __SYNC
        JR      NZ,REPEAT_SYNC2

        CALL    __SCAN_ACTIVE; FIND ALL THE ACTIVE DEVICES ON THE NET

        POP     IY; RESTORE IY
        POP     HL;         HL
        POP     DE;         DE
        POP     BC;         BC

        RET


; ENTRY:        __HARD_RESET_NET
; NEEDS:        NOTHING
; RETURNS:      HARD RESET APPLIED TO NETWORK

NET_DELAY_COUNT EQU     0

;GLB    __HARD_RESET_NET

__HARD_RESET_NET:
;EXT    NET_RESET_PORT
        LD      A,(NET_RESET_PORT)
        LD      C,A
        LD      A,0FH; RESET NETWORK
        OUT     (C),A

        LD      A,NET_DELAY_COUNT; DELAY (***** PROBABLY TOO LONG)

NET_RES_DELAY:
        NOP
        NOP
        NOP
        DEC     A
        JR      NZ,NET_RES_DELAY

        XOR     A; HELLLLLLLLOOOOOOO NETWORK .....
        OUT     (C),A

        RET


;GLB    __DLY_AFT_HRD_RES

__DLY_AFT_HRD_RES:
        PUSH    BC
        PUSH    DE

        LD      B,1

LOOP8:
        LD      DE,0001H

LOOP7:
        DEC     DE
        LD      A,D
        OR      E
        JR      NZ,LOOP7

        DJNZ    LOOP8

        POP     DE
        POP     BC

        RET


; ENTRY:        __SYNC
; NEEDS:        (CURRENT_PCB) SET TO ADDRESS OF CURRENTLY OPERATING PCB
; RETURNS:      NETWORK MASTER NODE IN SYNC WITH Z80
;               NUMBER OF DCB'S = 0 (SO MASTER NODE IS NOT SCANNING
;               ANY DCB'S - SO A __SCAN_ACTIVE NEEDS TO BE DONE
;               TO ESTABLISH DCB'S)

SYNC_DELAY_DE EQU 0
SYNC_DELAY_B  EQU 2

;GLB    __SYNC

__SYNC:
        PUSH    IY; SAVE IY
        PUSH    HL;      HL
        PUSH    BC
        PUSH    DE

        LD      IY,(CURRENT_PCB); CURRENT PCB

        LD      (IY+P_NUM_DCBS),0; 0 DCB'S

        LD      (IY+P_COM_STAT),PCB_SYNC1; START SYNC WITH FIRST
; BYTE

        LD      DE,SYNC_DELAY_DE
        LD      B,SYNC_DELAY_B

LOOP1:
        DEC     DE
        LD      A,D
        OR      E
        JR      NZ,NOT_TIME1

        LD      DE,SYNC_DELAY_DE

        DJNZ    NOT_TIME1

        LD      A,CANT_SYNC1
        OR      A; ERROR

        JR      END_SYNC

NOT_TIME1:
        LD      A,(IY+P_COM_STAT); DID MASTER NODE ACKNOWLEDGE ?
        CP      PCB_SYNC1_ACK
        JR      NZ,LOOP1; ***** NEED PROTECTION HERE

        LD      (IY+P_COM_STAT),PCB_SYNC2; CONTINUE SYNC WITH
; SECOND BYTE

        LD      DE,SYNC_DELAY_DE
        LD      B,SYNC_DELAY_B

LOOP2:
        DEC     DE
        LD      A,D
        OR      E
        JR      NZ,NOT_TIME2

        LD      DE,SYNC_DELAY_DE

        DJNZ    NOT_TIME2

        LD      A,CANT_SYNC2
        OR      A; ERROR

        JR      END_SYNC

NOT_TIME2:
        LD      A,(IY+P_COM_STAT); DID MASTER NODE ACKNOWLEDGE ?
        CP      PCB_SYNC2_ACK
        JR      NZ,LOOP2; ***** NEED PROTECTION HERE

        PUSH    IY; GET PCB ADDR INTO HL
        POP     HL

        LD      (IY+P_REL_ADDR_LO),L; IN CASE SOMEONE ACCIDENTALLY DOES
        LD      (IY+P_REL_ADDR_HI),H; A PCB RELOCATION COMMAND -
; IT WILL RELOCATE TO THIS SPOT

        XOR     A; NO ERROR

END_SYNC:
        POP     DE
        POP     BC
        POP     HL; RESTORE HL
        POP     IY;         IY

        RET


; ENTRY:        __SCAN_ACTIVE
; NEEDS:        (CURRENT_PCB) SET TO CURRENTLY OPERATING PCB
; RETURNS:      1 DCB ALLOTTED FOR EACH DEVICE ANSWERING A STATUS REQUEST
;               CORRECTLY
;               MASTER NODE SCANNING EACH OF THESE DCB'S FOR WORK TO DO

;GLB    __SCAN_ACTIVE

__SCAN_ACTIVE:
        PUSH    BC; SAVE BC
        PUSH    DE;      DE
        PUSH    HL;      HL
        PUSH    IY;      IY
        PUSH    IX;      IX

        LD      HL,(CURRENT_PCB); ZERO OUT DCB'S
        LD      DE,P_SIZE; POINT TO DCB'S
        ADD     HL,DE
        LD      E,L; WANT DE = (CURRENT_PCB)+P_SIZE+1
        LD      D,H
        INC     DE
        LD      BC,(15*D_SIZE)-1
        LD      (HL),0
        LDIR

        LD      IY,(CURRENT_PCB); FIND START ADDR OF DCB'S
        LD      DE,P_SIZE
        ADD     IY,DE

        LD      IX,(CURRENT_PCB); IX = (CURRENT_PCB)
        LD      (IX+P_NUM_DCBS),1; NEED AT LEAST 1 ACTIVE DCB
; TO START CHECKING

        LD      A,1; START WITH DEV ADDR 1

LOOP3:
        PUSH    AF; SAVE CURRENT DEVICE ADDR

        LD      (IY+D_DEV_ADDR),A; SELECT A NEW ADDRESS

        LD      (IY+D_COM_STAT),DCB_STATUS; ISSUE A REQUEST FOR STATUS

LOOP4:
        BIT     CMND_COMPLETE_BIT,(IY+D_COM_STAT); IO DONE ?
        JR      Z,LOOP4; ***** NEED PROTECTION HERE

        LD      A,(IY+D_COM_STAT); CHECK IF VALID RESPONSE
        CP      CMND_FIN_STATUS
        JR      Z,RECVD_VALID_STAT; YES INDEED ...

        POP     AF; TRY NEXT DEVICE ADDR

        INC     A
        CP      MAX_DEV_ADDR+1; PAST LAST VALID ADDR ?
        JR      NZ,LOOP3; NOPE - NEW ADDR

        DEC     (IX+P_NUM_DCBS); DON'T NEED LAST DCB WE USED

        JR      END_S_A; ALL DONE

RECVD_VALID_STAT:
        INC     (IX+P_NUM_DCBS)

        LD      DE,D_SIZE; ADVANCE TO NEXT DCB
        ADD     IY,DE

        POP     AF; ADVANCE TO NEXT NET ADDR

        INC     A
        CP      MAX_DEV_ADDR+1; NO MORE ?
        JR      NZ,LOOP3; MORE TO CHECK

        DEC     (IX+P_NUM_DCBS); DON'T NEED LAST DCB WE USED

END_S_A:
        POP     IX; RESTORE IX
        POP     IY;         IY
        POP     HL;         HL
        POP     DE;         DE
        POP     BC;         BC

        RET


; ENTRY:        __RELOC_PCB
; NEEDS:        (CURRENT_PCB) SET TO CURRENTLY OPERATING PCB
;               HL = ADDRESS OF WHERE PCB SHOULD BE RELOCATED TO
; RETURNS:      PCB RELOCATED AS REQUESTED
;               (CURRENT_PCB) UPDATED TO REFLECT NEW ADDRESS

;GLB    __RELOC_PCB

__RELOC_PCB:
        PUSH    IY

        LD      IY,(CURRENT_PCB); IY = ADDRESS OF CURRENT PCB

        LD      (IY+P_REL_ADDR_LO),L; PLACE ADDR OF NEW PCB IN PLACE
        LD      (IY+P_REL_ADDR_HI),H

        LD      (IY+P_COM_STAT),PCB_SNA; TELL MASTER TO SET NEW PCB ADDRESS

LOOP5:
        LD      A,(IY+P_COM_STAT); CHECK FOR OPERATION COMPLETE
        CP      PCB_SNA_ACK; ***** NEED PROTECTION HERE
        JR      NZ,LOOP5; NOPE

        LD      (CURRENT_PCB),HL; REMEMBER WHERE PCB IS (PLEASE...)

        POP     IY

        RET


; ENTRY:        __GET_PCB_ADDR

;GLB    __GET_PCB_ADDR

__GET_PCB_ADDR:
        LD      IY,(CURRENT_PCB); ADDRESS OF PCB

        RET


;GLB    __SOFT_RES_KBD,__SOFT_RES_PR,__SOFT_RES_TAPE

;EXT    __FIND_DCB,CHK_IF_INACTIVE

__SOFT_RES_KBD:
        LD      A,KEYBOARD_ID; RESET KBD
        JR      __SOFT_RES_DEV

__SOFT_RES_PR:
        LD      A,PRINTER_ID; RESET PRINTER
        JR      __SOFT_RES_DEV

__SOFT_RES_TAPE:
        LD      A,TAPE_ID; RESET TAPE
        JR      __SOFT_RES_DEV

;GLB    __SOFT_RES_DEV

__SOFT_RES_DEV:
        PUSH    IY; SAVE IY

        CALL    __FIND_DCB; FIND APPROPRIATE DEVICE
        JR      NZ,NO_DCB_FOUND; BAD DEVICE I.D.

        CALL    CHK_IF_INACTIVE; IS DEVICE IDLE?
        JR      NZ,ACTIVE_DCB; NOPE ... OOPS ...

        LD      (IY+D_COM_STAT),DCB_RESET; SOFT RESET DEVICE

DCB_CMND_LOOP:
        BIT     CMND_COMPLETE_BIT,(IY+D_COM_STAT); WAS COMMAND COMPLETE?
        JR      Z,DCB_CMND_LOOP; NOPE, CHECK AGAIN

        LD      A,(IY+D_COM_STAT); YUP
        CP      CMND_FIN_STATUS

ACTIVE_DCB:
NO_DCB_FOUND:
        POP     IY

        RET


; READ DCB RETURN CODE (FIRST BYTE OF DCB)

;GLB    __RD_KBD_RET_CODE,__RD_PR_RET_CODE,__RD_TAPE_RET_CODE

__RD_KBD_RET_CODE:
        LD      A,KEYBOARD_ID; RESET KBD
        JR      __RD_RET_CODE

__RD_PR_RET_CODE:
        LD      A,PRINTER_ID; RESET PRINTER
        JR      __RD_RET_CODE

__RD_TAPE_RET_CODE:
        LD      A,TAPE_ID; RESET TAPE
        JR      __RD_RET_CODE

;GLB    __RD_RET_CODE

__RD_RET_CODE:
        PUSH    IY; SAVE IY

        CALL    __FIND_DCB; FIND APPROPRIATE DEVICE
        JR      NZ,NO_DCB_FOUND2; BAD DEVICE I.D.
; Z CONDITION CODE PRESENT


        LD      A,(IY+D_COM_STAT); COMMAND/STATUS BYTE FROM DCB

NO_DCB_FOUND2:
        POP     IY

        RET

;WP             EQU     02000H                  ; WHERE TO GO TO START WP
WP              EQU     00100H; WHERE TO GO TO START WP
;GLB    __GOTO_WP
;EXT    MEM_CNFGOO
;EXT    SWITCH_MEM
__GOTO_WP:
        LD      A,(MEM_CNFGOO);get configuration byte for 32K ROM and 32 RAM
        CALL    SWITCH_MEM

;WP_CODE_START  EQU     2000H
;WP_SIZE        EQU     3*8+1024
;WP_DEST        EQU     8000H
;       LD      A,0                         ; BANK SWITCH IN THE BOOT ROMS
;       OUT     (7FH),A                     ; (I HOPE)
;
;       LD      HL,WP_CODE_START            ; WHERE DOES WP SIT IN BOOT ROMS
;       LD      DE,WP_DEST                  ; WHERE WP GOES
;       LD      BC,WP_SIZE                  ; HOW BIG WP IS
;       LDIR                                ; MOVE WP INTO PLACE
;
;       LD      A,3                         ; BANK SWITCH IN OS_7
;       OUT     (7FH),A                     ; (I KNOW)
;
        JP      WP; GOTO WP

;GLB    __READ_EOS

__READ_EOS:
        RET
;
;       CODE FROM HERE TO END OF EOS_UTIL WAS INSERTED AFTER THE
;       REV. 06 ROM WAS BURNED.  IT HAS BEEN COMMENTED OUT TO MAINTAIN
;       COMPATIBILITY WITH THAT ROM
;
;       END
;
;
;EOS_CODE_START EQU 00800H
;EOS_SIZE       EQU 02000H+800H
;EOS_DEST       EQU 0E000H+800H
;
;       LD      A,0                         ; BANK SWITCH IN THE BOOT ROMS
;       OUT     (7FH),A                     ; (I HOPE)
;
;       LD      HL,EOS_CODE_START           ; WHERE DOES EOS SIT IN BOOT ROMS
;       LD      DE,EOS_DEST                 ; WHERE EOS GOES
;       LD      BC,EOS_SIZE                 ; HOW BIG EOS IS
;       LDIR                                ; MOVE EOS INTO PLACE
;
;       LD      A,3                         ; BANK SWITCH IN OS_7
;       OUT     (7FH),A                     ; (I KNOW)
;
;       RET                                 ; EOS IS IN
;;
;;===============================================================
;;===============================================================
;;===============================================================
;;
; REV 0                  8/24/83  V/D
;***************************************************************
;
;       __RD_1_BLOCK WILL READ ONE BLOCK OF DATA FROM A BLOCK DEVICE
;       TO A LOCATION SPECIFIED BY REGISTER HL
;
;       INPUT:  A         DEVICE ID
;                         LOW NIBBLE - DEVICE ADDRESS
;                         HI NIBBLE  - SECONDARY DEVICE ID
;
;               HL        DESTINATION ADDRESS IN RAM
;
;               REGISTER PAIR.
;                         BC DE       - SECTOR NUMBER ON DEVICE
;
;       THE TRANSFER BYTE COUNT IS DEFINED BY "DCB_MAX_MESS_LEN" WHICH
;       IS FOUND IN THE DEVICE DCB.
;
;       OUTPUT:
;               CONDITION BITS:
;                         Z: NO ERRORS
;                         NZ: ERRORS OCCURED
;                             A - ERROR CODE
;
;       ALL REGISTERS ARE PRESERVED
;
;***************************************************************

;GLB    __RD_1_BLOCK
;EXT    __FIND_DCB
;EXT    CHK_IF_INACTIVE

__RD_1_BLOCK:
        PUSH    IY

        PUSH    AF; SAVE DEVICE ID

        CALL    __START_RD_1_BLOCK

        JR      NZ,ERROR_WITH_DCB

RD_NOT_COMPLETED:
        POP     AF; GET DEVICE ID
        PUSH    AF; SAVE IT AGAIN

        CALL    __END_RD_1_BLOCK; LOOK FOR STATUS

        JR      NC,RD_NOT_COMPLETED; COMMAND NOT COMPLETED, CHECK STATUS AGAIN

ERROR_WITH_DCB:
        POP     IY; REALLY IS AF BUT NEED TO SAVE IF AN ERROR

        POP     IY

        RET
;***************************************************************
;
;       __WR_1_BLOCK WILL WRITE ONE BLOCK OF DATA TO A BLOCK DRIVER
;       FORM A LOCATION SPECIFIED BY REGISTER HL
;
;       INPUT:
;               A         DEVICE ID
;                         LOW NIBBLE - DEVICE ADDRESS
;                         HI NIBBLE  - SECONDARY DEVICE ID
;
;               HL        SOURCE ADDRESS IN RAM
;
;               REGISTER PAIR:
;                         BC DE   - SECTOR NUMBER ON DEVICE
;
;       THE TRANSFER BYTE COUNT IS DEFINED BY "DCB_MAX_MESS_LEN"
;       WHICH IS FOUND IN THE DEVICE DCB
;
;       OUTPUT:
;               CONDITION BITS:
;                         Z:  NO ERRORS
;                         NZ: ERRORS OCCURED
;                             A - ERROR CODE
;
;       ALL REGISTERS  ARE PRESERVED
;
;***************************************************************

;GLB    __WR_1_BLOCK

__WR_1_BLOCK:
        PUSH    IY

        PUSH    AF; SAVE DEVICE ID

        CALL    __START_WR_1_BLOCK

        JR      NZ,ERROR_WITH_DCB2; DCB NOT FOUND OR NOT IDLE

WR_NOT_COMPLETED:
        POP     AF; GET DEVICE ID

        PUSH    AF

        CALL    __END_WR_1_BLOCK

        JR      NC,WR_NOT_COMPLETED; COMMAND NOT COMPLETED,CHECK STATUS AGAIN

ERROR_WITH_DCB2:
        POP     IY; IS REALLY AF BUT NEED TO PRESERVE A REG IN CASE OF ERRORS

        POP     IY

        RET
;***************************************************************
;
;       __START_RD_1_BLOCK WILL SEND A READ COMMAND TO READ A BLOCK
;       OF DATA FROM A BLOCK DEVICE TO A BUFFER SPECIFIED BY REGISTER HL
;
;       INPUT:  A         DEVICE ID
;                         LOW NIBBLE  - DEVICE ADDRESS
;                         HI NIBBLE   - SECONDARY DEVICE ID
;
;               HL        DESTINATION ADDRESS IN RAM
;
;               REGISTER PAIR:
;                         BC DE       - SECTOR NUMBER ON DEVICE
;
;       THE TRANSFER BYTE COUNT IS DEFINED BY "DCB_MAX_MESS_LEN" WHICH
;       IS FOUND IN THE DEVICE DCB.
;
;       OUTPUT:
;               CONDITION BITS:
;                         Z:  NO ERRORS
;                         NZ: ERRORS OCCURED
;                             A - ERROR CODE
;
;       ALL REGISTERS ARE PRESERVED
;
;***************************************************************

;
;NO_DCB_FOUND1 CHANGED TO BLK_NO_CB_FOUND1 TO AVOID CONFLICT
;WITH IDENTICAL LABEL ELSEWHERE
;GLB    __START_RD_1_BLOCK

__START_RD_1_BLOCK:
        PUSH    BC
        PUSH    DE
        PUSH    HL
        PUSH    IY

        CALL    __FIND_DCB

        JR      NZ,B_NO_DCB_FOUND1; COULD NOT FIND DCB FOR THIS DEVICE

        CALL    CHK_IF_INACTIVE; IS DEVICE IDLE?
        JR      NZ,ACTIVE_DCB1; NOPE, GET OUT

        CALL    PREP_DCB; SET UP THE DCB FOR READ

        LD      (IY+D_COM_STAT),DCB_RD; SEND READ COMMAND

ACTIVE_DCB1:
B_NO_DCB_FOUND1:
        POP     IY
        POP     HL
        POP     DE
        POP     BC

        RET

;***************************************************************
;
;       __END_RD_1_BLOCK CHECKS THE STATUS AFTER A __START_RD_1_BLOCK
;       IS EXECUTED
;
;       INPUT:  A       DEVICE ID
;                       LOW NIBBLE - DEVICE ADDRESS
;                       HI NIBBLE  - SECONDARY DEVICE ID
;
;       OUTPUT: CONDITION FLAGS
;               C:  OPERATION COMPLETED
;               NC: OPERATION NOT COMPLETED
;               Z:  NO ERRORS
;               NZ: ERRORS
;                   A = ERROR CODE
;
;       ALL REGISTERS ARE SAVED
;
;***************************************************************

;GLB    __END_RD_1_BLOCK
;EXT    CHK_IF_IDLE

__END_RD_1_BLOCK:
        PUSH    IY

        CALL    __FIND_DCB

        SCF; SET CARRY FLAG TO INDICATE OPERATION COMPLETED

        JR      NZ,NO_DCB_FOUND5; NO DCB FOUND

        CALL    CHK_IF_IDLE; IS DEVICE IDLE?

        JR      NZ,DCB_IS_IDLE5

        OR      A; CLEAR CARRY FLAG
        BIT     CMND_COMPLETE_BIT,(IY+D_COM_STAT); WAS COMMAND COMPLETE?
        JR      Z,COMMAND_NOT_COMPLETED; NOPE,


        LD      A,(IY+D_COM_STAT); GET STATUS OF LAST OPERATION

        CP      CMND_FIN_STATUS; ANY ERRORS?
        SCF; INDICATE COMMAND COMPLETED
; CONDITION FLAGS: IF NO ERRORS:  C,Z
;                  IF ERRORS:     C,NZ  A=ERROR CODE

DCB_IS_IDLE5:
NO_DCB_FOUND5:
COMMAND_COMPLETED:
COMMAND_NOT_COMPLETED:
        POP     IY

        RET

;***************************************************************
;
;       __START_WR_1_BLOCK WILL SEND A WRITE COMMAND TO WRITE A BLOCK
;       OF DATA TO A BLOCK DEVICE FROM A LOCATION SPECIFIED BY REGISTER HL
;
;       INPUT:
;               A         DEVICE ID
;                         LOW NIBBLE  - DEVICE ADDRESS
;                         HI NIBBLE   - SECONDARY DEVICE ID
;
;               HL        SOURCE ADDRESS IN RAM
;
;               REGISTER PAIR:
;                         BC DE   - SECTOR NUMBER ON DEVICE
;
;
;       THE TRANSFER BYTE COUNT IS DEFINED BY "DCB_MAX_MESS_LEN"
;       WHICH IS FOUND IN THE DEVICE DCB
;
;       OUTPUT:
;               CONDITION BITS:
;                         Z:  NO ERRORS
;                         NZ: ERRORS OCCURED
;                             A - ERROR CODE
;
;       ALL REGISTERS ARE PRESERVED
;
;***************************************************************

;NO_DCB_FOUND3 CHANGED TO B_NO_DCB_FOUND3 TO AVOID CONFLICT WITH
;IDENTICAL LABEL ELSEWHERE

;GLB    __START_WR_1_BLOCK

__START_WR_1_BLOCK:
        PUSH    BC
        PUSH    DE
        PUSH    HL
        PUSH    IY

        CALL    __FIND_DCB

        JR      NZ,B_NO_DCB_FOUND3; NO DCB FOUND

        CALL    CHK_IF_INACTIVE; IS DEVICE ACTIVE?
        JR      NZ,ACTIVE_DCB3; NOPE, GET OUT

        CALL    PREP_DCB; SET UP DCB FOR WRITE

        LD      (IY+D_COM_STAT),DCB_WR; SEND WRITE COMMAND

B_NO_DCB_FOUND3:
ACTIVE_DCB3:
        POP     IY
        POP     HL
        POP     DE
        POP     BC

        RET

;***************************************************************
;
;       __END_WR_1_BLOCK WILL CHECK THE STATUS OF THE LAST OPERATION
;       EXECUTED
;
;       INPUT:
;               A         DEVICE ID
;                         LOW NIBBLE  - DEVICE ADDRESS
;                         HI NIBBLE   - SECONDARY DEVICE ID
;
;       OUTPUT:
;               CONDITION FLAGS
;                         C        OPERATION COMPLETED
;                         NC       OPERATION NOT COMPLETED
;                         Z        NO ERRORS
;                         NZ       ERRORS
;                                  A - ERROR CODE
;
;       ALL REGISTERS ARE PRESERVED
;
;***************************************************************

;NO_DCB_FOUND4              B_NO_DCB_FOUND4
;DCB_IS_IDLE4 CHANGED TO BLK_DCB_IS_IDLE4 TO AVOID CONFLICT WITH
;IDENTICAL LABEL ELSEWHERE

;GLB    __END_WR_1_BLOCK

__END_WR_1_BLOCK:
        PUSH    IY

        CALL    __FIND_DCB

        SCF
        JR      NZ,B_NO_DCB_FOUND4; CONDITION FLAGS: C,NZ  A=ERROR CODE

        CALL    CHK_IF_IDLE; IS DEVICE IDLE?
        JR      NZ,BLK_DCB_IS_IDLE4; YUP

        OR      A; RESET CARRY FLAG

        BIT     CMND_COMPLETE_BIT,(IY+D_COM_STAT); WAS COMMAND COMPLETE?
        JR      Z,CMND_NOT_COMPLETED; NOPE,

        LD      A,(IY+D_COM_STAT); YUP


        CP      CMND_FIN_STATUS; ANY ERRORS?
        SCF; INDICATE COMMAND COMPLETED
; CONDITION FLAGS: IF NO ERRORS:  C,Z
;                  IF ERRORS:     C,NZ, A=ERROR CODE


BLK_DCB_IS_IDLE4:
B_NO_DCB_FOUND4:
CMND_COMPLETED:
CMND_NOT_COMPLETED:
        POP     IY
        RET
;***************************************************************
;
;       PREP_DCB LOADS THE DCB BUFFER WITH THE PROPER VALUES FOR
;       A READ OR WRITE COMMAND
;
;       INPUT:
;               IY      START OF SPECIFIC DCB
;               HL      ADDRESS OF RAM DESTINATION(READ)/SOURCE(WRITE)
;
;               BC DE   DEVICE SECTOR NUMBER
;
;       OUTPUT: NONE
;
;***************************************************************

PREP_DCB:
        PUSH    AF

        SRL     A; EXTRACT SECONDARY DEVICE ID
        SRL     A
        SRL     A
        SRL     A

        LD      (IY+D_SEC_DEV_ID),A; .... AND PLACE IN DCB
        LD      A,(IY+D_MAX_MSG_LN_LO); GET BLOCK LENGTH AND PLACE ....
        LD      (IY+D_BUF_LEN_LO),A; .... IT IN BUFFER LENGTH ....
        LD      A,(IY+D_MAX_MSG_LN_HI); .... FOR READ
        LD      (IY+D_BUF_LEN_HI),A

        LD      (IY+D_SECT_NUM),E; LOAD UP A 4 BYTE SECTOR....
        LD      (IY+D_SECT_NUM+1),D; .... NUMBER FROM REGISTERS....
        LD      (IY+D_SECT_NUM+2),C; .... PAIR BC DE
        LD      (IY+D_SECT_NUM+3),B

        LD      (IY+D_BUF_ADR_LO),L; ADDRESS OF SOURCE/DESTINATION
        LD      (IY+D_BUF_ADR_HI),H; .... IN RAM

        POP     AF
        RET
;
;===============================================================
;===============================================================
;===============================================================
;


;REV 0                  (V/D  8-24-83)

;EXT    DEVICE_ID

;***************************************************************
; THIS ROUTINE WILL INITIATE A READ COMMAND ON A CHARACTER DEVICE.  THE
; ROUTINE WILL WAIT FOR THE COMMAND TO BE COMPLETED.  IF THE COMMAND
; COMPLETED WITH NO ERRORS, THEN THE FLAG WILL BE ZERO.  IF THERE
; WERE ERRORS THEN THE FLAG WILL BE NON-ZERO.
;       INPUT:  A ==>   DEVICE ID
;               DE =>   DESTINATION ADDRESS
;               BC =>   NUMBER OF BYTES TO READ
;       OUTPUT:
;               CONDITION FLAGS
;                         Z :     NO ERROR
;                         A ==>   KEY READ
;                         NZ:     ERROR OCCURED
;                         A ===>  ERROR CODE
;***************************************************************

        GLOBAL  __RD_CH_DEV
;EXT    __FIND_DCB

__RD_CH_DEV:
        LD      (DEVICE_ID),A; SAVE DEVICE ID

        CALL    __START_RD_CH_DEV
        JR      NZ,GOOD_BYE

RD_DEV_LOOP:
        LD      A,(DEVICE_ID); RESTOR THE DEVICE ID
        CALL    __END_RD_CH_DEV
        JR      NC,RD_DEV_LOOP

GOOD_BYE:
        RET

;***************************************************************
; WRITE CHAR DEV ALLOWS THE CALLER TO SEND A PRINT COMMAND BY SPECIFYING
; THE BUFFER OF THE STRING AND THE NUMBER OF BYTES TO PRINT.
;       INPUT:  A ==>   DEVICE ID
;               BC =>   NUMBER OF BYTES TO WRITE
;               HL =>   SOURCE OF DATA
;       OUTPUT:
;               CONDITION FLAGS
;                         Z :     NO ERRORS
;                         NZ:     ERROR OCCURED
;                         A ===>  ERROR CODE
;***************************************************************

        GLOBAL  __WR_CH_DEV

__WR_CH_DEV:
        LD      (DEVICE_ID),A

        CALL    __START_WR_CH_DEV
        JR      NZ,SO_LONG

DCB_WRITE_LOOP:
        LD      A,(DEVICE_ID); RESTORE THE ID FOR USE IN THE CALL
        CALL    __END_WR_CH_DEV
        JR      NC,DCB_WRITE_LOOP

SO_LONG:
        RET


;***************************************************************
; THIS ROUTINE IS RESPONSIBLE FOR SETTING UP A DEVICE DCB TO DO A READ.
; THE LAST THING DONE IN THIS ROUTINE IS TO ISSUE THE COMMAND TO READ
; A KEY FROM THE KEYBOARD.
;       INPUT:  A  ===> CONTAINS THE DEVICE ID
;               DE ===> DESTINATION ADDRESS
;               BC ===> NUMBER OF BYTES TO READ
;       OUTPUT: CONDITION FLAGS
;               Z:      THE READ DATA FROM KEYBOARD COMMAND HAS BEEN SENT
;               NZ:     ERROR OCCURED
;                       A ===>  ERROR CODE
;***************************************************************

;GLB    __START_RD_CH_DEV
;EXT    CHK_IF_INACTIVE

__START_RD_CH_DEV:
        PUSH    IY
        CALL    __FIND_DCB; FIND THE DCB

        JR      NZ,NO_DCB_DEFINED

        CALL    CHK_IF_INACTIVE; SEE IF THE KEY BOARD IS AVAILABLE

        JR      NZ,DCB_IS_ACTIVE; DCB IS CURRENTLY ACTIVE

        LD      (IY+D_BUF_ADR_LO),E; LOAD THE DESTINATION ADDRESS INTO DCB
        LD      (IY+D_BUF_ADR_HI),D

        LD      (IY+D_BUF_LEN_LO),C; LOAD THE BYTE COUNT
        LD      (IY+D_BUF_LEN_HI),B

        LD      (IY+D_COM_STAT),DCB_RD; INITIATE THE COMMAND TO READ
; ZERO FLAG WAS SET ABOVE

DCB_IS_ACTIVE:; NZ IS ALREADY THE CONDITION OF THE FLAG
NO_DCB_DEFINED:; A CONTAINS THE ERROR CODE
        POP     IY

        RET

;***************************************************************
; THIS ROUTINE WILL CHECK THE DEVICES DCB COM/STATUS BYTE AND RETURN
; THE RESULT OF THE CHECK.
;       INPUT:  A ===> DEVICE ID
;       OUTPUT: CONDITION FLAGS
;               C       COMMAND HAS FINISHED
;               NC      COMMAND HAS NOT BEEN PROCESSED
;               Z :     NO ERROR OCCURED
;               NZ:     ERROR OCCURED
;                       A ===>  ERROR CODE

;***************************************************************

;GLB    __END_RD_CH_DEV
;EXT    CHK_IF_IDLE

__END_RD_CH_DEV:
        PUSH    IY
        CALL    __FIND_DCB
        SCF

        JR      NZ,NO_DCB; THERE WAS NO KEYBOARD DCB

        CALL    CHK_IF_IDLE; IS DEVICE IDL?
        JR      NZ,DCB_IS_IDL; YUP

        OR      A; CLEAR THE CARRY FLAG
        BIT     CMND_COMPLETE_BIT,(IY+D_COM_STAT); WAS THE COMMAND PROCESSED?
        JR      Z,ROUTINE_FINISHED; NO, RETURN WITH THE CARRY FLAG CLEARED
; YES, THE COMMAND WAS PROCESSED
        LD      A,(IY+D_COM_STAT); DID ANY ERRORS OCCUR?
        CP      CMND_FIN_STATUS
        SCF
; NO ERROR, SET THE CARRY FLAG, ZERO FLAG CONDITION
DCB_IS_IDL:
NO_DCB:
ROUTINE_FINISHED:
        POP     IY

        RET

;***************************************************************
; __START_WR_CH_DEV ALLOWS THE CALLER TO SEND A PRINT COMMAND BY SPECIFYING
; THE BUFFER OF THE STRING AND THE NUMBER OF BYTES TO PRINT.
;       INPUT:  A ==>   DEVICE ID
;               BC =>   NUMBER OF BYTES TO WRITE
;               HL =>   SOURCE OF DATA
;       OUTPUT:
;               CONDITION FLAGS
;                         Z :     NO ERRORS
;                         NZ:     ERROR OCCURED
;                         A ===>  ERROR CODE
;***************************************************************

;NO_DCB_FND3 CHANGED TO C_NO_DCB_FND3 TO AVOID CONFLICT WITH
;IDENTICAL LABEL ELSEWHERE

;GLOBAL __START_WR_CH_DEV

__START_WR_CH_DEV:
        PUSH    IY
        CALL    __FIND_DCB; FIND THE CORRECT DEVICE DCB

        JR      NZ,C_NO_DCB_FND3

        CALL    CHK_IF_INACTIVE; IS DCB ACTIVE?
        JR      NZ,DCB_IS_ACTIVE3; YUP

        LD      (IY+D_BUF_LEN_LO),C; LENGTH OF THE BUFFER
        LD      (IY+D_BUF_LEN_HI),B

        LD      (IY+D_BUF_ADR_LO),L; ADDRESS OF THE STRING
        LD      (IY+D_BUF_ADR_HI),H

        LD      (IY+D_COM_STAT),DCB_WR; INITIATE THE WRITE DATA COMMAND

C_NO_DCB_FND3:
DCB_IS_ACTIVE3:
        POP     IY
        RET
;***************************************************************
; __END_WR_CH_DEV WILL CHECK THE DEVICES DCB COM/STATUS BYTE AND RETURN
; THE RESULT OF THE CHECK.
;       INPUT:  A ===> DEVICE ID
;       OUTPUT: CONDITION FLAGS
;               C :     COMMAND HAS FINISHED
;               NC:     COMMAND HAS NOT BEEN PROCESSED
;               Z :     NO ERROR OCCURED
;               NZ:     ERROR OCCURED
;                       A ===>  ERROR CODE

;***************************************************************

;NO_DCB_FND4              C_NO_DCB_FND4
;DCB_IS_IDL4 CHANGED TO CHAR_DCB_IS_IDL4 TO AVOID CONFLICT WITH
;IDENTICAL LABEL ELSEWHERE

;GLB    __END_WR_CH_DEV

__END_WR_CH_DEV:
        PUSH    IY

        CALL    __FIND_DCB
        SCF

        JR      NZ,C_NO_DCB_FND4; THERE WAS NO PRINTER DCB

        CALL    CHK_IF_IDLE; IS DEVICE IDL?
        JR      NZ,CHAR_DCB_IS_IDL4

        OR      A; CLEAR THE CARRY FLAG
        BIT     CMND_COMPLETE_BIT,(IY+D_COM_STAT); WAS THE COMMAND PROCESSED?
        JR      Z,NOT_COMPLETED; NO, RETURN WITH THE CARRY FLAG CLEARED
; YES, THE COMMAND WAS PROCESSED
        LD      A,(IY+D_COM_STAT); DID ANY ERRORS OCCUR?
        CP      CMND_FIN_STATUS
        SCF
; NO ERROR, SET THE CARRY FLAG, ZERO FLAG CONDITION
CHAR_DCB_IS_IDL4:
C_NO_DCB_FND4:
NOT_COMPLETED:
        POP     IY
        RET
;
;===============================================================
;===============================================================
;===============================================================
;

; ==================================================================
; END PRESERVED COLECO LISTING TEXT
; ==================================================================
; MODERN RECONSTRUCTION AND BUILD NOTES
; ==================================================================
; This .asm is a generated preservation artifact, not the canonical
; hand-edited input. Maintained inputs are EOS_REBUILD/all_lines.txt
; plus the anchored correction rules in build_clean_z88_source.py.
; Every semantic correction is marked [RECON] beside its source line
; and documented in EOS_6_ASSEMBLEABLE_SOURCE_REPORT.md.
;
; Named sections retain the historical listing's block order. z80asm
; emits one binary per section; the build script places those sections
; at their declared ORG addresses in the 8192-byte $E000-$FFFF bank.
; U22 physical bytes $2000-$3FFF are the separate alternate boot bank
; and are not present in the OCR EOS listing.  The build script preserves
; that bank from the reference ROM when constructing the complete U22.
;
; Original MAME ROM member: eos 6 rev 57 08dd.u22
; Original MAME 16K ROM MD5: cf10b154f2e006a9740d7653cfc47cab
; Assembled 8K EOS bank MD5: 01df3140909f09aa9aac4f88890f676c
;
; Recommended build from the workspace root (PowerShell):
;   .\build_eos_assembleable_source.ps1
;
; Direct assembler command (section files; build script packages them):
;   & 'C:\z88dk\bin\z80asm.exe' -b -split-bin -f255 -l -m -s '-oeos.bin' '.\EOS_6_ASSEMBLEABLE_SOURCE.asm'
;
; The build script verifies the EOS bank, appends the untouched alternate
; bank, writes EOS_6_ASSEMBLEABLE_SOURCE.u22, and verifies the full MD5.
; Required reference filename: rom_reference\eos 6 rev 57 08dd.u22
; Required reference MD5: cf10b154f2e006a9740d7653cfc47cab
