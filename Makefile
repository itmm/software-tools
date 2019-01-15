APPs := $(wildcard *.s)
OBJs := $(APPs:.s=)
Xs := $(wildcard *.x)

.PHONY: tests clean

tests: index.html $(OBJs)
	@for script in tests/test_*.sh; \
	do \
		$$script || exit 1; \
	done
	@rm -f *-out.txt *-exp.txt

index.html: $(Xs)
	hx

clean:
	rm -f $(OBJs) *-out.txt *-exp.txt
