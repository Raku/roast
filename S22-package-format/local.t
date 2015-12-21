use v6;
use Test;

plan 19;

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
my $base   := $*SPEC.catdir($cwd, <t spec S22-package-format>);
my $srcdir := $*SPEC.catdir($base, 'local-file-src');
my $srcsrc := $*SPEC.catdir($srcdir, $src);
my $cmpext := $*VM.precomp-ext;
my $cmpdir := "$base/local-file-cmp";
my $cmpsrc := "$cmpdir/$src"; # should not exist
my $cmpcmp := "$cmpdir/$src.$cmpext";

# creating dirs / files needed
my $initialized = True; # try to cleanup from here on out
ok mkdir($srcdir), "Could we create '$srcdir'";
ok $srcsrc.IO.spurt($nanoonanoo), "Could we create '$srcsrc'";
ok mkdir($cmpdir), "Could we create $cmpdir";

#?rakudo.jvm    skip 'cannot do signals in JVM RT #124628'
ok signal(SIGINT).tap( {die} ), 'install Ctrl-C handler for cleanup in END';

# basic CURLF sanity
my $curlf1 = CompUnit::Repository::FileSystem.new(:prefix($cwd.Str));
isa-ok $curlf1, CompUnit::Repository::FileSystem;
isa-ok $curlf1.prefix, IO::Path;
is $curlf1.prefix, $cwd, 'is . looking at the right directory';
is $curlf1.short-id, 'file', 'is the short-id right';
dies-ok { $curlf1.install( "foo" ) }, 'Cannot install on CUR::FileSystem';

my $curlf2 = CompUnit::Repository::FileSystem.new(:prefix($cwd.Str));
isa-ok $curlf2, CompUnit::Repository::FileSystem;
ok $curlf1 === $curlf2, 'are they the same';

my $curlf = CompUnit::Repository::FileSystem.new(:prefix($srcdir.Str));
isa-ok $curlf, CompUnit::Repository::FileSystem;
ok $curlf2 !=== $curlf, 'are they different';
isa-ok $curlf.prefix, IO::Path;
is $curlf.prefix, IO::Path.new($srcdir), "is '$srcdir' looking at the right dir";

# all candidates
my $compunit-src = $curlf.need(CompUnit::DependencySpecification.new(:short-name<NanooNanoo>));
subtest {
    if isa-ok $compunit-src, CompUnit {
        is $compunit-src.from,        'Perl6', "is the language 'Perl6'";
        is $compunit-src.short-name,  $module, "is the name '$module'";
        is $compunit-src.precompiled,   False, "is the module pre-compiled";
    }
}, 'is there one candidate and is it sane';

# a specific existing candidate
my $second = $curlf.need(CompUnit::DependencySpecification.new(:short-name<NanooNanoo>));
isa-ok $second, CompUnit;
ok $compunit-src === $second, 'did we get the same CompUnit object';

# a specific non-existing candidate
throws-like { $curlf.need(CompUnit::DependencySpecification.new(:short-name<Shazbat>)) }, X::CompUnit::UnsatisfiedDependency;

# always cleanup
END {
    if $initialized {
        try unlink $srcsrc;
        try rmdir $srcdir;
        try unlink $cmpcmp;
        try rmdir $cmpdir;
    }
}
