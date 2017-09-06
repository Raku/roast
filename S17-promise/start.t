use v6;
use Test;

plan 59;

throws-like { await }, Exception, "a bare await should not work";

{
    my $p = Promise.start({
        pass "Promise.start actually runs";
        42
    });
    sleep 1;
    isa-ok $p, Promise, '.start gives a Promise';
    is $p.result, 42, "Correct result";
    is $p.status, Kept, "Promise was kept";
}

{
    my $p = start {
        pass "Promise.start actually runs";
        42
    };
    sleep 1;
    isa-ok $p, Promise, 'start {} gives a Promise';
    is $p.result, 42, "Correct result";
    is $p.status, Kept, "Promise was kept";
}

{
    my $p = Promise.start({
        pass "Promise.start actually runs";
        die "trying";
    });
    sleep 1;
    dies-ok { $p.result }, "result throws exception";
    is $p.status, Broken, "Promise was broken";
    is $p.cause.message, "trying", "Correct exception stored";
}

{
    my $p = start (1, 2, 3, 4);  # does start handle a blorst
    await $p;
    is $p.result.join(', '), '1, 2, 3, 4', 'can returns a List from a start block';
}

# RT #122715
{
    my $p = start {
        (0..3).map: *+1;
    };
    my \seq = await $p;
    is seq.join(', '), '1, 2, 3, 4', 'can return a potentially lazy list from a start block';
}
{
    my @outer = 0..3;
    my $p = start {
        @outer.map: *+1;
    };
    my \seq = await $p;
    is seq.join(', '), '1, 2, 3, 4', 'can return a lazy map from a start block';
}
{
    is (await start "d\te\tf".split("\t")), ('d', 'e', 'f').Seq,
        'can return a lazy split from a start block';
}

# RT #123702
{
    my @got = await do for 1..5 { start { buf8.new } };
    ok all(@got.map(* ~~ buf8)), 'buf8.new in many start blocks does not explode';
}

# RT #125346
{
    sub worker(Any $a, Int $b) {}
    my $deaths = 0;
    for ^200 {
        my $value = Any;
        my @workers = (^4).map: {
            start { worker($value) }
        };
        try {
            await @workers;
            CATCH {
                default { $deaths++ }
            }
        }
    }
    is $deaths, 200, 'Getting signature bind failure in Promise reliably breaks the Promise';
}

# RT #125161
{
    my @p = map { start { my @a = [ rand xx 1_000 ]; @a } }, ^10;
    for @p.kv -> $i, $_ {
        ok .result, "Got result from Promise populating/returning an array ($i)";
        is .result.elems, 1000, "Correct number of results in array ($i)";
    }
}

# RT #125196
{
    sub foo() {
        my $p = start { $*E + 1 }
        return $p.result;
    }
    my $*E = 5;
    is foo(), 6, 'Code running in start can see dynamic variables of the start point';
}

# RT #123204: retrowing of exceptions from start:

dies-ok { await start { die 'oh noe' } }, 'await rethrows exceptions';
dies-ok { await start { fail 'oh noe' } }, 'await rethrows failures';

# Fresh $/ in start block
{
    my $/ = 42;
    isnt await(start { $/ }), 42, 'Get a fresh $/ inside of a start block';
    isnt await(start $/), 42, 'Get a fresh $/ inside of a start thunk';

    is ([+] await map -> $n {
            start { my $foo = "barbaz" x $n; $foo ~~ s/.+/$/.chars()/; $foo } },
            ^100),
        29700,
        'No wrong answers due to over-sharing of $/';
}

# Fresh $! in start block
{
    my $ex = Exception.new;
    my $! = $ex;
    isnt await(start { $! }), $ex, 'Get a fresh $! inside of a start block';
    isnt await(start $!), $ex, 'Get a fresh $! inside of a start thunk';
}

# RT #127033
{
    sub t { $*d };
    my $*d = 1;
    is await( do { start { t() } }),1,
        "dynamic variables don't disappear in call inside start nested inside block";

    my $*A = 42;
    do { start { $*A++ } };
    sleep 1;
    is $*A,43,'dynamic variables modified inside start nested inside a block';
}

# RT #128833
{
    grammar G {
        token TOP { .+ { make ~$/ } }
    }
    my $warned = False;
    await do for ^300 {
        start {
            CONTROL {
                when CX::Warn {
                    $warned = True;
                }
            }
            G.parse("x" x 1000)
        }
    }
    nok $warned, 'No spurious warnings when using closures in grammar rules';
}

# RT #125782
{
	sub baz {
		die 'uh-oh';
	}

	sub bar {
		baz();
	}

	sub foo {
		bar();
	}

	my $p = start {
		foo();
	};

	sub catcher() {
		await $p;

		CATCH {
			default {
				like .backtrace.Str, rx/foo/, 'The backtrace should contain throwing location';
				like .gist, rx/foo/, 'The gist should contain throwing location';
				like .gist, rx/catcher/, 'The gist should also contain re-throwing location';
			}
		}
	}
	catcher();
}

# Covers various SEGVs, including the one at the root of RT #129781.
lives-ok {
    for ^1000 {
        my $a = ("A".."Z").pick x 1000;
        for ^4 {
            start { my %h; %h{$a} = 42; }
        }
    }
}, 'Access of hash declared in start block with repeat string outside of it does not crash';

# Covers mis-compilation of //=, ||=, and &&= that caused threading issues.
lives-ok {
    sub foo() { my $b = False; my $c; $c //= do { $b = True }; $b }
    await do for ^4 { start for ^1000 { die unless foo } }
}, '//= compilation not vulnerable to multiple threads';
lives-ok {
    sub foo() { my $b = False; my $c; $c ||= do { $b = True }; $b }
    await do for ^4 { start for ^1000 { die unless foo } }
}, '||= compilation not vulnerable to multiple threads';
lives-ok {
    sub foo() { my $b = False; my $c = True; $c &&= do { $b = True }; $b }
    await do for ^4 { start for ^1000 { die unless foo } }
}, '&&= compilation not vulnerable to multiple threads';

# Covers a SEGV in parallel grammars; it was in NFA caching, thus why we need
# to EVAL the grammar so it is a fresh one with a fresh cache each time. Covers
# RT #128833.
lives-ok {
    for ^100 {
        my \g = EVAL 'grammar { token TOP { <a> | <b> }; token a { \d | \s }; token b { a | b } }';
        await (start g.parse('b')) xx 8
    }
}, 'No crash when doing parallel parsing of grammars on first time';

# RT #131985
{
	my $wrong = False;
	await((1 .. 5).map: -> $tid {
	   start {
		  for (1 .. 100) -> $index {
			 my $s-tid   = "{$tid}";
			 my $s-index = "{$index}";
			 $wrong = True unless $tid ~~ $s-tid;
			 $wrong = True unless $index ~~ $s-index;
		  }
	   }
	});
    nok $wrong, 'No data races on closure interpolation in strings';
}
