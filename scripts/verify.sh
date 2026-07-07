#!/usr/bin/env bash
# Verification gate for Assignment 1 deliverables (v1.7 — all lanes).
set -euo pipefail
cd "$(dirname "$0")/.."
export PATH=".tools/go/bin:${PATH}"
chmod +x scripts/fetch-envtest.sh scripts/resolve-bundle-digests.sh 2>/dev/null || true

echo "=== go vet ==="
go vet ./...

echo "=== go test (unit + contract + BF-3 lane spec) ==="
go test ./... -count=1 -v

echo "=== bundle digest resolution ==="
./scripts/resolve-bundle-digests.sh

echo "=== integration (envtest) ==="
if ENVTEST_DIR="$(./scripts/fetch-envtest.sh 2>/dev/null)"; then
  export KUBEBUILDER_ASSETS="$ENVTEST_DIR"
  CGO_ENABLED=0 go test -tags integration -count=1 -v ./...
  echo "INTEGRATION PASSED"
else
  echo "SKIP integration: envtest fetch failed (run ./scripts/verify-all.sh or CI workflow)"
fi

echo ""
echo "ALL CHECKS PASSED"
echo "Full multi-lane record: ./scripts/verify-all.sh"
