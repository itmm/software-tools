#!/bin/bash

function run {
	file=$1
	expected=$2
	./re-tab <$file >re-tab-out.txt
	diff $expected re-tab-out.txt || exit 1
}

run test-data/empty.txt test-data/empty.txt
run test-data/newline.txt test-data/newline.txt
run test-data/two-lines.txt test-data/two-lines.txt
run test-data/untabbed.txt test-data/tabbed.txt
run test-data/untabbed-col.txt test-data/tabbed-col.txt
