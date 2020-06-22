use v6.e.PREVIEW;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use lib $?FILE.IO.parent(2).add("packages/S02-types/lib");
use Test::Util;

plan 60;

=begin description

Test for 'subset' with a closure

=end description

# L<S02/Polymorphic types/"Fancier type constraints may be expressed through a subtype">

subset Even of Int where { $_ % 2 == 0 };

is Even.^ver, '6.e', "subset created by 6.e language version";

{
    my Even $x = 2;
    is $x, 2, 'Can assign value to a type variable with subset';
};

throws-like 'my Even $x = 3', X::TypeCheck::Assignment,
    "Can't assign value that violates type constraint via subset";

# https://github.com/Raku/old-issue-tracker/issues/1337
throws-like 'Even.new', Exception, 'Cannot instantiate a subtype';

{
    ok 2 ~~ Even,  'Can smartmatch against subsets 1';
    ok 3 !~~ Even, 'Can smartmatch against subsets 2';
}

# L<S02/Polymorphic types/"Fancier type constraints may be expressed through a subtype">

subset Digit of Int where ^10;

{
    my Digit $x = 3;
    is  $x,     3,  "Can assign to var with 'subset' type constraint";
    $x = 0;
    is  $x,     0,  "one end of range";
    $x = 9;
    is  $x,     9,  "other end of range";
}

throws-like 'my Digit $x = 10', X::TypeCheck::Assignment,
    'type constraints prevents assignment 1';
throws-like 'my Digit $x = -1', X::TypeCheck::Assignment,
    'type constraints prevents assignment 2';
throws-like 'my Digit $x = 3.1', X::TypeCheck::Assignment,
    'original type prevents assignment';

# https://github.com/Raku/old-issue-tracker/issues/1159
{
    subset Subhash of Hash;
    lives-ok { my Subhash $a = {} },
             'can create subset of hash';

    subset Person of Hash where { .keys.sort ~~ ['firstname', 'lastname'] }
    lives-ok { my Person $p = { :firstname<Alpha>, :lastname<Bravo> } },
             'can create subset of hash with where';
    throws-like 'my Person $p = { :first<Charlie>, :last<Delta> }',
        X::TypeCheck::Assignment,
        'subset of hash with where enforces where clause';

    subset Austria of Array;
    lives-ok { my Austria $a = [] },
             'can create subset of array';

    subset NumArray of Array where { .elems == .grep: { $_ ~~ Num } }
    lives-ok { my NumArray $n = [] },
             'can create subset of array with where';
    throws-like 'my NumArray $n = <Echo 2>',
        X::TypeCheck::Assignment,
        'subset of array with where enforces where clause';

    subset Meercat of Pair;
    lives-ok { my Meercat $p = :a<b> },
             'can create subset of pair';

    subset Ordered of Pair where { .key < .value }
    lives-ok { my Ordered $o = 23 => 42 },
             'can create subset of Pair with where';
    throws-like 'my Ordered $o = 42 => 23',
        X::TypeCheck::Assignment,
        'subset of pair with where enforces where clause';
}

{
    my subset Str_not2b of Str where /^[isnt|arent|amnot|aint]$/;
    my Str_not2b $text = "isnt";
    $text = 'amnot';
    is $text, 'amnot', 'assignment to my subset of Str where pattern worked';
    throws-like q[ $text = 'oops' ],
        X::TypeCheck::Assignment,
        'my subset of Str where pattern enforces pattern';
}

{
    subset Negation of Str where /^[isnt|arent|amnot|aint]$/;
    my Negation $text = "isnt";
    $text = 'amnot';
    is $text, 'amnot', 'assignment to subset of Str where pattern worked';
    throws-like q[ $text = 'oops' ],
        X::TypeCheck::Assignment,
        'subset of Str where pattern enforces pattern';
}

# https://github.com/Raku/old-issue-tracker/issues/1120
{
    subset RT67256 of Int where { $^i > 0 }
    my RT67256 $rt67256 = 1;

    try { $rt67256 = -42 }

    ok  $!  ~~ Exception, 'subset of Int enforces where clause';
    ok "$!" ~~ / RT67256 /, 'error for bad assignment mentions subset';
}

# https://github.com/Raku/old-issue-tracker/issues/1315
{
    class Y {has $.z};
    subset sY of Y where {.z == 0};

    lives-ok { 4 ~~ sY }, 'Nominal type is checked first';
    ok 4 !~~ sY, 'and if nominal type check fails, it is False';
}

