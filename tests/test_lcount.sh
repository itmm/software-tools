#!/bin/bash

function run {
	file=$1
	expected=$2
	echo $expected >lcount-exp.txt
	./lcount <$file >lcount-out.txt
	diff lcount-exp.txt lcount-out.txt || exit 1
}

run test-data/empty.txt 0
run test-data/one-line.txt 1
run test-data/two-lines.txt 2
echo "$0 OK"
