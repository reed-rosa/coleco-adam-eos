# EOS 6 Release ZIP Fresh-Extraction Test

- Release archive: `EOS6V1.zip`
- Archive root directory: `EOS6V1/`

## Method

The release archive was extracted into a newly created directory. `RELEASE_SHA256SUMS.txt` was verified first. All generated source/build products were then deleted from the extracted tree, including the generated `.asm`, build script, reports, manifest, binary, listings, map, and symbol results.

The retained project inputs were the bundled OCR evidence, `EOS_REBUILD/all_lines.txt`, generator, regeneration launcher, README, and reference-ROM requirements. Regeneration and build were run with only these documented external inputs:

- z80asm: `Z80 Macro Assembler 23854-4d530b6eb7-20251002`
- z80asm SHA256: `8b923061aae40d210c038e991ed5f4b88ff4291e282a823eae469c7764ff1558`
- Reference ROM: `eos 6 rev 57 08dd.u22`, 16,384 bytes
- Reference ROM MD5: `cf10b154f2e006a9740d7653cfc47cab`
- Python: 3.13.13
- PowerShell: 7.6.5

## Results

- Release checksum manifest: PASS
- Deterministic two-pass regeneration: PASS
- Reconstructed source SHA256: `87cda81dbe8f4dbfc7c04cb008f3489df6ee9e2c050b3cc1947e68b11d753313`
- EOS bank: 8,192 bytes, MD5 `01df3140909f09aa9aac4f88890f676c`, zero reference differences
- Complete U22: 16,384 bytes, MD5 `cf10b154f2e006a9740d7653cfc47cab`, zero reference differences
- Expected-symbol checks: 193/193 PASS
- Raw z80asm listing generated: 595,132 bytes
- Processed absolute/final-byte listing generated: 595,284 bytes
- Source hash remained identical to the pre-packaging preservation source; no EOS routine was rewritten.
- Manual comparison present: 89 documented-entry rows and 12 omitted-entry rows.
- Manual comparison table checked against the regenerated symbol map and JP operands: 89/89 PASS.
- Original `FC4E` scan status: unavailable; the updated PDF's visible `FB13:64283` inconsistency is documented without claiming a proven original-manual OCR error.

Result: PASS
