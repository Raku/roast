use v6;
use Test;

plan 2;

my @files = dir();

# see roast's README as for why there is always a t/ available
ok @files.grep('t'), 'current directory contains a t/ dir';
isa_ok @files[0], IO::Path, 'dir() returns IO::Path objects';
