###############################################################################
# ocaml-magic Makefile                                                        #
#                                                                             #
# Copyright (c) 2014, Sang Kil Cha                                            #
# All rights reserved.                                                        #
# This software is free software; you can redistribute it and/or              #
# modify it under the terms of the GNU Library General Public                 #
# License version 2, with the special exception on linking                    #
# described in file LICENSE.                                                  #
#                                                                             #
# This software is distributed in the hope that it will be useful,            #
# but WITHOUT ANY WARRANTY; without even the implied warranty of              #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                        #
###############################################################################

OCAMLBUILD=ocamlbuild
FILEDIR=file-5.19

all: depcheck libmagic
	$(OCAMLBUILD) -Is src -Xs buildtools,$(FILEDIR) libmagic.cmxa

clean: depcheck
	$(OCAMLBUILD) -clean
	rm -rf stamp

depcheck: Makefile.dep
	@buildtools/depcheck.sh $<

stamp:
	mkdir $@

stamp/magic-conf:
	cd $(FILEDIR); ./configure && cd - && touch $@

stamp/magic-make: $(FILEDIR)/src/file
	cd $(FILEDIR); make && cd - && touch $@

libmagic: stamp stamp/magic-conf stamp/magic-make

.PHONY: all clean depcheck libmagic
