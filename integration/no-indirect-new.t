use v6;

use Test;

plan 2;

# Parsing test, so should use EVAL to ensure it can run even if something is
# broken.

{
    class A { has $.b }
   
    throws_like { EVAL "new A" },
      X::Undeclared::Symbols,
      'parameterless prefixed new is allowed';

    throws_like { EVAL "new A( :b('bulbous bouffant') )" },
      X::Obsolete,
      'what looks like a constructor call is really a coersion to A, and should therefore be disallowed';
}

# vim: ft=perl6
