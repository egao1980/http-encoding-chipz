# http-encoding-chipz

MIT. **gzip / deflate** Content-Encoding backend for [`http-protocol`](https://github.com/egao1980/http-protocol).

| Coding | Decode | Encode |
|--------|--------|--------|
| `:gzip` | chipz Gray stream / buffer | salza2 (stream = slurp+wrap) |
| `:deflate` | chipz zlib (+ raw fallback on buffer) | salza2 zlib |

Pattern: [`event-backend-libuv`](https://github.com/egao1980/event-backend-libuv) — specialize protocol generics; no registry.

```bash
# CI: cl-repository → ghcr.io/egao1980/cl-systems (newest tags)
# Local: CL_SOURCE_REGISTRY to sibling http-protocol/ or cl-repo install
ros -l scripts/ci-test.lisp   # needs cl-repository-client on the registry
```

## Publish

Source-only OCI publish is centralized in [`cl-stack-systems`](https://github.com/egao1980/cl-stack-systems)
(`imports/http-encoding-chipz/qlfile` pin + shared `publish.yml`). Packaging metadata lives in the `.asd`
(`auto-package-spec`):

```bash
gh workflow run publish.yml -R egao1980/cl-stack-systems -f import=http-encoding-chipz
```

