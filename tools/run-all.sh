#!/usr/bin/env bash
# Run every language implementation and diff its stdout against expected.txt.
#
#   tools/run-all.sh            # run everything
#   tools/run-all.sh python c   # run just these
#   VERBOSE=1 tools/run-all.sh  # show the diff for each failure
#
# Exit status is non-zero if anything FAILed. SKIP (missing toolchain) is not
# a failure -- no single image has 148 toolchains on it.
set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
EXPECTED="$ROOT/expected.txt"
TIMEOUT="${TIMEOUT:-120}"

if [[ $# -gt 0 ]]; then
  targets=("$@")
else
  mapfile -t targets < <(cd "$ROOT/languages" && ls -d */ | tr -d /)
fi

pass=(); fail=(); skip=()

for slug in "${targets[@]}"; do
  runner="$ROOT/languages/$slug/run.sh"
  if [[ ! -x "$runner" ]]; then
    printf '%-16s \033[33mSKIP\033[0m  (no run.sh)\n' "$slug"
    skip+=("$slug")
    continue
  fi

  out="$(mktemp)"
  err="$(mktemp)"
  timeout "$TIMEOUT" "$runner" >"$out" 2>"$err"
  rc=$?

  if [[ $rc -eq 127 ]]; then
    printf '%-16s \033[33mSKIP\033[0m  %s\n' "$slug" "$(head -1 "$err")"
    skip+=("$slug")
  elif [[ $rc -ne 0 ]]; then
    printf '%-16s \033[31mFAIL\033[0m  exit %d: %s\n' "$slug" "$rc" "$(head -1 "$err")"
    fail+=("$slug")
    [[ "${VERBOSE:-}" == 1 ]] && sed 's/^/    /' "$err" | head -20
  elif diff -q "$EXPECTED" "$out" >/dev/null 2>&1; then
    printf '%-16s \033[32mPASS\033[0m\n' "$slug"
    pass+=("$slug")
  else
    printf '%-16s \033[31mFAIL\033[0m  output differs\n' "$slug"
    fail+=("$slug")
    [[ "${VERBOSE:-}" == 1 ]] && diff "$EXPECTED" "$out" | head -20 | sed 's/^/    /'
  fi
  rm -f "$out" "$err"
done

echo
echo "PASS ${#pass[@]}   FAIL ${#fail[@]}   SKIP ${#skip[@]}"
[[ ${#fail[@]} -gt 0 ]] && { echo "failed: ${fail[*]}"; exit 1; }
exit 0
