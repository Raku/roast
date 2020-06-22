use v6;

use Test;

plan 18;

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

# vim: expandtab shiftwidth=4
