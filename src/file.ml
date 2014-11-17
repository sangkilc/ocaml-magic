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

let filelist = ref []

let filecheck m =
  if List.length !filelist = 0 then raise (Arg.Bad "file name not given")
  else
    List.iter (fun file ->
      let s = from_file m file in
      Printf.printf "%s: %s\n" file s
    ) (List.rev !filelist)

let use_mime = ref false

let spec =
  [
    ("-mime", Arg.Set use_mime, " use MIME");
  ]

let anon file = filelist := file::!filelist
let usage = "Usage: ./file [options] <file(s)>\n"

let _ =
  Arg.parse (Arg.align spec) anon usage;
  let opt = if !use_mime then MAGIC_MIME_TYPE else MAGIC_NONE in
  let m = init_magic opt in
  filecheck m;
  destroy_magic m

