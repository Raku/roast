use v6;
use Test;
plan 9;

# L<S29/Context/"=item eval">

=begin pod

Tests for the eval() builtin

=end pod

# eval should evaluate the code in the lexical scope of eval's caller
#?rakudo skip 'eval as closure'
{
    sub make_eval_closure {
        my $a = 5;
        return sub ($s) {
            eval $s 
        };
    };
    is(make_eval_closure().('$a'), 5, 'eval runs code in the proper lexical scope');
}

is(eval('5'), 5, 'simple eval works and returns the value');
my $foo = 1234;
#?rakudo skip 'eval needs access to outer scope'
is(eval('$foo'), $foo, 'simple eval using variable defined outside');

# traps die?
#?rakudo skip 'Null PMC access in type()'
ok(!eval('die; 1'), "eval can trap die");

ok(eval('my @a = (1); @a!<0>') ~~ undef, "eval returns undef on syntax error");

#?rakudo skip 'eval should trap fatal use statement'
ok(!eval('use Poison; 1'), "eval can trap a fatal use statement");

sub v { 123 }
ok(v() == 123, "a plain subroutine");
eval 'sub v { 456 }';
#?rakudo todo 'eval can override subroutines (specced?)'
ok(v() == 456, "eval can overwrite a subroutine");

# L<S04/Exception handlers/Perl 6's eval function only evaluates strings, not blocks.>
dies_ok({eval {42}}, 'block eval is gone');
