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
	$(OCAMLBUILD) -Is src -Xs buildtools,$(FILEDIR),file ocamlMagic.cmxa \
	file.native

clean: depcheck
	$(OCAMLBUILD) -clean
	rm -rf stamp

depcheck: Makefile.dep
	@buildtools/depcheck.sh $<

stamp:
	mkdir $@

stamp/magic-conf:
	cd $(FILEDIR); ./configure --enable-static && cd - && touch $@

stamp/magic-make:
	make -C $(FILEDIR) && touch $@

file:
	ln -sf $(FILEDIR) $@

libmagic: stamp stamp/magic-conf stamp/magic-make file

install: depcheck all
	ocamlfind install ocaml-magic META \
		_build/src/ocamlMagic.cmxa \
		_build/src/ocamlMagic.a \
		_build/src/magic.cmi \
		_build/src/magic.mli \
		_build/dllmagic_stubs.so \
		_build/libmagic_stubs.a

.PHONY: all clean depcheck libmagic install
