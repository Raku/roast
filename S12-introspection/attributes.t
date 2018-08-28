use v6;

use Test;

plan 39;

=begin pod

Tests for .^attributes from L<S12/Introspection>.

=end pod

# L<S12/Introspection/"The .^attributes method">

class A {
    has Str $.a = "dnes je horuci a potrebujem pivo";
}
class B is A {
    has Int $!b = $*FOO // 42;  # forces code closure
}
class C is B {
    has $.c is rw
}

my @attrs = C.^attributes();
is +@attrs, 3, 'attribute introspection gave correct number of elements';

is @attrs[0].name,         '$!c',  'first attribute had correct name';
is @attrs[0].type.gist,    '(Mu)', 'first attribute had correct type';
is @attrs[0].has_accessor, True,   'first attribute has an accessor';
ok !@attrs[0].build,               'first attribute has no build value';
ok @attrs[0].rw,                   'first attribute is rw';
ok !@attrs[0].readonly,            'first attribute is not readonly';

is @attrs[1].name,         '$!b',   'second attribute had correct name';
is @attrs[1].type.gist,    '(Int)', 'second attribute had correct type';
is @attrs[1].has_accessor, False,   'second attribute has no accessor';
ok @attrs[1].build ~~ Code,         'second attribute has build block';
is @attrs[1].build().(C, $_), 42,
                              'second attribute build block gives expected value';

is @attrs[2].name,         '$!a',   'third attribute had correct name';
is @attrs[2].type.gist,    '(Str)', 'third attribute had correct type';
is @attrs[2].has_accessor, True,    'third attribute has an accessor';
ok @attrs[2].build ~~ Str,          'third attribute has build valuek';
is @attrs[2].build,        "dnes je horuci a potrebujem pivo",
                                    'third attribute build block gives expected value';
ok !@attrs[2].rw,                   'third attribute is not rw';
ok @attrs[2].readonly,              'third attribute is readonly';

@attrs = C.^attributes(:local);
is +@attrs,        1,     'attribute introspection with :local gave just attribute in base class';
is @attrs[0].name, '$!c', 'get correct attribute with introspection';

#?rakudo skip ':tree NYI for .^attributes RT #125014'
{
    @attrs = C.^attributes(:tree);
    is +@attrs, 2,                  'attribute introspection with :tree gives right number of elements';
    is @attrs[0].name, '$!c',       'first element is attribute descriptor';
    ok @attrs[1] ~~ Array,          'second element is array';
    is @attrs[1][0].name, '$!b',    'can look into second element array to find next attribute';
    is @attrs[1][1][0].name, '$!a', 'can look deeper to find attribute beyond that';
}

{
    my $x = A.new(a => 'abc');
    my $attr = $x.^attributes(:local).[0];
    isa-ok $attr, Attribute;
    is $attr.get_value($x), 'abc', '.get_value works';
    lives-ok { $attr.set_value($x, 'new') }, 'can set_value';
    is $x.a, 'new', 'set_value worked';

}

{ # coverage; 2016-09-21
    my $g := Attribute.new(:name<test-name>, :type(Int), :package<Foo>).gist;
    like $g, /Int/,         '.gist of an Attribute includes type';
    like $g, /'test-name'/, '.gist of an Attribute includes name';
}

# RT #127059
{
    class RT127059 {
        has Str @.rt127059;
    }
    is RT127059.^attributes[0].name, '@!rt127059',
        'introspection of name of typed array attribute works';
    is RT127059.^attributes[0].type.gist, '(Positional[Str])',
        'introspection of type of typed array attribute works (using gist)';
}

# RT #77070
{
    # Attributes attributes are sure to actually be BOOTSTRAPATTRs because
    # of bootstrapping
    my $a = Attribute.^attributes[0];
    like $a.gist, /^ <ident>+ \s '$!' <ident>+ $/, '.gist of a BOOTSTRAPATTR is the type and name';
    like $a.Str,  /^ '$!' <ident>+ $/,             '.Str of a BOOTSTRAPATTR is the name';
    is   $a.perl, 'BOOTSTRAPATTR.new',             '.perl of a BOOTSTRAPATTR is the class name ~ ".new"';
}

# RT #131174
{
    # shape introspection
    my class RT131174 {
        has @.a[2];
    }
    is RT131174.new(:a[1, 2]).a.shape.gist, '(2)', 'shape of stantiated attribute';
#?rakudo todo 'RT #131174'
    is RT131174.^attributes[0].container.shape.gist, '(2)', 'attribute container shape';
}

# vim: ft=perl6
