#!/usr/bin/env bash

./scripts/4-build-looqs.sh
chown user -R out
su user -c "cd $(pwd); ./scripts/5-bundle.sh"