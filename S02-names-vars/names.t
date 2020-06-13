use v6;

use Test;

plan 156;

# I'm using semi-random nouns for variable names since I'm tired of foo/bar/baz and alpha/beta/...

# L<S02/Names/>
# syn r14552

{
    my $mountain = 'Hill';
    $Terrain::mountain  = 108;
    $Terrain::Hill::mountain = 1024;
    our $river = 'Terrain::Hill';
    is($mountain, 'Hill', 'basic variable name');
    is($Terrain::mountain, 108, 'variable name with package');
    #?rakudo skip 'package variable autovivification'
    is(Terrain::<$mountain>, 108, 'variable name with sigil not in front of package');
    is($Terrain::Hill::mountain, 1024, 'variable name with 2 deep package');
    #?rakudo skip 'package variable autovivification'
    is(Terrain::Hill::<$mountain>, 1024, 'varaible name with sigil not in front of 2 package levels deep');
    is($Terrain::($mountain)::mountain, 1024, 'variable name with a package name partially given by a variable ');
    is($::($river)::mountain, 1024, 'variable name with package name completely given by variable');
}

{
    my $bear = 2.16;
    is($bear,       2.16, 'simple variable lookup');
    # https://github.com/Raku/old-issue-tracker/issues/4424
    #?rakudo skip 'this kind of lookup NYI RT #125659'
    is($::{'bear'}, 2.16, 'variable lookup using $::{\'foo\'}');
    is(::{'$bear'}, 2.16, 'variable lookup using ::{\'$foo\'}');
    # https://github.com/Raku/old-issue-tracker/issues/4424
    #?rakudo skip 'this kind of lookup NYI RT #125659'
    is($::<bear>,   2.16, 'variable lookup using $::<foo>');
    is(::<$bear>,   2.16, 'variable lookup using ::<$foo>');
}

