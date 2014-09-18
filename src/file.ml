(** ocaml-magic

    @author Sang Kil Cha <sangkil.cha\@gmail.com>

*)
(*
    Copyright (c) 2014, Sang Kil Cha
    All rights reserved.
    This software is free software; you can redistribute it and/or
    modify it under the terms of the GNU Library General Public
    License version 2, with the special exception on linking
    described in file LICENSE.

    This software is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
*)

open Magic

let filecheck m file =
  let s = from_file m file in
  Printf.printf "%s: %s\n" file s

let _ =
  let file = try Sys.argv.(1) with _ -> failwith "provide a filename" in
  let m = init_magic MAGIC_MIME_TYPE in
  filecheck m file;
  destroy_magic m

