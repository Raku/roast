use v6;
use Test;

plan 12;

# L<S32::IO/IO::Path>

my $path = '/foo/bar.txt'.path;
isa_ok $path, IO::Path, "Str.path returns an IO::Path";
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
#?rakudo 3 skip 'need to test OS submodules instead'
is '/'.path.Str,        '/',       '.path.Str roundtrips';
is '///.'.path.Str,     '///.',    '... even for weird cases';
is 'foo/bar'.path.Str,  'foo/bar', 'roundtrips entire path';
