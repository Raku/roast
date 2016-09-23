use v6;
use Test;

plan 3;

# Tests of the Baggy role

{ # coverage; 2016-09-23
    my class Foo does Baggy {}
    my $b = Foo.new: <a a b>;
    is $b.WHICH, "Foo|Str|a(2) Str|b(1)", '.WHICH';
    is-deeply $b.invert,  (2 => "a", 1 => "b"), '.invert';
    is-deeply $b.SetHash, SetHash.new(<a b>),   '.SetHash';
}
