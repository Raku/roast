use v6;
use lib $?FILE.IO.parent(2).add: 'packages';
use MONKEY-TYPING;
use Test;
use Test::Util;

plan 111;

=begin description

Tests the "for" statement

This attempts to test as many variations of the
for statement as possible

=end description

## No foreach
# L<S04/The C<for> statement/"no foreach statement any more">
{
    my $times_run = 0;
    throws-like 'foreach 1..10 { $times_run++ }; 1', X::Obsolete, "foreach is gone";
    throws-like 'foreach (1..10) { $times_run++}; 1', X::Obsolete,
        "foreach is gone, even with parens";
    is $times_run, 0, "foreach doesn't work";
}

## for with plain old range operator w/out parens

{
    my $a = "";
    for 0 .. 5 { $a = $a ~ $_; };
    is($a, '012345', 'for 0..5 {} works');
}

# ... with pointy blocks

{
    my $b = "";
    for 0 .. 5 -> $_ { $b = $b ~ $_; };
    is($b, '012345', 'for 0 .. 5 -> {} works');
}

{
    my $str;
    my @a = 1..3;
    my @b = 4..6;
    for zip(@a, @b) -> ($x, $y) {
        $str ~= "($x $y)";
    }
    is $str, "(1 4)(2 5)(3 6)", 'for zip(@a; @b) -> $x, $y works';
}

# ... with referential sub
{
    my $d = "";
    for -2 .. 2 { $d ~= .sign };
    is($d, '-1-1011', 'for 0 .. 5 { .some_sub } works');
}

## and now with parens around the range operator
{
    my $e = "";
    for (0 .. 5) { $e = $e ~ $_; };
    is($e, '012345', 'for () {} works');
}

# ... with pointy blocks
{
    my $f = "";
    for (0 .. 5) -> $_ { $f = $f ~ $_; };
    is($f, '012345', 'for () -> {} works');
}

# ... with implicit topic

{
    $_ = "GLOBAL VALUE";
    for "INNER VALUE" {
        is( .lc, "inner value", "Implicit default topic is seen by lc()");
    };
    is($_,"GLOBAL VALUE","After the loop the implicit topic gets restored");
}

{
    # as statement modifier
    $_ = "GLOBAL VALUE";
    is( .lc, "inner value", "Implicit default topic is seen by lc()" )
        for "INNER VALUE";
    is($_,"GLOBAL VALUE","After the loop the implicit topic gets restored");
}

## and now for with 'topical' variables

# ... w/out parens

my $i = "";
for 0 .. 5 -> $topic { $i = $i ~ $topic; };
is($i, '012345', 'for 0 .. 5 -> $topic {} works');

# ... with parens

my $j = "";
for (0 .. 5) -> $topic { $j = $j ~ $topic; };
is($j, '012345', 'for () -> $topic {} works');


## for with @array operator w/out parens

my @array_k = (0 .. 5);
my $k = "";
for @array_k { $k = $k ~ $_; };
is($k, '012345', 'for @array {} works');

# ... with pointy blocks

my @array_l = (0 .. 5);
my $l = "";
for @array_l -> $_ { $l = $l ~ $_; };
is($l, '012345', 'for @array -> {} works');

## and now with parens around the @array

my @array_o = (0 .. 5);
my $o = "";
for (@array_o) { $o = $o ~ $_; };
is($o, '012345', 'for (@array) {} works');

# ... with pointy blocks
{
    my @array_p = (0 .. 5);
    my $p = "";
    for (@array_p) -> $_ { $p = $p ~ $_; };
    is($p, '012345', 'for (@array) -> {} works');
}

my @elems = <a b c d e>;

{
    my @a;
    for (@elems) {
        push @a, $_;
    }
    my @e = <a b c d e>;
    is(@a, @e, 'for (@a) { ... $_ ... } iterates all elems');
}

{
    my @a;
        for (@elems) -> $_ { push @a, $_ };
    my @e = @elems;
    is(@a, @e, 'for (@a)->$_ { ... $_ ... } iterates all elems' );
}

{
    my @a;
    for (@elems) { push @a, $_, $_; }
    my @e = <a a b b c c d d e e>;
    is(@a, @e, 'for (@a) { ... $_ ... $_ ... } iterates all elems, not just odd');
}

