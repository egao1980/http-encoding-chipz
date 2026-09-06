# http-encoding-chipz

MIT. **gzip / deflate** Content-Encoding adapter for [`http-protocol`](https://github.com/egao1980/http-protocol).
Bytes go through [`compression-protocol`](https://github.com/egao1980/compression-protocol)
(`compression-backend-chipz`). HTTP still owns coding names / `:identity`.

| Coding | Decode | Encode |
|--------|--------|--------|
| `:gzip` | `decompress` / decompressing stream | `compress` (stream = slurp+wrap) |
| `:deflate` | zlib, then raw deflate fallback | zlib |

```bash
# CI: canned cl-repository test-system.yml. Deps from ghcr.io/egao1980/cl-systems.
# Local: (asdf:test-system "http-encoding-chipz")
```

## Publish

```bash
gh workflow run publish-checkout.yml -R egao1980/http-encoding-chipz
```
