OCaml-Magic
===========

OCaml-Magic is an OCaml interface to the libmagic (file type identification
library).

Usage
-----

1. **file.native**: a simple executable for identifying file type.
2. **magic.top**: an OCaml top-level interface for libmagic. A usage example is:
```
$ ./magic.top -I _build/src/
        OCaml version 4.02.1

# open Magic;;
# let m = init_magic MAGIC_NONE;;
val m : Magic.magic = <abstr>
# from_file m "/bin/ls";;
- : string = "Mach-O 64-bit x86_64 executable"
#
```
