#!/bin/bash

function run {
	file=$1
	expected=$2
	echo $expected >countchars-exp.txt
	./countchars <$file >countchars-out.txt
	diff countchars-exp.txt countchars-out.txt || exit 1
}

run test-data/empty.txt 0
run test-data/one-line.txt 7
run test-data/two-lines.txt 14
