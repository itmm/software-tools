#!/bin/bash

function run {
	file=$1
	expected=$2
	echo $expected >count-chars-exp.txt
	./count-chars <$file >count-chars-out.txt
	diff count-chars-exp.txt count-chars-out.txt || exit 1
}

run test-data/empty.txt 0
run test-data/one-line.txt 7
run test-data/two-lines.txt 14
