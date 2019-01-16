#!/bin/bash

function run {
	file=$1
	expected=$2
	./un-tab <$file >un-tab-out.txt
	diff $expected un-tab-out.txt || exit 1
}

run test-data/tabbed.txt test-data/untabbed.txt
run test-data/tabbed-col.txt test-data/untabbed-col.txt
