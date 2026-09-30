from __future__ import annotations

import json
import re
from dataclasses import dataclass
from pathlib import Path


ROOT = Path(__file__).resolve().parent
INPUT = ROOT / "all_lines.txt"
ASM_OUT = ROOT / "eos6_clean_z88.asm"
BUILD_OUT = ROOT / "build_eos6_clean_z88.ps1"
CANONICAL_ASM_OUT = ROOT.parent / "EOS_6_ASSEMBLEABLE_SOURCE.asm"
CANONICAL_BUILD_OUT = ROOT.parent / "build_eos_assembleable_source.ps1"
REPORT_OUT = ROOT.parent / "EOS_6_ASSEMBLEABLE_SOURCE_REPORT.md"
EXPECTED_SYMBOLS_OUT = ROOT.parent / "EOS_6_EXPECTED_SYMBOLS.json"
EXPECTED_SYMBOLS_SOURCES_OUT = ROOT.parent / "EOS_6_EXPECTED_SYMBOLS_SOURCES.md"
REGENERATE_OUT = ROOT.parent / "regenerate_eos_assembleable_source.ps1"


LINE_RE = re.compile(r"^\s*(\d+)\s?(.*)$")

Z80_OPS = {
    "ADC", "ADD", "AND", "BIT", "CALL", "CCF", "CP", "CPD", "CPDR", "CPI", "CPIR",
    "CPL", "DAA", "DEC", "DI", "DJNZ", "EI", "EX", "EXX", "HALT", "IM", "IN",
    "INC", "IND", "INDR", "INI", "INIR", "JP", "JR", "LD", "LDD", "LDDR", "LDI",
    "LDIR", "NEG", "NOP", "OR", "OTDR", "OTIR", "OUT", "OUTD", "OUTI", "POP",
    "PUSH", "RES", "RET", "RETI", "RETN", "RL", "RLA", "RLC", "RLCA", "RLD",
    "RR", "RRA", "RRC", "RRCA", "RRD", "RST", "SBC", "SCF", "SET", "SLA",
    "SLL", "SRA", "SRL", "SUB", "XOR",
}

DIRECTIVES = {
    "ORG", "EQU", "DEFL", "DEFB", "DEFW", "DEFM", "DEFS", "DEFC", "PUBLIC",
    "EXTERN", "GLOBAL", "IF", "ELSE", "ENDIF", "SECTION", "BINARY", "INCLUDE",
    "END",
}

EARLY_EQUATES = {
    "MODE_REMAINDER_BIT": "5",
    "MODE_DIRTY_BIT": "6",
    "MODE_LAST_BLOCK_BIT": "7",
    "ATTR_DEL_BIT": "2",
    "ATTR_HOLE_BIT": "0",
    "CMND_COMPLETE_BIT": "7",
}


@dataclass(frozen=True)
class AnchorEdit:
    anchor: int
    old: str
    new: str
    note: str
    comment_out: bool = False


