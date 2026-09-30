# EOS 6 Build Verification Results

- Assembler: Z80 Macro Assembler 23854-4d530b6eb7-20251002
- Assembler executable SHA256: 8b923061aae40d210c038e991ed5f4b88ff4291e282a823eae469c7764ff1558
- Build isolation: fresh unique temporary directory; no prior binary/object/listing consumed.
- Diagnostic path normalization: temporary-directory names removed from listing and map outputs.
- Generated section sizes: code 7166, global table 49, jump table 303, global RAM 327, PCB/DCB 320 bytes.
- EOS bank: 8192 bytes; MD5 01df3140909f09aa9aac4f88890f676c; reference differences: 0.
- Complete U22: 16384 bytes; MD5 cf10b154f2e006a9740d7653cfc47cab; reference differences: 0.
- Symbols: 101 public jump entries, 75 RAM/PCB symbols, and 17 table symbols matched the independent manifest.
- Second 8K bank: copied unchanged from the verified reference U22; it is not reconstructed from the EOS OCR listing.

Result: PASS
