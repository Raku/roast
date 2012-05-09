use v6;
use Test;

=begin pod

This file was originally derived from the perl5 CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/counted.t.

=end pod

plan 118;

# L<S05/Modifiers/If the number is followed by an>

my $data = "f fo foo fooo foooo fooooo foooooo";
my $sub1 = "f bar foo fooo foooo fooooo foooooo";
my $sub2 = "f fo bar fooo foooo fooooo foooooo";
my $sub3 = "f fo foo bar foooo fooooo foooooo";
my $sub4 = "f fo foo fooo bar fooooo foooooo";
my $sub5 = "f fo foo fooo foooo bar foooooo";
my $sub6 = "f fo foo fooo foooo fooooo bar";

# :nth(N)...

ok(!( $data ~~ m:nth(0)/fo+/ ), 'No match nth(0)');

ok($data ~~ m:nth(1)/fo+/, 'Match nth(1)');
is($/, 'fo', 'Matched value for nth(1)');

ok($data ~~ m:nth(2)/fo+/, 'Match nth(2)');
is($/, 'foo', 'Matched value for nth(2)');

ok($data ~~ m:nth(3)/fo+/, 'Match nth(3)');
is($/, 'fooo', 'Matched value for nth(3)');

ok($data ~~ m:nth(4)/fo+/, 'Match nth(4)');
is($/, 'foooo', 'Matched value for nth(4)');

ok($data ~~ m:nth(5)/fo+/, 'Match nth(5)');
is($/, 'fooooo', 'Matched value for nth(5)');

ok($data ~~ m:nth(6)/fo+/, 'Match nth(6)');
is($/, 'foooooo', 'Matched value for nth(6)');

ok(!( $data ~~ m:nth(7)/fo+/ ), 'No match nth(7)');


# :nth($N)...

for (1..6) -> $N {
    ok($data ~~ m:nth($N)/fo+/, "Match nth(\$N) for \$N == $N" );
    is($/, 'f'~'o' x $N, "Matched value for $N" );
}

# more interesting variations of :nth(...)
#?niecza skip 'm:g'
#?rakudo todo 'unknown'
{
    ok($data ~~ m:nth(2,3):global/(fo+)/, 'nth(list) is ok');
    is(@(), <foo fooo>, 'nth(list) matched correctly');
}


# :Nst...

ok($data ~~ m:1st/fo+/, 'Match 1st');
is($/, 'fo', 'Matched value for 1st');

ok($data ~~ m:2st/fo+/, 'Match 2st');
is($/, 'foo', 'Matched value for 2st');

ok($data ~~ m:3st/fo+/, 'Match 3st');
is($/, 'fooo', 'Matched value for 3st');

ok($data ~~ m:4st/fo+/, 'Match 4st');
is($/, 'foooo', 'Matched value for 4st');

ok($data ~~ m:5st/fo+/, 'Match 5st');
is($/, 'fooooo', 'Matched value for 5st');

ok($data ~~ m:6st/fo+/, 'Match 6st');
is($/, 'foooooo', 'Matched value for 6st');

ok(!( $data ~~ m:7st/fo+/ ), 'No match 7st');


# :Nnd...

ok($data ~~ m:1nd/fo+/, 'Match 1nd');
is($/, 'fo', 'Matched value for 1nd');

ok($data ~~ m:2nd/fo+/, 'Match 2nd');
is($/, 'foo', 'Matched value for 2nd');

ok($data ~~ m:3nd/fo+/, 'Match 3nd');
is($/, 'fooo', 'Matched value for 3nd');

ok($data ~~ m:4nd/fo+/, 'Match 4nd');
is($/, 'foooo', 'Matched value for 4nd');

ok($data ~~ m:5nd/fo+/, 'Match 5nd');
is($/, 'fooooo', 'Matched value for 5nd');

ok($data ~~ m:6nd/fo+/, 'Match 6nd');
is($/, 'foooooo', 'Matched value for 6nd');

ok(!( $data ~~ m:7nd/fo+/ ), 'No match 7nd');


# :Nrd...

ok($data ~~ m:1rd/fo+/, 'Match 1rd');
is($/, 'fo', 'Matched value for 1rd');

ok($data ~~ m:2rd/fo+/, 'Match 2rd');
is($/, 'foo', 'Matched value for 2rd');

ok($data ~~ m:3rd/fo+/, 'Match 3rd');
is($/, 'fooo', 'Matched value for 3rd');

ok($data ~~ m:4rd/fo+/, 'Match 4rd');
is($/, 'foooo', 'Matched value for 4rd');

ok($data ~~ m:5rd/fo+/, 'Match 5rd');
is($/, 'fooooo', 'Matched value for 5rd');

ok($data ~~ m:6rd/fo+/, 'Match 6rd');
is($/, 'foooooo', 'Matched value for 6rd');