# Semantic/source-identity repairs are deliberately keyed to the surviving
# listing's source-line anchors. Each rule must match exactly once. This keeps
# regeneration from silently applying a plausible replacement in the wrong
# routine when the input changes.
ANCHOR_EDITS = (
    AnchorEdit(98, "0F8FFH", "0FBFFH", "OCR 98: scan value column is <FBFF>."),
    AnchorEdit(200, "[VERIFY]", "", "Resolved: sequential public entry and ROM bytes place _START_RD_CH_DEV at $FCA5."),
    AnchorEdit(320, "MSNTOILSN", "MSNTOLSN", "OCR 320: scan spells MSNTOLSN."),
    AnchorEdit(321, "__MSNTOILSN", "__MSNTOLSN", "OCR 321: scan spells __MSNTOLSN."),
    AnchorEdit(361, "[VERIFY: likely MEM_CNFG00?]", "", "Resolved: historical spelling is MEM_CNFGOO (two letter O characters); kept commented."),
    AnchorEdit(362, "[VERIFY: likely MEM_CNFG00?]", "", "Resolved: historical spelling is MEM_CNFGOO (two letter O characters); kept commented."),
    AnchorEdit(364, "[VERIFY: likely MEM_CNFG00?]", "", "Resolved: SWITCH_TABLE aliases MEM_CNFGOO; kept commented because active definitions follow at OCR 768-771."),
    AnchorEdit(385, "MEM_CNFGO8       [VERIFY: likely MEM_CNFGOB / MEM_CNFG0B]", "MEM_CNFGOB", "Resolved from active OCR 803 and ROM address $FC22; kept commented."),
    AnchorEdit(386, "MEM_CNFGO8               EQU     $+35             [VERIFY: likely MEM_CNFGOB / MEM_CNFG0B]", "MEM_CNFGOB               EQU     $+35", "Resolved from active OCR 803 and ROM address $FC22; kept commented."),
    AnchorEdit(613, "SAVED_COUNT    DEFS    2", "SAVED_COUNT    DEFS    2", "OCR 613 is commented in the scan; revision 6 removed it.", True),
    AnchorEdit(848, "08FH", "0BFH", "OCR 848: scan opcode/data column is BF."),
    AnchorEdit(1088, "RD_IP_STAT_ERR", "RQ_TP_STAT_ERR", "OCR 1088: restore printed symbol RQ_TP_STAT_ERR."),
    AnchorEdit(1207, "80H", "86H", "OCR 1207: scan value column is <0086>."),
    AnchorEdit(1854, "LD      BC,(DEL-00H+1)", "LD      BC,DEL-00H+1", "Assembler dialect: parentheses are arithmetic grouping in the HP source."),
    AnchorEdit(1981, "(01148H)", "(0114BH)", "OCR 1981: scan bytes are 3A 4B 11."),
    AnchorEdit(2238, "LD      D,A                         ;save raw data seg_1", "LD      A,L                         ;restore raw data segment 1", "OCR 2238: scan bytes are 7D and mnemonic is LD A,L."),
    AnchorEdit(2998, "SOUNDS", "__SOUNDS", "OCR 902/2998: exported implementation label restored."),
    AnchorEdit(3277, "0FH", "0F0H", "OCR 3277: scan bytes are DD 36 04 F0."),
    AnchorEdit(3294, "RET", "RET", "OCR 3294 is a commented historical instruction, not executable code.", True),
    AnchorEdit(3513, "FOUND_AVAIL_ENTRY", "FOUND_AVAIL_ENT", "Identifier repair: active OCR definition at 549 is FOUND_AVAIL_ENT."),
    AnchorEdit(3717, "FOUND_AVAIL_ENTRY", "FOUND_AVAIL_ENT", "Identifier repair: operand bytes address FOUND_AVAIL_ENT at $FDDB."),
    AnchorEdit(3804, "FOUND_AVAIL_ENTRY", "FOUND_AVAIL_ENT", "Identifier repair: operand bytes address FOUND_AVAIL_ENT at $FDDB."),
    AnchorEdit(3866, "FOUND_AVAIL_ENTRY", "FOUND_AVAIL_ENT", "Identifier repair: operand bytes address FOUND_AVAIL_ENT at $FDDB."),
    AnchorEdit(3875, "FOUND_AVAIL_ENTRY", "FOUND_AVAIL_ENT", "Identifier repair: operand bytes address FOUND_AVAIL_ENT at $FDDB."),
    AnchorEdit(5676, "MODE_CHECK:", "__MODE_CHECK:", "OCR 5675-5676 prints two coincident labels; exported implementation label restored."),
    AnchorEdit(5778, "LD      A,RENAME_ERR", "LD      A,RENAME_ERR", "OCR 5778 is commented; production preserves the error already in A.", True),
    AnchorEdit(5908, "RETRY_FOR_ERROR", "RETRY_FOR_ERRORS", "Identifier repair: branch targets printed label RETRY_FOR_ERRORS at OCR 5899."),
    AnchorEdit(5910, "RETRY_FOR_ERROR", "RETRY_FOR_ERRORS", "Identifier repair: branch targets printed label RETRY_FOR_ERRORS at OCR 5899."),
    AnchorEdit(5944, "_2ND_READ_ERROR", "RETRY_LIMIT_REACHED", "Uncertain listing/ROM discrepancy: bytes 28 03 target local cleanup at $F1D6."),
    AnchorEdit(6348, "DIR_ENT_LENGTH+3+VOL_DES_LENGTH", "DIR_ENT_LENGTH*3+VOL_DES_LENGTH", "OCR 6348: scan bytes are 01 68 00."),
    AnchorEdit(6392, "VOL_DES_LENGTH+DIR_ENT_LENGTH+2", "VOL_DES_LENGTH+DIR_ENT_LENGTH*2", "OCR 6392: scan bytes are 11 4E 00."),
    AnchorEdit(6505, "ATTR_SYS", "ATTR_SYSTEM", "Identifier repair: OCR definition at 1051 is ATTR_SYSTEM."),
    AnchorEdit(7162, "PRTR_DCB_ACTIVE1", "PRTR_DCB_ACTIVE", "Identifier repair: scan's trailing mark is not part of the label."),
    AnchorEdit(7363, "1BH", "18H", "OCR 7363: scan value column is <0018>."),
    AnchorEdit(7371, 'EQU     "-"', "EQU     020H", "OCR 7371: scan value column is <0020> (space)."),
    AnchorEdit(7510, "CALL    ERASE_THIS_LINE", "CALL    ERASE_THIS_LINE", "OCR 7510 is commented in the scan.", True),
    AnchorEdit(7838, "LINEBUFFER", "LINEBUFFER_", "Identifier repair: scan operand and active RAM symbol include the trailing underscore."),
    AnchorEdit(8111, "MEM_CNFG01", "MEM_CNFGO1", "Identifier repair: restore letter-O configuration-table symbol."),
    AnchorEdit(8112, "MEM_CNFG03", "MEM_CNFGO3", "Identifier repair: restore letter-O configuration-table symbol."),
    AnchorEdit(8130, "_EOS_START:", "__EOS_START:", "OCR 8129 exports __EOS_START; scan loses underscores in the label image."),
    AnchorEdit(8152, "MEM_CNFG01", "MEM_CNFGO1", "Identifier repair: restore letter-O configuration-table symbol."),
    AnchorEdit(8158, "CALL    _HARD_INIT", "CALL    __HARD_INIT", "OCR 8158 bytes CD F6 F8 call the implementation directly."),
    AnchorEdit(8164, "CALL    _FMGR_INIT", "CALL    __FMGR_INIT", "OCR 8164 bytes CD EA EE call the implementation directly."),
    AnchorEdit(8173, "CALL    _REQUEST_STATUS", "CALL    __REQUEST_STATUS", "OCR 8173 bytes CD 73 F4 call the implementation directly."),
    AnchorEdit(8177, "CALL    _FIND_DCB", "CALL    __FIND_DCB", "OCR 8177 bytes CD 46 F4 call the implementation directly."),
    AnchorEdit(8185, "CALL    _REQUEST_STATUS", "CALL    __REQUEST_STATUS", "OCR 8185 bytes CD 73 F4 call the implementation directly."),
    AnchorEdit(8189, "CALL    _FIND_DCB", "CALL    __FIND_DCB", "OCR 8189 bytes CD 46 F4 call the implementation directly."),
    AnchorEdit(8197, "CALL    _REQUEST_STATUS", "CALL    __REQUEST_STATUS", "OCR 8197 bytes CD 73 F4 call the implementation directly."),
    AnchorEdit(8201, "CALL    _FIND_DCB", "CALL    __FIND_DCB", "OCR 8201 bytes CD 46 F4 call the implementation directly."),
    AnchorEdit(8218, "LD      A,(MEM_CNFG03)", "LD      A,(MEM_CNFGO3)", "OCR 8218 is commented in the scan.", True),
    AnchorEdit(8219, "CALL    SWITCH_MEM", "CALL    SWITCH_MEM", "OCR 8219 is commented in the scan.", True),
    AnchorEdit(8231, "CALL    _RD_1_BLOCK", "CALL    __RD_1_BLOCK", "OCR 8231 bytes CD 9E FA call the implementation directly."),
    AnchorEdit(8293, "LD      BC,P_SIZE+(15*D_SIZE)-1", "LD      BC,P_SIZE+(15*D_SIZE)-1", "OCR 8293 is commented; OCR 8294 is the active full-size clear.", True),
)


