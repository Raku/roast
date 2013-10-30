use v6;
use Test;

plan 39;

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

{
    my $start = now;
    my $p = Promise.sleep(1);
    is $p.result, True, "Promise.sleep result is True";
    ok now - $start >= 1, "Promise.sleep took long enough";
}

{
    my $run_then = 0;
    my $p1 = Promise.new;
    my $p2 = $p1.then(-> $res {
        $run_then = 1;
        ok $res === $p1, "Got correct Promise passed to then";
        is $res.status, Kept, "Promise passed to then was kept";
        is $res.result, 42, "Got correct result";
        101
    });
    isa_ok $p2, Promise, "then returns a Promise";
    is $run_then, 0, "Not run then yet";
    
    $p1.keep(42);
    is $p2.result, 101, "Got correct result from then Promise";
    ok $run_then, "Certainly ran the then";
}

{
    my $p1 = Promise.new;
    my $p2 = $p1.then(-> $res {
        ok $res === $p1, "Got correct Promise passed to then";
        is $res.status, Broken, "Promise passed to then was broken";
        is $res.cause.message, "we fail it", "Got correct cause";
        "oh noes"
    });
    
    $p1.break("we fail it");
    is $p2.result, "oh noes", "Got correct result from then Promise";
}

{
    my $run_then = 0;
    my $p1 = Promise.new;
    my $p2 = $p1.then(-> $res {
        die "then died"
    });

    $p1.keep(42);
    dies_ok { $p2.result }, "result from then Promise dies";
    is $p2.status, Broken, "then Promise is broken";
    is $p2.cause.message, "then died", "then Promise has correct cause";
}