#?rakudo skip '::{ } package lookup NYI'
{
    my $::<!@#$> =  2.22;
    is($::{'!@#$'}, 2.22, 'variable lookup using $::{\'symbols\'}');
    is(::{'$!@#$'}, 2.22, 'variable lookup using ::{\'$symbols\'}');
    is($::<!@#$>,   2.22, 'variable lookup using $::<symbols>');
    is(::<$!@#$>,   2.22, 'variable lookup using ::<$symbols>');
}

# https://github.com/Raku/old-issue-tracker/issues/2593
{
    module A {
        our sub _b() { 'sub A::_b' }
    }
    is A::_b(), 'sub A::_b', 'A::_b() call works';
}

# https://github.com/Raku/old-issue-tracker/issues/2149
is-deeply ::.^methods, PseudoStash.^methods, ':: is a valid PseudoStash';

# https://github.com/Raku/old-issue-tracker/issues/743
{
    throws-like 'OscarMikeGolf::whiskey_tango_foxtrot()',
      Exception,
      'dies when calling non-existent sub in non-existent package';
    throws-like 'Test::bravo_bravo_quebec()',
      Exception,
      'dies when calling non-existent sub in existing package';
    # https://github.com/Raku/old-issue-tracker/issues/1706
    class TestA { };
    throws-like 'TestA::frobnosticate(3, :foo)',
      Exception,
      'calling non-existing function in foreign class dies';;
}

# https://github.com/Raku/old-issue-tracker/issues/1433
{
    sub self { 4 };
    is self(), 4, 'can define and call a sub self()';
}

# https://github.com/Raku/old-issue-tracker/issues/2110
# Subroutines whose names begin with a keyword followed by a hyphen
# or apostrophe
# https://github.com/Raku/old-issue-tracker/issues/1481
# Subroutines with keywords for names (may need to be called with
# parentheses).
#?DOES 114
{
    for <
        foo package module class role grammar my our state let
        temp has augment anon supersede sub method submethod
        macro multi proto only regex token rule constant enum
        subset if unless while repeat for foreach loop given
        when default > -> $kw {
        eval-lives-ok "sub $kw \{}; {$kw}();",
            "sub named \"$kw\" called with parentheses";
        eval-lives-ok "sub {$kw}-rest \{}; {$kw}-rest;",
            "sub whose name starts with \"$kw-\"";
        eval-lives-ok "sub {$kw}'rest \{}; {$kw}'rest;",
            "sub whose name starts with \"$kw'\"";
    }
}

{
    my \s = 42;
    is s, 42, 'local terms override quoters';
    sub m { return 42 };
    is m, 42, 'local subs override quoters';
}

# https://github.com/Raku/old-issue-tracker/issues/2016
isa-ok (rule => 1), Pair, 'rule => something creates a Pair';

# https://github.com/Raku/old-issue-tracker/issues/1360
{
    throws-like { EVAL 'Module.new' },
      X::Undeclared::Symbols,
      'error message mentions name not recognized, no maximum recursion depth exceeded';
}

# https://github.com/Raku/old-issue-tracker/issues/1680
# Rakudo had troubles with names starting with Q
lives-ok { EVAL 'class Quox { }; Quox.new' },
  'class names can start with Q';

# https://github.com/Raku/old-issue-tracker/issues/288
throws-like {
    EVAL 'class A { has $.a};  my $a = A.new();';
    EVAL 'class A { has $.a};  my $a = A.new();';
    EVAL 'class A { has $.a};  my $a = A.new();';
},
  X::Redeclaration,
  'can *not* redefine a class in EVAL -- classes are package scoped';

# https://github.com/Raku/old-issue-tracker/issues/2362
{
    class Class { };
    ok Class.new ~~ Class, 'can call a class Class';
}

# https://github.com/Raku/old-issue-tracker/issues/1822
{
    throws-like 'my ::foo $x, say $x', Exception,
        'no Null PMC access when printing a variable typed as ::foo ';
}

# https://github.com/Raku/old-issue-tracker/issues/2803
{
    my module A {
        enum Day is export <Mon Tue>;
        sub Day is export { 'sub Day' }
    }
    import A;
    is Day(0), Mon, 'when enum and sub Day exported, Day(0) is enum coercer';
    is &Day(), 'sub Day', 'can get sub using & to disamgibuate';
}

# https://github.com/Raku/old-issue-tracker/issues/2962
{
    my module foo {}
    sub foo() { "OH HAI" }
    ok foo.HOW ~~ Metamodel::ModuleHOW, 'when module and sub foo, bare foo is module type object';
    ok foo().HOW ~~ Metamodel::CoercionHOW, 'when module and sub foo, foo() is coercion type';
    is &foo(), 'OH HAI', 'can get sub using & to disambiguate';
}

# https://github.com/Raku/old-issue-tracker/issues/5479
subtest 'can use compile-time variables in names' => { 
    plan 2;
    constant $i = 42;
    my $foo:bar«$i» = 'meow';
    is-deeply $foo:bar«$i», 'meow', 'variable lookup';
    is-deeply $foo:bar<42>, 'meow', 'literal lookup';
}

{ # https://github.com/rakudo/rakudo/issues/1606
    role Foo[\T] { };
    role Foo::Bar[\T] { };
    role Foo::Bar::Baz[\T1, \T2] { }
    is Int.new.^shortname, 'Int', 'properly short name Metamodel instances';
    is Foo[Int].new.^shortname, 'Foo[Int]', 'properly short name Metamodel instances with braces';
    is Foo::Bar[Int].new.^shortname, 'Bar[Int]', 'properly short name Metamodel instances with colons and braces';
    is Foo::Bar::Baz[Int, Int].new.^shortname, 'Baz[Int,Int]', 'properly short name Metamodel instances with braces and commas';
    is Foo::Bar::Baz[
        Foo[Int],
        Foo::Bar[Int]
    ].new.^shortname, 'Baz[Foo[Int],Bar[Int]]', 'properly short name Metamodel instances with colons, braces, and commas';
    is Foo::Bar::Baz[
        Foo::Bar[Foo[Int]],
        Foo::Bar::Baz[Foo[Int], Foo::Bar[Int]]
    ].new.^shortname, 'Baz[Bar[Foo[Int]],Baz[Foo[Int],Bar[Int]]]', 'properly short name Metamodel instances with nested colons, braces, and commas';
}

# vim: expandtab shiftwidth=4
