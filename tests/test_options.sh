#!/usr/bin/env bash
set -eu

# Test different copier option combinations to ensure the template
# generates correctly across all supported configurations.

. tests/helpers.sh

TESTS_PASSED=0
TESTS_FAILED=0
FAILURES=""

# Generate a project with custom options.
# Usage: generate_with_options <dest> [-d key=value ...]
generate_with_options() {
  local dest="$1"
  shift
  copier copy -f --trust -r HEAD "$@" \
    -d testing=true \
    -d project_name="Oedokumaci Testing" \
    -d project_description='Testing this great template' \
    -d author_fullname="Oral Ersoy Dokumaci" \
    -d author_username="oedokumaci" \
    -d author_email="oral.ersoy.dokumaci@gmail.com" \
    "${PWD}" "${dest}"
}

# Assert a file exists
assert_file_exists() {
  local file="$1"
  local label="${2:-$1}"
  if [ -f "${file}" ]; then
    echo "  PASS: ${label} exists"
  else
    echo "  FAIL: ${label} does not exist"
    TESTS_FAILED=$((TESTS_FAILED + 1))
    FAILURES="${FAILURES}\n  - ${label} missing"
    return 0
  fi
  TESTS_PASSED=$((TESTS_PASSED + 1))
}

# Assert a file does NOT exist
assert_file_not_exists() {
  local file="$1"
  local label="${2:-$1}"
  if [ ! -f "${file}" ]; then
    echo "  PASS: ${label} correctly absent"
  else
    echo "  FAIL: ${label} should not exist"
    TESTS_FAILED=$((TESTS_FAILED + 1))
    FAILURES="${FAILURES}\n  - ${label} should not exist"
    return 0
  fi
  TESTS_PASSED=$((TESTS_PASSED + 1))
}

# Assert a directory exists
assert_dir_exists() {
  local dir="$1"
  local label="${2:-$1}"
  if [ -d "${dir}" ]; then
    echo "  PASS: ${label} directory exists"
  else
    echo "  FAIL: ${label} directory does not exist"
    TESTS_FAILED=$((TESTS_FAILED + 1))
    FAILURES="${FAILURES}\n  - ${label} directory missing"
    return 0
  fi
  TESTS_PASSED=$((TESTS_PASSED + 1))
}

# Assert a directory does NOT exist
assert_dir_not_exists() {
  local dir="$1"
  local label="${2:-$1}"
  if [ ! -d "${dir}" ]; then
    echo "  PASS: ${label} directory correctly absent"
  else
    echo "  FAIL: ${label} directory should not exist"
    TESTS_FAILED=$((TESTS_FAILED + 1))
    FAILURES="${FAILURES}\n  - ${label} directory should not exist"
    return 0
  fi
  TESTS_PASSED=$((TESTS_PASSED + 1))
}

# Assert a file contains a string
assert_file_contains() {
  local file="$1"
  local pattern="$2"
  local label="${3:-${file} contains '${pattern}'}"
  if grep -q "${pattern}" "${file}"; then
    echo "  PASS: ${label}"
  else
    echo "  FAIL: ${label}"
    TESTS_FAILED=$((TESTS_FAILED + 1))
    FAILURES="${FAILURES}\n  - ${label}"
    return 0
  fi
  TESTS_PASSED=$((TESTS_PASSED + 1))
}

# Assert a file does NOT contain a string
assert_file_not_contains() {
  local file="$1"
  local pattern="$2"
  local label="${3:-${file} should not contain '${pattern}'}"
  if ! grep -q "${pattern}" "${file}"; then
    echo "  PASS: ${label}"
  else
    echo "  FAIL: ${label}"
    TESTS_FAILED=$((TESTS_FAILED + 1))
    FAILURES="${FAILURES}\n  - ${label}"
    return 0
  fi
  TESTS_PASSED=$((TESTS_PASSED + 1))
}

cleanup() {
  local dir="$1"
  rm -rf "${dir}"
}

# =========================================================
# Test 1: Default options (notebooks=true, python=3.13, MIT)
# =========================================================
echo
echo "==========================================="
echo " Test 1: Default options"
echo "  (notebooks=true, python=3.13, MIT)"
echo "==========================================="
echo
output="tests/tmp-options-1"
cleanup "${output}"
generate_with_options "${output}"
echo