INJECTIONS_BEFORE = {
    2349: ("NOT_CONTROLLER_0:", "OCR address flow places the missing branch label at $E27E."),
}

INJECTIONS_AFTER = {
    2208: ("        DI", "OCR address gap at 2209 and ROM byte F3 restore DI at $E20A."),
    2403: ("        LD      (IX+0),A", "OCR address gap at 2404 and ROM bytes DD 77 00 restore the store at $E29A."),
    5676: ("MODE_CHECK:", "Preserved coincident historical local label from OCR 5675-5676."),
}


JUMP_ENTRIES = """
_EOS_START _CONS_DISP _CONS_INIT _CONS_OUT _DLY_AFT_HRD_RES
_END_PR_BUFF _END_PR_CH _END_RD_1_BLOCK _END_RD_CH_DEV _END_RD_KBD
_END_WR_1_BLOCK _END_WR_CH_DEV _FIND_DCB _GET_DCB_ADDR _GET_PCB_ADDR
_HARD_INIT _HARD_RESET_NET _PR_BUFF _PR_CH _RD_1_BLOCK _RD_KBD
_RD_KBD_RET_CODE _RD_PR_RET_CODE _RD_RET_CODE _RD_TAPE_RET_CODE
_RELOC_PCB _REQUEST_STATUS _REQ_KBD_STAT _REQ_PR_STAT _REQ_TAPE_STAT
_SCAN_ACTIVE _SOFT_INIT _SOFT_RES_DEV _SOFT_RES_KBD _SOFT_RES_PR
_SOFT_RES_TAPE _START_PR_BUFF _START_PR_CH _START_RD_1_BLOCK
_START_RD_CH_DEV _START_RD_KBD _START_WR_1_BLOCK _START_WR_CH_DEV
_SYNC _WR_1_BLOCK _WR_CH_DEV _FMGR_INIT _INIT_TAPE_DIR _OPEN_FILE
_CLOSE_FILE _RESET_FILE _MAKE_FILE _QUERY_FILE _SET_FILE _READ_FILE
_WRITE_FILE _SET_DATE _GET_DATE _RENAME_FILE _DELETE_FILE
_RD_DEV_DEP_STAT _GOTO_WP _READ_EOS _TRIM_FILE _CHECK_FCB _READ_BLOCK
_WRITE_BLOCK _MODE_CHECK _SCAN_FOR_FILE _FILE_QUERY _POSIT_FILE _EOS_1
_EOS_2 _EOS_3 _CV_A PORT_COLLECTION SWITCH_MEM PUT_ASCII WRITE_VRAM
READ_VRAM WRITE_REGISTER READ_REGISTER FILL_VRAM INIT_TABLE PUT_VRAM
GET_VRAM CALC_OFFSET PX_TO_PTRN_POS LOAD_ASCII WR_SPR_ATTRIBUTE POLLER
UPDATE_SPINNER DECLSN DECMSN MSNTOLSN ADD816 SOUND_INIT TURN_OFF_SOUND
PLAY_IT SOUNDS EFFECT_OVER
""".split()


