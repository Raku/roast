use v6;
use Test;

# Nil may be a type now.  Required?

plan 37;

sub empty_sub {}
sub empty_do { do {} }
sub empty_branch_true { if 1 {} else { 1; } }
sub empty_branch_false { if 0 { 1; } else {} }
sub bare_return { return; }
sub rt74448 { eval '' }

ok empty_sub()          === Nil, 'empty sub returns Nil';
ok empty_do()           === Nil, 'do {} is Nil';
ok empty_branch_true()  === Nil, 'if 1 {} is Nil';
ok empty_branch_false() === Nil, 'else {} is Nil';
ok bare_return()        === Nil, 'bare return returns Nil';
ok rt74448()            === Nil, 'eval of empty string is Nil';

nok Nil.defined, 'Nil is not defined';
ok  ().defined,  '() is defined';
nok (my $x = Nil).defined, 'assigning Nil to scalar leaves it undefined'; #OK
ok (my $y = ()).defined, 'assigning () to scalar results in a defined parcel'; #OK

# RT #63894
{
    my $calls;
    sub return_nil { $calls++; return; }

    $calls = 0;
    ok return_nil() === Nil, 'return_nil() === Nil';
    is return_nil().perl, 'Nil', 'return_nil().perl says Nil';
    is $calls, 2, 'return_nil() called twice';

    my $n = return_nil();
    nok $n.defined, 'variable holding nil is not defined';
}

{
    my $x = 0;
    $x++ for Nil;
    is $x, 0, '$Statement for Nil; does zero iterations';
}

# RT 93980
ok (my $rt93980 = Nil) === Any, 'Nil assigned to scalar produces an Any'; #OK

ok (my Str $str93980 = Nil) === Str; #OK

is Nil.gist, 'Nil', 'Nil.gist eq "Nil"';
ok !Nil.new.defined, 'Nil.new is not defined';

{
    subset MyInt of Int where True;
    my MyInt $x = 5;

    lives_ok { $x = Nil }, 'can assign Nil to subsets';
    #?rakudo todo 'triage'
    ok $x === Int, 'assigns to base-type object';
}

{
    my $z := Nil;
    ok $z === Nil, 'can bind to Nil';
}

{
    sub f1($x) { } #OK
    #?rakudo todo 'triage'
    dies_ok { f1(Nil) }, 'param: dies for mandatory';

    sub f2(Int $x?) { $x }
    my $z;
    #?rakudo skip 'triage'
    lives_ok { $z = f2(Nil) }, 'param: lives for optional';
    #?rakudo todo 'triage'
    ok $z === Int, '... set to type object';
    my $z2 is default(Nil);
    #?rakudo todo 'triage'
    lives_ok { $z = f2($z2) }, 'param: lives for optional from var';
    #?rakudo todo 'triage'
    ok $z === Int, '... set to type object';

    sub f3($x = 123) { $x }
    lives_ok { $z = f3(Nil) }, 'param: lives for with-default';
    #?rakudo todo 'triage'
    is $z, 123, '... set to default';

    sub f4($x = Nil) { $x }
    ok f4() === Nil, 'can use Nil as a default (natural)';
    ok f4(Nil) === Nil, 'can use Nil as a default (nil-triggered)';
}

#?pugs   todo '$/!_ does not default to Nil'
#?niecza todo '$/!_ does not default to Nil'
{
    ok $/ === Nil, '$/ is by default Nil';
    ok $! === Nil, '$! is by default Nil';
    ok $_ === Nil, '$_ is by default Nil';

    ok $/.VAR.default === Nil, '$/ has Nil as default';
    ok $!.VAR.default === Nil, '$! has Nil as default';
    ok $_.VAR.default === Nil, '$_ has Nil as default';
}

done;

# vim: ft=perl6
