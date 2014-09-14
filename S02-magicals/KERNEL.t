use v6;

use Test;

plan 37;

# $?KERNEL.name is the kernel we were compiled in.
#?rakudo skip 'unimpl $?KERNEL'
{
    ok $?KERNEL.name,      "We were compiled in '{$?KERNEL.name}'";
    ok $?KERNEL.auth,      "Authority is '{$?KERNEL.auth}'";
    ok $?KERNEL.version,   "Version is '{$?KERNEL.version}'";
    ok $?KERNEL.signature, "Signature is '{$?KERNEL.signature}'";
    ok $?KERNEL.desc,      "Description is '{$?KERNEL.desc}'";
    ok $?KERNEL.release,   "Release info is '{$?KERNEL.release}'";
    ok $?KERNEL.hardware,  "Hardware info is '{$?KERNEL.hardware}'";
    ok $?KERNEL.arch,      "Architecture info is '{$?KERNEL.arch}'";
    ok $?KERNEL.bits,      "Number of bits is '{$?KERNEL.bits}'";

    ok $?KERNEL.perl ~~ m/\w/, 'We can do a $?KERNEL.perl';
    ok $?KERNEL.gist ~~ m/\w/, 'We can do a $?KERNEL.gist';
    ok $?KERNEL.Str  ~~ m/\w/, 'We can do a $?KERNEL.Str';

    diag "'{$?KERNEL.name}' is an unknown KERNEL, please report" if !
      ok $?KERNEL.name eq any($?PERL.KERNELnames),
      "We know of the KERNEL we were compiled in";

    isa_ok $?KERNEL.version, Version;
    isa_ok $?KERNEL.signature, Blob;
    isa_ok $?KERNEL.bits, Int;
}

ok $*KERNEL.name,      "We are running under '{$*KERNEL.name}'";
ok $*KERNEL.auth,      "Authority is '{$*KERNEL.auth}'";
ok $*KERNEL.version,   "Version is '{$*KERNEL.version}'";
#?rakudo todo 'no Kernel.signature yet'
ok $*KERNEL.signature, "Signature is '{$*KERNEL.signature}'";
#?rakudo todo 'no Kernel.desc yet'
ok $*KERNEL.desc,      "Description is '{$*KERNEL.desc}'";
ok $*KERNEL.release,   "Release info is '{$*KERNEL.release}'";
ok $*KERNEL.hardware,  "Hardware info is '{$*KERNEL.hardware}'";
ok $*KERNEL.arch,      "Architecture info is '{$*KERNEL.arch}'";
ok $*KERNEL.bits,      "Number of bits is '{$*KERNEL.bits}'";

ok $*KERNEL.perl ~~ m/\w/, 'We can do a $*KERNEL.perl';
ok $*KERNEL.gist ~~ m/\w/, 'We can do a $*KERNEL.gist';
ok $*KERNEL.Str  ~~ m/\w/, 'We can do a $*KERNEL.Str';

diag "'{$*KERNEL.name}' is an unknown KERNEL, please report" if !
  ok $*KERNEL.name eq any($*PERL.KERNELnames),
  "We know of the KERNEL we are running under";

isa_ok $*KERNEL.version, Version;
#?rakudo todo 'no Kernel.signature yet'
isa_ok $*KERNEL.signature, Blob;
isa_ok $*KERNEL.bits, Int;

if $*VM.name ne 'moar' {
    skip_rest("Not supported on {$*VM.name}")
}
else {
    ok $*KERNEL.signals ~~ Positional, 'did Kernel.signals return a list';
    is $*KERNEL.signals.elems, $*KERNEL.signals.grep(Signal|Any).elems,
      "do we have Signals only?  and Any's of course";

    my $hup = $*KERNEL.signal(SIGHUP);
    isnt $hup, 0, "no signal should come out as 0";
    is $*KERNEL.signal("SIGHUP"), $hup, "also ok as string?";
    is $*KERNEL.signal("HUP"),    $hup, "also ok as partial string?";
}

# vim: ft=perl6
