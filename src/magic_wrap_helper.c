/// ocaml-magic

/*
Copyright (c) 2014, Sang Kil Cha
All rights reserved.
This software is free software; you can redistribute it and/or
modify it under the terms of the GNU Library General Public
License version 2, with the special exception on linking
described in file LICENSE.

This software is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
*/

#include <stdio.h>
#include <string.h>
#include "magic_wrap.h"
#include "magic.h"

magic_ptr init_magic( int* r, const char* filename )
{
    magic_t m = magic_open( MAGIC_NONE );
    if ( strlen( filename ) == 0 )
        *r = magic_load( m, NULL );
    else
        *r = magic_load( m, filename );
    return (magic_ptr) m;
}

void destroy_magic( magic_ptr m )
{
    magic_close( m );
}

char* from_file( magic_ptr p, const char* filename )
{
    return (char*) magic_file( (magic_t) p, filename );
}

