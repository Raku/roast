use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 41;

{
    my $p = Promise.new;
    is $p.status, Planned, "Newly created Promise has Planned status";
    nok $p.Bool, "Newly created Promise has now result yet";
    nok ?$p, "Newly created Promise is false";
    dies-ok { $p.cause }, "Cannot call cause on a Planned Promise";

    $p.keep("kittens");
    is $p.status, Kept, "Kept Promise has Kept status";
    ok $p.Bool, "Kept Promise has a result";
    ok ?$p, "Kept Promise is true";
    is $p.result, "kittens", "Correct result";

    dies-ok { $p.cause }, "Cannot call cause on a Kept Promise";
    throws-like { $p.cause }, X::Promise::CauseOnlyValidOnBroken,
        status => 'Kept';
    dies-ok { $p.keep("eating") }, "Cannot re-keep a Kept Promise";
    throws-like { $p.keep('eating') }, X::Promise::Vowed;
    dies-ok { $p.break("bad") }, "Cannot break a Kept Promise";
}

{
    my $p = Promise.new;
    $p.keep();
    is $p.status, Kept, "Kept Promise without a value has Kept status";
    ok $p.Bool, "Kept Promise has a result";
    ok ?$p, "Kept Promise is true";
    ok $p.result eqv True, "Default keep value is True.";
}

{
    my $p = Promise.new;
    $p.break("glass");
    is $p.status, Broken, "Broken Promise has Broken status";
    ok $p.Bool, "Broken Promise has a result";
    ok ?$p, "Broken Promise is true";
    isa-ok $p.cause, Exception, "cause returns an exception";
    is $p.cause.message, "glass", "Correct message";
    dies-ok { $p.result }, "result throws exception";

    dies-ok { $p.keep("eating") }, "Cannot keep a Broken Promise";
    dies-ok { $p.break("bad") }, "Cannot re-break a Broken Promise";
}

{
    my $p = Promise.new;
    $p.break();
    is $p.status, Broken, "Broken Promise without a value has Broken status";
    ok $p.Bool, "Broken Promise has a result";
    ok ?$p, "Broken Promise is true";
    isa-ok $p.cause, Exception, "cause returns an exception";
    is $p.cause.payload, "Died", "Default exception payload is 'Died'";
}

# https://github.com/Raku/old-issue-tracker/issues/3758
{ 
    my $p = Promise.new;
    my $vowname = $p.vow.^name;

    ok Promise.WHO{$vowname} :!exists, "the nested Vow class is lexically scoped";
}

# https://github.com/Raku/old-issue-tracker/issues/4268
{
    throws-like 'await', Exception, 'bare "await" dies';
}

# https://github.com/Raku/old-issue-tracker/issues/3527
#?rakudo.jvm todo 'fails most of the time'
{
    for ^4 {
        is_run q[ await ^9 .map: { start { say "start"; sleep 1; say "end" } };],
            { :0status, :err(''), :out("start\n" x 9 ~ "end\n" x 9) },
            "promises execute asynchronously [try $_]"
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5703
is-deeply Promise.new ~~ Planned, False,
    'smartmatching Promise against an Enum does not hang';

# https://github.com/Raku/old-issue-tracker/issues/5790
{
    my $p = Promise.new;
    $p.break("OH NOES");
    try await $p;
    is $!.message, "OH NOES", "Promise broken with string form of .break conveys correct message";
}

{
    class X::Test is Exception {
        has $.message
    }
    my $p = Promise.new;
    $p.break(X::Test.new(message => "oh crumbs"));
    try await start { await $p };
    like $!.gist, /crumbs/, 'Message not lost in nested await where inner one fails';
}

subtest 'subclasses create subclassed Promises' => {
    plan 7;
    my class Meows is Promise {};

    my $p = Meows.start: { sleep .5 };
    isa-ok $p,           Meows, '.start';
    isa-ok $p.then({;}), Meows, '.then (when waiting)';
    await $p;
    isa-ok $p.then({;}), Meows, '.then (when original already completed)';

    isa-ok Meows.in(1),           Meows, '.in';
    isa-ok Meows.at(now + 1),     Meows, '.at';
    isa-ok Meows.anyof(start {}), Meows, '.anyof';
    isa-ok Meows.allof(start {}), Meows, '.anyof';
}

subtest '.kept and .broken constructor methods' => {
    plan 12;
    my $kp = Promise.kept;

    is $kp.status, Kept, "Newly kept Promise has Kept status";
    ok $kp.result eqv True, "Promises kept without a value are kept with 'True'";

    my $bp = Promise.broken;

    is $bp.status, Broken, "Newly broken Promise has Broken status";
    throws-like { $bp.result }, X::AdHoc, payload => "Died", "Promises broken without a value have 'Died' in an X::AdHoc as the cause (via .result)";
    isa-ok $bp.cause, X::AdHoc, "Promises broken without a value have an X::AdHoc as the cause (via .result)";
    ok $bp.cause.payload eqv "Died", "Promises broken without a value have 'Died' as exception payload (via .result)";


    my $kpv = Promise.kept("kittens");

    is $kpv.status, Kept, "Newly kept Promise has Kept status";
    ok $kpv.result eqv "kittens", "Promises kept with a value is kept with the value";

    my $bpv = Promise.broken("glass");

    is $bpv.status, Broken, "Newly broken Promise has Broken status";
    throws-like { $bpv.result }, X::AdHoc, payload => "glass", "Promises broken with a value have the value in an X::AdHoc as the cause (via .result)";
    isa-ok $bpv.cause, X::AdHoc, "Promises broken with a value have an X::AdHoc as the cause (via .result)";
    ok $bpv.cause.payload eqv "glass", "Promises broken without a value have the value as exception payload (via .result)";
}

# vim: expandtab shiftwidth=4