assert_file_exists "${output}/pyproject.toml" "pyproject.toml"
assert_file_exists "${output}/LICENSE" "LICENSE"
assert_file_exists "${output}/README.md" "README.md"
assert_file_exists "${output}/CLAUDE.md" "CLAUDE.md"
assert_file_exists "${output}/src/oedokumaci_testing/__init__.py" "package __init__.py"
assert_dir_exists  "${output}/notebooks" "notebooks"
assert_file_exists "${output}/notebooks/starter.py" "notebooks/starter.py"
assert_file_exists "${output}/docs/notebooks.md" "docs/notebooks.md"
assert_file_contains "${output}/pyproject.toml" 'requires-python = "==3.13.*"' "python version 3.13"
assert_file_contains "${output}/pyproject.toml" '"MIT"' "MIT license in pyproject.toml"
assert_file_contains "${output}/pyproject.toml" '"notebooks"' "notebooks in default-groups"
assert_file_contains "${output}/pyproject.toml" 'marimo' "marimo dependency"
assert_file_contains "${output}/LICENSE" "MIT" "MIT in LICENSE file"

cleanup "${output}"
echo

# =========================================================
# Test 2: Notebooks disabled
# =========================================================
echo "==========================================="
echo " Test 2: Notebooks disabled"
echo "  (notebooks=false, python=3.13, MIT)"
echo "==========================================="
echo
output="tests/tmp-options-2"
cleanup "${output}"
generate_with_options "${output}" -d include_notebooks=false
echo

assert_file_exists "${output}/pyproject.toml" "pyproject.toml"
assert_dir_not_exists "${output}/notebooks" "notebooks"
assert_file_not_exists "${output}/docs/notebooks.md" "docs/notebooks.md"
assert_file_not_contains "${output}/pyproject.toml" 'marimo' "no marimo dependency"
assert_file_not_contains "${output}/pyproject.toml" '"notebooks"' "no notebooks in default-groups"

cleanup "${output}"
echo

# =========================================================
# Test 3: Python 3.12
# =========================================================
echo "==========================================="
echo " Test 3: Python 3.12"
echo "  (notebooks=true, python=3.12, MIT)"
echo "==========================================="
echo
output="tests/tmp-options-3"
cleanup "${output}"
generate_with_options "${output}" -d python_version=3.12
echo

assert_file_contains "${output}/pyproject.toml" 'requires-python = "==3.12.*"' "python version 3.12"
assert_file_contains "${output}/pyproject.toml" 'Python :: 3.12' "python 3.12 classifier"

cleanup "${output}"
echo

# =========================================================
# Test 4: Python 3.14
# =========================================================
echo "==========================================="
echo " Test 4: Python 3.14"
echo "  (notebooks=true, python=3.14, MIT)"
echo "==========================================="
echo
output="tests/tmp-options-4"
cleanup "${output}"
generate_with_options "${output}" -d python_version=3.14
echo

assert_file_contains "${output}/pyproject.toml" 'requires-python = "==3.14.*"' "python version 3.14"
assert_file_contains "${output}/pyproject.toml" 'Python :: 3.14' "python 3.14 classifier"

cleanup "${output}"
echo

# =========================================================
# Test 5: Apache-2.0 license
# =========================================================
echo "==========================================="
echo " Test 5: Apache-2.0 license"
echo "  (notebooks=true, python=3.13, Apache-2.0)"
echo "==========================================="
echo
output="tests/tmp-options-5"
cleanup "${output}"
generate_with_options "${output}" -d copyright_license=Apache-2.0
echo

assert_file_contains "${output}/pyproject.toml" '"Apache-2.0"' "Apache-2.0 in pyproject.toml"
assert_file_contains "${output}/LICENSE" "Apache" "Apache in LICENSE file"

cleanup "${output}"
echo

# =========================================================
# Test 6: GPL-3.0 license
# =========================================================
echo "==========================================="
echo " Test 6: GPL-3.0 license"
echo "  (notebooks=true, python=3.13, GPL-3.0)"
echo "==========================================="
echo
output="tests/tmp-options-6"
cleanup "${output}"
generate_with_options "${output}" -d copyright_license=GPL-3.0
echo

assert_file_contains "${output}/pyproject.toml" '"GPL-3.0"' "GPL-3.0 in pyproject.toml"
assert_file_contains "${output}/LICENSE" "GNU GENERAL PUBLIC LICENSE" "GPL in LICENSE file"

cleanup "${output}"
echo

# =========================================================
# Test 7: Combined — Python 3.12 + no notebooks + BSD-3
# =========================================================
echo "==========================================="
echo " Test 7: Combined options"
echo "  (notebooks=false, python=3.12, BSD-3-Clause)"
echo "==========================================="
echo
output="tests/tmp-options-7"
cleanup "${output}"
generate_with_options "${output}" \
  -d python_version=3.12 \
  -d include_notebooks=false \
  -d copyright_license=BSD-3-Clause
echo

