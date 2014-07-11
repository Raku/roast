use v6;

use Test;

plan 37;

# =head1 Introspection
#     WHAT        the type object of the type

my class A is Array {};
my class H is Hash  {};

{
    my $a;
    ok $a.WHAT    === Any,   '$a default is Any';
    my @a;
    ok @a.WHAT    === Array, '@a default is Array';
    ok @a[0].WHAT === Any,   '@a[0] default is Any';
    my %a;
    ok %a.WHAT    === Hash,  '%a default is Hash';
    ok %a<a>.WHAT === Any,   '%a<a> default is Any';
} #5

{
    my $a = Array.new;
    ok $a.WHAT    === Array, 'Array.new default is Array';
    ok $a[0].WHAT === Any,   'Array.new[0] default is Any';
    my $h = Hash.new;
    ok $h.WHAT    === Hash,  'Hash.new default is Hash';
    ok $h<a>.WHAT === Any,   'Hash.new<a> default is Any';
} #4

{
    my $a = A.new;
    ok $a.WHAT    === A,   'A.new default is A';
    ok $a[0].WHAT === Any, 'A.new[0] default is Any';
    my $h = H.new;
    #?niecza todo
    ok $h.WHAT    === H,   'H.new default is Hash';
    ok $h<a>.WHAT === Any, 'H.new<a> default is Any';
} #4

#?niecza skip "no typed support"
{
    my Int $a;
    ok $a.WHAT    === Int,        'Int $a default is Int';
    my Int @a;
    ok @a.WHAT    === Array[Int], 'Int @a default is Array[Int]';
    ok @a[0].WHAT === Int,        'Int @a[0] default is Int';
    my Int %a;
    ok %a.WHAT    === Hash[Int],  'Int %a default is Hash[Int]';
    ok %a<a>.WHAT === Int,        'Int %a<a> default is Int';
} #5

#?niecza skip "no typed support"
{
    my $a of Int;
    #?rakudo todo "of Type on scalars fails"
    ok $a.WHAT    === Int,        '$a of Int default is Int';
    my @a of Int;
    #?rakudo todo "looks like a type object, but is not"
    ok @a.WHAT    === Array[Int], '@a of Int default is Array[Int]';
    #?rakudo todo "of Type on scalars fails"
    ok @a[0].WHAT === Int,        '@a[0] of Int default is Int';
    my %a of Int;
    #?rakudo todo "looks like a type object, but is not"
    ok %a.WHAT    === Hash[Int],  '%a of Int default is Hash[Int]';
    #?rakudo todo "of Type on scalars fails"
    ok %a<a>.WHAT === Int,        '%a<a> of Int default is Int';
} #5

#?niecza skip "no typed support"
{
    my Int %a{Str};
    ok %a.WHAT    === Hash[Int,Str], 'Int %a{Str} default is Hash[Int,Str]';
    ok %a<a>.WHAT === Int,           'Int %a{Str}<a> default is Int';
} #2

#?niecza skip "no typed support"
#?rakudo todo '%h{Str} of Int fails'
{
    my %a{Str} of Int;
    ok %a.WHAT    === Hash[Int,Str], '%a{Str} of Int default is Hash[Int,Str]';
    ok %a<a>.WHAT === Int,           '%a{Str}<a> of Int default is Int';
} #2

#?niecza skip "no typed support"
{
    my $a = Array[Int].new;
    ok $a.WHAT    === Array[Int], 'Array[Int].new default is Array';
    #?rakudo todo "Foo[Int].new on scalars fails"
    ok $a[0].WHAT === Int,        'Array[Int].new[0] default is Int';
    my $h = Hash[Int].new;
    ok $h.WHAT    === Hash[Int],  'Hash[Int].new default is Hash[Int]';
    #?rakudo todo "Foo[Int].new on scalars fails"
    ok $h<a>.WHAT === Int,        'Hash[Int].new<a> default is Int';
} #4

#?niecza skip "no typed support"
{
    my $a = A[Int].new;
    ok $a.WHAT    === A[Int], 'A[Int].new default is A[Int]';
    #?rakudo todo "Foo[Int].new on scalars fails"
    ok $a[0].WHAT === Int,    'A[Int].new[0] default is Int';
    my $h = H[Int].new;
    ok $h.WHAT    === H[Int], 'H[Int].new default is H[Int]';
    #?rakudo todo "Foo[Int].new on scalars fails"
    ok $h<a>.WHAT === Int,    'H[Int].new<a> default is Int';
} #4

#?niecza skip "no typed support"
{
    my $h = H[Int,Str].new;
    ok $h.WHAT    === H[Int,Str], 'H[Int,Str].new default is H[Int,Str]';
    #?rakudo todo "Foo[Int,Str].new on scalars fails"
    ok $h<a>.WHAT === Int,        'H[Int,Str].new<a> default is Int';
} #2

# vim: ft=perl6
