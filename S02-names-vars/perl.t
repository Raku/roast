use v6;
use Test;
plan 116;
# L<S02/Names and Variables/To get a Raku representation of any object>

my @tests = (
    # Basic scalar values
    42,
    42/10,
    4.2,
    sqrt(2),
    3e5,
    Inf, -Inf, NaN,

    "a string", "", "\0", "\t", "\n",
    "\r\n",
    "\o7",
    '{', # "\d123",	# XXX there is no \d escape!!!
    '}',
    '$a @string %with &sigils()',
    'שלום',

    ?1, ?0,
    rx:P5/foo/, rx:P5//, rx:P5/^.*$/,

    # Captures containing scalars
    \(42), \(Inf), \(-Inf), \(NaN), \("string"), \(""), \(?1), \(?0),

    \Mu,

    (a => 1),
    :b(2),

    # Aggregates
    {},           # empty hash
    { a => 42 },  # only one elem
    { :a(1), :b(2), :c(3) },

    # Nested things
    { a => [1,2,3] },  # only one elem
    { a => [1,2,3], b => [4,5,6] },
    [ { :a(1) }, { :b(2), :c(3) } ],

    # a List
    <a b c>
);

# L<S02/Names and Variables/To get a Raku representation of any object>
# Quoting S02 (emphasis added):
#   To get a Perlish representation of any data value, use the .raku method.
#   This will put quotes around strings, square brackets around list values,
#   curlies around hash values, etc., **such that standard Perl could reparse
#   the result**.
{
    for @tests -> $obj {
        my $s = (~$obj).subst(/\n/, '␤');
        ok EVAL($obj.raku).raku eq $obj.raku,
            "($s.raku()).raku returned something whose EVAL()ed stringification is unchanged";
        is WHAT(EVAL($obj.raku)).gist, $obj.WHAT.gist,
            "($s.raku()).raku returned something whose EVAL()ed .WHAT is unchanged";
    }
}

# Recursive data structures
{
    my $foo = { a => 42 }; $foo<b> = $foo;
    is $foo<b><b><b><a>, 42, "basic recursive hashitem";

    ok $foo.raku,
        ".raku worked correctly on a recursive hashitem";
}

{
    my $foo = [ 42 ];
    my $bar = { a => 23 };
    $foo[1] = $bar;
    $bar<b> = $foo;

    is $foo[1]<b>[1]<b>[0], 42, "mixed arrayitem/hashitem recursive structure";

    ok $foo.raku,
        ".raku worked correctly on a mixed arrayitem/hashitem recursive structure";
}

# https://github.com/Raku/old-issue-tracker/issues/3771
{
    class Bug {
        has @.myself;
        method bind( $myself ) {
            @.myself[0] = $myself;
        }
    }
    my $a1 = Bug.new;
    $a1.bind( $a1 );
    say $a1;
    pass "survived saying a self-referencing object";
}

# https://github.com/Raku/old-issue-tracker/issues/3437
{
    class Location {...}
    class Item {
        has Location $.loc is rw;
        method locate (Location $l) {
            self.loc=$l;
        }
        method whereis () {
            return self.loc;
        }
    }
    class Location {
        has Item @.items;
        method put (Item $item) {
            push(@.items, $item);
        }
    }
    my $i1=Item.new;
    my $l1=Location.new;
    $l1.put($i1);
    $i1.locate($l1);
    say $i1.whereis;
    pass "survived saying two mutually referencing objects";
}

{
    # test a bug reported by Chewie[] - apparently this is from S03
    is(EVAL((("f","oo","bar").keys.List).raku), <0 1 2>, ".raku on a .keys list");
}


# https://github.com/Raku/old-issue-tracker/issues/567
{
    class RT61918 {
        has $.inst is rw;
        has $!priv;
        has $.string = 'krach';

        method init {
            $.inst = [ 0.451619069541592e0, 0.248524740881188e0 ];
            $!priv = [ 0.016026552444413e0, 0.929197054085006e0 ].raku;
        }
    }

    my $t1 = RT61918.new();
    my $t1_new = $t1.raku;
    $t1.init;
    my $t1_init = $t1.raku;

    ok $t1_new ne $t1_init, 'changing object changes .raku output';

    # TODO: more tests that show EVAL($t1_init) has the same guts as $t1.
    ok $t1_new ~~ /<< krach >>/, 'attribute value appears in .raku output';

    # https://github.com/Raku/old-issue-tracker/issues/2593
    my $t2_init = EVAL($t1_init).raku;
    is $t1_init, $t2_init, '.raku on user-defined type roundtrips okay';
}

# https://github.com/Raku/old-issue-tracker/issues/3564
{
    my $a = 0.219947518065601987e0;
    is $a.raku, EVAL($a.raku).raku,
        '.raku on float with many digits roundtrips okay';
}

# https://github.com/Raku/old-issue-tracker/issues/819
{
    my %h;
    lives-ok { %h<a> = [%h<a>] },
             'can assign list with new hash element to itself';
    lives-ok { %h<a>.raku }, 'can take .raku from hash element';
    ok %h<a> !=== %h<a>[0], 'hoa does not refer to hash element';
}

# https://github.com/Raku/old-issue-tracker/issues/1156
{
    class RT67790 {}
    lives-ok { RT67790.HOW.raku }, 'can .raku on .HOW';
    #?rakudo skip 'RT #67790'
    ok EVAL(RT67790.HOW.raku) === RT67790.HOW, '... and it returns the right thing';
}

# https://github.com/Raku/old-issue-tracker/issues/1366
{
    is 1.0.WHAT.gist, Rat.gist, '1.0 is Rat';
    is EVAL( 1.0.raku ).WHAT.gist, Rat.gist, "1.0 perl'd and EVAL'd is Rat";
}


# https://github.com/Raku/old-issue-tracker/issues/1177
{
    my @a;
    ([0, 0], [1, 1]).grep({@a.push: .raku; 1}).eager;
    for @a {
        my $n = EVAL($_);
        isa-ok $n, Array, '.raku in .grep works - type';
        is $n.elems, 2, '.raku in .grep works - number of elems';
        is $n[0], $n[1], '.raku in .grep works - element equality';
    }
}

# Buf
{
    my Blob $a = "asdf".encode();
    is EVAL($a.raku).decode("utf8"), "asdf";
}

{
    my $ch;
    lives-ok { $ch = EVAL 100.chr.raku }, '100.chr.raku - lives';
    is $ch, 100.chr, ".raku on latin character";
    $ch = '';

    lives-ok { $ch = EVAL 780.chr.raku }, '780.chr.raku - lives';
    is $ch, 780.chr, ".raku on composing character";

    # https://github.com/Raku/old-issue-tracker/issues/4219
    my $non-print-then-combchar = 1.chr ~ 780.chr;
    lives-ok { $ch = EVAL $non-print-then-combchar.raku },
        '.raku on string with combining char on a non-printable - lives';
    is $ch, $non-print-then-combchar,
        ".raku on string with combining char on a non-printable - roundtrips";

    is "Ħ".raku.chars, 3, 'non-combining start does not need escaping';
}

# vim: expandtab shiftwidth=4
