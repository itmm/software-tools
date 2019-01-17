#!/bin/bash

echo -n "Abc" | ./crypt X x  >crypt-out.txt
echo -n "aBC" >crypt-exp.txt
diff crypt-exp.txt crypt-out.txt || exit 1

cat test-data/two-lines.txt | ./crypt >crypt-out.txt
diff test-data/two-lines.txt crypt-out.txt || exit 1

cat test-data/two-lines.txt | ./crypt abc abc >crypt-out.txt
diff test-data/two-lines.txt crypt-out.txt || exit 1

cat test-data/two-lines.txt | ./crypt abc >crypt-out.txt
cmp -s test-data/two-lines.txt crypt-out.txt && exit 1
cat crypt-out.txt | ./crypt abc >crypt-dec-out.txt
diff test-data/two-lines.txt crypt-dec-out.txt || exit 1

