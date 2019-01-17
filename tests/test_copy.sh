#!/bin/bash

function run {
	file=$1
	./copy <$file >copy-out.txt
	diff $file copy-out.txt || exit 1
}

run test-data/empty.txt
run test-data/newline.txt
run test-data/one-line.txt
run test-data/two-lines.txt
