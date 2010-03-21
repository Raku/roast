module Test::Util;

use Test;

# Tests for this testing code may be in the pugs repo under t/03-test-util/

# This seems necessary, and yet it crashes Rakudo.
#use Test;

# No input, no test name
multi sub is_run( Str $code, %expected ) is export(:DEFAULT) {
    return is_run( $code, '', %expected, '' );
}

# Has input, but not a test name
multi sub is_run( Str $code, Str $input, %expected ) is export(:DEFAULT) {
    return is_run( $code, $input, %expected, '' );
}

# No input, named
multi sub is_run( Str $code, %expected, Str $name ) is export(:DEFAULT) {
    return is_run( $code, '', %expected, $name );
}

multi sub is_run( Str $code, Str $input, %expected, Str $name ) is export(:DEFAULT) {
    my %got = get_out( $code, $input // '' );

    # The test may have executed, but if so, the results couldn't be collected.
    if %got<test_died> {
        return skip 1, 'test died: ' ~ %got<test_died>;
    }

    my $ok = ?1;
    my $tests_aggregated = 0;
    my @diag_q;

    # We check each of the attributes and pass the test only if all are good.
    for <status out err> -> $attr {
        # Attributes not specified are not tested.
        next if ! %expected.exists( $attr );

        my $attr_good = %got{$attr} ~~ %expected{$attr};

        # The check for this attribute failed.
        # Note why for a diag() after the test failure is reported.
        if !$attr_good {
            @diag_q.push(     "     got $attr: {%got{$attr}.perl}"      );
            if %expected{$attr} ~~ Str|Num {
                @diag_q.push( "expected $attr: {%expected{$attr}.perl}" );
            }
        }

        $ok = $ok && $attr_good;
        $tests_aggregated++;
    }

    if $tests_aggregated == 0 {
        return skip 1, 'nothing tested';
    }

    ok ?$ok, $name;
    diag $_ for @diag_q;

    return;
}

sub get_out( Str $code, Str $input? ) is export {
    my $fnbase = 'getout-';
    $fnbase ~= $*PID // 1_000_000.rand.Int;

    my $clobber = sub ($a, $b) {
        my $fh = open $a, :w
            or die "Can't create '$a': $!";
        $fh.print( $b );
        $fh.close or die "close failed: $!";
    };

    my %out;

    try {
        $clobber( "$fnbase.in", $input // '' );
        $clobber( "$fnbase.code", $code );

        my $perl6 = $*EXECUTABLE_NAME;

        %out<status> = run( "$perl6 $fnbase.code < $fnbase.in > $fnbase.out 2> $fnbase.err" );
        %out<out> = slurp "$fnbase.out";
        %out<err> = slurp "$fnbase.err";

        CATCH { %out<test_died> = ~$! }
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

=begin pod

=head1 NAME

Test::Util - Extra utility code for testing

=head1 SYNOPSIS

  use Test;
  use Test::Util;

  is_run( 'say $*IN.lines',                            # code to run
          'GIGO',                                      # input for code
          { out => "GIGO\n", err => '', status => 0 }, # results expected
          'input comes back out' );                    # test name

=head1 DESCRIPTION

This module is for test code that would be useful
across Perl 6 implementations.

=head1 FUNCTIONS

=head2 is_run( Str $code, Str $input?, %wanted, Str $name? )

It runs the code given, feeding it the input given, and collects results
in the form of its stdout, stderr, and exit status.  The %wanted hash
specifies which of these to check and what to check them against.
Every item in the hash must "match" for the is_run() test to pass.
For example:

   {
       out    => "Hello world!\n",   # outputs Hello world!
       err    => '',                 # no error output
       status => 0,                  # standard successful exit
   },

Any of those items not present in the %wanted hash will not be tested
(that is, the test passes regardless of the results of those items).
For example, if 'status' is not specified, the test passes regardless
of what the code's exit status was.

Each item can be a string, a Regexp, or a Callable.  Strings must match
exactly.

A Callable is passed the result, and the test passes
if the Callable returns a true value.
For example:

  is_run( 'rand.say', { out => sub { $^a > 0 && $^a < 1 }, err => '' },
          'output of rand is between zero and one' );

=head3 Errors

If the underlying code could not be executed properly (e.g., because
temp files could not be accessed), is_run() will skip().

If the %wanted hash passed in does not contain any of the items it checks,
is_run() will skip() (but it will still execute the code not being tested).

is_run() depends on get_out(), which might die.  In that case, it dies
also (this error is not trapped).

=head2 get_out( Str $code, Str $input? )

This is what is_run() uses to do its work.  It returns a hash with the
'status', 'err', and 'out' of the code run.  In addition, if the hash
it returns has an element named 'test_died', that means it failed to
either run the code or collect the results.  Any other elements of the
hash should be disregarded.

=head3 Errors

This will die if it can't clean up the temp files it uses to do its work.
All other errors should be trapped and reported via the 'test_died' item.

=end pod

# vim: ft=perl6
