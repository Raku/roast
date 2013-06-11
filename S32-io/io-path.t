use v6;
use Test;

plan 10;

# L<S32::IO/IO::Path>

my $path = '/foo/bar.txt'.path;
isa_ok $path, IO::Path, "Str.path returns an IO::Path";
is IO::Path.gist, "(IO::Path)", ".gist returns the correct thing on an IO::Path type object";

is $path.volume,    '',        'volume';
is $path.directory, '/foo',    'directory';
is $path.basename,  'bar.txt', 'basename';
#?niecza 2 skip '.parent NYI'
is $path.parent,    '/foo',    'parent';
is $path.parent.parent, '/',   'parent of parent';
#?niecza 2 skip '.is-absolute, .is-relative NYI'
is $path.is-absolute, True,    'is-absolute';
is $path.is-relative, False,   'is-relative';

isa_ok $path.path, IO::Path, 'IO::Path.path returns IO::Path';

# These tests aren't particularly platform independent
# is '/'.path.Str,        '/',       '.path.Str roundtrips';
# is '///.'.path.Str,     '///.',    '... even for weird cases';
# nor is this one
#is 'foo/bar'.path.Str,  'foo/bar', 'roundtrips entire path';
