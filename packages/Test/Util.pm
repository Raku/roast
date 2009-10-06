module Test::Util;

# XXX This code hasn't been successfully tested.

# This seems necessary, and yet it crashes Rakudo.
#use Test;

# is_run 'say "hello"', { status => 0, out => "hello\n", err => '' }, 'say hello';

multi sub is_run( Str $code, Str $input, %expected, Str $name ) is export(:DEFAULT) {
    my %got = get_out( $code, $input // '' );

    # The test wasn't executed because the collection of kluges died.
    if %got<test_died> {
        skip 1, %got<test_died>;
    }

    my $ok = ?1;
    my $tests_aggregated = 0;

    for <status out err> -> $attr {
        # Attributes not specified are not tested.
        next if ! %expected.exists( $attr );

        my $attr_good;
        given %expected{$attr} {
            when Regex {
                $attr_good = %got{$attr} ~~ %expected{$attr};
            }
            when Callable {
                $attr_good = %expected{$attr}( %got{$attr} );
            }
            default {
                $attr_good = %got{$attr} eq %expected{$attr};
            }
        }
        
        if !$attr_good {
            diag "     got $attr: {%got{$attr}}";
            diag "expected $attr: {%expected{$attr}}";
        }

        $ok &&= $attr_good;
        $tests_aggregated++;
    }

    if $tests_aggregated > 0 {
        proclaim(?$ok, $name);
    }
    else {
        skip 1, 'nothing tested';
    }
}

multi sub get_out( Str $code ) {
    return get_out( $code, '' );
}

multi sub get_out( Str $code, Str $input ) {
    my $bin = $*EXECUTABLE_NAME;

    my $fnbase = 'getout-';
    $fnbase ~= try { $*PID } // 1_000.rand.Int;

    my $clobber = sub {
        my $fh = open $^a, :w
            or die "Can't create '$^a': $!";
        $fh.print( $^b );
        $fh.close or die "close failed: $!";
    };

    my %out;

    try {
        $clobber( "$fnbase.in", $input );
        $clobber( "$fnbase.code", $code );

        %out<status> = run( "$bin $fnbase.code < $fnbase.in > $fnbase.out 2> $fnbase.err" );
        %out<out> = slurp "$fnbase.out";
        %out<err> = slurp "$fnbase.err";

        CATCH { %out<test_died> = $! }
    }

    # Try to delete all the temp files written.  If any survive, die.
    my @files = map { "$fnbase.$_" }, <code in out err>;
    unlink $_ for @files;
    for @files -> $f {
        # TODO: File existence test works in Rakudo but is not current spec
        if $f ~~ :e {
            die "Can't unlink '$f'";
        }
    }

    return %out;
}