RAM_EXPECTED = {
    "CLEAR_RAM_START": 0xFD60,
    "REV_NUM": 0xFD60,
    "VDP_MODE_WORD": 0xFD61,
    "VDP_STATUS_BYTE": 0xFD63,
    "VRAM_ADDR_TABLE": 0xFD64,
    "SPRITEATTRTBL": 0xFD64,
    "SPRITEGENTBL": 0xFD66,
    "PATTRNNAMETBL": 0xFD68,
    "PATTRNGENTBL": 0xFD6A,
    "COLORTABLE": 0xFD6C,
    "CUR_BANK": 0xFD6E,
    "DEFAULT_BT_DEV": 0xFD6F,
    "CURRENT_DEV": 0xFD6F,
    "CURRENT_PCB": 0xFD70,
    "DEVICE_ID": 0xFD72,
    "FILE_NAME_ADDR": 0xFD73,
    "KEYBOARD_BUFFER": 0xFD75,
    "PRINT_BUFFER": 0xFD76,
    "SECTORS_TO_INIT": 0xFD86,
    "SECTOR_NO": 0xFD87,
    "DCB_IMAGE": 0xFD8B,
    "QUERY_BUFFER": 0xFDA0,
    "FCB_BUFFER": 0xFDBA,
    "FILE_COUNT": 0xFDD4,
    "MOD_FILE_COUNT": 0xFDD5,
    "RETRY_COUNT": 0xFDD6,
    "FILE_NUMBR": 0xFDD7,
    "FILENAME_CMPS": 0xFDD8,
    "DIR_BLOCK_NO": 0xFDD9,
    "FOUND_AVAIL_ENT": 0xFDDB,
    "BLK_STRT_PTR": 0xFDDC,
    "VOL_BLK_SZ": 0xFDDC,
    "EOS_YEAR": 0xFDE0,
    "EOS_MONTH": 0xFDE1,
    "EOS_DAY": 0xFDE2,
    "FMGR_DIR_ENT": 0xFDE3,
    "FCB_HEAD_ADDR": 0xFDFD,
    "FCB_DATA_ADDR": 0xFDFF,
    "FNUM": 0xFE01,
    "BYTES_REQ": 0xFE02,
    "BYTES_TO_GO": 0xFE04,
    "USER_BUF": 0xFE06,
    "BUF_START": 0xFE08,
    "BUF_END": 0xFE0A,
    "BLOCKS_REQ": 0xFE0C,
    "USER_NAME": 0xFE10,
    "START_BLOCK": 0xFE12,
    "NEW_HOLE_START": 0xFE16,
    "NEW_HOLE_SIZE": 0xFE1A,
    "STACK_START": 0xFE1C,
    "EOS_STACK": 0xFE58,
    "SPIN_SW0_CT": 0xFE58,
    "SPIN_SW1_CT": 0xFE59,
    "PERSONAL_DEBOUNCE_TABLE": 0xFE5A,
    "TEMP_STACK": 0xFE6E,
    "PTR_TO_LST_OF_SND_ADDRS": 0xFE6E,
    "PTR_TO_S_ON_0": 0xFE70,
    "PTR_TO_S_ON_1": 0xFE72,
    "PTR_TO_S_ON_2": 0xFE74,
    "PTR_TO_S_ON_3": 0xFE76,
    "SAVE_CTRL": 0xFE78,
    "OLDCHAR_": 0xFE79,
    "X_MIN": 0xFE7A,
    "X_MAX": 0xFE7B,
    "Y_MIN": 0xFE7C,
    "Y_MAX": 0xFE7D,
    "LINEBUFFER_": 0xFE7E,
    "NUM_LINES": 0xFE9F,
    "NUM_COLUMNS": 0xFEA0,
    "UPPER_LEFT": 0xFEA1,
    "PTRN_NAME_TBL": 0xFEA3,
    "CURSOR": 0xFEA5,
    "PCB": 0xFEC0,
    "DCBS": 0xFEC4,
    "RESERVED_BYTE": 0xFFFF,
}


