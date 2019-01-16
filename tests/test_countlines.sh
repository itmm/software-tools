#!/bin/bash

function run {
	file=$1
	expected=$2
	echo $expected >countlines-exp.txt
	./countlines <$file >countlines-out.txt
	diff countlines-exp.txt countlines-out.txt || exit 1
}

run test-data/empty.txt 0
run test-data/one-line.txt 1
run test-data/two-lines.txt 2
