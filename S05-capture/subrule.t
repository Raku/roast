use v6;

use Test;

=begin pod

This file was derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/subrule.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

plan 36;

# L<S05/Match objects/When used as a hash>

my regex abc {abc}

my regex once {<&abc>}

ok("abcabcabcabcd" ~~ m/<&once>/, 'Once match');
ok($/, 'Once matched');
is(~$/, "abc", 'Once matched');
ok(@($/) == 0, 'Once no array capture');
ok(%($/).keys == 0, 'Once no hash capture');


my regex rep {<&abc>**{4}}

ok("abcabcabcabcd" ~~ m/<&rep>/, 'Rep match');
ok($/, 'Rep matched');
is(~$/, "abcabcabcabc", 'Rep matched');
ok(@($/) == 0, 'Rep no array capture');
ok(%($/).keys == 0, 'Rep no hash capture');


my regex cap {<abc=&abc>}

ok("abcabcabcabcd" ~~ m/<cap=&cap>/, 'Cap match');
ok($/, 'Cap matched');
is(~$/, "abc", 'Cap zero matched');
is(~$/<cap>, "abc", 'Cap captured');

is(~$/<cap><abc>, "abc", 'Cap abc captured');
ok(@($/) == 0, 'Cap no array capture');
ok(%($/).keys == 1, 'Cap hash capture');

my regex repcap {<abc=&abc>**{4}}

ok("abcabcabcabcd" ~~ m/<repcap=&repcap>/, 'Repcap match');
ok($/, 'Repcap matched');
is(~$/, "abcabcabcabc", 'Repcap matched');
is(~$/<repcap>, "abcabcabcabc", 'Repcap captured');
is(~$/<repcap><abc>[0], "abc", 'Repcap abc zero captured');
is(~$/<repcap><abc>[1], "abc", 'Repcap abc one captured');
is(~$/<repcap><abc>[2], "abc", 'Repcap abc two captured');
is(~$/<repcap><abc>[3], "abc", 'Repcap abc three captured');
ok(@($/) == 0, 'Repcap no array capture');


my regex caprep {(<&abc>**{4})}

ok("abcabcabcabcd" ~~ m/<caprep=&caprep>/, 'Caprep match');
ok($/, 'Caprep matched');
is(~$/, "abcabcabcabc", 'Caprep matched');
is(~$/<caprep>, "abcabcabcabc", 'Caprep captured');
is(~$/<caprep>[0], "abcabcabcabc", 'Caprep abc one captured');

# RT #76892
{
    nok 'abc' !~~ /<alpha>(.)/, 'unsuccessful non-match';
    is $0,       'b', 'failed !~~ still makes $0 available';
    is $<alpha>, 'a', 'failed !~~ still makes $<foo> available';
}

# RT #96424 
{
    ok '0' ~~ /<alpha>|<digit>/, 'regex matches';
    is $<alpha>.Str, '', 'Can call methods on captures from unsuccessful matches';
}

# vim: ft=perl6
