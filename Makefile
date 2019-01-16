Xs := $(wildcard *.x)
SRCs := $(shell hx-files.sh $(Xs))
EXEs := $(SRCs:.s=)
DOCs := $(Xs:.x=.html)

CFLAGS += -Wall

.PHONY: tests clean

tests: $(EXEs)
	@tests/run-all.sh || exit 1

$(SRCs): $(Xs)
	@echo '  HX'
	@hx

%: %.s
	@echo '  CC ' $@
	@$(CC) $(CFLAGS) $^ -o $@

clean:
	@echo '  RM generated files'
	@rm -f $(SRCs) $(EXEs) $(DOCs) *-out.txt *-exp.txt
