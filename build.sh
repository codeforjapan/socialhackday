#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

function run_build() {
  bundle exec middleman build
}

run_build
