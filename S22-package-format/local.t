use v6;
use Test;

plan 11;

chdir 't/spec/S22-package-format';
my $cwd = $*CWD;

my $curlf1 = CompUnitRepo::Local::File.new(".");
isa_ok $curlf1, CompUnitRepo::Local::File;
isa_ok $curlf1.path, IO::Path;
is $curlf1.path, $cwd, 'is . looking at the right directory';
is $curlf1.short-id, 'file', 'is the short-id right';
dies_ok { $curlf1.install( "foo" ) }, 'Cannot install on CUR::File';

my $curlf2 = CompUnitRepo::Local::File.new(".");
isa_ok $curlf2, CompUnitRepo::Local::File;
ok $curlf1 === $curlf2, 'are they the same';

my $curlf3 = CompUnitRepo::Local::File.new("local");
isa_ok $curlf3, CompUnitRepo::Local::File;
ok $curlf2 !=== $curlf3, 'are they different';
isa_ok $curlf3.path, IO::Path;
is $curlf3.path, IO::Path.new("$cwd/local"), 'is "local" looking at the right dir';

say $curlf3.candidates('Shazbat');

say $*CWD;