# "for @a -> $var" is ro by default.
{
   {
        my @a = <1 2 3 4>;
        throws-like 'for @a -> $elem {$elem = 5}', Exception,
            '-> $var is ro by default';
   }

   {
        my @a = <1 2 3 4>;
        for @a <-> $elem {$elem++;}
        is(@a, <2 3 4 5>, '<-> $var is rw');
   }

   {
       my @a = <1 2 3 4>;
       for @a <-> $first, $second {$first++; $second++}
       is(@a, <2 3 4 5>, '<-> $var, $var2 works');
   }

   {
       my @a = <1 2 3 4>;
       for @a <-> $_ {$_++;}
       is(@a, <2 3 4 5>, '<-> $_ is rw');
   }

}

# for with "is rw"
{
    my @array_s = (0..2);
    my @s = (1..3);
    for @array_s { $_++ };
    is(@array_s, @s, 'for @array { $_++ }');
}

{
  my @array = <a b c d>;
  for @array { $_ ~= "c" }
  is ~@array, "ac bc cc dc",
    'mutating $_ in for works';
}

{
    my @array_t = (0..2);
    my @t = (1..3);
    for @array_t -> $val is rw { $val++ };
    is(@array_t, @t, 'for @array -> $val is rw { $val++ }');
}

{
    my @array_v = (0..2);
    my @v = (1..3);
    for @array_v.values -> $val is rw { $val++ };
    is(@array_v, @v, 'for @array.values -> $val is rw { $val++ }');
}

{
    my @array_kv = (0..2);
    my @kv = (1..3);
    for @array_kv.kv -> $key, $val is rw { $val++ };
    is(@array_kv, @kv, 'for @array.kv -> $key, $val is rw { $val++ }');
}

{
    my %hash_v = ( a => 1, b => 2, c => 3 );
    my %v = ( a => 2, b => 3, c => 4 );
    for %hash_v.values -> $val is rw { $val++ };
    is(%hash_v, %v, 'for %hash.values -> $val is rw { $val++ }');
}

{
    my %hash_kv = ( a => 1, b => 2, c => 3 );
    my %kv = ( a => 2, b => 3, c => 4 );
    try { for %hash_kv.kv -> $key, $val is rw { $val++ }; };
    is( %hash_kv, %kv, 'for %hash.kv -> $key, $val is rw { $val++ }');
}

# .key //= ++$i for @array1;
class TestClass{ has $.key is rw  };

