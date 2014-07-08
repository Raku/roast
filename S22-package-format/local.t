use v6;
use Test;

plan 21;

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

my $compdir = 'localfile';
my $curlf3 = CompUnitRepo::Local::File.new($compdir);
isa_ok $curlf3, CompUnitRepo::Local::File;
ok $curlf2 !=== $curlf3, 'are they different';
isa_ok $curlf3.path, IO::Path;
is $curlf3.path, IO::Path.new("$cwd/$compdir"), "is '$compdir' looking at the right dir";

for False, True -> $no-precomp {
    my $what = $no-precomp ?? ' with :no-precomp' !! '';
    my $candidates = $curlf3.candidates('NanooNanoo',:$no-precomp);
    ok $candidates ~~ Positional, "did we get a Positional$what";
    is $candidates.elems, 1, "did we get 1 candidate$what";
    isa_ok $candidates[0], CompUnit;

    $candidates = $curlf3.candidates('Shazbat',:$no-precomp);
    ok $candidates ~~ Positional, "did we get a Positional$what";
    is $candidates.elems, 0, "did we get 0 candidates$what";
}
