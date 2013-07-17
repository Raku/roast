use v6;

use Test;

plan 14;

#?pugs todo 'hyper ops'
#?niecza skip 'does not work; recurses into hash'
#?DOES 2
{ # hyper dereferencing
    my @array = (
        { key => 'val' },
        { key => 'val' },
        { key => 'val' }
    );

    my $full = join '', eval '@array>>.<key>';
    is($full, 'valvalval', 'hyper-dereference an array');

    my $part = join '', eval '@array[0,1]>>.<key>';
    is($part, 'valval', 'hyper-dereference an array slice');
}

#?pugs todo 'hyper ops'
#?niecza skip 'does not work; recurses into hash'
{ # hyper dereferencing of hashes
    my %hash = {
        one => { name => 'pugs'   },
        two => { name => 'niecza' },
        thr => { name => 'rakudo' }
    };

    my $full = %hash>>.<name>.pairs;
    is($full, ("one" => "pugs", "two" => "niecza", "thr" => "rakudo"), 'hyper-dereference a hash');

    my $part = join ' ', eval '%hash<one two>>>.<name>';
    is($part, 'pugs niecza', 'hyper-dereference a hash slice');
}

#?pugs todo 'hyper ops'
#?niecza skip 'does not work; recurses into hash'
{
    my @nested = (
            (1),
           (2,3),
          (4,5,6)
        ).tree;

    is(@nested>>.elems, (1, 2, 3), ".elems doesn't descend");
    is(@nested>>.[0], (1, 2, 4),   ".[0] doesn't descend");
}

#?pugs todo 'is nodal'
#?niecza skip 'is nodal'
#?DOES 4
{
    our sub postfix:<!>(@a) is nodal {
        [*] @a;
    }

    my %a = a => (1, 2, 3), b => (2, 3, 4), c => (3, 4, 5);
    my %r = %a>>!;
    is +%r,   3, 'hash - >>! result has right number of keys';
    is %r<a>, 6, 'hash - correct result from >>!';
    is %r<b>, 24, 'hash - correct result from >>!';
    is %r<c>, 60, 'hash - correct result from >>!';
}

#?pugs todo 'is nodal'
#?niecza skip 'is nodal'
#?DOES 4
{
    our sub postfix:<!>(@a) is nodal {
        [*] @a;
    }

    my @a = ((1, 2, 3), (2, 3, 4), (3, 4, 5)).tree;
    my @r = @a>>!;
    is +@r,   3,  'array - >>! result has right number of results';
    is @r[0], 6,  'array - correct result from >>!';
    is @r[1], 24, 'array - correct result from >>!';
    is @r[2], 60, 'array - correct result from >>!';
}

done;

# vim: ft=perl6
