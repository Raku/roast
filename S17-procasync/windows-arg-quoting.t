use v6;
use Test;

=begin pod

Sub process arguments need to be quoted according to a specific schema
to be understood by most processes on Windows.
This quoting is tested here.

See L<https://github.com/Raku/problem-solving/issues/20>

=end pod

plan 21;

if !$*DISTRO.is-win {
    skip-rest "windows argument quoting can't be tested on non-Windows";
    exit;
};

sub test-run(@args, $expected, $verbatim = False) is test-assertion {
    my $marker = 'MARKER_Sx%3bX';
    my $script = $?FILE.IO.parent.child('windows-print-raw-args.p6');
    my $proc = run($*EXECUTABLE, $script, $marker, |@args, :out, :win-verbatim-args($verbatim));
    my $out = $proc.out.slurp(:close).trim-trailing();
    $out ~~ s/^ .* $marker ' '//;
    is $out, $expected, $expected;
}
sub test-run-verbatim(@args, $expected) is test-assertion {
    test-run(@args, $expected, True)
}

#?rakudo.jvm skip 'JVM enforces its own process argument quoting.'
{
    test-run <a b>,                Q[a b];
    test-run (Q[a space],    'b'), Q["a space" b];
    test-run (Q[a "quote"],  'b'), Q["a \"quote\"" b];
    test-run (Q[a 'quote'],  'b'), Q["a 'quote'" b];
    test-run (Q[a "quote],   'b'), Q["a \"quote" b];
    test-run (Q[a \"quote],  'b'), Q["a \\\"quote" b];
    test-run (Q[a \\"quote], 'b'), Q["a \\\\\"quote" b];
    test-run (Q[a \\quote],  'b'), Q["a \\quote" b];

    test-run-verbatim <a b>,                  Q[a b];
    test-run-verbatim (Q[a space],      'b'), Q[a space b];
    test-run-verbatim (Q[a \"quote\"],  'b'), Q[a \"quote\" b];
    test-run-verbatim (Q[a \'quote\'],  'b'), Q[a \'quote\' b];
    test-run-verbatim (Q[a \"quote],    'b'), Q[a \"quote b];
    test-run-verbatim (Q[a "quote"],    'b'), Q[a "quote" b];
    test-run-verbatim (Q[a 'quote'],    'b'), Q[a 'quote' b];
    test-run-verbatim (Q[a "quote],     'b'), Q[a "quote b];
    test-run-verbatim (Q[a \escape],    'b'), Q[a \escape b];
    test-run-verbatim (Q[a \\escape],   'b'), Q[a \\escape b];
    test-run-verbatim (Q[a \\\"escape], 'b'), Q[a \\\"escape b];
    test-run-verbatim (Q[a escape\],    'b'), Q[a escape\ b];
    test-run-verbatim (Q[a escape\"],   'b'), Q[a escape\" b];
}

# vim: expandtab shiftwidth=4
