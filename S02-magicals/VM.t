use v6;

use Test;

my $isjvm = $*VM.name eq 'jvm';
plan 28 + 2 * $isjvm;

# $?VM.name is the Virtual machine we were compiled in.
#?rakudo skip 'unimpl $?VM'
{
    ok $?VM.name,           "We were compiled in '{$?VM.name}'";
    ok $?VM.auth,           "Authority is '{$?VM.auth}'";
    ok $?VM.version,        "Version is '{$?VM.version}'";
    ok $?VM.signature,      "Signature is '{$?VM.signature}'";
    ok $?VM.desc,           "Description is '{$?VM.desc}'";
    ok $?VM.config,         "We have config";
    ok $?VM.properties,     "We have properties" if $isjvm;
    ok $?VM.desc,           "Description is '{$?VM.desc}'";
    ok $?VM.precomp-ext,    "Extension is '{$?VM.precomp-ext}'";
    ok $?VM.precomp-target, "Extension is '{$?VM.precomp-target}'";

    ok $?VM.perl, 'We can do a $?VM.perl';
    ok $?VM.gist, 'We can do a $?VM.gist';

    diag "'{$?VM.name}' is an unknown VM, please report" if !
      ok $?VM.name eq any($?PERL.VMnames),
      "We know of the VM we were compiled in";

    isa_ok $?VM.version, Version;
    isa_ok $?VM.signature, Blob;
}

ok $*VM.name,           "We are running under '{$*VM.name}'";
ok $*VM.auth,           "Authority is '{$*VM.auth}'";
ok $*VM.version,        "Version is '{$*VM.version}'";
#?rakudo todo 'no VM.signature yet'
ok $*VM.signature,      "Signature is '{$*VM.signature}'";
ok $*VM.config,         "We have config";
ok $*VM.properties,     "We have properties" if $isjvm;
#?rakudo todo 'no VM.desc yet'
ok $*VM.desc,           "Description is '{$*VM.desc}'";
ok $*VM.precomp-ext,    "Extension is '{$*VM.precomp-ext}'";
ok $*VM.precomp-target, "Extension is '{$*VM.precomp-target}'";

ok $*VM.perl, 'We can do a $*VM.perl';
ok $*VM.gist, 'We can do a $*VM.gist';

diag "'{$*VM.name}' is an unknown VM, please report" if !
  ok $*VM.name eq any($*PERL.VMnames),
  "We know of the VM we are running under";

isa_ok $*VM.version, Version;
#?rakudo todo 'no VM.signature yet'
isa_ok $*VM.signature, Blob;

# vim: ft=perl6
