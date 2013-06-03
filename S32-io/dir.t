use v6;
use Test;

plan 8;

# L<S32::IO/Functions/"=item dir">

my @files;
ok (@files = dir()), "dir() runs in cwd()";

# see roast's README as for why there is always a t/ available
#?niecza skip "Grepping Str against a list of IO::Path does not work"
ok @files.grep('t'), 'current directory contains a t/ dir';
isa_ok @files[0], IO::Path, 'dir() returns IO::Path objects';
is @files[0].directory, '.', 'dir() returns IO::Path object in the current directory';

#?niecza 3 skip "Grepping Str against a list of IO::Path does not work"
nok @files.grep('.'|'..'), '"." and ".." are not returned';
is +dir(:test).grep('.'|'..'), 2, "... unless you override :test";
nok dir( test=> none('.', '..', 't') ).grep('t'), "can exclude t/ dir";

is dir('t').[0].directory, 't', 'dir("t") returns paths with .directory of "t"';


