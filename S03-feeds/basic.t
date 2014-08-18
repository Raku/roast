use v6;

use Test;

# L<S06/"Feed operators">
# L<S03/"Feed operators">

=begin pod

Tests for the feed operators 

    ==> and <== 
    
=end pod

plan 24;

{
    my @a = (1, 2);
    my (@b, @c);
    
    @a ==> @b;
    @c <== @a;

    is(~@b, ~@a, "ltr feed as simple assignment");
    is(~@c, ~@a, "rtl feed as simple assignment");
}

{
    my @a = (1 .. 5);
    my @e = (2, 4);

    my (@b, @c);
    @a ==> grep { ($_ % 2) == 0 } ==> @b;
    @c <== grep { ($_ % 2) == 0 } <== @a;
    my @f = do {@a ==> grep {($_ % 2) == 0}};
    my @g = (@a ==> grep {($_ % 2) == 0});

    is(~@b, ~@e, "array ==> grep ==> result");
    is(~@c, ~@e, "result <== grep <== array");
    is(~@f, ~@e, 'result = do {array ==> grep}');
    is(~@g, ~@e, 'result = (array ==> grep)');
}

{
    my ($got_x, $got_y, @got_z);
    sub foo ($x, $y?, *@z) {
        $got_x = $x;
        $got_y = $y;
        @got_z = @z;
    }

    my @a = (1 .. 5);

    @a ==> foo "x";

    is($got_x, "x", "x was passed as explicit param");
    #?rakudo 2 todo 'feeds + signatures'
    ok(!defined($got_y), "optional param y was not bound to fed list");
    is(~@got_z, ~@a, '...slurpy array *@z got it');
}

{
    my @data = <1 2 4 5 7 8>;
    my @odds = <1 5 7>;

    eval_dies_ok('@data <== grep {$_ % 2} <== @data', 'a chain of feeds may not begin and end with the same array');

    @data = <1 2 4 5 7 8>;
    @data <== grep {$_ % 2} <== eager @data;
    #?rakudo 2 todo 'feeds + eager'
    is(~@data, ~@odds, '@arr <== grep <== eager @arr works');

    @data = <1 2 4 5 7 8>;
    @data <== eager grep {$_ % 2} <== @data;
    is(~@data, ~@odds, '@arr <== eager grep <== @arr works');
}

# checking the contents of a feed: installing a tap
{
    my @data = <0 1 2 3 4 5 6 7 8 9>;
    my @tap;

    @data <== map {$_ + 1} <== @tap <== grep {$_ % 2} <== eager @data;
    is(@tap, <1 3 5 7 9>, '@tap contained what was expected at the time');
    #?rakudo todo 'feeds + eager'
    is(@data, <2 4 6 8 10>, 'final result was unaffected by the tap variable');
}

# <<== and ==>> pretending to be unshift and push, respectively
#?rakudo skip 'double-ended feeds'
{
    my @odds = <1 3 5 7 9>;
    my @even = <0 2 4 6 8>;

    my @numbers = do {@odds ==>> @even};
    is(~@numbers, ~(@even, @odds), 'basic ==>> test');

    @numbers = do {@odds <<== @even};
    is(~@numbers, ~(@odds, @even), 'basic <<== test');
}

# feeding to whatever using ==> and ==>>

#?rakudo skip 'double-ended feeds'
{
    my @data = 'a' .. 'e';

    @data ==> *;
    is(@(*), @data, 'basic feed to whatever');

    <a b c d> ==>  *;
    0 .. 3    ==>> *;
    is(@(*), <a b c d 0 1 2 3>, 'two feeds to whatever as array');
}

# feed and Inf
#?nieza skip "unhandled exception
{
  lives_ok { my @a <== 0..Inf }
}

#?nieza skip "Unhandled exception"
{
  my $call-count = 0;
  my @a <== gather for 1..10 -> $i { $call-count++; take $i };
  @a[0];
  #?rakudo todo "isn't lazy"
  is $call-count, 1;
}

# no need for temp variables in feeds: $(*), @(*), %(*)
#?rakudo skip '* feeds'
#?DOES 4
{
    my @data = 'a' .. 'z';
    my @out  = <a e i o u y>;

    @data ==> grep {/<[aeiouy]>/} ==> is($(*), $(@out), 'basic test for $(*)');
    @data ==> grep {/<[aeiouy]>/} ==> is(@(*), @(@out), 'basic test for @(*)');
    @data ==> grep {/<[aeiouy]>/} ==> is(%(*), %(@out), 'basic test for %(*)');

    # XXX: currently the same as the @(*) test above. Needs to be improved
    @data ==> grep {/<[aeiouy]>/} ==> is(@(*).slice, @(@out).slice, 'basic test for @(*).slice');
}


done;

# vim: ft=perl6
