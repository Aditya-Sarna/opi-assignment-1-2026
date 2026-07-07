# CI validation reference (mentor / reviewer)

When local Docker is unavailable, `./scripts/verify-all.sh` records **green integration + e2e (envtest fallback) + BF-3 contract** in `validation_output.txt`. Full **Kind cluster** proof runs on GitHub Actions Linux runners.

## Workflow

File: `.github/workflows/verify.yml`

| Job | Command | Proves |
|---|---|---|
| `unit-contract` | `./scripts/verify.sh` (unit slice) | 22 tests + digest gate |
| `integration` | `fetch-envtest.sh` + `go test -tags integration` | SSA, drift, teardown on apiserver |
| `kind-e2e` | `./scripts/e2e-kind.sh` | Real Kind cluster + CRD install |
| `bf3-lane-contract` | `./scripts/e2e-bf3-hardware.sh` | Phase 6 hardware lane spec gate |

## Trigger (after pushing to GitHub)

```bash
# Push branch, then in repo UI: Actions → verify → Run workflow
# Or with gh CLI:
gh workflow run verify.yml
gh run list --workflow verify.yml --limit 1
gh run view --log
```

## Local full stack (preferred when Docker Desktop is running)

```bash
chmod +x scripts/*.sh
./scripts/verify-all.sh          # writes validation_output.txt
./scripts/e2e-bf3-hardware.sh    # writes validation_hardware_e2e.txt
```

With Docker stopped, e2e uses **envtest fallback** (`USE_ENVTEST_E2E=1`) — same golden-object assertions, labeled honestly in the log.

## BF-3 hardware lab (Phase 6)

Contract gate (Assignment 1 bundle): `TestBF3LaneSpec_Complete` + `testdata/hardware/bf3-lane.yaml`

Full lab (requires BlueField-3 + DOCA): `BF3_LAB=1 KUBECONFIG=<lab> ./scripts/e2e-bf3-hardware.sh`
