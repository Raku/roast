use v6;
use Test;
plan *;

#L<S03/Smart matching/Any Bool simple truth>
{
    ok  (0 ~~ True),         '$something ~~ True (1)';
    ok  (0 ~~ Bool::True),   '$something ~~ Bool::True (1)';
    ok  ('a' ~~ True),       '$something ~~ True (2)';
    ok  ('a' ~~ Bool::True), '$something ~~ Bool::True (2)';
    ok !(0 ~~ False),        '$something ~~ False (1)';
    ok !(0 ~~ Bool::False),  '$something ~~ Bool::False (1)';
    ok !('a' ~~ False),      '$something ~~ False (2)';
    ok !('a' ~~ Bool::False),'$something ~~ Bool::False (2)';
}

done_testing;

# vim: ft=perl6
