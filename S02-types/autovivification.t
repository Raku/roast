use v6;

use Test;

plan 16;

# L<S09/Autovivification/In Perl 6 these read-only operations are indeed non-destructive:>
{
    my %h;
    my $b = %h<a><b>;
    #?pugs todo
    is %h.keys.elems, 0, "fetching doesn't autovivify.";
    ok $b === Any, 'and the return value is not defined';
}

#?pugs skip ':exists'
{
    my %h;
    my $exists = %h<a><b>:exists;
    is %h.keys.elems, 0, "exists doesn't autovivify.";
    ok $exists === False, '... and it returns the right value';
}

# L<S09/Autovivification/But these bindings do autovivify:>
#?pugs todo
{
    my %h;
    bar(%h<a><b>);
    is %h.keys.elems, 0, "in ro arguments doesn't autovivify.";
}

{
    my %h;
    my $b := %h<a><b>;
    is %h.keys.elems, 0, 'binding does not immediately autovivify';
    ok $b === Any, '... to an undefined value';
    $b = 1;
    is %h.keys.elems, 1, '.. but autovivifies after assignment';
    is %h<a><b>, 1, 'having it in there';
    ok %h<a><b> =:= $b, 'check binding';
}

#?rakudo todo 'prefix:<\\>'
#?niecza todo 'disagree; captures should be context neutral'
{
    my %a;
    my $b = \%a<b><c>;
    is %a.keys.elems, 1, 'capturing autovivifies.';
}

#?rakudo todo 'get_pmc_keyed() not implemented in class Undef'
{
    my %a;
    foo(%a<b><c>);
    is %a.keys.elems, 1, 'in rw arguments autovivifies.';
}

{
    my %a;
    %a<b><c> = 1;
    is %a.keys.elems, 1, 'store autovivify.';
}


sub foo ($baz is rw) {    #OK not used
    # just some random subroutine.
}

# readonly signature, should it autovivify?
sub bar ($baz is readonly) { } #OK not used

# RT #77038
#?niecza skip "Unable to resolve method push in type Any"
{
    my %h;
    push %h<a>, 4, 2;
    is %h<a>.join, '42', 'can autovivify in sub form of push';
    unshift %h<b>, 5, 3;
    is %h<b>.join, '53', 'can autovivify in sub form of unshift';
}

# RT #77048
{
    my Array $a;
    $a[0] = '4';
    $a[1] = '2';
    is $a.join, '42', 'Can autovivify Array-typed scalar';
}

# vim: ft=perl6
