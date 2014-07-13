use v6;
use Test;

plan 39;

chdir 't/spec/S22-package-format';
my $cwd := $*CWD;
my $nanoonanoo := '
use v6;
class NanooNanoo { }
';
my $module := 'NanooNanoo';
my $ext    := 'pm';
my $src    := "$module.$ext";
my $srcdir := 'local-file-src';  
my $srcsrc := "$srcdir/$src";
my $cmpdir := 'local-file-cmp';
my $cmpsrc := "$cmpdir/$src";
my $cmpcmp := "$cmpdir/$module\.{$*VM.precomp-ext}";

my $initialized = True; # try to cleanup from here on out
ok mkdir($srcdir), "Could we create '$srcdir'";
ok $srcsrc.IO.spurt($nanoonanoo), "Could we create '$srcsrc'";
ok mkdir($cmpdir), "Could we create $cmpdir";
ok $cmpsrc.IO.spurt($nanoonanoo), "Could we create '$cmpsrc'";

#?rakudo.parrot skip 'cannot do signals in parrot'
ok signal(SIGINT).tap( {die} ), 'install Ctrl-C handler for cleanup in END';

my $curlf1 = CompUnitRepo::Local::File.new(".");
isa_ok $curlf1, CompUnitRepo::Local::File;
isa_ok $curlf1.path, IO::Path;
is $curlf1.path, $cwd, 'is . looking at the right directory';
is $curlf1.short-id, 'file', 'is the short-id right';
dies_ok { $curlf1.install( "foo" ) }, 'Cannot install on CUR::File';

my $curlf2 = CompUnitRepo::Local::File.new(".");
isa_ok $curlf2, CompUnitRepo::Local::File;
ok $curlf1 === $curlf2, 'are they the same';

my $curlf = CompUnitRepo::Local::File.new($srcdir);
isa_ok $curlf, CompUnitRepo::Local::File;
ok $curlf2 !=== $curlf, 'are they different';
isa_ok $curlf.path, IO::Path;
is $curlf.path, IO::Path.new("$cwd/$srcdir"), "is '$srcdir' looking at the right dir";

my $compunit;
for False, True -> $no-precomp {
    my $what = $no-precomp ?? ' with :no-precomp' !! '';

    # all candidates
    my $candidates = $curlf.candidates(:$no-precomp);
    ok $candidates ~~ Positional, "did we get a Positional$what";
    is $candidates.elems, 1, "did we get 1 candidate$what";
    $compunit = $candidates[0];
    isa_ok $compunit, CompUnit;

    # a specific existing candidate
    $candidates = $curlf.candidates('NanooNanoo',:$no-precomp);
    ok $candidates ~~ Positional, "did we get a Positional$what";
    is $candidates.elems, 1, "did we get 1 candidate$what";
    my $second = $candidates[0];
    isa_ok $second, CompUnit;
    ok $compunit === $second, 'did we get the same CompUnit object';

    # a specific non-existing candidate
    $candidates = $curlf.candidates('Shazbat',:$no-precomp);
    ok $candidates ~~ Positional, "did we get a Positional$what";
    is $candidates.elems, 0, "did we get 0 candidates$what";
}

is $compunit.from,        'Perl6', "is the language 'Perl6'";
is $compunit.name,        $module, "is the name '$module'";
is $compunit.extension,      $ext, "is the extension '$ext'";
is $compunit.path, "$cwd/$srcsrc", "is the path '$srcsrc'";
is ?$compunit.loaded,       False, "is the module loaded";

# always cleanup
END {
    if $initialized {
        try unlink $srcsrc;
        try rmdir $srcdir;
        try unlink $cmpsrc;
        try unlink $cmpcmp;
        try rmdir $cmpdir;
    }
}
