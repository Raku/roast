use v6;
use Test;

# Nil may be a type now.  Required?

plan 48;

sub empty_sub {}
sub empty_do { do {} }
sub empty_branch_true { if 1 {} else { 1; } }
sub empty_branch_false { if 0 { 1; } else {} }
sub bare_return { return; }
sub rt74448 { EVAL '' }

ok empty_sub()          === Nil, 'empty sub returns Nil';
ok empty_do()           === Nil, 'do {} is Nil';
ok empty_branch_true()  === Nil, 'if 1 {} is Nil';
ok empty_branch_false() === Nil, 'else {} is Nil';
ok bare_return()        === Nil, 'bare return returns Nil';
ok rt74448()            === Nil, 'EVAL of empty string is Nil';

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
    ok $x === MyInt, 'assigns to subset type object';
}

{
    my $z := Nil;
    ok $z === Nil, 'can bind to Nil';
}

{
    sub f1($x) { } #OK
    #?rakudo todo 'triage'
    throws_like { f1(Nil) },
      X::AdHoc, # XXX fix when this starts to fail
      'param: dies for mandatory';

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

#?niecza todo '$/!_ does not default to Nil'
{
    ok $/ === Nil, '$/ is by default Nil';
    ok $! === Nil, '$! is by default Nil';
    ok $_ === Nil, '$_ is by default Nil';

    ok $/.VAR.default === Nil, '$/ has Nil as default';
    ok $!.VAR.default === Nil, '$! has Nil as default';
    ok $_.VAR.default === Nil, '$_ has Nil as default';
}

# calling methods and similar things on Nil should return Nil again
{
    sub niltest { return Nil };

    ok niltest()           === Nil, "sanity";
    ok niltest.foo         === Nil, "calling methods on Nil gives Nil again I";
    ok niltest.foo.bar     === Nil, "calling methods on Nil gives Nil again II";
    ok niltest.foo.bar.baz === Nil, "calling methods on Nil gives Nil again III";

    ok niltest[0]          === Nil, "array access on Nil gives Nil again I";
    ok niltest[0][2]       === Nil, "array access on Nil gives Nil again II";
    ok niltest[0][2][4]    === Nil, "array access on Nil gives Nil again III";

    ok niltest<foo>         === Nil, "hash access on Nil gives Nil again I";
    ok niltest<foo><bar>    === Nil, "hash access on Nil gives Nil again II";
    ok niltest<foo><bar><A> === Nil, "hash access on Nil gives Nil again II";

    ok niltest.foo.bar.<bar>.[12].[99].<foo> === Nil, ".<> and .[] works properly, too";
}

done;

# vim: ft=perl6
