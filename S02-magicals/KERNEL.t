use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 42;

# $?KERNEL.name is the kernel we were compiled in.
# https://github.com/Raku/old-issue-tracker/issues/3918
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

    ok $?KERNEL.raku ~~ m/\w/, 'We can do a $?KERNEL.raku';
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
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Kernel.signature yet RT #124624'
ok $*KERNEL.signature, "Signature is '{$*KERNEL.signature}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Kernel.desc yet RT #124624'
ok $*KERNEL.desc,      "Description is '{$*KERNEL.desc}'";
ok $*KERNEL.release,   "Release info is '{$*KERNEL.release}'";
ok $*KERNEL.hardware,  "Hardware info is '{$*KERNEL.hardware}'";
ok $*KERNEL.arch,      "Architecture info is '{$*KERNEL.arch}'";
ok $*KERNEL.bits,      "Number of bits is '{$*KERNEL.bits}'";
ok $*KERNEL.hostname,  "Hostname is '{$*KERNEL.hostname}'";

ok $*KERNEL.raku ~~ m/\w/, 'We can do a $*KERNEL.raku';
ok $*KERNEL.gist ~~ m/\w/, 'We can do a $*KERNEL.gist';
ok $*KERNEL.Str  ~~ m/\w/, 'We can do a $*KERNEL.Str';

diag "'{$*KERNEL.name}' is an unknown KERNEL, please report" if !
  ok $*KERNEL.name eq any($*RAKU.KERNELnames),
  "We know of the KERNEL we are running under";

isa-ok $*KERNEL.version, Version;
# https://github.com/Raku/old-issue-tracker/issues/3918
isa-ok $*KERNEL.signature, Blob;
isa-ok $*KERNEL.bits, Int;

#?rakudo.js.browser skip 'no signals in the browser'
{
    ok $*KERNEL.signals ~~ Positional, 'did Kernel.signals return a list';
    is $*KERNEL.signals.elems, $*KERNEL.signals.grep(Signal|Any).elems,
      "do we have Signals only?  and Any's of course";

    my $hup = $*KERNEL.signal(SIGHUP);
    isa-ok $hup, Int, 'did we get an Int back';
    ok defined($hup), 'was the Int defined';
    isnt $hup, 0, "no signal should come out as 0";
    is $*KERNEL.signal("SIGHUP"), $hup, "also ok as string?";
    is $*KERNEL.signal("HUP"),    $hup, "also ok as partial string?";
    is $*KERNEL.signal($hup),     $hup, "also ok as Int?";
}

# https://github.com/rakudo/rakudo/commit/01d948d2d2
#?rakudo.js.browser skip 'no signals in the browser'
is_run ｢print $*KERNEL.signal: 'SIGHUP';｣, {out => /^\d+$/},
    '.signal: Str:D works with un-initialized $*KERNEL.signals';

# vim: expandtab shiftwidth=4
