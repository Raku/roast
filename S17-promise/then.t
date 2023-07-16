use Test;

plan 19;

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
    isa-ok $p2, Promise, "then returns a Promise";
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
    dies-ok { $p2.result }, "result from then Promise dies";
    is $p2.status, Broken, "then Promise is broken";
    is $p2.cause.message, "then died", "then Promise has correct cause";
}

# https://github.com/Raku/old-issue-tracker/issues/6325
subtest 'dynamics accessible from .then' => {
    plan 4;

    my @code;
    my $*FOO; my @*FOO; my %*FOO;
    my &*FOO = { @code.push: $_ };

    await start {
        $*FOO ~= 'prom';
        @*FOO.push: 'prom';
        %*FOO<prom> = 42;
        &*FOO('prom');
    }.then: {
        $*FOO ~= 'then';
        @*FOO.push: 'then';
        %*FOO<then> = 72;
        &*FOO('then');
    }

    is-deeply $*FOO, 'promthen',         '$*FOO';
    is-deeply @*FOO, [<prom then>],      '@*FOO';
    is-deeply %*FOO, {:42prom, :72then}, '%*FOO';
    is-deeply @code, [<prom then>],      '&*FOO';
}

{
    my %test-status;
    my $slock = Lock.new;

    my sub get-results($p1) {
        %test-status = ();

        my sub record-result($p, $key) {
            $slock.protect: {
                %test-status{$key}<status> = $p.status;
                if $p.status == Kept {
                    %test-status{$key}<result> = $p.result;
                }
                else {
                    %test-status{$key}<cause> = ~$p.cause;
                }
            }
        }

        $p1.then: { record-result($_, "independent-then"); };

        $p1
            .andthen({ record-result($_, "andthen1"); .result < -10 ?? die "andthen1 dies" !! .result * 2 })
            .andthen({ record-result($_, "andthen2"); .result < 0 ?? die "andthen2 dies" !! .result })
            .orelse({
                record-result($_, "orelse1");
                .cause.message.contains("andthen2")
                    ??  die "orelse1 dies"
                    !! "problem 1"
            })
            .orelse({ record-result($_, "orelse2"); "problem 2" })
            .then({ record-result($_, "final-then"); "final: " ~ .result })
    }

    my sub test-conditionals(Str:D $message, Str:D :$method, :$value, :$rc, :%status) is test-assertion {
        subtest $message, {
            plan 2;

            subtest "immediate", {
                plan 2;
                my $p1 = Promise.new;
                $p1."$method"($value);
                my $p2 = get-results($p1);

                is await($p2), $rc, "final promise result";
                is-deeply %test-status, %status, "thens ran as expected";
            }

            subtest "planned", {
                plan 2;
                my $p1 = Promise.new;
                my $p2 = get-results($p1);
                $p1."$method"($value);

                is await($p2), $rc, "final promise result";
                is-deeply %test-status, %status, "thens ran as expected";
            }
        }
    }

    test-conditionals "simple keep",
        method => 'keep',
        value => 42,
        rc => 'final: 84',
        status => {
            andthen1 => { result => 42, status => Kept },
            andthen2 => { result => 84, status => Kept },
            final-then => { result => 84, status => Kept },
            independent-then => { result => 42, status => Kept },
        };

    test-conditionals "simple break",
        method => 'break',
        value => 'something is wrong',
        rc => 'final: problem 1',
        status => {
            final-then => { result => 'problem 1', status => Kept },
            independent-then => { cause => 'something is wrong', status => Broken },
            orelse1 => { cause => 'something is wrong', status => Broken }
        };

    test-conditionals "the first .andthen dies",
        method => 'keep',
        value => -13,
        rc => 'final: problem 1',
        status => {
            andthen1 => { result => -13, status => Kept, },
            final-then => { result => 'problem 1', status => Kept },
            independent-then => { result => -13, status => Kept },
            orelse1 => { cause => 'andthen1 dies', status => Broken }
        };

    test-conditionals "the second .andthen and the first .orelse dies",
        method => 'keep',
        value => -5,
        rc => 'final: problem 2',
        status => {
            andthen1 => { result => -5, status => Kept, },
            andthen2 => { result => -10, status => Kept, },
            final-then => { result => 'problem 2', status => Kept },
            independent-then => { result => -5, status => Kept },
            orelse1 => { cause => 'andthen2 dies', status => Broken },
            orelse2 => { cause => 'orelse1 dies', status => Broken }
        };
}

# vim: expandtab shiftwidth=4
