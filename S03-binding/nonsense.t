use Test;

plan 4;

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
