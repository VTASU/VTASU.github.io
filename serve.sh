#!/usr/bin/env bash
# Local preview server for this al-folio site.
# Handles the machine-specific environment this project needs:
#   - Homebrew Ruby 3.3 (system Ruby 2.6 is too old; Ruby 4.x can't build some gems)
#   - Bundler 4.0.6 (pinned by Gemfile.lock)
#   - CPLUS_INCLUDE_PATH workaround for the broken Command Line Tools libc++ headers
#
# Usage:
#   ./serve.sh            # live-preview at http://localhost:4000 (auto-rebuilds on save)
#   ./serve.sh build      # one-off production build into _site/
set -euo pipefail
cd "$(dirname "$0")"

export PATH="/opt/homebrew/opt/ruby@3.3/bin:$PATH"
export SDKROOT="$(xcrun --show-sdk-path)"
export CPLUS_INCLUDE_PATH="$SDKROOT/usr/include/c++/v1"

if [[ "${1:-serve}" == "build" ]]; then
  JEKYLL_ENV=production bundle _4.0.6_ exec jekyll build
else
  bundle _4.0.6_ exec jekyll serve --livereload
fi
