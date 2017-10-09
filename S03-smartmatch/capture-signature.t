use v6;

use Test;

plan 7;

sub t1(%h) {
    given %h {
        when :(Int :$a) { "pivo" }
        when :(Str :$a) { "slivovica" }
    }
}
my %h = a => 42;
is t1(%h), "pivo", "signature smart-match against hash works (1)";
%h<a> = "moja draha";
is t1(%h), "slivovica", "signature smart-match against hash works (1)";


sub t2(@a) {
    given @a {
        when :($a)     { "godis" }
        when :($a, $b) { "om nom nom" }
    }
}
is t2([1]), "godis", "signature smart-match against array works (1)";
is t2([1,2]), "om nom nom", "signature smart-match against array works (2)";

# RT #77164
{
    sub f($ = rand) { };
    ok \() ~~ &f.signature, 'can smart-match against a signature with a default value';
}

# RT #118581
{
    lives-ok { \(1) ~~ :(Str(int) $x) },
        'can match integer capture against signature with native integer coercing to Str';
}

subtest 'non-Capture/non-Signature types on LHS' => {
    plan 6;
    is-deeply  42 ~~ :(Int), False, 'Int'; # Int.Capture throws
    is-deeply  set(<a b>)   ~~ :(:$a where .so, :$b where .so), True, 'Set';
    is-deeply  (1, 2, :42c) ~~ :($a where 1, $b where 2, :$c where 42),
        True, 'List';
    is-deeply  %(:42a, :b<meows>) ~~ :(Int :$a where 42, Str :$b where 'meows'),
        True, 'Hash';
    is-deeply  <1/2> ~~ :(Int :$numerator where 1, Int :$denominator where 2),
        True,  'Rat (1)';
    is-deeply  <1/2> ~~ :(Int :$numerator where 3, Int :$denominator where 2),
        False, 'Rat (2)';
}

# vim: ft=perl6
