Xs := $(wildcard *.x)
DOCs := $(Xs:.x=.html)
EXEs := $(filter-out index,$(Xs:.x=))

.PHONY: tests clean

tests: $(EXEs)
	@tests/run-all.sh || exit 1

$(EXEs): $(Xs)
	@echo '  HX'
	@hx

clean:
	@echo '  RM generated files'
	@rm -f $(EXEs) $(DOCs) *-out.txt *-exp.txt
