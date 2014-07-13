use v6;
use Test;

plan 60;

# initializations
chdir 't/spec/S22-package-format';
my $cwd := $*CWD;
my $nanoonanoo := '
use v6;
class NanooNanoo { }
';
my $module := 'NanooNanoo';
my $srcext := 'pm';
my $src    := "$module.$srcext";
my $srcdir := 'local-file-src';  
my $srcsrc := "$srcdir/$src";
my $cmpext := $*VM.precomp-ext;
my $cmpdir := 'local-file-cmp';
my $cmpsrc := "$cmpdir/$src";
my $cmpcmp := "$cmpdir/$module.$cmpext";

# creating dirs / files needed
my $initialized = True; # try to cleanup from here on out
ok mkdir($srcdir), "Could we create '$srcdir'";
ok $srcsrc.IO.spurt($nanoonanoo), "Could we create '$srcsrc'";
ok mkdir($cmpdir), "Could we create $cmpdir";
ok $cmpsrc.IO.spurt($nanoonanoo), "Could we create '$cmpsrc'";

#?rakudo.jvm    skip 'cannot do signals in JVM'
#?rakudo.parrot skip 'cannot do signals in parrot'
ok signal(SIGINT).tap( {die} ), 'install Ctrl-C handler for cleanup in END';

# basic CURLF sanity
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

# checking with/without precomp
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

# basic CompUnit sanity
is $compunit.from,        'Perl6', "is the language 'Perl6'";
is $compunit.name,        $module, "is the name '$module'";
is $compunit.extension,   $srcext, "is the extension '$srcext'";
is $compunit.path, "$cwd/$srcsrc", "is the path '$srcsrc'";
is $compunit.loaded,        False, "is the module loaded";
is $compunit.precomped,     False, "is the module pre-compiled";

# create precomp file after creating CURLF object, so we sure it reads on-demand
$curlf = CompUnitRepo::Local::File.new($cmpdir);
isa_ok $curlf, CompUnitRepo::Local::File;
ok $compunit.precomp($cmpcmp), 'did we pre-compile ok?';

# does it find the precomped version
my $candidates = $curlf.candidates;
ok $candidates ~~ Positional, "did we get a Positional";
is $candidates.elems, 1, "did we get 1 candidate";
$compunit = $candidates[0];
isa_ok $compunit, CompUnit;
is $compunit.from,        'Perl6', "is the language 'Perl6'";
is $compunit.name,        $module, "is the name '$module'";
is $compunit.extension,   $cmpext, "is the extension '$cmpext'";
is $compunit.path, "$cwd/$cmpcmp", "is the path '$cmpcmp'";
is $compunit.loaded,        False, "is the module loaded";
is $compunit.precomped,      True, "is the module pre-compiled";

# force it to skip pre-comped version
$candidates = $curlf.candidates(:no-precomp);
ok $candidates ~~ Positional, "did we get a Positional";
is $candidates.elems, 1, "did we get 1 candidate";
$compunit = $candidates[0];
isa_ok $compunit, CompUnit;
is $compunit.from,        'Perl6', "is the language 'Perl6'";
is $compunit.name,        $module, "is the name '$module'";
is $compunit.extension,   $srcext, "is the extension '$srcext'";
is $compunit.path, "$cwd/$cmpsrc", "is the path '$cmpsrc'";
is $compunit.loaded,        False, "is the module loaded";
is $compunit.precomped,     False, "is the module pre-compiled";

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
