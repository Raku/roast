use v6;
use Test;

plan 14;

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
