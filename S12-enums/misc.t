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

# RT #66648
{
    enum RT66648 <a b c>;
    dies-ok { RT66648.c }, 'die attempting to access enum item as method';
}

# RT #70894

{
    enum SomeEnum <a b c>;
    lives-ok {SomeEnum::.keys}, 'keys on enum stash works';

}

# L<S12/Miscellaneous Rules>
# see also: RT #63650
{
    enum Maybe <OK FAIL>;
    sub OK { 'sub OK' };
    is OK,    'OK',     'enum key wins in case of conflict';
    is +OK,   0,        'enum key wins in case of conflict (numeric)';
    #?niecza skip 'No value for parameter $key in CORE CommonEnum.postcircumfix:<( )>'
    is OK(),  'sub OK', 'but () is still a function call';
    is FAIL,  'FAIL',   'non-conflicting enum key';
    is +FAIL, 1,        'non-conflicting enum key (numeric)';
    # RT #112202
    #?niecza todo
    lives-ok { OK.^methods }, 'can call .^methods on an enum';
}

# anonymous Enum in our context, # RT #122514
{
    enum :: <un>;
    is +un, 0, 'is un the right value';
    is ~un, 'un', 'is un the right string';
}

#RT # 123114
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

# RT#129160
{
    enum RT<R T>;
    ok R.ACCEPTS(RT), 'enum member ACCEPTS the enum type object';
}

# vim: ft=perl6