TABLE_EXPECTED = {
    "SWITCH_TABLE": 0xFC17,
    "MEM_CNFGOO": 0xFC17,
    "MEM_CNFGO1": 0xFC18,
    "MEM_CNFGO2": 0xFC19,
    "MEM_CNFGO3": 0xFC1A,
    "MEM_CNFGO4": 0xFC1B,
    "MEM_CNFGO5": 0xFC1C,
    "MEM_CNFGO6": 0xFC1D,
    "MEM_CNFGO7": 0xFC1E,
    "MEM_CNFGO8": 0xFC1F,
    "MEM_CNFGO9": 0xFC20,
    "MEM_CNFGOA": 0xFC21,
    "MEM_CNFGOB": 0xFC22,
    "MEM_CNFGOC": 0xFC23,
    "MEM_CNFGOD": 0xFC24,
    "MEM_CNFGOE": 0xFC25,
    "MEM_CNFGOF": 0xFC26,
}


def split_anchor(line: str) -> tuple[int, str] | None:
    m = LINE_RE.match(line.rstrip("\n"))
    if not m:
        return None
    return int(m.group(1)), m.group(2).rstrip()


def annotate(line: str, note: str) -> str:
    return f"{line.rstrip()} ; [RECON] {note}"


def normalize_expr(line: str) -> str:
    code, sep, comment = line.partition(";")
    # z88dk-z80asm understands C-like expression operators reliably.
    code = re.sub(r"\.OR\.", " | ", code, flags=re.IGNORECASE)
    code = re.sub(r"\.AND\.", " & ", code, flags=re.IGNORECASE)
    code = re.sub(r"\.NOT\.", " ~ ", code, flags=re.IGNORECASE)
    code = re.sub(r"\.NT\.", "!", code, flags=re.IGNORECASE)

    # Plain " OR " appears in a few data expressions. Do not touch the OR
    # instruction itself; only rewrite obvious directive/equate expressions.
    if re.search(r"\b(EQU|DEFL|DEFB|DEFW)\b", code, flags=re.IGNORECASE):
        code = re.sub(r"\s+OR\s+", " | ", code)
        code = re.sub(r"\s+AND\s+", " & ", code)
    code = re.sub(r"\[([A-Za-z0-9_+$]+)\]", r"(\1)", code)
    return code.rstrip() + (sep + comment if sep else "")


def normalize_directives(line: str) -> str:
    stripped = line.strip()
    m = re.match(r"^:([A-Za-z_][A-Za-z0-9_]*)\s*:\s*$", stripped)
    if m:
        return f"{m.group(1)}:"
    m = re.match(r"^:([A-Za-z_][A-Za-z0-9_]*)\s*:\s*(.+)$", stripped)
    if m:
        return f"{m.group(1)}: {m.group(2)}"
    m = re.match(r"^:([A-Za-z_][A-Za-z0-9_]*)\s+EQU\s+(.+)$", stripped, flags=re.IGNORECASE)
    if m:
        return f"{m.group(1)} EQU {m.group(2)}"
    m = re.match(r"^;:([A-Za-z_][A-Za-z0-9_]*)\s*:\s*$", stripped)
    if m:
        return f"{m.group(1)}:"
    m = re.match(r"^;:([A-Za-z_][A-Za-z0-9_]*)\s*:\s*(.+)$", stripped)
    if m:
        return f"{m.group(1)}: {m.group(2)}"
    m = re.match(r"^;:([A-Za-z_][A-Za-z0-9_]*)\s+EQU\s+(.+)$", stripped, flags=re.IGNORECASE)
    if m:
        return f"{m.group(1)} EQU {m.group(2)}"
    if stripped.startswith(":"):
        return ";" + line
    if re.match(r"^GLB\b", stripped, flags=re.IGNORECASE):
        return ";" + line
    if re.match(r"^EXT\b", stripped, flags=re.IGNORECASE):
        return ";" + line
    return line


