#!/bin/bash

function run {
	file=$1
	expected=$2
	echo $expected >count-words-exp.txt
	./count-words <$file >count-words-out.txt
	diff count-words-exp.txt count-words-out.txt || exit 1
}

run test-data/empty.txt 0
run test-data/newline.txt 0
run test-data/one-line.txt 2
run test-data/two-lines.txt 4
