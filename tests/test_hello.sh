#!/bin/bash

./hello >hello-out.txt
diff test-data/hello.txt hello-out.txt || exit 1
