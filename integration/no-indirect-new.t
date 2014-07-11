use v6;

use Test;

plan 2;

# Parsing test, so should use EVAL to ensure it can run even if something is
# broken.

{
    class A { has $.b }
   
    eval_dies_ok "new A", 'parameterless prefixed new is allowed';

    eval_dies_ok( "new A( :b('bulbous bouffant') )", 'what looks like a constructor call is really a coersion to A, and should therefore be disallowed' );
}

# vim: ft=perl6
