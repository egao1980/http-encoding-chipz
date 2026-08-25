# http-encoding-chipz

MIT. **gzip / deflate** Content-Encoding backend for [`http-protocol`](https://github.com/egao1980/http-protocol).

| Coding | Decode | Encode |
|--------|--------|--------|
| `:gzip` | chipz Gray stream / buffer | salza2 (stream = slurp+wrap) |
| `:deflate` | chipz zlib (+ raw fallback on buffer) | salza2 zlib |

Pattern: [`event-backend-libuv`](https://github.com/egao1980/event-backend-libuv) — specialize protocol generics; no registry.

```bash
# CI: canned [`cl-repository`](https://github.com/egao1980/cl-repository) (`test-system.yml` / `setup-client` + `ci`). Deps from `ghcr.io/egao1980/cl-systems`.
# Local: (asdf:test-system "http-encoding-chipz")
```

## Publish

Owning-repo canned [`publish-source.yml`](https://github.com/egao1980/cl-repository/blob/main/.github/workflows/publish-source.yml):

```bash
gh workflow run publish-checkout.yml -R egao1980/http-encoding-chipz
```

