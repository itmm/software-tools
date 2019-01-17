#!/bin/bash

./echo >echo-out.txt
diff test-data/newline.txt echo-out.txt || exit 1

./echo Line 1 >echo-out.txt
diff test-data/one-line.txt echo-out.txt || exit 1
