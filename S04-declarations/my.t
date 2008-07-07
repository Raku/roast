use v6;
use Test;

plan 12;

#L<S04/The Relationship of Blocks and Declarations/"declarations, all
# lexically scoped declarations are visible"> 
{

    #?rakudo todo 'lexicals bug'
    eval_dies_ok('$x; my $x = 42', 'my() variable not yet visible prior to declartation');
    is(eval('my $x = 42; $x'), 42, 'my() variable is visible now (2)');
}


{
    my $ret = 42;
    eval_dies_ok '$ret = $x ~ my $x;', 'my() variable not yet visible (1)';
    is $ret, 42,                       'my() variable not yet visible (2)';
}

#?rakudo skip 'scoping bug'
{
    my $ret = 42;
    lives_ok { $ret = my($x) ~ $x }, 'my() variable is visible (1)';
    is $ret, "",                     'my() variable is visible (2)';
}

#?rakudo skip 'pointy subs'
{
  my $was_in_sub;
  my &foo := -> $arg { $was_in_sub = $arg };
  foo(42);
  is $was_in_sub, 42, 'calling a lexically defined my()-code var worked';
}

#?rakudo skip 'test depency on fudge test'
eval_dies_ok 'foo(42)', 'my &foo is lexically scoped';

#?rakudo todo 'do { } and lexicals'
{
  is(do{my $a = 3; $a}, 3, 'do{my $a = 3; $a} works');
  is(do{1; my $a = 3; $a}, 3, 'do{1; my $a = 3; $a} works');
}

eval_lives_ok 'my $x = my $y = 0;', '"my $x = my $y = 0" parses';

{
    my $test = "value should still be set for arg, even if there's a later my";
    sub foo (*%p) {
        is(%p<a>, 'b', $test);
        my %p;
    }
    foo(a => 'b');
}


# vim: ft=perl6
