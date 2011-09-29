use v6;

use Test;

=begin pod

This file was derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/charset.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

plan 28;

# Broken:
# L<S05/Extensible metasyntax (C<< <...> >>)/"A leading [ ">

ok("zyxaxyz" ~~ m/(<[aeiou]>)/, 'Simple set');
is($0, 'a', 'Simple set capture');

# L<S05/Extensible metasyntax (C<< <...> >>)/"A leading - indicates">
ok(!( "a" ~~ m/<-[aeiou]>/ ), 'Simple neg set failure');
ok("f" ~~ m/(<-[aeiou]>)/, 'Simple neg set match');
is($0, 'f', 'Simple neg set capture');

# L<S05/Extensible metasyntax (C<< <...> >>)/Character classes can be combined>
ok(!( "a" ~~ m/(<[a..z]-[aeiou]>)/ ), 'Difference set failure');
ok("y" ~~ m/(<[a..z]-[aeiou]>)/, 'Difference set match');
is($0, 'y', 'Difference set capture');
ok(!( "a" ~~ m/(<+alpha-[aeiou]>)/ ), 'Named difference set failure');
ok("y" ~~ m/(<+alpha-[aeiou]>)/, 'Named difference set match');
is($0, 'y', 'Named difference set capture');
ok(!( "y" ~~ m/(<[a..z]-[aeiou]-[y]>)/ ), 'Multi-difference set failure');
ok("f" ~~ m/(<[a..z]-[aeiou]-[y]>)/, 'Multi-difference set match');
is($0, 'f', 'Multi-difference set capture');

ok(']' ~~ m/(<[\]]>)/, 'quoted close LSB match');
is($0, ']', 'quoted close LSB capture');
ok('[' ~~ m/(<[\[]>)/, 'quoted open LSB match');
is($0, '[', 'quoted open LSB capture');
ok('{' ~~ m/(<[\{]>)/, 'quoted open LCB match');
is($0, '{', 'quoted open LCB capture');
ok('}' ~~ m/(<[\}]>)/, 'quoted close LCB match');
is($0, '}', 'quoted close LCB capture');

# RT #67124
#?rakudo todo 'comment in charset (RT #67124)'
eval_lives_ok( '"foo" ~~ /<[f] #`[comment] + [o]>/',
               'comment embedded in charset can be parsed' );
#?rakudo skip 'comment in charset (RT #67124)'
ok( "foo" ~~ /<[f] #`[comment] + [o]>/, 'comment embedded in charset works' );

# RT #67122
#?rakudo skip 'large \\x char spec in regex (RT #67122) (noauto)'
ok "\x[10001]" ~~ /<[\x10000..\xEFFFF]>/, 'large \\x char spec';

#?rakudo skip 'RT 71702: lethal reverse range in charset'
#?niecza skip 'TODO'
eval_dies_ok( "'RT 71702' ~~ /<[d..b]>? RT/",
    'reverse range in charset is lethal (RT 71702)' );

# RT #64220
ok 'b' ~~ /<[. .. b]>/, 'weird char class matches at least its end point';

# RT #69682
#?rakudo skip 'nom regression'
#?niecza skip 'Unsupported use of - as character range; in Perl 6 please use ..'
{
eval "/<[a-z]>/";
ok ~$! ~~ / 'Unsupported use of - as character range; in Perl 6 please use ..'/,
    "STD error message for - as character range";
}

done;

# vim: ft=perl6
