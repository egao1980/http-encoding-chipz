# http-encoding-chipz

MIT. **gzip / deflate** Content-Encoding backend for [`http-protocol`](https://github.com/egao1980/http-protocol).

| Coding | Decode | Encode |
|--------|--------|--------|
| `:gzip` | chipz Gray stream / buffer | salza2 (stream = slurp+wrap) |
| `:deflate` | chipz zlib (+ raw fallback on buffer) | salza2 zlib |

Pattern: [`event-backend-libuv`](https://github.com/egao1980/event-backend-libuv) — specialize protocol generics; no registry.

```bash
# siblings: http-protocol/ http-encoding-chipz/
qlot install
qlot exec ros -S . -e '(asdf:test-system "http-encoding-chipz")'
```
