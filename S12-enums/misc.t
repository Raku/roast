use Test;

plan 28;

{
    class EnumClass     { enum C <a b c> }
    is +EnumClass::C::a, 0, 'enum element in class has the right value';

    module EnumModule   { enum M <a b c> }
    is +EnumModule::M::b, 1, 'enum element in module has the right value';

    package EnumPackage { enum P <a b c> }
    is +EnumPackage::P::c, 2, 'enum element in package has the right value';

    grammar EnumGrammar { enum G <a b c> }
    is +EnumGrammar::G::b, 1, 'enum element in grammar has the right value';
}

# https://github.com/Raku/old-issue-tracker/issues/1070
{
    enum RT66648 <a b c>;
    dies-ok { RT66648.c }, 'die attempting to access enum item as method';
}

# https://github.com/Raku/old-issue-tracker/issues/1418

{
    enum SomeEnum <a b c>;
    lives-ok {SomeEnum::.keys}, 'keys on enum stash works';

}

# L<S12/Miscellaneous Rules>
# https://github.com/Raku/old-issue-tracker/issues/744
# see also: RT #63650
{
    enum Maybe <OK FAIL>;
    sub OK { 'sub OK' };
    is OK,    'OK',     'enum key wins in case of conflict';
    is +OK,   0,        'enum key wins in case of conflict (numeric)';
    is OK(),  'sub OK', 'but () is still a function call';
    is FAIL,  'FAIL',   'non-conflicting enum key';
    is +FAIL, 1,        'non-conflicting enum key (numeric)';
    # https://github.com/Raku/old-issue-tracker/issues/2694
    lives-ok { OK.^methods }, 'can call .^methods on an enum';
}

# https://github.com/Raku/old-issue-tracker/issues/3481
# anonymous Enum in our context,
{
    enum :: <un>;
    is +un, 0, 'is un the right value';
    is ~un, 'un', 'is un the right string';
}

# https://github.com/Raku/old-issue-tracker/issues/2593
{
    module RT123114 {
        enum A is export <B C>;
    }
    import RT123114;
    is C.value, 1, 'Enum members are exported with enumeration itself';
}

# compile-time indirect list
{
    constant @stuff = <A B C>;
    enum Stuff (@stuff);
    is (A,B,C), (A,B,C), "can declare enums using constant lists";
    is (+A,+B,+C), (0,1,2), "and they get the right values";
}

# https://github.com/Raku/old-issue-tracker/issues/5631

{
    my enum RT<R T>;
    is-deeply R.ACCEPTS(RT), False, 'enum member does not ACCEPTS the enum type object';
}

# https://github.com/rakudo/rakudo/issues/4310
{
    my Array enum PageSizes «
      :Letter[0,0,612,793]
      :Tabloid[0,0,792,1224]
    »;

    is-deeply
      PageSizes.pairs.sort,
      (:Letter[0, 0, 612, 793], :Tabloid[0, 0, 792, 1224]),
      ".pairs on an Enum with Array values";

    is-deeply
      PageSizes.kv.sort,
      ([0, 0, 612, 793], [0, 0, 792, 1224], "Letter", "Tabloid"),
      ".kv on an Enum with Array values";

    is-deeply
      PageSizes.keys.sort,
      <Letter Tabloid>,
      ".keys on an Enum with Array values";

    is-deeply
      PageSizes.values.sort,
      ([0, 0, 612, 793],[0, 0, 792, 1224]),
      ".values on an Enum with Array values";

    is-deeply
      PageSizes.antipairs.sort,
      ([0, 0, 612, 793] => "Letter", [0, 0, 792, 1224] => "Tabloid"),
      ".antipairs on an Enum with Array values";

    is-deeply
      PageSizes.invert.sort,
      (  0 => "Letter",    0 => "Letter",
         0 => "Tabloid",   0 => "Tabloid",
       612 => "Letter",  792 => "Tabloid",
       793 => "Letter", 1224 => "Tabloid"),
      ".invert on an Enum with Array values";
}

{
    my enum Foo <A B>;
    throws-like { Foo.new }, X::Constructor::BadType, "invoking .new on an enum throws";
}

# https://github.com/rakudo/rakudo/issues/3349
{
    my enum Direction (:LEFT(-1), :NEUTRAL(0), :RIGHT(1));
    throws-like { Direction( 2 <=> 3 ) }, X::Enum::NoValue,
      type  => Direction,
      value => Less,
    ;
}

# https://github.com/rakudo/rakudo/issues/4134
{
    enum BooleanEnum (:!Lies, :Truth);
    is-deeply True ~~ BooleanEnum, False, 'should not match';
}

# https://github.com/rakudo/rakudo/issues/5935
{
    my enum Directions <⬆️>;
    lives-ok { Directions::<⬆️>.raku.EVAL }, 'enum raku method should be round-trippable';
}

# vim: expandtab shiftwidth=4
