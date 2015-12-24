use Test;

plan 4;

{
    my $a = List;
    dies-ok { $a[0] := 1; }, X::Bind, "can't bind into an undefined list";
}

{
    my $a = Int;
    dies-ok { $a[0] := 1; }, X::Bind, "Can't bind into an undefined Int";
}

{
    my $a = 10;
    dies-ok { $a[0] := 1; }, X::Bind, "Can't bind into a defined Int, either";
}

{
    my $a = "Hi";
    dies-ok { $a[0] := 1; }, X::Bind, "Can't bind into a defined Str";
}
