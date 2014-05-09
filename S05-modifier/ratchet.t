use v6;
use Test;
plan 5;

#L<S05/Modifiers/"The new :r or :ratchet modifier">
# for other tests see
# t/spec/S05-mass/rx.t

# backtracking
regex aplus { a+ };

ok 'aaaa'  ~~ m/ ^ <aplus> a $ /, 'normal regexes backtrack into subrules';
ok 'aaaa' !~~ m/ :ratchet ^ <aplus> a $ /, ' ... but not with :ratchet';

# what follows now might make your head twitch. Don't worry about that, it's
# normal. See http://irclog.perlgeek.de/perl6/2009-10-12#i_1595951 for a
# discussion

ok 'aaaa' !~~ m/ :ratchet ^ [ :!ratchet <aplus> ] a /,
   'if the failing atom is outside the :!ratchet group: no backtracking';
ok 'aaaa'  ~~ m/ :ratchet ^ [ :!ratchet <aplus> a ]  /,
   'if the failing atom is inside the :!ratchet group: backtracking';

ok 'aaaa'  ~~ m/ ^ :!ratchet <aplus> :ratchet a  /,
   'Same if not grouped';

# vim: ft=perl6
