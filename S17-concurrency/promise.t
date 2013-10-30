use v6;
use Test;

plan 23;

{
    my $p = Promise.new;
    is $p.status, Planned, "Newly created Promise has Planned status";
    nok $p.has_result, "Newly created Promise has now result yet";
    dies_ok { $p.cause }, "Cannot call cause on a Planned Promise";
    
    $p.keep("kittens");
    is $p.status, Kept, "Kept Promise has Kept status";
    ok $p.has_result, "Kept Promise has a result";
    is $p.result, "kittens", "Correct result";
    
    dies_ok { $p.cause }, "Cannot call cause on a Kept Promise";
    dies_ok { $p.keep("eating") }, "Cannot re-keep a Kept Promise";
    dies_ok { $p.break("bad") }, "Cannot break a Kept Promise";
}

{
    my $p = Promise.new;
    $p.break("glass");
    is $p.status, Broken, "Broken Promise has Broken status";
    ok $p.has_result, "Broken Promise has a result";
    isa_ok $p.cause, Exception, "cause returns an exception";
    is $p.cause.message, "glass", "Correct message";
    dies_ok { $p.result }, "result throws exception";
    
    dies_ok { $p.keep("eating") }, "Cannot keep a Broken Promise";
    dies_ok { $p.break("bad") }, "Cannot re-break a Broken Promise";
}

{
    my $p = Promise.run({
        pass "Promise.run actually runs";
        42
    });
    is $p.result, 42, "Correct result";
    is $p.status, Kept, "Promise was kept";
}

{
    my $p = Promise.run({
        pass "Promise.run actually runs";
        die "trying"
    });
    dies_ok { $p.result }, "result throws exception";
    is $p.status, Broken, "Promise was broken";
    is $p.cause.message, "trying", "Correct exception stored";
}
