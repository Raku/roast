use v6;
use Test;
plan 8;

#L<S03/Smart matching/Any Bool simple truth>

{
    sub is-true() { True };
    sub is-false() { False };
    ok   0  ~~ is-true(),      '~~ non-syntactic True';
    ok  'a' ~~ is-true(),      '~~ non-syntactic True';
    nok  0  ~~ is-false(),     '~~ non-syntactic True';
    nok 'a' ~~ is-false(),     '~~ non-syntactic True';

}

{
    nok  0   ~~ .so,           'boolean truth';
    ok   'a' ~~ .so,           'boolean truth';
    ok   0   ~~ .not,          'boolean truth';
    nok  'a' ~~ .not,          'boolean truth';
}

done;

# vim: ft=perl6
