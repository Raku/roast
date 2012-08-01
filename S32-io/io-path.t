use v6;
use Test;

plan 5;

my $path = '/foo/bar.txt'.path;
isa_ok $path, IO::Path;
is $path.directory, '/foo', 'directory';
is $path.basename, 'bar.txt', 'basename';

is '/'.path.path, '/', '.path.path roundtrips';
is '///.'.path.path, '///.', '... even for weird cases';