def normalize_data_strings(line: str) -> str:
    stripped = line.strip()
    if stripped == "DEFB    '":
        return re.sub(r"DEFB\s+'", 'DEFB    "            "', line)
    line = line.replace("DEFB    'BOOT',ETX,'", 'DEFB    "BOOT",ETX,"       "')
    line = line.replace("DEFB    'DIRECTORY',ETX,'  '", 'DEFB    "DIRECTORY",ETX,"  "')
    line = line.replace("DEFB    'BLOCKS LEFT',ETX", 'DEFB    "BLOCKS LEFT",ETX')
    line = line.replace('EQU     "_"', "EQU     05FH")
    return line


def first_token(line: str) -> str:
    stripped = line.lstrip()
    if not stripped:
        return ""
    return re.split(r"\s+", stripped, maxsplit=1)[0].rstrip(":").upper()


def labelize(line: str) -> str:
    """Convert HP-style bare labels to z88dk-z80asm labels.

    z80asm accepts "LABEL: OP ..." consistently. It rejects many of the old
    listing forms such as "LABEL DEFS 1" and bare "LABEL" lines.
    """
    code, sep, comment = line.partition(";")
    if not code.strip():
        return line
    if code.lstrip() != code:
        return line
    if code.rstrip().endswith(":"):
        return line

    parts = re.split(r"\s+", code.strip(), maxsplit=1)
    tok = parts[0].upper()
    if tok in Z80_OPS or tok in DIRECTIVES:
        return line

    if len(parts) == 1:
        return parts[0] + ":" + (sep + comment if sep else "")

    rest = parts[1]
    rest_tok = rest.strip().split(None, 1)[0].upper() if rest.strip() else ""
    if rest_tok == "EQU":
        return line
    return f"{parts[0]}: {rest.rstrip()}".replace("::", ":") + (sep + comment if sep else "")


def sectionize_org_blocks(lines: list[str]) -> list[str]:
    org_re = re.compile(r"^\s*ORG\s+([A-Za-z0-9_$]+)\s*$", flags=re.IGNORECASE)
    section_names = {
        "EOS_JMP_TBL": "jump_table",
        "EOS_GLB_RAM": "global_ram",
        "EOS_PCB_DCB": "pcb_dcb",
        "EOS_GLB_TBL": "global_table",
        "EOS_CODE": "code",
    }
    out: list[str] = []
    seen: set[str] = set()
    for line in lines:
        match = org_re.match(line)
        if not match:
            out.append(line)
            continue
        org = match.group(1).upper()
        if org not in section_names:
            raise RuntimeError(f"Unexpected active ORG: {line!r}")
        if org in seen:
            raise RuntimeError(f"Duplicate active ORG for {org}")
        seen.add(org)
        out.append(f"; [RECON assembler] Named section preserves OCR block order for z80asm.")
        out.append(f"        SECTION {section_names[org]}")
        out.append(line)
    if seen != set(section_names):
        raise RuntimeError(f"Active ORG set changed: found {sorted(seen)}")
    return out


def is_name_or_skip(line: str) -> bool:
    return bool(re.match(r"^\s*(NAME\b|SKIP\b)", line, flags=re.IGNORECASE))


