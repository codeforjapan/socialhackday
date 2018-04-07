#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

function run_server() {
  bundle exec middleman server --bind-address="0.0.0.0"
}

run_server
