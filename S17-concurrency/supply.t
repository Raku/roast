use v6;
use Test;

plan 236;

sub tap_ok ( $s, $expected, $text, :$sort, :&after_tap ) {
    ok $s ~~ Supply, "{$s.^name} appears to be doing Supply";

    my @res;
    my $done;
    $s.tap({ @res.push($_) }, :done( {$done = True} ));
    after_tap() if &after_tap;

    for ^50 { sleep .1; last if $done or $s.done }
    ok $done, "$text was really done";
    @res .= sort if $sort;
    is_deeply @res, $expected, $text;
}

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

    {
        my $s = Supply.new;
    
        my @vals;
        my $saw_done;
        my $tap = $s.tap( -> $val { @vals.push($val) },
          done => { $saw_done = True });

        $s.more(1);
        is ~@vals, "1", "Tap got initial value";
        nok $saw_done, "No done yet";

        $s.more(2);
        $s.more(3);
        $s.done;
        is ~@vals, "1 2 3", "Tap saw all values";
        ok $saw_done, "Saw done";
    }

    {
        my $s = Supply.new;

        my @tap1_vals;
        my @tap2_vals;
        my $tap1 = $s.tap(-> $val { @tap1_vals.push($val) });

        $s.more(1);
        is ~@tap1_vals, "1", "First tap got initial value";

        my $tap2 = $s.tap(-> $val { @tap2_vals.push($val) });
        $s.more(2);
        is ~@tap1_vals, "1 2", "First tap has both values";
        is ~@tap2_vals, "2", "Second tap missed first value";

        $tap1.close;
        $s.more(3);
        is ~@tap1_vals, "1 2", "First tap closed, missed third value";
        is ~@tap2_vals, "2 3", "Second tap gets third value";
    }

    {
        my $s = Supply.for(1..10);
        tap_ok $s, [1..10], "On demand publish worked";
        tap_ok $s, [1..10], "Second tap gets all the values";
    }

    {
        my $seen;
        tap_ok Supply.for(1..10).do( {$seen++} ),
          [1..10], ".do worked";
        is $seen, 10, "did the side effect work";
    }

    tap_ok Supply.for( [1,2],[3,4,5] ).flat,
      [1..5], "On demand publish with flat";

    tap_ok Supply.for( (1..5).map( {[$_]} ) ),
      [[1],[2],[3],[4],[5]], "On demand publish with arrays";

    tap_ok Supply.for( [1,2],[3,4,5] ).map( {.flat} ),
      [1..5], "On demand publish with flattened arrays";

