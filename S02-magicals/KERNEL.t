use v6;

use Test;

plan 40;

# $?KERNEL.name is the kernel we were compiled in.
#?rakudo skip 'unimpl $?KERNEL RT #124624'
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

    isa-ok $?KERNEL.version, Version;
    isa-ok $?KERNEL.signature, Blob;
    isa-ok $?KERNEL.bits, Int;
}

ok $*KERNEL.name,      "We are running under '{$*KERNEL.name}'";
ok $*KERNEL.auth,      "Authority is '{$*KERNEL.auth}'";
ok $*KERNEL.version,   "Version is '{$*KERNEL.version}'";
#?rakudo todo 'no Kernel.signature yet RT #124625'
ok $*KERNEL.signature, "Signature is '{$*KERNEL.signature}'";
#?rakudo todo 'no Kernel.desc yet RT #124626'
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

isa-ok $*KERNEL.version, Version;
#?rakudo todo 'no Kernel.signature yet RT #124627'
isa-ok $*KERNEL.signature, Blob;
isa-ok $*KERNEL.bits, Int;

{
    ok $*KERNEL.signals ~~ Positional, 'did Kernel.signals return a list';
    is $*KERNEL.signals.elems, $*KERNEL.signals.grep(Signal|Any).elems,
      "do we have Signals only?  and Any's of course";

    #?rakudo.jvm emit # Type check failed for return value; expected ?:? but got Int (Int)
    my $hup = $*KERNEL.signal(SIGHUP);
    #?rakudo.jvm 6 skip "skip tests because of above failure"
    isa-ok $hup, Int, 'did we get an Int back';
    # #?rakudo.jvm todo "limited signal handling on jvm RT #124628"
    ok defined($hup), 'was the Int defined';
    isnt $hup, 0, "no signal should come out as 0";
    is $*KERNEL.signal("SIGHUP"), $hup, "also ok as string?";
    is $*KERNEL.signal("HUP"),    $hup, "also ok as partial string?";
    # #?rakudo.jvm skip "limited signal handling on jvm RT #124628"
    is $*KERNEL.signal($hup),     $hup, "also ok as Int?";
}

# vim: ft=perl6
