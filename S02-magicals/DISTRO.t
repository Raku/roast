use v6;

use Test;

plan 28;

=begin kwid

Config Tests

If this test fails because your osname is not listed here, please add it.
But don't add other osnames just because you know of them. That way we can
get a list of osnames that have actually passed tests.

=end kwid

# $?DISTRO.name is the OS we were compiled in.
#?rakudo skip 'unimpl $?DISTRO RT #124616'
{
    ok $?DISTRO.name,      "We were compiled in '{$?DISTRO.name}'";
    ok $?DISTRO.auth,      "Authority is '{$?DISTRO.auth}'";
    ok $?DISTRO.version,   "Version is '{$?DISTRO.version}'";
    ok $?DISTRO.signature, "Signature is '{$?DISTRO.signature}'";
    ok $?DISTRO.desc,      "Description is '{$?DISTRO.desc}'";
    ok $?DISTRO.release,   "Release info is '{$?DISTRO.release}'";
    ok $?DISTRO.path-sep,  "Path separator is '{$?DISTRO.path-sep}'";

    ok $?DISTRO.perl ~~ m/\w/, 'We can do a $?DISTRO.perl';
    ok $?DISTRO.gist ~~ m/\w/, 'We can do a $?DISTRO.gist';
    ok $?DISTRO.Str  ~~ m/\w/, 'We can do a $?DISTRO.Str';

    diag "'{$?DISTRO.name}' is an unknown DISTRO, please report" if !
      ok $?DISTRO.name eq any($?PERL.DISTROnames),
      "We know of the DISTRO we were compiled in";

    isa-ok $?DISTRO.version, Version;
    isa-ok $?DISTRO.signature, Blob;
    isa-ok $?DISTRO.is-win, Bool;
}

ok $*DISTRO.name,      "We are running under '{$*DISTRO.name}'";
ok $*DISTRO.auth,      "Authority is '{$*DISTRO.auth}'";
ok $*DISTRO.version,   "Version is '{$*DISTRO.version}'";
#?rakudo.jvm    todo 'no Distro.signature yet RT #124617'
#?rakudo.moar   todo 'no Distro.signature yet RT #124618'
#?rakudo.parrot skip 'no Distro.signature yet RT #124619'
ok $*DISTRO.signature, "Signature is '{$*DISTRO.signature}'";
#?rakudo.parrot skip 'no Distro.desc yet RT #124620'
ok $*DISTRO.desc,      "Description is '{$*DISTRO.desc}'";
ok $*DISTRO.release,   "Release info is '{$*DISTRO.release}'";
ok $*DISTRO.path-sep,  "Path separator is '{$*DISTRO.path-sep}'";

ok $*DISTRO.perl ~~ m/\w/, 'We can do a $*DISTRO.perl';
ok $*DISTRO.gist ~~ m/\w/, 'We can do a $*DISTRO.gist';
ok $*DISTRO.Str  ~~ m/\w/, 'We can do a $*DISTRO.Str';

ok $*DISTRO.name, 'Non-empty $*DISTRO.name';

isa-ok $*DISTRO.version, Version;
#?rakudo.jvm    todo 'no Distro.signature yet RT #124621'
#?rakudo.moar   todo 'no Distro.signature yet RT #124622'
#?rakudo.parrot skip 'no Distro.signature yet RT #124623'
isa-ok $*DISTRO.signature, Blob;
isa-ok $*DISTRO.is-win, Bool;

# vim: ft=perl6
