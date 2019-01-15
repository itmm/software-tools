CPPFLAGS += -Wall -std=c++14

APPs := $(wildcard *.cpp)
OBJs := $(APPs:.cpp=)

.PHONY: tests clean

tests: $(OBJs)
	@for script in tests/test_*.sh; \
	do \
		$$script || exit 1; \
	done
	@rm -f *-out.txt *-exp.txt

clean:
	rm -f $(OBJs) *-out.txt *-exp.txt
