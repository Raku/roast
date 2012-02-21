use v6;
use Test;

=begin pod

This file was originally derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/exhaustive.t.

# L<S05/Modifiers/:exhaustive>

=end pod

#?pugs emit force_todo(2,3,5,6,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42);

my $str = "abrAcadAbbra";

my @expected = (
    [ 0 => 'abrAcadAbbra' ],
    [ 0 => 'abrAcadA'     ],
    [ 0 => 'abrAca'       ],
    [ 0 => 'abrA'         ],
    [ 3 =>    'AcadAbbra' ],
    [ 3 =>    'AcadA'     ],
    [ 3 =>    'Aca'       ],
    [ 5 =>      'adAbbra' ],
    [ 5 =>      'adA'     ],
    [ 7 =>        'Abbra' ],
);

for (1..2) -> $rep {
    ok($str ~~ m:i:exhaustive/ a .+ a /, "Repeatable every-way match ($rep)" );

    ok(@$/ == @expected, "Correct number of matches ($rep)" );
    my %expected; %expected{map {$_[1]}, @expected} = (1) x @expected;
    my %position; %position{map {$_[1]}, @expected} = map {$_[0]}, @expected;
    for (@$/) {
        ok( %expected{$_}, "Matched '$_' ($rep)" );
        ok( %position{$_} == $_.pos, "At correct position of '$_' ($rep)" );
        #?rakudo emit #
        %expected{$_} :delete;
        #?rakudo emit %expected.delete($_)
    }
    ok(%expected.keys == 0, "No matches missed ($rep)" );
}

ok(!( "abcdefgh" ~~ m:exhaustive/ a .+ a / ), 'Failed every-way match');
ok(@$/ == 0, 'No matches');

ok($str ~~ m:ex:i/ a (.+) a /, 'Capturing every-way match');

ok(@$/ == @expected, 'Correct number of capturing matches');
my %expected; %expected{map {$_[1]}, @expected} = (1) x @expected;

for @($/) {
    ok( %expected{$_}, "Capture matched '$_'" );
    ok( $_[1] = substr($_[0],1,-1), "Captured within '$_'" );
    %expected{$_} :delete;
}

my @adj  = <time>;
my @noun = <time flies arrow>;
my @verb = <time flies like>;
my @art  = <an>;
my @prep = <like>;

ok( "time flies like an arrow" ~~
    m:s:ex/^    [
                $<adj>  = (@adj)
                $<subj> = (@noun)
                $<verb> = (@verb)
                $<art>  = (@art)
                $<obj>  = (@noun)
              |
                $<subj> = (@noun)
                $<verb> = (@verb)
                $<prep> = (@prep)
                $<art>  = (@art)
                $<obj>  = (@noun)
              |
                $<verb> = (@verb)
                $<obj>  = (@noun)
                $<prep> = (@prep)
                $<art>  = (@art)
                $<noun> = (@noun)
              ]
           /, 'Multiple capturing');

is(~$/[0]<adj>,  'time',  'Capture 0 adj');
is(~$/[0]<subj>, 'flies', 'Capture 0 subj');
is(~$/[0]<verb>, 'like',  'Capture 0 verb');
is(~$/[0]<art>,  'an',    'Capture 0 art');
is(~$/[0]<obj>,  'arrow', 'Capture 0 obj');

is(~$/[1]<subj>, 'time',  'Capture 1 subj');
is(~$/[1]<verb>, 'flies', 'Capture 1 verb');
is(~$/[1]<prep>, 'like',  'Capture 1 prep');
is(~$/[1]<art>,  'an',    'Capture 1 art');
is(~$/[1]<obj>,  'arrow', 'Capture 1 obj');

is(~$/[2]<verb>, 'time',  'Capture 2 verb');
is(~$/[2]<obj>,  'flies', 'Capture 2 obj');
is(~$/[2]<prep>, 'like',  'Capture 2 prep');
is(~$/[2]<art>,  'an',    'Capture 2 art');
is(~$/[2]<noun>, 'arrow', 'Capture 2 noun');


regex subj  { <?noun> }
regex obj   { <?noun> }
regex noun  { time | flies | arrow }
regex verb  { flies | like | time }
regex adj   { time }
regex art   { an? }
regex prep  { like }

skip_rest("XXX - infinite loop"); exit;

ok("time   flies   like    an     arrow" ~~
    m:s:ex/^ [ <adj>  <subj> <verb> <art> <obj>
                 | <subj> <verb> <prep> <art> <noun> 
                 | <verb> <obj>  <prep> <art> <noun>
                 ]
         /,
    "Any with capturing rules"
);

is(~$/[0]<adj>,  'time',  'Rule capture 0 adj');
is(~$/[0]<subj>, 'flies', 'Rule capture 0 subj');
is(~$/[0]<verb>, 'like',  'Rule capture 0 verb');
is(~$/[0]<art>,  'an',    'Rule capture 0 art');
is(~$/[0]<obj>,  'arrow', 'Rule capture 0 obj');

is(~$/[1]<subj>, 'time',  'Rule capture 1 subj');
is(~$/[1]<verb>, 'flies', 'Rule capture 1 verb');
is(~$/[1]<prep>, 'like',  'Rule capture 1 prep');
is(~$/[1]<art>,  'an',    'Rule capture 1 art');
is(~$/[1]<noun>, 'arrow', 'Rule capture 1 noun');

is(~$/[2]<verb>, 'time',  'Rule capture 2 verb');
is(~$/[2]<obj>,  'flies', 'Rule capture 2 obj');
is(~$/[2]<prep>, 'like',  'Rule capture 2 prep');
is(~$/[2]<art>,  'an',    'Rule capture 2 art');
is(~$/[2]<noun>, 'arrow', 'Rule capture 2 noun');


ok(!( "fooooo" ~~ m:exhaustive { s o+ } ), 'Subsequent failed any match...');
    ok(@$/ == 0, '...leaves @$/ empty');

done();

# vim: ft=perl6