# https://github.com/Raku/old-issue-tracker/issues/1676
{
    subset RT74234 of Mu;
    my RT74234 $rt74234 = 23;
    is $rt74234, 23, 'subset RT74234 of Mu + type check and assignment works';
}

# https://github.com/Raku/old-issue-tracker/issues/2085
{
    sub limit() { 0 }
    subset aboveLexLimit of Int where { $_ > limit() };
    ok 1 ~~ aboveLexLimit, 'can use subset that depends on lexical sub (1)';
    nok -1 ~~ aboveLexLimit, 'can use subset that depends on lexical sub (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/2085
{
    my $limit = 0;
    subset aboveLexVarLimit of Int where { $_ > $limit };
    ok 1 ~~ aboveLexVarLimit, 'can use subset that depends on lexical variable (1)';
    nok -1 ~~ aboveLexVarLimit, 'can use subset that depends on lexical variable (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/2299
subset Bug::RT80930 of Int where { !.defined || $_ %% 2 };
lives-ok { my Bug::RT80930 $rt80930 }, 'subset with "::" in the name';

# https://github.com/Raku/old-issue-tracker/issues/2451
{
    subset SomeStr of Str where any <foo bar>;
     ok 'foo' ~~ SomeStr, 'subset ... where any(...) (+)';
    nok 'fox' ~~ SomeStr, 'subset ... where any(...) (-)';
}


# https://github.com/Raku/old-issue-tracker/issues/963
{
    subset FooStr of Str where /^foo/;
    my multi method uc(FooStr $self:) { return "OH HAI" }; #OK not used
    is "foo".uc, 'FOO', 'multi method with subset invocants do not magically find their way into the method dispatch';

}

# https://github.com/Raku/old-issue-tracker/issues/1555
my $a = 1;
{
    my $a = 3;
    sub producer {
        my $a = 2;
        sub bar($x where $a ) { $x }  #OK not used
    }
    my &bar := producer();
    lives-ok { bar(2) }, 'where-constraint picks up the right lexical (+)';
    throws-like 'bar(1)', Exception, 'where-constraint picks up the right lexical (-)';
}

{
    # https://github.com/Raku/old-issue-tracker/issues/2780
    my subset MI of Int;
    ok MI ~~ Mu,   'subset conforms to Mu';
    ok MI ~~ Int,  'subset conforms to base type';
    nok Mu  ~~ MI, 'Mu does not conform to subset';
}

# https://github.com/Raku/old-issue-tracker/issues/1691
{
    subset A of Array;
    subset B of A;
    subset C of A;
    subset D of A where B & C;
    ok [] ~~ D, "complicated subset combinations #74352";
}

# https://github.com/Raku/old-issue-tracker/issues/4525
lives-ok { EVAL 'my class A { has $.integer where * > 0 = 1; method meth { 1 / $!integer } }' },
    'subset constraint in attribute does not blow up optimizer dispatch analysis';

# https://github.com/Raku/old-issue-tracker/issues/6510
{
    my subset S-Int of Int;
    my subset S-Str of Str;
    ok S-Int.isa(Int), 'isa type';
    nok S-Int.isa(Str), 'isa type';
    nok S-Int.isa(S-Str), 'isa subset';

    # isa on a superset - not yet handled
    my subset SI2 of S-Int;
    ok SI2.isa(S-Int), 'isa subset';
    my subset S of Int;
    my subset S3 of S;
    my subset S2 of S;
    nok S2.isa(S3), 'exclusive subsets';
}

# https://github.com/rakudo/rakudo/issues/1457
subtest 'Junction arguments to `where` parameters' => {
    plan 6;

    my subset Foo of Mu where Int|Bool;
    subtest 'implicit Mu, block, literal where' => {
        plan 4;
        throws-like ｢-> $ where Int|Bool { }(none True)｣,
            X::TypeCheck::Binding::Parameter, 'Junction, false';
        throws-like ｢-> $ where Int|Bool { }(2e0)｣,
            X::TypeCheck::Binding::Parameter, 'other,    false';

        -> $ where Int|Bool { pass 'Junction, true' }(one True);
        -> $ where Int|Bool { pass 'other,    true' }(42);
    }
    subtest 'subset, block' => {
        plan 4;
        throws-like {-> Foo $ { }(none True)},
            X::TypeCheck::Binding::Parameter, 'Junction, false';
        throws-like {-> Foo $ { }(2e0)},
            X::TypeCheck::Binding::Parameter, 'other,    false';

        -> Foo $ { pass 'Junction, true' }(one True);
        -> Foo $ { pass 'other,    true' }(42);
    }
    subtest 'subset, block, literal where' => {
        plan 4;
        throws-like {-> Foo $ where Int|Bool { }(all True, 42e0)},
            X::TypeCheck::Binding::Parameter, 'Junction, false';
        throws-like {-> Foo $ where Int|Bool { }(2e0)},
            X::TypeCheck::Binding::Parameter, 'other,    false';

        -> Foo $ where Int|Bool { pass 'Junction, true' }(any True, 42e0);
        -> Foo $ where Int|Bool { pass 'other,    true' }(42);
    }

    subtest 'implicit Any, sub, literal where' => {
        plan 4;
        throws-like ｢sub ($ where Int|Bool) { }(none 42e0)｣,
            X::TypeCheck::Binding::Parameter, 'Junction, false';
        throws-like ｢sub ($ where Int|Bool) { }(2e0)｣,
            X::TypeCheck::Binding::Parameter, 'other,    false';

        sub ($ where Int|Bool) { pass 'Junction, true' }(none True);
        sub ($ where Int|Bool) { pass 'other,    true' }(42);
    }
    subtest 'subset, sub' => {
        plan 4;
        throws-like {sub (Foo $) { }(none True)},
            X::TypeCheck::Binding::Parameter, 'Junction, false';
        throws-like {sub (Foo $) { }(2e0)},
            X::TypeCheck::Binding::Parameter, 'other,    false';

        sub (Foo $) { pass 'Junction, true' }(one True);
        sub (Foo $) { pass 'other,    true' }(42);
    }
    subtest 'subset, sub, literal where' => {
        plan 4;
        throws-like {sub (Foo $ where Int|Bool) { }(all True, 42e0)},
            X::TypeCheck::Binding::Parameter, 'Junction, false';
        throws-like {sub (Foo $ where Int|Bool) { }(2e0)},
            X::TypeCheck::Binding::Parameter, 'other,    false';

        sub (Foo $ where Int|Bool) { pass 'Junction, true' }(any True, 42e0);
        sub (Foo $ where Int|Bool) { pass 'other,    true' }(42);
    }
}

# https://github.com/rakudo/rakudo/issues/1799
{
    my subset CAT of Code where { .arity == 2 };
    my sub xz(CAT $c) {
        return $c(3, 5);
    }

    is xz(* <=> *), Order::Less, "subset with Code arity check in sub signature";
}

{
    # Test is similar to one in nil.t but with 6.e specifics applied
    subset MyInt of Int where { True };
    my MyInt $x = 5;

    lives-ok { $x = Nil }, 'can assign Nil to subsets';
    # Subset is a nominal type, it's implicit default is subset's nominalization.
    ok $x === Int, 'assigns to subset type object';
}

{


    is_run q:to/CODE/,
            use v6.e.PREVIEW;
            subset SSDefinite of Int:D where { True };
            my SSDefinite $s;
            CODE
        {
            :out(''),
            :err(rx:s/Variable definition of type SSDefinite .* needs to be given an initializer/),
            :status(1),
        },
        "subset of a definite type needs initialization";
    is_run q:to/CODE/,
            use v6.e.PREVIEW;
            subset SSDefinedOnly of Str where { .defined };
            my SSDefinedOnly $s;
            CODE
        {
            :out(''),
            :err(rx:s/Variable definition of type SSDefinedOnly .* needs to be given an initializer/),
            :status(1),
        },
        "subset requiring a defined value needs initialization";
}

{
    # Try subsets from modules of different language versions
    use Subset6c;
    use Subset6e;

    is SSDefined6c.^ver, '6.c', "subset from 6.c module bears correct language version";
    is SSDefined6e.^ver, '6.e', "subset from 6.e module bears correct language version";

    is_run q:to/CODE/,
            use v6.e.PREVIEW;
            use Subset6c;
            my SSDefined6c $s;
            print $s.^ver;
            CODE
        {
            :out('6.c'),
            :err(''),
            :status(0),
        },
        :compiler-args['-I' ~ $?FILE.IO.parent(2).add("packages/S02-types/lib")],
        "definite subset from 6.c allows init without a value even in 6.e code";
    is_run q:to/CODE/,
            use v6.d;
            use Subset6e;
            my SSDefined6e $s;
            note $s.^ver;
            CODE
        {
            :out(''),
            :err(rx:s/Variable definition of type SSDefined6e .* needs to be given an initializer/),
            :status(1),
        },
        :compiler-args['-I' ~ $?FILE.IO.parent(2).add("packages/S02-types/lib")],
        "definite subset from 6.e doesn't allow init without a value even in 6.d code";
}

# vim: expandtab shiftwidth=4
