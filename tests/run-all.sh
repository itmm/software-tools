#!/bin/bash

echo
echo 'running tests:'

for script in tests/test_*.sh
do
	$script
	if [ $? -ne 0 ]; then
		echo
		echo "## $script FAILED"
		exit 1
	else
		echo "  $script OK"
	fi
done

rm -f *-out.txt *-exp.txt

echo 'all tests passed'
echo
