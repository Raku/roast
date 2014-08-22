use v6;

use Test;

plan 28;


# L<S04/The C<gather> statement prefix/>

# Standard gather
{
    my @a;
    my $i;
    
    @a := gather {
        $i = 1;
        for (1 .. 5) -> $j {
            take $j;
        }
    };

    ok(!$i, "not yet gathered");
    is(+@a, 5, "5 elements gathered");
    ok($i, "gather code executed");
    is(@a[0], 1, "first elem taken");
    is(@a[*-1], 5, "last elem taken");
};

# Nested gathers, two levels
{
  my @outer = gather {
    for 1..3 -> $i {
      my @inner = gather {
         take $_ for 1..3;
      };

      take "$i:" ~ @inner.join(',');
    }
  };

  is ~@outer, "1:1,2,3 2:1,2,3 3:1,2,3", "nested gather works (two levels)";
}

# Nested gathers, three levels
{
  my @outer = gather {
    for 1..2 -> $i {
      my @inner = gather {
        for 1..2 -> $j {
          my @inner_inner = gather {
              take $_ for 1..2;
          };
          take "$j:" ~ @inner_inner.join(',');
        }
      };
      take "$i:" ~ @inner.join(';');
    }
  };

  is ~@outer, "1:1:1,2;2:1,2 2:1:1,2;2:1,2", "nested gather works (three levels)";
}

# take on lists, multiple takes per loop
{
  my @outer = gather {
    my @l = (1, 2, 3);
    take 5;
    take @l;
    take 5;
  };

  is ~@outer, "5 1 2 3 5", "take on lists and multiple takes work";
}

# gather scopes dynamiclly, not lexically
{
    my $dynamic_take = sub { take 7 };
    my @outer = gather {
        $dynamic_take();
        take 1;
    };

    is ~@outer, "7 1", "gather scopes dynamically, not lexically";
}

# take on array-ref
{
  my @list  = gather { take [1,2,3]; take [4,5,6];};
  my @list2 = ([1,2,3],[4,5,6]);
  is @list.perl, @list2.perl , "gather array-refs";
}

# gather statement prefix
{
    my @out = gather for 1..5 {
        take $_;
    };

    is ~@out, "1 2 3 4 5", "gather as a statement_prefix";
}

# lazy gather
{
    my $count = 0;
    my @list := gather {
        for 1 .. 10 -> $a {
            take $a;
            $count++
        }
    };
    my $result = @list[2];
    is($count, 2, "gather is lazy");	
}

{
    my @list = gather {
        my $v = 1;
        while $v <= 10 {
            take $v if $v % 2 == 0;
            $v++;
        }
    };
    is ~@list, "2 4 6 8 10", "gather with nested while";
}

{
    my @list = gather {
        loop (my $v = 1; $v <= 10; $v++)
        {
            take $v if $v % 2 == 0;
        }
    };
    is ~@list, "2 4 6 8 10", "gather with nested loop";
}

{
    is (gather { take 1, 2, 3; take 4, 5, 6; }).elems, 2,
        'take with multiple arguments produces one item each';

    is (gather { take 1, 2, 3; take 4, 5, 6; }).flat.elems, 6,
        'take with multiple arguments .flat tens out';
}

#?rakudo.moar todo 'RT #117635 (infinite loop)'
{
    my sub grep-div(@a, $n) {
        gather for @a {
            take $_ if $_ %% $n;
        }
    }
    
    my @evens := grep-div((1...*), 2);
    is ~grep-div(@evens, 3)[^16], ~grep-div((1...100), 6), "Nested identical gathers";
}

# RT #77036
{
    class E {
        has $.n is rw;
        has $.v;
        method Str() {~self.v }
    };
    my E $x .= new(:v(1));
    $x.n = E.new(:v(2));
    is (gather { my $i = $x; while $i.defined { take $i; $i = $i.n } }).join("|"), '1|2', 'Elements in gather/take stringify correctly';

}

# RT #78026, RT #77302
{
    sub foo {
        my @a = (1,2,3,4,5);
        gather {
            my $val ;
            while @a {
                $val = @a.shift();
                take $val;
            }
        }
    };
    is foo().join, '12345', 'decontainerization happens (1)';
    is (<a b c d e> Zxx 0,1,0,1,0).Str, 'b d',
        'decontainerization happens (2)';
}

# Method form of take
{
  my @outer = gather {
    my @l = (1, 2, 3);
    5.take;
    @l.take;
    5.take;
  };

  is ~@outer, "5 1 2 3 5", "method form of take works.";
}

# RT #115598
{
    my $x;
    my @a = gather { $x = take 3; };
    is $x, 3, "return value of take" 
}

# tests for the S04-control.pod document
#?rakudo.jvm skip "unwind"
{
    my @list = 1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 6, 6;
    my @uniq = gather for @list {
        state $previous = take $_;
        next if $_ === $previous;
        $previous = take $_;
    }
    is @uniq, (1, 2, 3, 4, 5, 6), "first example in S04-control.pod works";
}

#?niecza skip 'Cannot use bind operator with this LHS'
{
    my @y;
    my @x = gather for 1..2 {            # flat context for list of parcels
        my ($y) := \(take $_, $_ * 10);  # binding forces item context
        push @y, $y;
    }
    is @x, (1, 10, 2, 20), "take in flat context flattens";
    is @y, ($(1, 10), $(2, 20)), "take in item context doesn't flatten";
}

#?niecza skip 'Cannot use bind operator with this LHS'
{
    my ($c) := \(gather for 1..2 {
        take $_, $_ * 10;
    });
    is $c.flat, (1,10,2,20), ".flat flattens fully into a list of Ints.";
    is $c.lol, LoL.new($(1,10),$(2,20)), ".lol: list of Parcels.";
    is $c.item, ($(1,10),$(2,20)).list.item, "a list of Parcels, as an item.";
}


# vim: ft=perl6
