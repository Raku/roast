use v6;
use Test;

plan 47;

# L<S09/Typed arrays>

# while S09 doesn't explicit state it for Hashes, we can assume that
# the same that it says for Arrays hold true.

{
    my Int %h;
    is %h.of,    Int, 'my Int %h declares a Hash of Int';
    # https://github.com/Raku/old-issue-tracker/issues/6659
    #?rakudo.jvm todo 'Coercion type Str(Any) returned from .keyof is not the same object as Str(Any) RT #132694'
    is %h.keyof, Str(Any), 'my Int %h declares a Hash with Str(Any) keys';
    lives-ok { %h = (a => 3, b => 7) }, 'can assign Ints to an Hash of Int';
    lives-ok { %h<foo> = 8           }, 'can assign Int to hash slot';
    lives-ok { %h{'c', 'd' } = (3, 4) }, 'can assign to slice of typed hash';
    is +%h, 5, '... and we have the right number of items';

    my Int %g;
    lives-ok { %g = %h }, 'can assign one typed hash to another';
    lives-ok { %h.pairs }, 'can call methods on typed hashes';
    is %h.pairs.sort.join, %g.pairs.sort.join,
                        '... and the hashes are the same afterwards';

    lives-ok { my Int %s = :a(3) }, 'can initialize typed hash';
    my Str %s = :y<b>;
    dies-ok { %h = %s }, "Can't assign Str hash to Int hash";
    ok %h<y>:!exists,  'Make sure we did not create an empty container';
    dies-ok { %h = :a<b> }, "Can't assign literal Str hash to Int hash";
    ok %h<y>:!exists,  'Make sure we did not create an empty container';
    dies-ok { %h<a> = 'foo' }, "Can't assign to hash item";
    ok %h<y>:!exists,  'Make sure we did not create an empty container';
    dies-ok { %h{'a', 'b'} = <c d> }, "prevent mismatched hash slice";
    ok %h<y>:!exists,  'Make sure we did not create an empty container';
    dies-ok { %h<z><t> = 3 }, 'Type constraint prevents autovivification';
    ok %h<z>:!exists,  'Make sure autovivication did not happen';
} #16

{
    lives-ok { my %s of Int = :a(3) }, 'can initialize typed hash (of Int)';
    dies-ok { my %s of Int = :a("3") }, 'initialization of typed hash type checked (of Int)';
    my %s of Str;
    lives-ok { %s<a> = 'b' }, "Can assign to typed hash element (of Str)";
    dies-ok { %s<a> = 1 }, "Can't assign wrongly typed value to typed hash element (of Int)";
} #4

{
    my %h{Int};
    is %h.of,    Any, "check the value constraint";
    is %h.keyof, Int, "check the key constraint";
    dies-ok { %h<a>=1 }, "cannot use strings as keys";
    dies-ok { %h<a b c>=(1,2,3) }, "cannot use string slices as keys";
    lives-ok { %h{1} = "a" }, "can use Ints as keys";
    is %h{1}, 'a', "a did the assignment work";
    lives-ok { %h{(2,3,4)} = <b c d> }, "can use Int slices as keys";
    is %h{2}, 'b', "b did the assignment work";
    is %h{3}, 'c', "b did the assignment work";
    is %h{4}, 'd', "b did the assignment work";

    ok %h{2}:exists, ':exists adverb works with key constraint hashes';
    is %h{2}:delete, 'b', ':delete adverb works with key constraint hashes';
    ok %h{2}:!exists, ':delete adverb works with key constraint hashes';
} #13

# https://github.com/Raku/old-issue-tracker/issues/3138
{
    my Int %h{Int} = 1 => 2, 3 => 4;
    my %bound := %h;
    ok %bound ~~ Hash[Int, Int], 'Binding typed hash "preserves" type';
    my %assigned = %h;
    nok %assigned ~~ Hash[Int, Int], 'Assigning from a typed hash copies values, but not type';
}
{
    my Int %h{Int} = 1 => 2, 3 => 4;
    my %bound := %h.clone;
    ok %bound ~~ Hash[Int, Int], 'Binding clone of a typed hash "preserves" type';
    my %assigned = %h.clone;
    nok %assigned ~~ Hash[Int, Int], 'Assigning from clone of a typed hash copies values, but not type';
}

{ # coverage; 2016-10-04
    my class Foo {};
    my $o = Foo.new;
    my %h{Any} = :42a, :72b, :c{:200bers, :100bars}, Foo, $o;
    is-deeply %h.antipairs.sort, (42 => "a", 72 => "b", (Foo.new) => Foo,
        ({:bars(100), :bers(200)}) => "c").Seq.sort,
    '.antipairs on typed Hash';

    is-deeply %h.invert.sort, (42 => "a", 72 => "b",
        (:bers(200)) => "c", (:bars(100)) => "c", (Foo.new) => Foo).Seq.sort,
    '.invert on typed Hash';
}

# https://github.com/Raku/old-issue-tracker/issues/6103

subtest 'self-referential top-level hash assignment' => {
    plan 4;

    subtest '= self, other' => {
        plan 2;
        my %h1 = :1a; my %h2 = :2b;
        is-deeply (%h1 = %h1, %h2), %(:1a, :2b), 'result of assignment';
        is-deeply  %h1,             %(:1a, :2b), 'value in original hash';
    }

    subtest '= self, self' => {
        plan 2;
        my %h1 = :1a;
        is-deeply (%h1 = %h1, %h1), %(:1a), 'result of assignment';
        is-deeply  %h1,             %(:1a), 'value in original hash';
    }

    subtest '= self, other - clashing keys' => {
        plan 2;
        my %h1 = :1a, :2b; my %h2 = :4b, :3c;
        is-deeply (%h1 = %h1, %h2), %(:1a, :4b, :3c), 'result of assignment';
        is-deeply  %h1,             %(:1a, :4b, :3c), 'value in original hash';
    }

    subtest '= other, self - clashing keys' => {
        plan 2;
        my %h1 = :1a, :2b; my %h2 = :4b, :3c;
        is-deeply (%h1 = %h2, %h1), %(:1a, :2b, :3c), 'result of assignment';
        is-deeply  %h1,             %(:1a, :2b, :3c), 'value in original hash';
    }
}

# R#2348
{
    dies-ok { Hash[Int,Any].new("a","b") }, 'typecheck on initialization';
    my %h := Hash[Int,Any].new;
    dies-ok { %h<a> = "b" }, 'typecheck on assignment';
    dies-ok { %h<a> := "b" }, 'typecheck on binding';
}

# vim: expandtab shiftwidth=4
