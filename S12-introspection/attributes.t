use v6;

use Test;

plan 17;

=begin pod

Tests for .^attributes from L<S12/Introspection>.

=end pod

# L<S12/Introspection/"The C<.^attributes> method">

class A {
    has Str $.a = "dnes je horuci a potrebujem pivo";
}
class B is A {
    has Int $!b = 42;
}
class C is B {
    has $.c is rw
}

my @attrs = C.^attributes();
is +@attrs, 3, 'attribute introspection gave correct number of elements';

is @attrs[0].name,     '$!c',  'first attribute had correct name';
is @attrs[0].type,     Object, 'first attribute had correct type';
is @attrs[0].accessor, True,   'first attribute has an accessor';
ok !@attrs[0].build,           'first attribute has no build value';

is @attrs[1].name,     '$!b', 'second attribute had correct name';
is @attrs[1].type,     Int,   'second attribute had correct type';
is @attrs[1].accessor, False, 'second attribute has no accessor';
ok @attrs[1].build ~~ Code,   'second attribute has build block';
is @attrs[1].build().(C, $_), 42,
                              'second attribute build block gives expected value';

is @attrs[2].name,     '$!a', 'third attribute had correct name';
is @attrs[2].type,     Str,   'third attribute had correct type';
is @attrs[2].accessor, True,  'first attribute has an accessor';
ok @attrs[2].build ~~ Code,   'second attribute has build block';
is @attrs[2].build().(C, $_), "dnes je horuci a potrebujem pivo",
                              'second attribute build block gives expected value';

@attrs = C.^attributes(:local);
is +@attrs,        1,     'attribute introspection with :local gave just attribute in base class';
is @attrs[0].name, '$!c', 'get correct attribute with introspection';
