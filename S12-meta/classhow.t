use Test;

plan 1;

# RT #128516
{
    my class Foo {
        has $.a = Metamodel::ClassHOW.new_type(name => "Bar");
        method comp { $!a.^compose }
    }
    my $obj = Foo.new; 
    lives-ok { $obj.comp; $obj.gist },
        'Storing a meta-object in an attribute then composing/gisting works out';
}
