#
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
#


########## Make rule for test oop256  ########

fcheck.o check_mod.mod: $(SRC)/check_mod.F90
	-$(FC) -c $(FFLAGS) $(SRC)/check_mod.F90 -o fcheck.o

oop256.o:  $(SRC)/oop256.f90 check_mod.mod
	@echo ------------------------------------ building test $@
	-$(FC) -c $(FFLAGS) $(LDFLAGS) $(SRC)/oop256.f90 -o oop256.o

oop256: oop256.o fcheck.o
	-$(FC) $(FFLAGS) $(LDFLAGS) oop256.o fcheck.o $(LIBS) -o oop256

oop256.run: oop256
	@echo ------------------------------------ executing test oop256
	oop256
	-$(RM) mod.mod

### TA Expected Targets ###

build: $(TEST)

.PHONY: run
run: $(TEST).run

verify: ; 

### End of Expected Targets ###
