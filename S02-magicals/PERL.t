use v6;

use Test;

plan 50;

# $?PERL.name is the Perl we were compiled in.
#?rakudo skip 'unimpl $?PERL'
{
    ok $?PERL.name,      "We were compiled in '{$?PERL.name}'";
    ok $?PERL.auth,      "Authority is '{$?PERL.auth}'";
    ok $?PERL.version,   "Version is '{$?PERL.version}'";
    ok $?PERL.signature, "Signature is '{$?PERL.signature}'";
    ok $?PERL.desc,      "Description is '{$?PERL.desc}'";
    ok $?PERL.compiler,  "Has compiler info";

    ok $?PERL.perl ~~ m/\w/, 'We can do a $?PERL.perl';
    ok $?PERL.gist ~~ m/\w/, 'We can do a $?PERL.gist';
    ok $?PERL.Str  ~~ m/\w/, 'We can do a $?PERL.Str';

    isa_ok $?PERL.version, Version;
    isa_ok $?PERL.signature, Blob;
    isa_ok $?PERL.compiler, Compiler;

    my $C = $?PERL.compiler;
    ok $C.name,       "We were compiled in '{$C.name}'";
    ok $C.auth,       "Authority is '{$C.auth}'";
    ok $C.version,    "Version is '{$C.version}'";
    ok $C.signature,  "Signature is '{$C.signature}'";
    ok $C.desc,       "Description is '{$C.desc}'";
    ok $C.release,    "Release is '{$C.release}'";
    ok $C.build-date, "Build-date is '{$C.build-date}'";
    ok $C.codename,   "Codename is '{$C.codename}'";

    ok $C.perl, 'We can do a $?PERL.compiler.perl';
    ok $C.gist, 'We can do a $?PERL.compiler.gist';

    isa_ok $C.version, Version;
    isa_ok $C.signature, Blob;
    isa_ok $C.build-date, DateTime;
}

ok $*PERL.name,      "We are running under '{$*PERL.name}'";
ok $*PERL.auth,      "Authority is '{$*PERL.auth}'";
ok $*PERL.version,   "Version is '{$*PERL.version}'";
#?rakudo.jvm    todo 'no Perl.signature yet'
#?rakudo.moar   todo 'no Perl.signature yet'
#?rakudo.parrot skip 'no Perl.signature yet'
ok $*PERL.signature, "Signature is '{$*PERL.signature}'";
#?rakudo.jvm    todo 'no Perl.desc yet'
#?rakudo.moar   todo 'no Perl.desc yet'
#?rakudo.parrot skip 'no Perl.desc yet'
ok $*PERL.desc,      "Description is '{$*PERL.desc}'";
ok $*PERL.compiler,  "Has compiler info";

ok $*PERL.perl ~~ m/\w/, 'We can do a $*PERL.perl';
ok $*PERL.gist ~~ m/\w/, 'We can do a $*PERL.gist';
ok $*PERL.Str  ~~ m/\w/, 'We can do a $*PERL.Str';

isa_ok $*PERL.version, Version;
#?rakudo.jvm    todo 'no Perl.signature yet'
#?rakudo.moar   todo 'no Perl.signature yet'
#?rakudo.parrot skip 'no Perl.signature yet'
isa_ok $*PERL.signature, Blob;
isa_ok $*PERL.compiler, Compiler;

my $C = $*PERL.compiler;
ok $C.name,       "We were compiled in '{$C.name}'";
ok $C.auth,       "Authority is '{$C.auth}'";
ok $C.version,    "Version is '{$C.version}'";
#?rakudo.jvm    todo 'no Perl.compiler.signature yet'
#?rakudo.moar   todo 'no Perl.compiler.signature yet'
#?rakudo.parrot skip 'no Perl.compiler.signature yet'
ok $C.signature,  "Signature is '{$C.signature}'";
#?rakudo.jvm    todo 'no Perl.compiler.desc yet'
#?rakudo.moar   todo 'no Perl.compiler.desc yet'
#?rakudo.parrot skip 'no Perl.compiler.desc yet'
ok $C.desc,       "Description is '{$C.desc}'";
#?rakudo.jvm    todo 'no Perl.compiler.release yet'
#?rakudo.moar   todo 'no Perl.compiler.release yet'
#?rakudo.parrot skip 'no Perl.compiler.release yet'
ok $C.release,    "Release is '{$C.release}'";
ok $C.build-date, "Build-date is '{$C.build-date}'";
#?rakudo.jvm    todo 'no Perl.compiler.codename yet'
#?rakudo.moar   todo 'no Perl.compiler.codename yet'
#?rakudo.parrot skip 'no Perl.compiler.codename yet'
ok $C.codename,   "Codename is '{$C.codename}'";

ok $C.perl, 'We can do a $?PERL.compiler.perl';
ok $C.gist, 'We can do a $?PERL.compiler.gist';

isa_ok $C.version, Version;
#?rakudo.jvm    todo 'no Perl.compiler.signature yet'
#?rakudo.moar   todo 'no Perl.compiler.signature yet'
#?rakudo.parrot skip 'no Perl.compiler.signature yet'
isa_ok $C.signature, Blob;
isa_ok $C.build-date, DateTime;

# vim: ft=perl6
