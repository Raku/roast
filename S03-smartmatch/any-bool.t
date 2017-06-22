use v6;
use Test;
plan 8;

#L<S03/Smart matching/Any Bool simple truth>

{
    sub is-true() { True };
    sub is-false() { False };
    is-deeply   0  ~~ is-true(), True,      '~~ non-syntactic True';
    is-deeply  'a' ~~ is-true(), True,      '~~ non-syntactic True';
    is-deeply  0  ~~ is-false(), False,     '~~ non-syntactic True';
    is-deeply 'a' ~~ is-false(), False,     '~~ non-syntactic True';
}

{
    is-deeply  0   ~~ .so, False,           'boolean truth';
    is-deeply   'a' ~~ .so, True,           'boolean truth';
    is-deeply   0   ~~ .not, True,          'boolean truth';
    is-deeply  'a' ~~ .not, False,          'boolean truth';
}

# vim: ft=perl6
