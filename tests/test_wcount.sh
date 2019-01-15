#!/bin/bash

function run {
	file=$1
	expected=$2
	echo $expected >wcount-exp.txt
	./wcount <$file >wcount-out.txt
	diff wcount-exp.txt wcount-out.txt || exit 1
}

run test-data/empty.txt 0
run test-data/one-line.txt 2
run test-data/two-lines.txt 4
echo "$0 OK"
