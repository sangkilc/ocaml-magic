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

open Magic_wrap

type magic = magic_ptr

type magic_flag =
  | MAGIC_NONE
  | MAGIC_MIME_TYPE
  | MAGIC_MIME

let flag_to_int = function (* these are from file/src/magic.h *)
  | MAGIC_NONE      -> 0x0
  | MAGIC_MIME_TYPE -> 0x10
  | MAGIC_MIME      -> 0x410

let magic_file = "magic.mgc"
let resolve_magic_path cwd =
  let path1 = Filename.concat cwd magic_file in
  let path2 = Filename.concat (Filename.concat cwd "file/magic") magic_file in
  if Sys.file_exists path1 then path1
  else if Sys.file_exists path2 then path2
  else ""

let init_magic flag =
  let path = resolve_magic_path (Unix.getcwd ()) in
  let flag = flag_to_int flag in
  match init_magic path flag with
    | m, 0 -> m
    | _, _ -> failwith "failed to initialize libmagic"

let destroy_magic = destroy_magic
let from_file = from_file

