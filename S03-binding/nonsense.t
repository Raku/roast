use Test;

plan 5;

{
    my $a = List;
    #?rakudo todo 'wrong exception'
    throws-like { $a[0] := 1; }, X::Bind, "can't bind into an undefined list";
}

{
    my $a = Int;
    #?rakudo todo 'wrong exception'
    throws-like { $a[0] := 1; }, X::Bind, "Can't bind into an undefined Int";
}

{
    my $a = 10;
    #?rakudo skip 'hangs'
    throws-like { $a[0] := 1; }, X::Bind, "Can't bind into a defined Int, either";
}

{
    my $a = "Hi";
    #?rakudo skip 'hangs'
    throws-like { $a[0] := 1; }, X::Bind, "Can't bind into a defined Str";
}

# RT #128755
{
    my $list = (1,2,3);
    throws-like { $list[1] := 4 }, X::Bind, "Can't bind into a List item";
}
