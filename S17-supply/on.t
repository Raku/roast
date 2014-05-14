use v6;
use lib 't/spec/packages';

use Test;
use Test::Tap;

plan 12;

for (ThreadPoolScheduler, CurrentThreadScheduler) {
    $*SCHEDULER = .new;
    isa_ok $*SCHEDULER, $_, "***** scheduling with {$_.gist}";

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
}
