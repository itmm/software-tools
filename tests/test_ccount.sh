#!/bin/bash

function run {
	file=$1
	expected=$2
	echo $expected >ccount-exp.txt
	./ccount <$file >ccount-out.txt
	diff ccount-exp.txt ccount-out.txt || exit 1
}

run test-data/empty.txt 0
run test-data/one-line.txt 7
run test-data/two-lines.txt 14
echo "$0 OK"
