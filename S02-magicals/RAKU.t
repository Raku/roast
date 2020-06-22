use v6;

use Test;

plan 46;

#?rakudo 46 skip q<$*RAKU and $?RAKU aren't implemented yet>
# $?RAKU.name is the Raku we were compiled in.
# The following fudge directive must be uncommented when Raku is ready for it.
# https://github.com/Raku/old-issue-tracker/issues/3918
##?rakudo skip 'unimpl $?RAKU RT #124624'
{
    ok $?RAKU.name,      "We were compiled in '{$?RAKU.name}'";
    ok $?RAKU.auth,      "Authority is '{$?RAKU.auth}'";
    ok $?RAKU.version,   "Version is '{$?RAKU.version}'";
    ok $?RAKU.signature, "Signature is '{$?RAKU.signature}'";
    ok $?RAKU.desc,      "Description is '{$?RAKU.desc}'";
    ok $?RAKU.compiler,  "Has compiler info";

    ok $?RAKU.raku ~~ m/\w/, 'We can do a $?RAKU.raku;
    ok $?RAKU.gist ~~ m/\w/, 'We can do a $?RAKU.gist';
    ok $?RAKU.Str  ~~ m/\w/, 'We can do a $?RAKU.Str';

    isa-ok $?RAKU.version, Version;
    isa-ok $?RAKU.signature, Blob;
    isa-ok $?RAKU.compiler, Compiler;

    my $C = $?RAKU.compiler;
    ok $C.name,       "We were compiled in '{$C.name}'";
    ok $C.auth,       "Authority is '{$C.auth}'";
    ok $C.version,    "Version is '{$C.version}'";
    ok $C.signature,  "Signature is '{$C.signature}'";
    ok $C.desc,       "Description is '{$C.desc}'";
    ok $C.release,    "Release is '{$C.release}'";
    ok $C.codename,   "Codename is '{$C.codename}'";

    ok $C.raku, 'We can do a $?RAKU.compiler.raku;
    ok $C.gist, 'We can do a $?RAKU.compiler.gist';

    isa-ok $C.version, Version;
    isa-ok $C.signature, Blob;
}

ok $*RAKU.name,      "We are running under '{$*RAKU.name}'";
ok $*RAKU.auth,      "Authority is '{$*RAKU.auth}'";
ok $*RAKU.version,   "Version is '{$*RAKU.version}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no raku.signature yet RT #124624'
ok $*RAKU.signature, "Signature is '{$*RAKU.signature}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Raku.desc yet RT #124624'
ok $*RAKU.desc,      "Description is '{$*RAKU.desc}'";
ok $*RAKU.compiler,  "Has compiler info";

ok $*RAKU.raku ~~ m/\w/, 'We can do a $*RAKU.raku;
ok $*RAKU.gist ~~ m/\w/, 'We can do a $*RAKU.gist';
ok $*RAKU.Str  ~~ m/\w/, 'We can do a $*RAKU.Str';

isa-ok $*RAKU.version, Version;
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Raku.signature yet RT #124624'
isa-ok $*RAKU.signature, Blob;
isa-ok $*RAKU.compiler, Compiler;

{
my $C = $*RAKU.compiler;
ok $C.name,       "We were compiled in '{$C.name}'";
ok $C.auth,       "Authority is '{$C.auth}'";
ok $C.version,    "Version is '{$C.version}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Raku.compiler.signature yet RT #124624'
ok $C.signature,  "Signature is '{$C.signature}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Raku.compiler.desc yet RT #124624'
ok $C.desc,       "Description is '{$C.desc}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Raku.compiler.release yet RT #124624'
ok $C.release,    "Release is '{$C.release}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Raku.compiler.codename yet RT #124624'
ok $C.codename,   "Codename is '{$C.codename}'";
}

ok $C.raku, 'We can do a $?RAKU.compiler.raku;
ok $C.gist, 'We can do a $?RAKU.compiler.gist';

isa-ok $C.version, Version;
#?rakudo todo 'no Raku.compiler.signature yet'
isa-ok $C.signature, Blob;

# vim: expandtab shiftwidth=4