{
   my @array1 = (TestClass.new(:key<1>),TestClass.new());
   my $i = 0;
   for @array1 { .key //= ++$i }
   my $sum1 = [+] @array1.map: { $_.key };
   is( $sum1, 2, '.key //= ++$i for @array1;' );

}

# .key = 1 for @array1;
{
   my @array1 = (TestClass.new(),TestClass.new(:key<2>));

   .key = 1 for @array1;
   my $sum1 = [+] @array1.map: { $_.key };
   is($sum1, 2, '.key = 1 for @array1;');
}

# $_.key = 1 for @array1;
{
   my @array1 = (TestClass.new(),TestClass.new(:key<2>));

   $_.key = 1 for @array1;
   my $sum1 = [+] @array1.map: { $_.key };
   is( $sum1, 2, '$_.key = 1 for @array1;');

}

# rw scalars
#L<S04/The C<for> statement/implicit parameter to block read/write "by default">
{
    my ($a, $b, $c) = 0..2;
    try { for ($a, $b, $c) { $_++ } };
    is( [$a,$b,$c], [1,2,3], 'for ($a,$b,$c) { $_++ }');

    ($a, $b, $c) = 0..2;
    try { for ($a, $b, $c) -> $x is rw { $x++ } };
    is( [$a,$b,$c], [1,2,3], 'for ($a,$b,$c) -> $x is rw { $x++ }');
}

# list context

{
    my $a = '';
    my $b = '';
    for flat 1..3, 4..6 { $a ~= $_.WHAT.gist ; $b ~= Int.gist };
    is($a, $b, 'List context');

    $a = '';
    for ([1..3, 4..6],) { $a ~= $_.WHAT.gist };
    is($a, Array.gist, 'List context');

    $a = '';
    $b = '';
    for [1..3], [4..6] { $a ~= $_.WHAT.gist ; $b ~= Array.gist };
    is($a, $b, 'List context');
}

{
    # this was a rakudo bug with mixed 'for' and recursion, which seems to
    # confuse some lexical pads or the like, see RT #58392
    my $gather = '';
    sub f($l) {
        if $l <= 0 {
            return $l;
        }
        $gather ~= $l;
        for 1..3 {
        f($l-1);
            $gather ~= '.';
        }
    }
    f(2);

    is $gather, '21....1....1....', 'Can mix recursion and for';
}

# another variation
{
    my $t = '';
    my $c;
    sub r($x) {
        my $h = $c++;
        r $x-1 if $x;
        for 1 { $t ~= $h };
    };
    r 3;
    is $t, '3210', 'can mix recursion and for (RT #103332)';
}

# grep and sort in for
{
  my @array = <1 2 3 4>;
  my $output = '';

  for (grep { 1 }, @array) -> $elem {
    $output ~= "$elem,";
  }

  is $output, "1,2,3,4,", "grep works in for";
}

{
  my @array = <1 2 3 4>;
  my $output = '';

  for @array.sort -> $elem {
    $output ~= "$elem,";
  }

  is $output, "1,2,3,4,", "sort works in for";
}

{
  my @array = <1 2 3 4>;
  my $output = '';

  for (grep { 1 }, @array.sort) -> $elem {
    $output ~= "$elem,";
  }

  is $output, "1,2,3,4,", "grep and sort work in for";
}

# L<S04/Statement parsing/keywords require whitespace>
throws-like 'for(0..5) { }', X::Comp::Group, 'keyword needs at least one whitespace after it';

# looping with more than one loop variables
{
  my @a = <1 2 3 4>;
  my $str = '';
  for @a -> $x, $y {
    $str ~= $x+$y;
  }
  is $str, "37", "for loop with two variables";
}

{
  my $str = '';
  throws-like 'for 1..5 ->  $x, $y { $str ~= "$x$y" }', Exception,
      'Should throw exception, no value for parameter $y';
  is $str, "1234", "loop ran before throwing exception";
  #diag ">$str<";
}

# RT #63994
{
  my $str = '';
  for 1..5 -> $x, $y? {
    $str ~= " " ~ $x * ($y//0);
  }
  is $str, " 2 12 0";
}

{
  my $str = '';
  for 1..5 -> $x, $y = 7 {
    $str ~= " " ~ $x*$y;
  }
  is $str, " 2 12 35", 'default values in for-loops';
}

{
  my @a = <1 2 3>;
  my @b = <4 5 6>;
  my $res = '';
  for flat @a Z @b -> $x, $y {
    $res ~= " " ~ $x * $y;
  }
  is $res, " 4 10 18", "Z -ed for loop";
}

{
  my @a = <1 2 3>;
  my $str = '';

  for flat @a Z @a Z @a Z @a Z @a -> $q, $w, $e, $r, $t {
    $str ~= " " ~ $q*$w*$e*$r*$t;
  }
  is $str, " 1 {2**5} {3**5}", "Z-ed for loop with 5 arrays";
}

{
  throws-like 'for 1.. { };', X::Comp::Group, "Please use ..* for indefinite range";
  throws-like 'for 1... { };', X::Comp::Group, "1... does not exist";
}

{
  my $c;
  for 1..8 {
    $c = $_;
    last if $_ == 6;
  }
  is $c, 6, 'for loop ends in time using last';
}

{
  my $c;
  for 1..* {
    $c = $_;
    last if $_ == 6;
  }
  is $c, 6, 'infinte for loop ends in time using last';
}

{
  my $c;
  for 1..Inf {
    $c = $_;
    last if $_ == 6;
  }
  is $c, 6, 'infinte for loop ends in time using last';
}

#L<S04/Loop statements/"list comprehensions">
{
    my @odd-squares = ($_ * $_ if $_ % 2 for 0..10);
    is @odd-squares.join(' '), '1 9 25 49 81', 'list comprehension';
}

#L<S04/Loop statements/"The value of a loop statement">

{
    is (for ^2 { 41; 42 }), (42,42), "for loop value is list of iter values";
    is (for ^5 { 41; next if $_ == 2; $_; }).flat, (0,1,3,4),
                "for loop with value-less next flattens out nexted iterations";

# see RT #124568
    my $l = (for ^5 { 41; next if $_ == 2; $_; });
    is $l[2].perl, 3, "for loop iteration with value-less 'next' gives Empty";

    is (for ^5 { 41; last if $_ == 2; $_; }).flat, (0,1),
                "for loop with value-less last flattens out last iteration";

#?rakudo todo 'Rakudo still uses Nil here RT #124569'
    $l = (for ^5 { 41; last if $_ == 2; $_; });
    is $l[2].perl, "()", "for loop iteration with value-less 'last' gives ()";
}

# RT #62478
{
    try { EVAL('for (my $ii = 1; $ii <= 3; $ii++) { say $ii; }') };
    ok "$!" ~~ /C\-style/,   'mentions C-style';
    ok "$!" ~~ /for/,        'mentions for';
    ok "$!" ~~ /loop/,       'mentions loop';
}

# RT #65212
{
    my $parsed = 0;
    try { EVAL '$parsed = 1; for (1..3)->$n { last }' };
    ok ! $parsed, 'for (1..3)->$n   fails to parse';
}

# RT #71268
{
    sub rt71268 { for ^1 {} }
    lives-ok { ~(rt71268) }, 'can stringify "for ^1 {}" without death';
    # This test is actually wrong design-wise, should return ()
    is rt71268(), Nil, 'result of "for ^1 {}" is Nil';
}

# RT #62478
{
    throws-like 'for (my $i; $i <=3; $i++) { $i; }', X::Obsolete, 'Unsupported use of C-style "for (;;)" loop; in Perl 6 please use "loop (;;)"';
}

{
    try { EVAL 'for (my $x; $x <=3; $x++) { $i; }'; diag($!) };
    ok $! ~~ / 'C-style' /, 'Sensible error message';
}

# RT #64886
{
    my $a = 0;
    for 1..10000000000 {
        $a++;
        last;
    }
    is $a, 1, 'for on Range with huge max value is lazy and enters block';
}

# RT #60780
lives-ok {
    for 1 .. 5 -> $x, $y? { }
}, 'Iteration variables do not need to add up if one is optional';

# RT #78232
{
    my $a = 0;
    for 1, 2, 3 { sub foo {}; $a++ }
    is $a, 3, 'RT #78232';
}

# http://irclog.perlgeek.de/perl6/2011-12-29#i_4892285
# (Niecza bug)
{
    my $x = 0;
    for 1 .. 2 -> $a, $b { $x = $b } #OK not used
    is $x, 2, 'Lazy lists interact properly with multi-element for loops';
}

# RT #71270
# list comprehension
{
    sub f() { for ^1 { } };
    is f(), Nil, 'for-loop as last statement returns Nil';
}

# RT #74060
# more list comprehension
{
    my @s = ($_ * 2 if $_ ** 2 > 3 for 0 .. 5);
    is ~@s, '4 6 8 10', 'Can use statement-modifying "for" in list comprehension';
}

# RT #123506
{
    my \rt123506a = ($_ for ^1);
    is-eqv rt123506a, (0,),
        'assigning list comprehension to sigilless works (1)';
    my \rt123506b = ($_ for ^2);
    is-eqv rt123506b, (0, 1),
        'assigning list comprehension to sigilless works (2)';
}

# RT #113026
{
    my @rt113026 = 1 .. 10;
    my $iter = 0;
    for @rt113026 -> $n {
        $iter++;
        if $iter % 2 {
            @rt113026.push: $n;
        }
    }
    is $iter, 20, 'iterating over an expanding list';
    is @rt113026, <1 2 3 4 5 6 7 8 9 10 1 3 5 7 9 1 5 9 5 5>,
       'array expanded in for loop is expanded';
}

# RT #78406
{
    my $c = 0;
    dies-ok { for ^8 { .=fmt('%03b'); $c++ } }, '$_ is read-only here';
    is $c, 0, '... and $_ is *always* read-only here';
}

dies-ok
    {
        my class Foo {
            has @.items;
            method check_items { for @.items -> $item { die "bad" if $item == 2 } }
            method foo { self.check_items; .say for @.items }
        }
        Foo.new(items => (1, 2, 3, 4)).foo
    }, 'for in called method runs (was a sink context bug)';

# RT #77460
{
    my @a = 1;
    for 1..10 {
        my $last = @a[*-1];
        push @a, (sub ($s) { $s + 1 })($last)
    };
    is @a, [1, 2, 3, 4, 5, 6, 7, 8,9, 10, 11];
}

# RT #89208
is (for 5 { (sub { "OH HAI" })() }), "OH HAI", 'Anon sub inside for works.';

{
    sub f() { for 1..2 { } };
    is f(), Nil, 'for-loop as last statement returns Nil';
}

# RT #77738
{
    sub incr1 (*@v is raw) { @v[0]++; @v[1]++; };
    sub incr2 (*@v is raw) { for @v { $_++} };
    sub incr3 (*@v is raw) { for @v -> $x is rw { $x++ } };
    sub incr4 (*@v is raw) { for @v -> $x { $x++ } };
    my ($a, $b) = (0, 0);
    incr1($a, $b);
    is [$a, $b], [1, 1], 'is rw on slurpy parameters works (1)';
    incr2($a, $b);
    is [$a, $b], [2, 2], 'is rw on slurpy parameters works (2)';
    incr3($a, $b);
    is [$a, $b], [3, 3], 'is rw on slurpy parameters works (3)';
    throws-like { incr4($a, $b) }, X::Multi::NoMatch;
}

# RT #123005, #118705
{
    my $str = 'ACCB';
    my $rt123323;
    for $str {
        s/A (<-[B]>*) B/$0/;
        $rt123323 ~= $_;
    }
    is $rt123323, 'CC', '$0 works in substitution in for loop (1)';

    my $a = 'a';
    s/(.)/$0/ for $a;
    is $a, 'a', '$0 works in substition in for loop (2)';
}

# RT #122095
{
    my class RT122095 {};
    my $a = RT122095.new();
    my $w = $a.WHICH;
    my $good = True;
    for 0 .. 20000 {
        if $a.WHICH ne $w {
            $good = False;
        }
    };
    is $good, True, '.WHICH value did not change in for loop';
}

# RT #126349
{
    my @strs = ("11 22 33", "44 55 66", "77 88 99");

    for @strs {
        $_ ~~ s/\s(\S+)\s(\S+)/-$0-$1/;
    }

    is @strs.join(' '), '11-22-33 44-55-66 77-88-99', 'substitution with backreferences in for loop'
}

# RT #125598
{
    my $x = 'a1'; $x ~~ s/(\d+)/<$0>/;
    is $x, 'a<1>', 'substitution with backreferences outside of loop';

    for 1 {
        my $x = 'a1'; $x ~~ s/(\d+)/<$0>/;
        is $x, 'a<1>', 'substitution with backreferences inside of loop';
    }
}

# RT #77334
{
    sub foo { my $s; (for 1..3 { $s += $_ }) }
    is foo(), (6, 6, 6), 'for loops do not decontainerize';
}

# RT #128054
{
    my $out = '';
    quietly $out ~= ("{$_}") for <aa bb>;
    is $out, 'aabb',
        'topic of for loop has correct value in ("{$_}") construct';
}

# RT #123072
{
    my class Sinker { method sink() { take "Blub" } }
    is-deeply (gather for ^5 { Sinker.new(); }), <Blub Blub Blub Blub Blub>.Seq,
        "for loop properly sinks final statement method call";
}

# RT #131567
#?rakudo.jvm skip 'labeled next without loop construct'
#?DOES 1
{
  subtest 'next with label works inside list comprehended for loops' => {
    # We have several of these cases because some implementations chose
    # to branch handling of these special cases for perf reasons.

    plan 4;
    {
        my @ans;
        @ = (MEOW: for ^10 {
            eager MOO: for "a".."c" -> $n {
                next MEOW if $_ %% 2;
                next MOO  if $_ %% 3;
                @ans.push: "$_$n"
            }
        });
        is-deeply @ans, [<1a 1b 1c 5a 5b 5c 7a 7b 7c>],
            'just a for with Range';
    }

    {
        my @ans;
        @ = (MEOW: for ^10 -> $_ --> List {
            eager MOO: for "a".."c" -> $n --> Array {
                next MEOW if $_ %% 2;
                next MOO  if $_ %% 3;
                @ans.push: "$_$n"
            }
        });
        is-deeply @ans, [<1a 1b 1c 5a 5b 5c 7a 7b 7c>],
            '1 at a time, no phasers, non slippy';
    }

    {
        my @ans;
        @ = (MEOW: for ^6 -> $, $a --> Array { next MEOW if $a == 1; @ans.push: $a });
        is-deeply @ans, [3, 5], 'two at a time, no phasers, non slippy';
    }

    {
        my @ans;
        FOO: for ^10 -> $_ --> Array { next FOO if $_ %% 2; @ans.push: $_ }
        is-deeply @ans, [1, 3, 5, 7, 9]
    }
  }
}

# RT #131593
{
    my $i = 0;
    sub foo($?) { ^2 .map: { $i++ } }; for 1 { .&foo() };
    is $i, 2, 'for statement sinks its content';
}

{
    my $loops = 0;
    my @values = lazy for ^10 { $loops++; $_ }
    is $loops, 0, 'Lazy for loop does not execution until asked for values';
    is @values[^5], (0, 1, 2, 3, 4),
        'Lazy for loop produces correct values on demand';
    is $loops, 5, 'Lazy for loop does no more work than required';
}

# RT#126312
{
    my Int @a;
    @a[5] = 42;
    lives-ok { $_ = 6 for @a    }, ‘holes are mutable (for @a)’;
    is-deeply @a, Array[Int].new(6, 6, 6, 6, 6, 6), ‘holes were changed correctly (for @a)’;

    my Int @b;
    @b[5] = 24;
    lives-ok { $_ = 9 for @b[*] }, ‘holes are mutable (for @a[*])’;
    is-deeply @b, Array[Int].new(9, 9, 9, 9, 9, 9), ‘holes were changed correctly (for @a[*])’;
}

# vim: ft=perl6
