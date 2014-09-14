use v6;
use Test;

plan 40;

# initializations
my $cwd := $*CWD;
my $nanoonanoo := '
use v6;
use Test;
class NanooNanoo { }
';
my $module := 'NanooNanoo';
my $srcext := 'pm';
my $src    := "$module.$srcext";
my $base   := "$cwd/t/spec/S22-package-format";
my $srcdir := "$base/local-file-src";  
my $srcsrc := "$srcdir/$src";
my $cmpext := $*VM.precomp-ext;
my $cmpdir := "$base/local-file-cmp";
my $cmpsrc := "$cmpdir/$src"; # should not exist
my $cmpcmp := "$cmpdir/$src.$cmpext";

# creating dirs / files needed
my $initialized = True; # try to cleanup from here on out
ok mkdir($srcdir), "Could we create '$srcdir'";
ok $srcsrc.IO.spurt($nanoonanoo), "Could we create '$srcsrc'";
ok mkdir($cmpdir), "Could we create $cmpdir";

#?rakudo.jvm    skip 'cannot do signals in JVM'
#?rakudo.parrot skip 'cannot do signals in parrot'
ok signal(SIGINT).tap( {die} ), 'install Ctrl-C handler for cleanup in END';

# basic CURLF sanity
my $curlf1 = CompUnitRepo::Local::File.new($cwd);
isa_ok $curlf1, CompUnitRepo::Local::File;
isa_ok $curlf1.path, IO::Path;
is $curlf1.path, $cwd, 'is . looking at the right directory';
is $curlf1.short-id, 'file', 'is the short-id right';
dies_ok { $curlf1.install( "foo" ) }, 'Cannot install on CUR::File';

my $curlf2 = CompUnitRepo::Local::File.new($cwd);
isa_ok $curlf2, CompUnitRepo::Local::File;
ok $curlf1 === $curlf2, 'are they the same';

my $curlf = CompUnitRepo::Local::File.new($srcdir);
isa_ok $curlf, CompUnitRepo::Local::File;
ok $curlf2 !=== $curlf, 'are they different';
isa_ok $curlf.path, IO::Path;
is $curlf.path, IO::Path.new($srcdir), "is '$srcdir' looking at the right dir";

# all candidates
my $candidates = $curlf.candidates('NanooNanoo');
is $candidates.elems, 1, "did we get 1 candidate";
my $compunit-src = $candidates[0];
isa_ok $compunit-src, CompUnit;

# a specific existing candidate
$candidates = $curlf.candidates('NanooNanoo');
is $candidates.elems, 1, "did we get 1 candidate";
my $second = $candidates[0];
isa_ok $second, CompUnit;
ok $compunit-src === $second, 'did we get the same CompUnit object';

# a specific non-existing candidate
$candidates = $curlf.candidates('Shazbat');
is $candidates.elems, 0, "did we get 0 candidates";

# basic CompUnit sanity
is $compunit-src.from,        'Perl6', "is the language 'Perl6'";
is $compunit-src.name,        $module, "is the name '$module'";
is $compunit-src.extension,   $srcext, "is the extension '$srcext'";
is $compunit-src.path,        $srcsrc, "is the path '$srcsrc'";
is $compunit-src.is-loaded,     False, "is the module is-loaded";
is $compunit-src.has-source,     True, "do we have the source?";
is $compunit-src.has-precomp,   False, "is the module pre-compiled";

# create precomp file after creating CURLF, so we're sure it reads on-demand
$curlf = CompUnitRepo::Local::File.new($cmpdir);
isa_ok $curlf, CompUnitRepo::Local::File;
ok $compunit-src.precomp($cmpcmp),   'did we pre-compile ok?';
is $compunit-src.has-precomp, False, "is the module pre-compiled";

# does it find the precomped version (without a source being present)
$candidates = $curlf.candidates('NanooNanoo');
is $candidates.elems, 1, "did we get 1 candidate";
my $compunit-cmp = $candidates[0];
isa_ok $compunit-cmp, CompUnit;
is $compunit-cmp.from,        'Perl6', "is the language 'Perl6'";
is $compunit-cmp.name,        $module, "is the name '$module'";
is $compunit-cmp.extension,   $srcext, "is the extension '$srcext'";
is $compunit-cmp.path,        $cmpsrc, "is the path '$cmpsrc'";
is $compunit-cmp.is-loaded,     False, "is the module is-loaded";
is $compunit-cmp.has-source,    False, "don't we have the source?";
is $compunit-cmp.has-precomp,    True, "is the module pre-compiled";

# always cleanup
END {
    if $initialized {
        try unlink $srcsrc;
        try rmdir $srcdir;
        try unlink $cmpcmp;
        try rmdir $cmpdir;
    }
}
