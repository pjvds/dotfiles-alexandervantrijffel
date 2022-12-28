#!/bin/sh
TORUN=${1:-go run -tags=debug .}
reflex -r '\.go$' -s -- sh -c "$TORUN 2>&1"

# reflex -r '\.go$' -s -- sh -c "$TORUN 2>&1 | zap-pretty"