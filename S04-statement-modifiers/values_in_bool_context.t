use v6.c;

use Test;

plan 24;

# L<S04/Conditional statements/Conditional statement
#   modifiers work as in Perl 5>

##  scalar checking  ##

{
    my $var = 20;

    my ($a, $b, $c, $d, $e, $f, $g, $h);

    $a = 1 if 1;
    $b = 1 if 0;
    $c = 1 if "true";
    $d = 1 if "";
    $e = 1 if "1";
    $f = 1 if "0";
    $g = 1 if Mu;
    $h = 1 if $var;

    ok  $a, 'literal in bool context - numeric true value';
    ok !$b, 'literal in bool context - numeric false value';
    ok  $c, 'literal in bool context - string true value';
    ok !$d, 'literal in bool context - string false value';
    ok  $e, 'literal in bool context - stringified true value';
    ok  $f, 'literal in bool context - stringified true value';
    ok !$g, 'literal in bool context - undefined value';
    ok  $h, 'literal in bool context - scalar variable';
}

##  array checking  ##

{
    my @array = (1, 0, "true", "", "1", "0", Mu);

    my ($a, $b, $c, $d, $e, $f, $g, $h);

    $a = 1 if @array[0];
    $b = 1 if @array[1];
    $c = 1 if @array[2];
    $d = 1 if @array[3];
    $e = 1 if @array[4];
    $f = 1 if @array[5];
    $g = 1 if @array[6];
    $h = 1 if @array;

    ok  $a, 'array in bool context - numeric true value';
    ok !$b, 'array in bool context - numeric false value';
    ok  $c, 'array in bool context - string true value';
    ok !$d, 'array in bool context - string false value';
    ok  $e, 'array in bool context - stringified true value';
    ok  $f, 'array in bool context - stringified true value';
    ok !$g, 'array in bool context - undefined value';
    ok  $h, 'array in bool context  array as a whole';
}

##  hash checking  ##

{
    my %hash = (
        0 => 1, 1 => 0, 2 => "true",
        3 => "", 4 => "1", 5 => "0", 6 => Mu
    );

    my ($a, $b, $c, $d, $e, $f, $g, $h);

    $a = 1 if %hash{0};
    $b = 1 if %hash{1};
    $c = 1 if %hash{2};
    $d = 1 if %hash{3};
    $e = 1 if %hash{4};
    $f = 1 if %hash{5};
    $g = 1 if %hash{6};
    $h = 1 if %hash;

    ok  $a, 'hash in bool context - numeric true value';
    ok !$b, 'hash in bool context - numeric false value';
    ok  $c, 'hash in bool context - string true value';
    ok !$d, 'hash in bool context - string false value';
    ok  $e, 'hash in bool context - stringified true value';
    ok  $f, 'hash in bool context - stringified true value';
    ok !$g, 'hash in bool context - undefined value';
    ok  $h, 'hash in bool context - hash as a whole';
}

# vim: ft=perl6
