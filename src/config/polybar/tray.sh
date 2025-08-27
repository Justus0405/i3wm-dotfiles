#!/usr/bin/env bash

if pgrep -f "polybar bar2" >/dev/null; then
	pkill -f "polybar bar2"
else
	echo "---" | tee -a /tmp/polybar2.log
	polybar bar2 2>&1 | tee -a /tmp/polybar2.log &
	disown
fi
