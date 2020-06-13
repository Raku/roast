use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;
plan 30;

# L<S29/Context/"=item EVAL">

=begin pod

Tests for the EVAL() builtin

=end pod

# EVAL should evaluate the code in the lexical scope of EVAL's caller
{
    sub make_eval_closure {
        my $a = 5;   #OK not used
        return sub ($s) {
            EVAL $s
        };
    };
    is(make_eval_closure().('$a'), 5, 'EVAL runs code in the proper lexical scope');
}

is(EVAL('5'), 5, 'simple EVAL works and returns the value');
my $foo = 1234;
is(EVAL('$foo'), $foo, 'simple EVAL using variable defined outside');

# traps die?
dies-ok {EVAL('die; 1')}, "EVAL does not trap die";

dies-ok {EVAL '1 1)'}, "EVAL throws on syntax error";

dies-ok {EVAL 'use Poison; 1'}, "EVAL dies on fatal use";

# L<S04/Exception handlers/Raku's EVAL function only evaluates strings, not blocks.>
dies-ok({EVAL {; 42} }, 'block EVAL is gone');

# https://github.com/Raku/old-issue-tracker/issues/800
# EVAL didn't work in methods
{
    class EvalTester1 {
        method e($s) { EVAL $s };
    }
    is EvalTester1.e('5'),       5, 'EVAL works inside class methods';
    is EvalTester1.new.e('5'),   5, 'EVAL works inside instance methods';
}

{
    my $x = 5;
    class EvalTester2 {
        method e($s) { EVAL "$s + \$x" };
    }
    is EvalTester2.e('1'),       6,
       'EVAL works inside class methods, with outer lexicals';
    is EvalTester2.new.e('1'),   6,
       'EVAL works inside instance methods, with outer lexicals';
}

# https://github.com/Raku/old-issue-tracker/issues/3432
{
    is EVAL("'møp'".encode('UTF-8')), 'møp', 'EVAL(Buf)';
#?rakudo skip 'Buf.EVAL NYI (if ever)'
    is "'møp'".encode('UTF-8').EVAL, 'møp', 'Buf.EVAL';
}

{
    is EVAL(88), 88, 'EVAL of non-string works';
    is 88.EVAL, 88, '.EVAL of non-string works';

    my $number = 2;
    is EVAL($number), $number, 'EVAL of non-string variable works';
    is $number.EVAL, $number, '.EVAL of non-string variable works';
}

# https://github.com/Raku/old-issue-tracker/issues/2134
{
    my $x = 0;
    EVAL '$x++' for 1..4;
    is $x, 4, 'can execute the same EVAL multiple times, without surrounding block';

}

# https://github.com/Raku/old-issue-tracker/issues/2716
{
    try EVAL(:lang<rt112472>, '1');
    ok "$!" ~~ / 'rt112472' /, 'EVAL in bogus language mentions the language';
}

# https://github.com/Raku/old-issue-tracker/issues/2933
my $rt115344 = 115344;
is('$rt115344'.EVAL, $rt115344, 'method form of EVAL sees outer lexicals');

# https://github.com/Raku/old-issue-tracker/issues/2977
{
    my int $a; EVAL('');
    ok(1, "presence of low level types doesn't cause EVAL error")
}

# https://github.com/Raku/old-issue-tracker/issues/3781
{
    my \a = rand;
    lives-ok { EVAL 'a' }, 'Can EVAL with a sigilless var';
    is EVAL('a'), a, 'EVAL with sigilless var gives correct result';
}

# https://github.com/Raku/old-issue-tracker/issues/3781
{
    use nqp;
    is
        nqp::atkey(CompUnit::Loader.load-source(q<package Qux { BEGIN EVAL q<>; };>.encode).unit, q<$?PACKAGE>).^name,
        "GLOBAL",
        "EVAL's package does not leak to the surrounding compilation unit";
}

is_run 'use MONKEY-SEE-NO-EVAL; EVAL q|print "I ® U"|.encode',
    {:out('I ® U'), :err(''), :0status}, 'EVAL(Buf)';

# :check parameter on EVAL
{
    my $begin = False;
    my $check = False;
    my $run   = False;
    EVAL q/BEGIN $begin = True; CHECK $check = True; $run = True/, :check;
    ok $begin, 'Did the EVAL run BEGIN';
    ok $check, 'Did the EVAL run CHECK';
    nok $run, 'Did the EVAL NOT run the code';
}

# GH rakudo/rakudo#3263
{
    for <c d> -> $rev {
        is_run q<use v6.> ~ $rev ~ q<; use MONKEY-SEE-NO-EVAL; EVAL 'print $*PERL.version'>,
            {:out("6.$rev"), :err(''), :0status},
            "EVAL preserves version 6.$rev";
    }
}

# vim: expandtab shiftwidth=4