ok(!( $data ~~ m:7rd/fo+/ ), 'No match 7rd');


# :Nth...

ok($data ~~ m:1th/fo+/, 'Match 1th');
is($/, 'fo', 'Matched value for 1th');

ok($data ~~ m:2th/fo+/, 'Match 2th');
is($/, 'foo', 'Matched value for 2th');

ok($data ~~ m:3th/fo+/, 'Match 3th');
is($/, 'fooo', 'Matched value for 3th');

ok($data ~~ m:4th/fo+/, 'Match 4th');
is($/, 'foooo', 'Matched value for 4th');

ok($data ~~ m:5th/fo+/, 'Match 5th');
is($/, 'fooooo', 'Matched value for 5th');

ok($data ~~ m:6th/fo+/, 'Match 6th');
is($/, 'foooooo', 'Matched value for 6th');

ok(!( $data ~~ m:7th/fo+/ ), 'No match 7th');


# Substitutions...
#?rakudo skip 's{} = ...'
{
    my $try = $data;
    ok(!( $try ~~ s:0th{fo+}=q{bar} ), "Can't substitute 0th" );
    is($try, $data, 'No change to data for 0th');

    $try = $data;
    ok($try ~~ s:1st{fo+}=q{bar}, 'substitute 1st');
    is($try, $sub1, 'substituted 1st correctly');

    $try = $data;
    ok($try ~~ s:2nd{fo+}=q{bar}, 'substitute 2nd');
    is($try, $sub2, 'substituted 2nd correctly');

    $try = $data;
    ok($try ~~ s:3rd{fo+}=q{bar}, 'substitute 3rd');
    is($try, $sub3, 'substituted 3rd correctly');

    $try = $data;
    ok($try ~~ s:4th{fo+}=q{bar}, 'substitute 4th');
    is($try, $sub4, 'substituted 4th correctly');

    $try = $data;
    ok($try ~~ s:5th{fo+}=q{bar}, 'substitute 5th');
    is($try, $sub5, 'substituted 5th correctly');

    $try = $data;
    ok($try ~~ s:6th{fo+}=q{bar}, 'substitute 6th');
    is($try, $sub6, 'substituted 6th correctly');

    $try = $data;
    ok(!( $try ~~ s:7th{fo+}=q{bar} ), "Can't substitute 7th" );
    is($try, $data, 'No change to data for 7th');
}


# Other patterns...

ok($data ~~ m:3rd/ f [\d|\w+]/, 'Match 3rd f[\d|\w+]');
is($/, 'fooo', 'Matched value for 3rd f[\d|\w+]');

ok($data ~~ m:3rd/ <ident> /, 'Match 3rd <ident>');
is($/, 'foo', 'Matched value for 3th <ident>');

ok($data ~~ m:3rd/ « <ident> /, 'Match 3rd « <ident>');
is($/, 'foo', 'Matched value for 3th « <ident>');


$data = "f fo foo fooo foooo fooooo foooooo";
$sub1 = "f bar foo fooo foooo fooooo foooooo";
$sub2 = "f bar bar fooo foooo fooooo foooooo";
$sub3 = "f bar bar bar foooo fooooo foooooo";
$sub4 = "f bar bar bar bar fooooo foooooo";
$sub5 = "f bar bar bar bar bar foooooo";
$sub6 = "f bar bar bar bar bar bar";

#?DOES 1

# :Nx...


#?rakudo skip 's{} = ...'
{
    my $try = $data;
    ok(!( $try ~~ s:0x{fo+}=q{bar} ), "Can't substitute 0x" );
    is($try, $data, 'No change to data for 0x');

    $try = $data;
    ok($try ~~ s:1x{fo+}=q{bar}, 'substitute 1x');
    is($try, $sub1, 'substituted 1x correctly');

    $try = $data;
    ok($try ~~ s:2x{fo+}=q{bar}, 'substitute 2x');
    is($try, $sub2, 'substituted 2x correctly');

    $try = $data;
    ok($try ~~ s:3x{fo+}=q{bar}, 'substitute 3x');
    is($try, $sub3, 'substituted 3x correctly');

    $try = $data;
    ok($try ~~ s:4x{fo+}=q{bar}, 'substitute 4x');
    is($try, $sub4, 'substituted 4x correctly');

    $try = $data;
    ok($try ~~ s:5x{fo+}=q{bar}, 'substitute 5x');
    is($try, $sub5, 'substituted 5x correctly');

    $try = $data;
    ok($try ~~ s:6x{fo+}=q{bar}, 'substitute 6x');
    is($try, $sub6, 'substituted 6x correctly');

    $try = $data;
    ok($try ~~ s:7x{fo+}=q{bar}, 'substitute 7x');
    is($try, $data, 'substituted 7x correctly');
}

# vim: ft=perl6
