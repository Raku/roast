use v6;


use Test;

plan 4;

my $here;

#?rakudo skip 'defining operators'
{
    my @a;
    $here = 0;
    multi infix:<..> ( Int $a, Int $b ) { $here++ }
    @a = 1..2;
    is $here, 1, "range operator was redefined";
}

{
    my @a;
    $here = 0;
    multi push ( Array @a, *@data ) { $here++ }
    push @a, 2;
    is $here, 1, "push operator was redefined";
}

{
my @a;
$here = 0;
multi postcircumfix:<[]> ( *@a ) { $here++ }
my $x = @a[1];
}
is $here, 1, "slice fetch was redefined", :todo<bug>;

{
my @a;
$here = 0;
multi postcircumfix:<[]> ( *@a ) { $here++ }
@a[1] = 0;
}
is $here, 1, "slice store was redefined", :todo<bug>;
