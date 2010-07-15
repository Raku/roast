use v6;
use Test;
plan *;

#L<S03/Smart matching/Any Bool simple truth>
{
    ok  (0 ~~ True),         '$something ~~ True (1)';    #OK always matches
    ok  (0 ~~ Bool::True),   '$something ~~ Bool::True (1)';    #OK always matches
    ok  ('a' ~~ True),       '$something ~~ True (2)';    #OK always matches
    ok  ('a' ~~ Bool::True), '$something ~~ Bool::True (2)';    #OK always matches
    ok !(0 ~~ False),        '$something ~~ False (1)';    #OK always fails
    ok !(0 ~~ Bool::False),  '$something ~~ Bool::False (1)';    #OK always fails
    ok !('a' ~~ False),      '$something ~~ False (2)';    #OK always fails
    ok !('a' ~~ Bool::False),'$something ~~ Bool::False (2)';    #OK always fails
}

done_testing;

# vim: ft=perl6
