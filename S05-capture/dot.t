use v6;

use Test;

=begin pod

This file was derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/capture.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

# L<S05/Accessing captured subpatterns/The array elements of the regex's>

Broken:
## L<S05/Extensible metasyntax (C<< <...> >>)/A leading C<.> causes>
=end pod

plan 61;

my regex dotdot { (.)(.) };

ok("zzzabcdefzzz" ~~ m/(a.)<.dotdot>(..)/, 'Match');
ok($/, 'Matched');
is(~$/, "abcdef", 'Captured');
is(~$/[0], 'ab', '$/[0]');
is(~$0, 'ab', '$0');
is(~$/[1], 'ef', '$/[1]');
is(~$1, 'ef', '$1');
ok(!defined($/[2]), 'no $/[2]');
ok(!defined($2), 'no $2');
ok(!defined($/<dotdot>), 'no $/<dotdot>');

ok("zzzabcdefzzz" ~~ m/(a.)<dotdot>(..)/, 'Match');
ok($/, 'Matched');
is(~$/, "abcdef", 'Captured');
is(~$/[0], 'ab', '$/[0]');
is(~$0, 'ab', '$0');
is(~$/[1], 'ef', '$/[1]');
is(~$1, 'ef', '$1');
ok(!defined($/[2]), '$/[2]');
ok(!defined($2), '$2');
is(~$/<dotdot>, 'cd', '$/<dotdot>');
is(~$/<dotdot>[0], 'c', '$/<dotdot>[0]');

is(~$/<dotdot>[1], 'd', '$/<dotdot>[1]');

ok(!defined(try { $/<dotdot>[2] }), '$/<dotdot>[2]');

ok("abcd" ~~ m/(a(b(c))(d))/, 'Nested captured');
is(~$0, "abcd", 'Nested $0');
is(~$0[0], "bc", 'Nested $1');
is(~$0[0][0], "c", 'Nested $2');
is(~$0[1], "d", 'Nested $3');

# L<S05/Backslash reform/Backreferences>

ok("bookkeeper" ~~ m/(((\w)$0)+)/, 'Backreference');
is(~$0, 'ookkee', 'Captured');
#?rakudo todo 'really? :-)'
is(~$0[0], 'ee', 'Captured');

# L<S05/Accessing captured subrules/The hash entries>

my regex single { o | k | e };

#?rakudo 3 todo 'dubious test'
ok("bookkeeper" ~~ m/<single> ($<single>)/, 'Named backref');
is(~$/<single>, 'o', 'Named capture');
is(~$0, 'o', 'Backref capture');

#?rakudo 3 todo 'dubious test'
ok("bookkeeper" ~~ m/(<.single>) ($0)/, 'Positional backref');
is(~$0, 'o', 'Named capture');
is(~$1, 'o', 'Backref capture');

ok(!( "bokeper" ~~ m/(<.single>) ($0)/ ), 'Failed positional backref');
# XXX wtf?
ok !( "bokeper" ~~ m/<single> ($<single>)/ ) , 'Failed named backref';

is("\$0", '$'~'0', 'Non-translation of non-interpolated "\\$0"');
is('$0',  '$'~'0', 'Non-translation of non-interpolated \'$0\'');
is(q{$0}, '$'~'0', 'Non-translation of non-interpolated q{$0}');
is(q[$0], '$'~'0', 'Non-translation of non-interpolated q[$0]');
is(q<$0>, '$'~'0', 'Non-translation of non-interpolated q<$0>');
is(q/$0/, '$'~'0', 'Non-translation of non-interpolated q/$0/');
is(q!$0!, '$'~'0', 'Non-translation of non-interpolated q!$0!');
is(q|$0|, '$'~'0', 'Non-translation of non-interpolated q|$0|');

# L<S05/Grammars/Just like the methods of a class, the rule definitions of a grammar are inherited> 

grammar English { regex name { john } }
grammar French  { regex name { jean } }
grammar Russian { regex name { ivan } }

ok("john" ~~ m/<.English::name> | <.French::name> | <.Russian::name>/, 'English name');
is(~$/, "john", 'Match is john');
ok($/ ne "jean", "Match isn't jean");
#?rakudo todo 'needs review'
is(~$/<name>, "john", 'Name is john');

ok("jean" ~~ m/<.English::name> | <.French::name> | <.Russian::name>/, 'French name');
is(~$/, "jean", 'Match is jean');
#?rakudo todo 'needs review'
is(~$/<name>, "jean", 'Name is jean');

ok("ivan" ~~ m/<.English::name> | <.French::name> | <.Russian::name>/, 'Russian name');
is(~$/, "ivan", 'Match is ivan');
#?rakudo todo 'needs review'
is(~$/<name>, "ivan", 'Name is ivan');

my regex name { <.English::name> | <.French::name> | <.Russian::name> }
 
ok("john" ~~ m/<name>/, 'English metaname');
is(~$/, "john", 'Metaname match is john');
ok(~$/ ne "jean", "Metaname match isn't jean");
is(~$/<name>, "john", 'Metaname is john');


# vim: ft=perl6
