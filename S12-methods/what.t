use v6;
use Test;
plan *;

=begin pod

=head1 DESCRIPTION

This test tests the C<WHAT> builtin.

=end pod

# L<S12/Introspection/"WHAT">

# Basic subroutine/method form tests for C<WHAT>.
{
  my $a = 3;
  ok((WHAT $a) === Int, "subroutine form of WHAT");
  ok(($a.WHAT) === Int, "method form of WHAT");
}

# Now testing basic correct inheritance.
{
  my $a = 3;
  ok($a.WHAT ~~ Numeric, "an Int isa Numeric");
  ok($a.WHAT ~~ Mu,  "an Int isa Mu");
}

# And a quick test for Code:
{
  my $a = sub ($x) { 100 + $x };
  ok($a.WHAT === Sub,    "a sub's type is Sub");
  ok($a.WHAT ~~ Routine, "a sub isa Routine");
  ok($a.WHAT ~~ Code,    "a sub isa Code");
}

# L<S12/Introspection/"which also bypasses the macros.">

# RT #60992
{
    class Foo {
        method WHAT {'Bar'}
    }
    my $o = Foo.new;
    is($o."WHAT"(), 'Bar', '."WHAT" calls the method instead of the macro');
    #?rakudo todo '.WHAT not (easily overridable)'
    is($o.WHAT,   'Foo', '.WHAT still works as intended');
    my $meth = "WHAT";
    #?rakudo skip 'indirect method calls'
    is($o.$meth,  'Bar', '.$meth calls the method instead of the macro');
}

# these used to be Rakudo regressions, RT #62006

{
    # proto as a term
    lives_ok {  Match }, 'proto as a term lives';
    lives_ok { +Match }, 'numification of proto lives';
    isa_ok ("bac" ~~ /a/).WHAT, Match, '.WHAT on a Match works';
    is +("bac" ~~ /a/).WHAT, 0, 'numification of .WHAT of a Match works';
}

ok &infix:<+>.WHAT ~~ Multi, '.WHAT of built-in infix op is Multi (RT 66928)';

# RT #69915
{
    sub rt69915f( $a, $b ) { return WHAT($a) ~ '~' ~ WHAT($b) }
    sub rt69915m( $a, $b ) { return $a.WHAT  ~ '~' ~ $b.WHAT  }

    is rt69915m( a => 42, 23 ), 'Int()~Int()', 'WHAT method on ints';

    is rt69915f( a => 42, 23 ), 'Int()~Int()', 'WHAT function on ints (1)';
    is rt69915f( 23, a => 42 ), 'Int()~Int()', 'WHAT function on ints (2)';

    is rt69915f( :a, 23 ), 'Bool()~Int()', 'WHAT function on bool and int';
    is rt69915m( :a, 23 ), 'Bool()~Int()', 'WHAT method on bool and int';

    sub wm($x) { return $x.WHAT }
    sub rt69915wm( $a, $b ) { return wm($a) ~ '~' ~ wm($b) }
    is rt69915wm( a => 42, 23 ), 'Int()~Int()', 'WHAT method on ints via func';
    
    sub wf($x) { return WHAT($x) }
    sub rt69915wf( $a, $b ) { return wf($a) ~ '~' ~ wf($b) }
    is rt69915wf( a => 42, 23 ), 'Int()~Int()', 'WHAT func on ints via func';
}

is 6.02e23.WHAT, Num, 'decimal using "e" is a Num';
is 1.23456.WHAT, Rat, 'decimal without "e" is Rat';
ok 1.1 == 11/10, 'decimal == the equivalent rational';

# RT #70237
{
    is ~1.WHAT, 'Int()', '1.WHAT sanity';
    dies_ok { Int.WHAT = Str }, '.WHAT is readonly';
    is ~2.WHAT, 'Int()', 'assignment to Int.WHAT does nothing';
}

{
    class AccessMethods {
        our method a { };
        method b { };
    }

    ok &AccessMethods::a.defined, 'Can access "our" method with &class::method';
    ok &AccessMethods::a ~~ Method, '... and got a Method back';
    nok &AccessMethods::b.defined, '"has" methods are hidden';
    lives_ok {&AccessMethods::c.defined and die "foo"}, 'non-existant method access livess (and returns undef)';

}

done_testing;

# vim: ft=perl6
