use v6;

use Test;

plan 7;

# L<S09/Autovivification/In Perl 6 these read-only operations are indeed non-destructive:>
#?rakudo skip 'Undef to integer'
{
    my %a;
    my $b = %a<b><c>;
    is %a.keys.elems, 0, "fetching doesn't autovivify.";
}

#?rakudo skip 'Undef to integer'
{
    my %a;
    my $b = so %a<b><c>:exists;
    is %a.keys.elems, 0, "exists doesn't autovivify.";
}

# L<S09/Autovivification/But these bindings do autovivify:>
#?rakudo skip 'get_pmc_keyed() not implemented in class Undef'
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
}

#?rakudo skip 'prefix:<\\>'
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

#?rakudo skip 'get_pmc_keyed() not implemented in class Undef'
{
    my %a;
    %a<b><c> = 1;
    is %a.keys.elems, 1, 'store autovivify.';
}


sub foo ($baz is rw) {    #OK not used
    # just some random subroutine.
}

sub bar ($baz is readonly) {
    # readonly signature, should it autovivify?
}

# vim: ft=perl6
