# GitHub Actions CI proof (captured)

| Field | Value |
|---|---|
| **Repo** | https://github.com/Aditya-Sarna/opi-assignment1-ci-proof (private test repo) |
| **Workflow run** | https://github.com/Aditya-Sarna/opi-assignment1-ci-proof/actions/runs/28885043356 |
| **Run ID** | 28885043356 |
| **Commit** | c6cb9e9 — Fix Kind kubeconfig path for CI e2e tests |
| **Date (UTC)** | 2026-07-07T17:16–17:19Z |

## Job results (all green)

| Job | Result | Key proof |
|---|---|---|
| `unit-contract` | ✓ | 22 unit/contract tests + digest gate |
| `integration` | ✓ | `TestIntegrationTranslateApplyAndReady`, drift SSA, finalizer teardown |
| `kind-e2e` | ✓ | **Real Kind cluster** — `TestE2EKindSFCGoldenApply` PASS, `KIND E2E PASSED` |
| `bf3-lane-contract` | ✓ | `TestBF3LaneSpec_Complete` PASS |

Full log: `validation_ci_github.log` (1328+ lines from `gh run view --log`).

## Mentor quick check

Open the workflow run URL above, or grep the log:

```bash
grep -E 'PASS: TestIntegration|PASS: TestE2EKind|KIND E2E PASSED|INTEGRATION PASSED' validation_ci_github.log
```
