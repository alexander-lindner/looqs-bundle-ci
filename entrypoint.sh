#!/usr/bin/env bash

./scripts/4-build-looqs.sh
su user -c "cd $(pwd); ./scripts/5-bundle.sh"