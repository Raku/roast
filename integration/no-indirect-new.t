use v6;

use Test;

plan 2;

# Parsing test, so should use eval to ensure it can run even if something is
# broken.

#?pugs emit if $?PUGS_BACKEND ne "BACKEND_PUGS" {
#?pugs emit   skip_rest "PIL2JS and PIL-Run do not support eval() yet.";
#?pugs emit   exit;
#?pugs emit }

{
    class A { has $.b }

    eval_dies_ok "new A", 'parameterless prefixed new is allowed';

    eval_dies_ok( "new A( :b('bulbous bouffant') )", 'what looks like a constructor call is really a coersion to A, and should therefore be disallowed' );
}

# vim: ft=perl6
