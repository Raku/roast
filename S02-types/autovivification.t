use v6;

use Test;

plan 10;

# L<S09/Autovivification/In Perl 6 these read-only operations are indeed non-destructive:>
{
    my %a;
    my $b = %a<b><c>;
    #?pugs todo
    is %a.keys.elems, 0, "fetching doesn't autovivify.";
    ok !defined($b), 'and the return value is not defined';
}

#?rakudo skip 'Undef to integer'
#?pugs skip ':exists'
{
    my %a;
    my $b = so %a<b><c>:exists;
    is %a.keys.elems, 0, "exists doesn't autovivify.";
    nok $b, '... and it returns the right value';
}

# L<S09/Autovivification/But these bindings do autovivify:>
#?pugs todo
{
    my %a;
    bar(%a<b><c>);
    is %a.keys.elems, 0, "in ro arguments doesn't autovivify.";
}

#?rakudo skip 'get_pmc_keyed() not implemented in class Undef'
{
    my %a;
    my $b := %a<b><c>;
    is %a.keys.elems, 1, 'binding autovivifies.';
    nok defined($b), '... to an undefined value';
}

#?rakudo skip 'prefix:<\\>'
#?niecza todo 'disagree; captures should be context neutral'
{
    my %a;
    my $b = \%a<b><c>;
    is %a.keys.elems, 1, 'capturing autovivifies.';
}

#?rakudo skip 'get_pmc_keyed() not implemented in class Undef'
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

# vim: ft=perl6
