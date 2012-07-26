use v6;

use Test;

# L<S03/Assignment operators/A op= B>

plan 28;

{
    my @a = (1, 2, 3);
    lives_ok({@a .= map: { $_ + 1 }}, '.= runs with block');
    is(@a[0], 2, 'inplace map [0]');
    is(@a[1], 3, 'inplace map [1]');
    is(@a[2], 4, 'inplace map [2]');
}

{
    my @b = <foo 123 bar 456 baz>;
    #?pugs todo
    lives_ok { @b.=grep(/<[a..z]>/)},
             '.= works without surrounding whitespace';
    is @b[0], 'foo', 'inplace grep [0]';
    #?pugs todo
    is @b[1], 'bar', 'inplace grep [1]';
    #?pugs todo
    is @b[2], 'baz', 'inplace grep [2]';
}

#?rakudo skip "Method '' not found for invocant of class 'Str'"
{
    my $a=3.14;
    $a .= Int;
    is($a, 3, "inplace int");

    my $b = "a_string"; $b .= WHAT;
    my $c =         42; $c .= WHAT;
    my $d =      42.23; $d .= WHAT;
    my @e = <a b c d>;  @e .= WHAT;
    isa_ok($b,    Str,   "inplace WHAT of a Str");
    isa_ok($c,    Int,   "inplace WHAT of a Num");
    isa_ok($d,    Rat,   "inplace WHAT of a Rat");
    isa_ok(@e[0], Array, "inplace WHAT of an Array");
}

my $f = "lowercase"; $f .= uc;
my $g = "UPPERCASE"; $g .= lc;
my $h = "lowercase"; $h .= tc;
my $i = "UPPERCASE"; $i .= tc;
is($f, "LOWERCASE", "inplace uc");
is($g, "uppercase", "inplace lc");
is($h, "Lowercase", "inplace tc");
is($i, "uPPERCASE", "inplace lcfirst");

# L<S12/"Mutating methods">
my @b = <z a b d e>;
@b .= sort;
is ~@b, "a b d e z", "inplace sort";

{
    $_ = -42;
    .=abs;
    is($_, 42, '.=foo form works on $_');
}

# RT #64268
{
    my @a = 1,3,2;
    my @a_orig = @a;

    my @b = @a.sort: {1};
    #?niecza todo "sort is not a stable sort on all platforms"
    #?pugs todo
    is @b, @a_orig,            'worked: @a.sort: {1}';

    @a.=sort: {1};
    #?niecza todo "sort is not a stable sort on all platforms"
    #?pugs todo
    is @a, @a_orig,            'worked: @a.=sort: {1}';

    @a.=sort;
    #?pugs todo
    is @a, [1,2,3],            'worked: @a.=sort';
}

# RT #70676
{
   my $x = 5.5;
   $x .= Int;
   isa_ok $x, Int, '.= Int (type)';
   is $x, 5, '.= Int (value)';

   $x = 3;
   $x .= Str;
   isa_ok $x, Str, '.= Str (type)';
   is $x, '3', '.= Str (value)';

   $x = 15;
   $x .= Bool;
   isa_ok $x, Bool, '.= Bool (type)';
   is $x, True, '.= Bool (value)';
}

# vim: ft=perl6