def main() -> None:
    raw = INPUT.read_text(encoding="utf-8", errors="replace").splitlines()
    header: list[str] = [
        "; ==================================================================",
        "; MODERN RECONSTRUCTION HEADER (not historical Coleco source text)",
        "; ==================================================================",
        "; Coleco ADAM EOS 6 reconstructed z88dk-z80asm source.",
        "; Generated deterministically from EOS_REBUILD/all_lines.txt by",
        "; EOS_REBUILD/build_clean_z88_source.py. Do not hand-edit this file.",
        "; The raw scan transcription EOS_6_ABSOLUTE_LISTING_OCR.txt is the",
        "; authority for source structure, labels, comments, and intent. The",
        "; production U22 ROM is the byte oracle. This is not a ROM-byte dump.",
        "; OCR source-line anchors are retained in the generator and correction",
        "; report, rather than repeated in this readable assembly file.",
        "; ==================================================================",
        "",
    ]
    for name, value in EARLY_EQUATES.items():
        header.append(f"{name} EQU {value} ; [RECON assembler] forward bit equate for z80asm")
    header.append("")
    header.append("; ==================================================================")
    header.append("; BEGIN PRESERVED COLECO LISTING TEXT")
    header.append("; ==================================================================")
    out: list[str] = []

    in_cleaned_listing = False
    suppress_doc_macro = False
    suppress_until_org = False
    awaiting_retry_limit_label = False
    edits_by_anchor = {edit.anchor: edit for edit in ANCHOR_EDITS}
    applied_edits: set[int] = set()
    applied_before: set[int] = set()
    applied_after: set[int] = set()
    early_equate_duplicates: set[str] = set()

    for raw_line in raw:
        if raw_line.strip() == "===== CLEANED LISTING SO FAR =====":
            in_cleaned_listing = True
            continue
        if not in_cleaned_listing:
            continue

        parsed = split_anchor(raw_line)
        if parsed is None:
            continue
        anchor, line = parsed

        stripped = line.strip()
        if not stripped:
            out.append("")
            continue

        if anchor in INJECTIONS_BEFORE:
            injected, note = INJECTIONS_BEFORE[anchor]
            out.append(annotate(injected, note))
            applied_before.add(anchor)

        edit = edits_by_anchor.get(anchor)
        if edit is not None:
            if edit.old not in line:
                raise RuntimeError(
                    f"OCR anchor {anchor}: expected {edit.old!r} in {line!r}"
                )
            if anchor in applied_edits:
                raise RuntimeError(f"OCR anchor {anchor}: correction matched more than once")
            line = line.replace(edit.old, edit.new, 1)
            if edit.comment_out:
                line = "; " + line
            line = annotate(line, edit.note)
            applied_edits.add(anchor)
            stripped = line.strip()
            if anchor == 5944:
                awaiting_retry_limit_label = True

        if any(re.match(rf"^{name}\s+EQU\b", stripped, flags=re.IGNORECASE) for name in EARLY_EQUATES):
            name = next(name for name in EARLY_EQUATES if re.match(rf"^{name}\s+EQU\b", stripped, flags=re.IGNORECASE))
            out.append(annotate("; duplicate historical definition: " + line, "Assembler dialect: active copy emitted in modern header."))
            early_equate_duplicates.add(name)
            continue

        if is_name_or_skip(line):
            out.append("; " + line)
            continue

        if re.search(r"\bMACRO\b", line, flags=re.IGNORECASE):
            out.append("; " + line)
            suppress_doc_macro = True
            suppress_until_org = "De_A_uOS_00" in line
            continue

        if suppress_doc_macro:
            if re.search(r"\bMEND\b", line, flags=re.IGNORECASE):
                out.append("; " + line)
                suppress_doc_macro = False
                suppress_until_org = False
                continue
            if suppress_until_org and re.match(r"^\s*ORG\b", stripped, flags=re.IGNORECASE):
                suppress_doc_macro = False
                suppress_until_org = False
            else:
                out.append("; " + line)
                continue

        if stripped.startswith("*"):
            out.append(";" + line[line.index("*") + 1 :])
            continue

        line = normalize_directives(line)
        line = normalize_expr(line)
        line = normalize_data_strings(line)
        line = labelize(line)
        if awaiting_retry_limit_label and "NZ CONDITION" in line and re.search(r"\bOR\s+A\b", line):
            out.append(annotate("RETRY_LIMIT_REACHED:", "ROM branch at $F1D0 targets this cleanup at $F1D6; printed target is unresolved."))
            awaiting_retry_limit_label = False
        out.append(line)
        if anchor in INJECTIONS_AFTER:
            injected, note = INJECTIONS_AFTER[anchor]
            out.append(annotate(injected, note))
            applied_after.add(anchor)

    if applied_edits != set(edits_by_anchor):
        missing = sorted(set(edits_by_anchor) - applied_edits)
        raise RuntimeError(f"Expected anchored corrections did not match: {missing}")
    if applied_before != set(INJECTIONS_BEFORE):
        raise RuntimeError(f"Expected pre-line injections did not match: {sorted(set(INJECTIONS_BEFORE) - applied_before)}")
    if applied_after != set(INJECTIONS_AFTER):
        raise RuntimeError(f"Expected post-line injections did not match: {sorted(set(INJECTIONS_AFTER) - applied_after)}")
    if early_equate_duplicates != set(EARLY_EQUATES):
        raise RuntimeError(f"Early-equate duplicate set changed: {sorted(early_equate_duplicates)}")
    if awaiting_retry_limit_label:
        raise RuntimeError("Could not place RETRY_LIMIT_REACHED label")

    out = header + sectionize_org_blocks(out)

    footer = [
        "",
        "; ==================================================================",
        "; END PRESERVED COLECO LISTING TEXT",
        "; ==================================================================",
        "; MODERN RECONSTRUCTION AND BUILD NOTES",
        "; ==================================================================",
        "; This .asm is a generated preservation artifact, not the canonical",
        "; hand-edited input. Maintained inputs are EOS_REBUILD/all_lines.txt",
        "; plus the anchored correction rules in build_clean_z88_source.py.",
        "; Every semantic correction is marked [RECON] beside its source line",
        "; and documented in EOS_6_ASSEMBLEABLE_SOURCE_REPORT.md.",
        ";",
        "; Named sections retain the historical listing's block order. z80asm",
        "; emits one binary per section; the build script places those sections",
        "; at their declared ORG addresses in the 8192-byte $E000-$FFFF bank.",
        "; U22 physical bytes $2000-$3FFF are the separate alternate boot bank",
        "; and are not present in the OCR EOS listing.  The build script preserves",
        "; that bank from the reference ROM when constructing the complete U22.",
        ";",
        "; Original MAME ROM member: eos 6 rev 57 08dd.u22",
        "; Original MAME 16K ROM MD5: cf10b154f2e006a9740d7653cfc47cab",
        "; Assembled 8K EOS bank MD5: 01df3140909f09aa9aac4f88890f676c",
        ";",
        "; Recommended build from the workspace root (PowerShell):",
        ";   .\\build_eos_assembleable_source.ps1",
        ";",
        "; Direct assembler command (section files; build script packages them):",
        ";   & 'C:\\z88dk\\bin\\z80asm.exe' -b -split-bin -f255 -l -m -s '-oeos.bin' '.\\EOS_6_ASSEMBLEABLE_SOURCE.asm'",
        ";",
        "; The build script verifies the EOS bank, appends the untouched alternate",
        "; bank, writes EOS_6_ASSEMBLEABLE_SOURCE.u22, and verifies the full MD5.",
        "; Required reference filename: rom_reference\\eos 6 rev 57 08dd.u22",
        "; Required reference MD5: cf10b154f2e006a9740d7653cfc47cab",
    ]
    out.extend(footer)

    expected_symbols = {
        "basis": "Surviving EOS listing source-line order and printed address columns",
        "provenance": {
            "expected_values_derived_from": [
                {
                    "file": "EOS_6_ABSOLUTE_LISTING_OCR.txt",
                    "role": "Primary surviving listing evidence: printed source-line, address, opcode, value, label, and allocation columns",
                    "ranges": {
                        "memory_bases": "OCR source lines 97-101",
                        "public_jump_table": "OCR source lines 122-333",
                        "ram_and_pcb": "OCR source lines 428-683",
                        "common_tables": "OCR source lines 694-848; configuration symbols at 768-816",
                    },
                },
                {
                    "file": "EOS_REBUILD/all_lines.txt",
                    "role": "Line-anchored working transcription used to preserve symbol order and corrected historical spellings",
                },
            ],
            "independent_corroboration": [
                {
                    "file": "rom_reference/eos 6 rev 57 08dd.u22",
                    "identity": "16384 bytes; MD5 cf10b154f2e006a9740d7653cfc47cab",
                    "role": "Independent shipped-byte evidence for jump opcodes/targets and RAM/table operands; not the source of unused-symbol expectations",
                }
            ],
            "not_used_as_expected_values": [
                "EOS_6_ASSEMBLEABLE_SOURCE.map",
                "EOS_6_ASSEMBLEABLE_SOURCE.bin",
                "binary identity alone",
            ],
        },
        "jump_table": {
            "start": "0xFC30",
            "stride": 3,
            "entries": JUMP_ENTRIES,
        },
        "ram": {name: f"0x{value:04X}" for name, value in RAM_EXPECTED.items()},
        "tables": {name: f"0x{value:04X}" for name, value in TABLE_EXPECTED.items()},
    }
    EXPECTED_SYMBOLS_OUT.write_text(
        json.dumps(expected_symbols, indent=2) + "\n", encoding="ascii"
    )

    expected_symbol_sources = r'''# Expected-Symbol Manifest Sources

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
'''.strip() + "\n"
    EXPECTED_SYMBOLS_SOURCES_OUT.write_text(expected_symbol_sources, encoding="ascii")

    canonical_build = r'''param(
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
'''.strip() + "\n"
    CANONICAL_BUILD_OUT.write_text(canonical_build, encoding="ascii")

    BUILD_OUT.write_text(
        "$ErrorActionPreference = 'Stop'\n"
        "$rootBuild = Join-Path $PSScriptRoot '..\\build_eos_assembleable_source.ps1'\n"
        "& $rootBuild @args\n"
        "exit $LASTEXITCODE\n",
        encoding="ascii",
    )

    regenerate = r'''$ErrorActionPreference = 'Stop'
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
'''.strip() + "\n"
    REGENERATE_OUT.write_text(regenerate, encoding="ascii")

    report = r'''# EOS 6 OCR Source Preservation Report

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
'''.strip() + "\n"
    REPORT_OUT.write_text(report, encoding="ascii")

    source_text = "\n".join(out) + "\n"
    ASM_OUT.write_text(source_text, encoding="ascii", errors="replace")
    CANONICAL_ASM_OUT.write_text(source_text, encoding="ascii", errors="replace")


if __name__ == "__main__":
    main()
