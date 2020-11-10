use v6;

use Test;

plan 46;

# $?PERL.name is the Perl we were compiled in.
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo skip 'unimpl $?PERL RT #124624'
{
    ok $?PERL.name,      "We were compiled in '{$?PERL.name}'";
    ok $?PERL.auth,      "Authority is '{$?PERL.auth}'";
    ok $?PERL.version,   "Version is '{$?PERL.version}'";
    ok $?PERL.signature, "Signature is '{$?PERL.signature}'";
    ok $?PERL.desc,      "Description is '{$?PERL.desc}'";
    ok $?PERL.compiler,  "Has compiler info";

    ok $?PERL.raku ~~ m/\w/, 'We can do a $?PERL.raku';
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
    ok $C.codename,   "Codename is '{$C.codename}'";

    ok $C.raku, 'We can do a $?PERL.compiler.raku';
    ok $C.gist, 'We can do a $?PERL.compiler.gist';

    isa-ok $C.version, Version;
    isa-ok $C.signature, Blob;
}

ok $*PERL.name,      "We are running under '{$*PERL.name}'";
ok $*PERL.auth,      "Authority is '{$*PERL.auth}'";
ok $*PERL.version,   "Version is '{$*PERL.version}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Perl.signature yet RT #124624'
ok $*PERL.signature, "Signature is '{$*PERL.signature}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Perl.desc yet RT #124624'
ok $*PERL.desc,      "Description is '{$*PERL.desc}'";
ok $*PERL.compiler,  "Has compiler info";

ok $*PERL.raku ~~ m/\w/, 'We can do a $*PERL.raku';
ok $*PERL.gist ~~ m/\w/, 'We can do a $*PERL.gist';
ok $*PERL.Str  ~~ m/\w/, 'We can do a $*PERL.Str';

isa-ok $*PERL.version, Version;
# https://github.com/Raku/old-issue-tracker/issues/3918
isa-ok $*PERL.signature, Blob;
isa-ok $*PERL.compiler, Compiler;

my $C = $*PERL.compiler;
ok $C.name,       "We were compiled in '{$C.name}'";
ok $C.auth,       "Authority is '{$C.auth}'";
ok $C.version,    "Version is '{$C.version}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Perl.compiler.signature yet RT #124624'
ok $C.signature,  "Signature is '{$C.signature}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Perl.compiler.desc yet RT #124624'
ok $C.desc,       "Description is '{$C.desc}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Perl.compiler.release yet RT #124624'
ok $C.release,    "Release is '{$C.release}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Perl.compiler.codename yet RT #124624'
ok $C.codename,   "Codename is '{$C.codename}'";

ok $C.raku, 'We can do a $?PERL.compiler.raku';
ok $C.gist, 'We can do a $?PERL.compiler.gist';

isa-ok $C.version, Version;
isa-ok $C.signature, Blob;

# vim: expandtab shiftwidth=4
