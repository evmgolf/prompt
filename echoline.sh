#!/usr/bin/env bash

echo -n "> "; head -n1 >input
forge script --ffi EchoLine -v
