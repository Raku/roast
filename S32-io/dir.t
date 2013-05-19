use v6;
use Test;

plan 3;

# L<S32::IO/Functions/"=item dir">

my @files = dir();

# see roast's README as for why there is always a t/ available
ok @files.grep('t'), 'current directory contains a t/ dir';
isa_ok @files[0], IO::Path, 'dir() returns IO::Path objects';
#?rakudo: todo "returns empty directory"
ok @files[0].directory, 'dir() returns IO::Path object with a directory';
