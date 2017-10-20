#!/usr/bin/env bash
# CI test script.
# Usage:
#  ./tests.sh [setup|syntax|run|ci|full]

# Set err exit option to exit immediately on any non-zero status return
set -e

echo -e "\n\033[38;5;255m\033[48;5;234m\033[1m  P R O J E C T  \033[0m\n"

# Compute an absolute path to the test ansible.cfg file
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export ANSIBLE_CONFIG=$DIR/ansible.cfg

# Include the check_ansible function from ansible_check.sh
source util/ansible_check.sh

function run_playbook {
  PLAYBOOK="$1"
  EXTRA_FLAGS=(${@:2})
  #ansible-playbook -i "$DIR/inventory" --extra-vars=@global_vars/vars.yml "$PLAYBOOK" "${EXTRA_FLAGS[@]}"
  # the "--extra-vars=@global_vars/vars.yml " option should not be necessary for our needs for now
  echo -e "\nRun \"ansible-playbook -i \"$DIR/inventory\" \"$PLAYBOOK\"" "${EXTRA_FLAGS[@]}" "\n"
  ansible-playbook -i "$DIR/inventory" "$PLAYBOOK" "${EXTRA_FLAGS[@]}"
}

# syntax_check runs `ansible-playbook` with `--syntax-check` to vet Ansible
# playbooks for syntax errors
function syntax_check {
  run_playbook "$DIR/syntax-check.yml" --syntax-check -vv
}

function dev_setup {
  run_playbook "$DIR/development-setup.yml"
}

function run_tests {
  run_playbook "$DIR/run.yml" -e container_ci=true "$1"
}

function ci_tests {
  dev_setup && run_tests
}

function ci_tests_verbose {
  dev_setup && run_tests -vv
}

# Make sure the system is ready for the playbooks
check_ansible

# Allow overriding the RUN env var by providing an arg to the script
if [ -n "$1" ]; then
  RUN="$1"
fi

# Setup prepares the local environment for running a Streisand LXC
if [[ "$RUN" =~ "setup" ]] ; then
    dev_setup
fi

# Syntax checks for Ansible syntax errors
if [[ "$RUN" =~ "syntax" ]] ; then
    syntax_check
fi

# Shellcheck checks for bash/sh errors/pitfalls
if [[ "$RUN" =~ "shellcheck" ]] ; then
  ./tests/shellcheck.sh
fi

# Yamlcheck checks for general YAML best practices
if [[ "$RUN" =~ "yamlcheck" ]] ; then
  ./tests/yamlcheck.sh
fi

# Run will run CI tests assuming the local environment is already prepared
if [[ "$RUN" =~ "run" ]] ; then
  run_tests
fi

# CI will setup the local environment and then run tests
if [[ "$RUN" =~ "ci" ]] ; then
  ci_tests
fi

# Full will do the same as "ci" but with verbose output
if [[ "$RUN" =~ "full" ]] ; then
  ci_tests_verbose
fi