#?rakudo.jvm skip "hangs"
{
        my $s = Supply.for(2..6);
        my @a;
        for $s.list {
            @a.push($_);
        }
        is ~@a, "2 3 4 5 6", "Supply.for and .list work";
}

    tap_ok Supply.for(1..10).map( * * 5 ),
      [5,10,15,20,25,30,35,40,45,50],
      "mapping tap with single values works";

    tap_ok Supply.for(1..10).map( { $_ xx 2 } ),
      [1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10],
      "mapping tap with multiple values works";

    tap_ok Supply.for(1..10).grep( * > 5 ),
      [6,7,8,9,10],
      "grepping taps works";

    tap_ok Supply.for(1..10,1..10).uniq,
      [1,2,3,4,5,6,7,8,9,10],
      "uniq tap works";

    tap_ok Supply.for(1..10).uniq(:as(* div 2)),
      [1,2,4,6,8,10],
      "uniq with as tap works";

    tap_ok Supply.for(<a A B b c C>).uniq( :with( {$^a.lc eq $^b.lc} ) ),
      [<a B c>],
      "uniq with with tap works";

    tap_ok Supply.for(<a AA B bb cc C>).uniq(
        :as( *.substr(0,1) ), :with( {$^a.lc eq $^b.lc} )
      ),
      [<a B cc>],
      "uniq with as and with tap works";

    tap_ok Supply.for(1..10,1..10).squish,
      [1,2,3,4,5,6,7,8,9,10,1,2,3,4,5,6,7,8,9,10],
      "squish tap with 2 ranges works";

    tap_ok Supply.for(1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10).squish,
      [1,2,3,4,5,6,7,8,9,10],
      "squish tap with doubling range works";

    tap_ok Supply.for(1..10).squish(:as(* div 2)),
      [1,2,4,6,8,10],
      "squish with as tap works";

    tap_ok Supply.for(<a A B b c C A>).squish( :with( {$^a.lc eq $^b.lc} ) ),
      [<a B c A>],
      "squish with with tap works";

    tap_ok Supply.for(<a AA B bb cc C AA>).squish(
        :as( *.substr(0,1) ), :with( {$^a.lc eq $^b.lc} )
      ),
      [<a B cc AA>],
      "squish with as and with tap works";

    {
        my $s1 = Supply.for(1..10);
        my $on = on -> $res {
            $s1 => sub ($val) {
                $res.more($val);
            }
        }
        tap_ok $on, [1..10], "minimal 'on' works";
    }

    {
        my $s1 = Supply.for("a".."j");
        my $s2 = Supply.for(1..10);
        my $on = on -> $res {
            my @a1;
            my @a2;
            $s1 => sub ($val) {
                @a1.push($val);
                if @a1 && @a2 {
                    $res.more( (@a1.shift => @a2.shift) );
                }
            },
            $s2 => -> \val {
                @a2.push(val);
                if @a1 && @a2 {
                    $res.more( @a1.shift => @a2.shift );
                }
            }
        }
        tap_ok $on,
          [:a(1),:b(2),:c(3),:d(4),:e(5),:f(6),:g(7),:h(8),:i(9),:j(10)],
          "basic 2 supply 'on' works";
    }

    {
        my $a = Supply.for("a".."e");
        my $b = Supply.for("f".."k");
        my $on = on -> $res {
            my @values = ([],[]);
            ($a,$b) => sub ($val,$index) {
                @values[$index].push($val);
                if all(@values) {
                    $res.more( (@values>>.shift) );
                }
            }
        }
        tap_ok $on,
          [<a f>,<b g>,<c h>,<d i>,<e j>],
          "basic 2 supply with (a,b) 'on' works";
    }

    {
        my @s=(Supply.for("a".."e"),Supply.for("f".."k"),Supply.for("l".."p"));
        my $on = on -> $res {
            my @values = ([] xx +@s);
            my &infix:<op> = &[,];
            @s => -> \val, \index {
                @values[index].push(val);
                if all(@values) {
                    $res.more( [op] @values>>.shift );
                }
            }
        }
        tap_ok $on,
          [<a f l>,<b g m>,<c h n>,<d i o>,<e j p>],
          "basic 3 supply with array 'on' works";
    }

    {
        my @s = ( Supply.for("a".."e"), Supply.for("f".."k") );
        my @seen;
        my $on = on -> $res {
            my $done = 0;
            @s => {
              more => sub ($val) { @seen.push($val); $res.more($val) },
              done => { $res.done if ++$done == +@s }
            }
        }
        tap_ok $on, @seen, "basic 2 supply with array without index 'on' works";
    }

    {
        my $s1 = Supply.new;
        my $s2 = Supply.new;

        tap_ok $s1.zip($s2, :with( &infix:<~> )),
          [<1a 2b>],
          'zipping taps works',
          :after_tap( {
              $s1.more(1);
              $s1.more(2);
              $s2.more('a');
              $s2.more('b');
              $s2.more('c');
              $s1.done();
              $s2.done();
          } );
    }

    tap_ok Supply.zip(
        Supply.for("a".."e"),
        Supply.for("f".."k"),
        Supply.for("l".."p")
      ),
      [<a f l>,<b g m>,<c h n>,<d i o>,<e j p>],
      "zipping with 3 supplies works";

    {
        my $s = Supply.for(1..10);
        my $z = Supply.zip($s);
        ok $s === $z, "zipping one supply is a noop";
        tap_ok $z, [1..10], "noop rotor";
    }

    {
        my $s1 = Supply.new;
        my $s2 = Supply.new;
        tap_ok $s1.merge($s2),
          [1,2,'a',3,'b'],
          "merging supplies works",
          :after_tap( {
              $s1.more(1);
              $s1.more(2);
              $s2.more('a');
              $s1.more(3);
              $s1.done();
              $s2.more('b');
              $s2.done();
          } );
    }

    tap_ok Supply.merge(
      Supply.for(1..5), Supply.for(6..10), Supply.for(11..15)
     ),
      [1..15], "merging 3 supplies works", :sort;

    {
        my $s = Supply.for(1..10);
        my $m = Supply.merge($s);
        ok $s === $m, "merging one supply is a noop";
        tap_ok $m, [1..10], "noop rotor";
    }

    tap_ok Supply.for(1..14).batch(:elems(5)),
      [[1..5],[6..10],[11..14]],
      "we can batch by number of elements";

    {
        my $for   = Supply.for(1..10);
        my $batch = $for.batch(:elems(1)),
        ok $for === $batch, "batch by 1 is a noop";
        tap_ok $batch, [1..10], "noop batch";
    }

    tap_ok Supply.for(1..5).rotor,
      [[1,2],[2,3],[3,4],[4,5],[5]],
      "we can rotor";

    tap_ok Supply.for(1..5).rotor(3,2),
      [[1,2,3],[2,3,4],[3,4,5],[4,5]],
      "we can rotor by number of elements and overlap";

    {
        my $for = Supply.for(1..10);
        my $rotor = $for.rotor(1,0);
        ok $for === $rotor, "rotoring by 1/0 is a noop";
        tap_ok $rotor, [1..10], "noop rotor";
    }
}
