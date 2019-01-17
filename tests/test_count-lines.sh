#!/bin/bash

function run {
	file=$1
	expected=$2
	echo $expected >count-lines-exp.txt
	./count-lines <$file >count-lines-out.txt
	diff count-lines-exp.txt count-lines-out.txt || exit 1
}

run test-data/empty.txt 0
run test-data/newline.txt 1
run test-data/one-line.txt 1
run test-data/two-lines.txt 2
