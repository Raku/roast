use v6;
use Test;

plan 1;

# L<S11/"Exportation"/>

sub exp_no_parens is export           { 'exp_no_parens' }


ok( &exp_no_parens === &EXPORT::ALL::exp_no_parens,
    'sub bound to ::EXPORT::ALL inner module' );