assert_file_contains "${output}/pyproject.toml" 'requires-python = "==3.12.*"' "python version 3.12"
assert_file_contains "${output}/pyproject.toml" '"BSD-3-Clause"' "BSD-3-Clause in pyproject.toml"
assert_dir_not_exists "${output}/notebooks" "notebooks"
assert_file_not_contains "${output}/pyproject.toml" 'marimo' "no marimo dependency"
assert_file_not_contains "${output}/pyproject.toml" '"notebooks"' "no notebooks in default-groups"

cleanup "${output}"
echo

# =========================================================
# Test 8: Combined — Python 3.14 + notebooks + Unlicense
# =========================================================
echo "==========================================="
echo " Test 8: Combined options"
echo "  (notebooks=true, python=3.14, Unlicense)"
echo "==========================================="
echo
output="tests/tmp-options-8"
cleanup "${output}"
generate_with_options "${output}" \
  -d python_version=3.14 \
  -d include_notebooks=true \
  -d copyright_license=Unlicense
echo

assert_file_contains "${output}/pyproject.toml" 'requires-python = "==3.14.*"' "python version 3.14"
assert_file_contains "${output}/pyproject.toml" '"Unlicense"' "Unlicense in pyproject.toml"
assert_dir_exists "${output}/notebooks" "notebooks"
assert_file_exists "${output}/notebooks/starter.py" "notebooks/starter.py"
assert_file_contains "${output}/pyproject.toml" 'marimo' "marimo dependency"

cleanup "${output}"
echo

# =========================================================
# Test 9: Core template structure (common files always present)
# =========================================================
echo "==========================================="
echo " Test 9: Core template structure"
echo "  (verify all expected files/dirs exist)"
echo "==========================================="
echo
output="tests/tmp-options-9"
cleanup "${output}"
generate_with_options "${output}"
echo

# Source structure
assert_dir_exists  "${output}/src" "src"
assert_dir_exists  "${output}/src/oedokumaci_testing" "package dir"
assert_dir_exists  "${output}/src/oedokumaci_testing/_internal" "_internal dir"
assert_file_exists "${output}/src/oedokumaci_testing/__init__.py" "__init__.py"
assert_file_exists "${output}/src/oedokumaci_testing/__main__.py" "__main__.py"
assert_file_exists "${output}/src/oedokumaci_testing/_internal/cli.py" "_internal/cli.py"
assert_file_exists "${output}/src/oedokumaci_testing/_internal/debug.py" "_internal/debug.py"
assert_file_exists "${output}/src/oedokumaci_testing/_internal/logging.py" "_internal/logging.py"
assert_file_exists "${output}/src/oedokumaci_testing/py.typed" "py.typed"

# Test structure
assert_dir_exists  "${output}/tests" "tests dir"
assert_file_exists "${output}/tests/__init__.py" "tests/__init__.py"
assert_file_exists "${output}/tests/conftest.py" "tests/conftest.py"
assert_file_exists "${output}/tests/test_main.py" "tests/test_main.py"

# Config
assert_dir_exists  "${output}/config" "config dir"
assert_file_exists "${output}/config/ruff.toml" "config/ruff.toml"
assert_file_exists "${output}/config/pytest.ini" "config/pytest.ini"
assert_file_exists "${output}/config/coverage.ini" "config/coverage.ini"

# Docs
assert_dir_exists  "${output}/docs" "docs dir"
assert_file_exists "${output}/docs/index.md" "docs/index.md"
assert_file_exists "${output}/docs/changelog.md" "docs/changelog.md"
assert_file_exists "${output}/docs/contributing.md" "docs/contributing.md"
assert_file_exists "${output}/docs/credits.md" "docs/credits.md"
assert_file_exists "${output}/docs/license.md" "docs/license.md"

# Root files
assert_file_exists "${output}/.gitignore" ".gitignore"
assert_file_exists "${output}/.pre-commit-config.yaml" ".pre-commit-config.yaml"
assert_file_exists "${output}/CHANGELOG.md" "CHANGELOG.md"
assert_file_exists "${output}/CONTRIBUTING.md" "CONTRIBUTING.md"
assert_file_exists "${output}/zensical.toml" "zensical.toml"

# GitHub
assert_dir_exists  "${output}/.github" ".github dir"
assert_dir_exists  "${output}/.github/ISSUE_TEMPLATE" "ISSUE_TEMPLATE dir"
assert_dir_exists  "${output}/.github/workflows" "workflows dir"

cleanup "${output}"
echo

# =========================================================
# Summary
# =========================================================
echo "==========================================="
echo " RESULTS"
echo "==========================================="
echo
echo "  Passed: ${TESTS_PASSED}"
echo "  Failed: ${TESTS_FAILED}"
if [ "${TESTS_FAILED}" -gt 0 ]; then
  echo
  echo "  Failures:"
  echo -e "${FAILURES}"
  echo
  exit 1
fi
echo
echo "  All option combination tests passed!"
echo
