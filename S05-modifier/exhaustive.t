use v6;
use Test;
plan 104;

=begin pod

This file was originally derived from the Perl CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/exhaustive.t.

# L<S05/Modifiers/:exhaustive>

=end pod

my $str = "abrAcadAbbra";

my @expected =
    [ 0, 'abrAcadAbbra' ],
    [ 0, 'abrAcadA'     ],
    [ 0, 'abrAca'       ],
    [ 0, 'abrA'         ],
    [ 3,    'AcadAbbra' ],
    [ 3,    'AcadA'     ],
    [ 3,    'Aca'       ],
    [ 5,      'adAbbra' ],
    [ 5,      'adA'     ],
    [ 7,        'Abbra' ],
;

for (1..2) -> $rep {
    ok($str ~~ m:i:exhaustive/ a .+ a /, "Repeatable every-way match ($rep)" );

    is +@$/, +@expected, "Correct number of matches (pass $rep)";
    my %position;
    for @expected -> ($pos, $exp) {
        %position{$exp} = $pos;
    }
    for (@$/) {
        ok %position{$_}:exists, "Matched '$_' ($rep)";
        is .from, %position{$_}, "At correct position of '$_' ($rep)";
        %position{$_}:delete;
    }
    is +%position, 0, "No matches missed ($rep)";
}

nok "abcdefgh" ~~ m:exhaustive/ a .+ a /, 'Failed every-way match';
is +@$/, 0, 'No matches';

ok $str ~~ m:ex:i/ a (.+) a /, 'Capturing every-way match';

is +@$/, +@expected, 'Correct number of capturing matches';

my %expected = |(@expected.map: { $_[1] => True });

for @($/) {
    ok %expected{$_}, "Capture matched '$_'";
    is $_[0], substr($_,1,*-1), "Captured within '$_'";
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


my regex noun  { time | flies | arrow }
my regex subj  { <noun> }
my regex obj   { <noun> }
my regex verb  { flies | like | time }
my regex adj   { time }
my regex art   { an? }
my regex prep  { like }

#skip-rest("XXX - infinite loop"); exit;

ok "time   flies   like    an     arrow" ~~
    m:s:ex/^[<adj>   <subj>   <verb>    <art>     <obj>|<subj>   <verb>   <prep>    <art>     <noun>|<verb>   <obj>   <prep>    <art>     <noun>]/,
    "Any with capturing rules";

is ~$/[0]<adj>,  'time',  'Rule capture 0 adj';
is ~$/[0]<subj>, 'flies', 'Rule capture 0 subj';
is ~$/[0]<verb>, 'like',  'Rule capture 0 verb';
is ~$/[0]<art>,  'an',    'Rule capture 0 art';
is ~$/[0]<obj>,  'arrow', 'Rule capture 0 obj';

is ~$/[1]<subj>, 'time',  'Rule capture 1 subj';
is ~$/[1]<verb>, 'flies', 'Rule capture 1 verb';
is ~$/[1]<prep>, 'like',  'Rule capture 1 prep';
is ~$/[1]<art>,  'an',    'Rule capture 1 art';
is ~$/[1]<noun>, 'arrow', 'Rule capture 1 noun';

is ~$/[2]<verb>, 'time',  'Rule capture 2 verb';
is ~$/[2]<obj>,  'flies', 'Rule capture 2 obj';
is ~$/[2]<prep>, 'like',  'Rule capture 2 prep';
is ~$/[2]<art>,  'an',    'Rule capture 2 art';
is ~$/[2]<noun>, 'arrow', 'Rule capture 2 noun';


nok "fooooo" ~~ m:exhaustive { s o+ }, 'Subsequent failed any match...';
is +@$/, 0, '...leaves @$/ empty';

# vim: expandtab shiftwidth=4
