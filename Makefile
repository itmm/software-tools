CPPFLAGS += -Wall -std=c++14

CPP_FILEs := $(wildcard *.cpp)
S_FILEs := $(wildcard *.s)
OBJs := $(CPP_FILEs:.cpp=) $(S_FILEs:.s=)

.PHONY: tests clean

tests: $(OBJs)
	@for script in tests/test_*.sh; \
	do \
		$$script || exit 1; \
	done
	@rm -f *-out.txt *-exp.txt

clean:
	rm -f $(OBJs) *-out.txt *-exp.txt
