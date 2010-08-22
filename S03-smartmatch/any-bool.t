use v6;
use Test;
plan 12;

#L<S03/Smart matching/Any Bool simple truth>
#?rakudo skip 'RT 77080'
{
    ok  (0 ~~ True),         '$something ~~ True (1)';    #OK always matches
    ok  (0 ~~ Bool::True),   '$something ~~ Bool::True (1)';    #OK always matches
    ok  ('a' ~~ True),       '$something ~~ True (2)';    #OK always matches
    ok  ('a' ~~ Bool::True), '$something ~~ Bool::True (2)';    #OK always matches
    nok (0 ~~ False),        '$something ~~ False (1)';    #OK always fails
    nok (0 ~~ Bool::False),  '$something ~~ Bool::False (1)';    #OK always fails
    nok ('a' ~~ False),      '$something ~~ False (2)';    #OK always fails
    nok ('a' ~~ Bool::False),'$something ~~ Bool::False (2)';    #OK always fails
}

{
    sub is-true() { True };
    sub is-false() { False };
    ok   0  ~~ is-true(),      '~~ non-syntactic True';
    ok  'a' ~~ is-true(),      '~~ non-syntactic True';
    nok  0  ~~ is-false(),     '~~ non-syntactic True';
    nok 'a' ~~ is-false(),     '~~ non-syntactic True';

}

done_testing;

# vim: ft=perl6
