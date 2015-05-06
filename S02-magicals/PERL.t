use v6;

use Test;

plan 50;

# $?PERL.name is the Perl we were compiled in.
#?rakudo skip 'unimpl $?PERL RT #124581'
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

    isa-ok $?PERL.version, Version;
    isa-ok $?PERL.signature, Blob;
    isa-ok $?PERL.compiler, Compiler;

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

    isa-ok $C.version, Version;
    isa-ok $C.signature, Blob;
    isa-ok $C.build-date, DateTime;
}

ok $*PERL.name,      "We are running under '{$*PERL.name}'";
ok $*PERL.auth,      "Authority is '{$*PERL.auth}'";
ok $*PERL.version,   "Version is '{$*PERL.version}'";
#?rakudo todo 'no Perl.signature yet RT #124582'
ok $*PERL.signature, "Signature is '{$*PERL.signature}'";
#?rakudo todo 'no Perl.desc yet RT #124585'
ok $*PERL.desc,      "Description is '{$*PERL.desc}'";
ok $*PERL.compiler,  "Has compiler info";

ok $*PERL.perl ~~ m/\w/, 'We can do a $*PERL.perl';
ok $*PERL.gist ~~ m/\w/, 'We can do a $*PERL.gist';
ok $*PERL.Str  ~~ m/\w/, 'We can do a $*PERL.Str';

isa-ok $*PERL.version, Version;
#?rakudo todo 'no Perl.signature yet RT #124588'
isa-ok $*PERL.signature, Blob;
isa-ok $*PERL.compiler, Compiler;

my $C = $*PERL.compiler;
ok $C.name,       "We were compiled in '{$C.name}'";
ok $C.auth,       "Authority is '{$C.auth}'";
ok $C.version,    "Version is '{$C.version}'";
#?rakudo todo 'no Perl.compiler.signature yet RT #124591'
ok $C.signature,  "Signature is '{$C.signature}'";
#?rakudo todo 'no Perl.compiler.desc yet RT #124594'
ok $C.desc,       "Description is '{$C.desc}'";
#?rakudo todo 'no Perl.compiler.release yet RT #124597'
ok $C.release,    "Release is '{$C.release}'";
ok $C.build-date, "Build-date is '{$C.build-date}'";
#?rakudo todo 'no Perl.compiler.codename yet RT #124600'
ok $C.codename,   "Codename is '{$C.codename}'";

ok $C.perl, 'We can do a $?PERL.compiler.perl';
ok $C.gist, 'We can do a $?PERL.compiler.gist';

isa-ok $C.version, Version;
#?rakudo todo 'no Perl.compiler.signature yet RT #124603'
isa-ok $C.signature, Blob;
isa-ok $C.build-date, DateTime;

# vim: ft=perl6
