# http://perl6advent.wordpress.com/2012/12/13/day-13-bags-and-sets/
use v6;
use Test;

plan 42;

our $slurp1 = q<aa bb cc Dd ee ZZ>;
our $slurp2 = q<dd ee ff gg>;

sub hashy(Str $s) {
    my %words;
    for $s.comb(/\w+/).map(*.lc) -> $word {
    %words{$word}++;
    }
    %words;
}
sub baggy(Str $s) {
    my %words := BagHash.new();
    for $slurp1.comb(/\w+/).map(*.lc) -> $word {
    %words{$word}++;
    }
    %words;
}

my %words1 := hashy($slurp1);
my %words2 := baggy($slurp1);
is-deeply %words1.keys.sort, %words1.keys.sort, 'standard vs baggy word-count';
is-deeply %words1.values.sort, %words1.values.sort, 'standard vs baggy word-count';
lives-ok {EVAL q<%words1{"the"} = "green">}, 'hash assign (lives)';
throws-like {EVAL q<%words2{"the"} = "green">},
  X::Str::Numeric,
  'baggy assign (dies)';

# use {...}.Bag constructor (dwarring's reply to this post)
# >my $bag = bag "red" => 2, "blue" => 10;
my $bag = {"red" => 2, "blue" => 10}.Bag;

# > say $bag.roll(10);
sub red-blue-roll($bag) {
    my $reds = 0;
    my $blues = 0;
    my $others = 0;
    my @rolls = $bag.roll(100);
    my $elems = @rolls.elems;
    for @rolls {
    $_ eq  'red' ?? $reds++ !! $_ eq 'blue' ?? $blues++ !! $others++
    }
    my $ok = $elems == 100 && $blues > $reds && $others == 0;
    diag "elems: $elems,  reds: $reds,  blues: $blues,  others: $others"
    unless $ok;
    return $ok;
}

# > say $bag.roll(10);
ok red-blue-roll( $bag ), 'weighted roll';

# > say $bag.pick(*).join(" ");
my @pick = $bag.pick(*);
is-deeply [@pick.sort], [<blue blue blue blue blue blue blue blue blue blue red red>], '.pick(*)';

$bag = {"red" => 20000000000000000001, "blue" => 100000000000000000000}.Bag;

#> say $bag.roll(10);
ok red-blue-roll( $bag ), 'weighted roll';

# > say $bag.pick(*).join(" ");
@pick = $bag.pick(10);
is @pick.elems, 10, 'pick from large bag';

do {
    my $words1 = bag $slurp1.comb(/\w+/).map(*.lc);
    my $words2 = set $slurp2.comb(/\w+/).map(*.lc);
    my $unique = ($words1 (-) $words2);
    isa-ok $unique, Bag, 'set difference (-)';
    is-deeply [$unique.keys.sort], [<aa bb cc zz>], 'set difference (-)';
}

my $s1 = set <A B>;
my $s2 = set <B C>;

isa-ok 'B' ∈ $s1, Bool, 'set ∈ result type';
isa-ok 'B' (elem) $s1, Bool, 'set (elem) result type';
isa-ok 'B' ∉ $s1, Bool, 'set ∉ result type';
isa-ok 'B' ∋ $s1, Bool, 'set ∋ result type';
isa-ok 'B' (cont) $s1, Bool, 'set (cont) result type';
isa-ok 'B' ∌ $s1, Bool, 'set ∌ result type';

my @set-and-bag-ops =
    # Operation                  Unicode         ASCII              Type
    # ---------                  -------         ---------------    ----
    ['union',                    &infix:«∪»,     &infix:«(|)»,      [Set,Bag]],
    ['intersection',             &infix:«∩»,     &infix:«(&)»,      [Set,Bag]],
    ['set difference',           Mu,             &infix:«(-)»,      [Set]],
    ['set symmetric difference', Mu,             &infix:«(^)»,      [Set]],

    ['subset',                   &infix:«⊆»,     &infix:«(<=)»,     [Bool]],
    ['not a subset',             &infix:«⊈»,     Mu,                [Bool]],

    ['proper subset',            &infix:«⊂»,     &infix:«(<)»,      [Bool]],
    ['not a proper subset',      &infix:«⊄»,     Mu,                [Bool]],

    ['superset',                 &infix:«⊇»,     &infix:«(>=)»,     [Bool]],
    ['not a superset',           &infix:«⊉»,     Mu,                [Bool]],

    ['proper superset',          &infix:«⊃»,     &infix:«(>)»,      [Bool]],
    ['not a proper superset',    &infix:«⊅»,     Mu,                [Bool]],

    ['bag multiplication',       &infix:«⊍»,     &infix:«(.)»,      [Bag]],
    ['bag addition',             &infix:«⊎»,     &infix:«(+)»,      [Bag]],
;

for @set-and-bag-ops {
    my ($operation, $unicode-op, $ASCII-op, $result-type) = @$_;

    if $unicode-op.defined {
        my $result = $unicode-op($s1, $s2);
        ok $result-type.grep({$result.isa($_)}), "{$unicode-op.name} return type";
    }

    if $ASCII-op.defined {
        my $result = $ASCII-op($s1, $s2);
        ok $result-type.grep({$result.isa($_)}), "{$ASCII-op.name} return type";
    }

}

my $a = bag <a a a b b c>;
my $b = bag <a b b b>;

is-deeply $a (|) $b, {"a" => 3, "b" => 3, "c" => 1}.Bag, '$a (|) $b';

is-deeply $a (&) $b, {"a" => 1, "b" => 2}.Bag, '$a (&) $b';

is-deeply $a (+) $b, {"a" => 4, "b" => 5, "c" => 1}.Bag, '$a (+) $b';

is-deeply $a (.) $b, {"a" => 3, "b" => 6}.Bag, '$a (.) $b';
