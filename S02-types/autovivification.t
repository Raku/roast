use v6;

use Test;

plan 25;

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
    $b = 42;
    is %h.keys.elems, 1, '.. but autovivifies after assignment';
    is %h<a><b>, 42, 'having it in there';
    ok %h<a><b> =:= $b, 'check binding';
}

#?niecza todo 'disagree; captures should be context neutral'
{
    my %h;
    my $b = \(%h<a><b>);
    is %h.keys.elems, 0, 'capturing does not autovivify';
}

{
    my %h;
    foo(%h<a><b>);
    is %h.keys.elems, 0, 'in rw arguments does not autovivify';
    foo(%h<a><b>,42);
    is %h.keys.elems, 1, 'storing from within the sub does autovivify';
    is %h<a><b>, 42, 'got the right value';
}

{
    my %h;
    %h<a><b> = 42;
    is %h.keys.elems, 1, 'store autovivify.';
    is %h<a><b>, 42, 'got the right value';
}

# helper subs
sub foo ($baz is rw, $assign? ) { $baz = $assign if $assign }
sub bar ($baz is readonly) { }

# RT #77038
#?niecza skip "Unable to resolve method push in type Any"
{
    my %h;
    push %h<a>, 4, 2;
    is %h<a>.join, '42', 'can autovivify in sub form of push';
    unshift %h<b>, 5, 3;
    is %h<b>.join, '53', 'can autovivify in sub form of unshift';
    %h<c><d>.push( 7, 8 );
    is %h<c><d>.join, '78', 'can autovivify in method form of push';
    %h<e><f>.unshift( 9, 10 );
    is %h<e><f>.join, '910', 'can autovivify in method form of unshift';
    is %h.keys.elems, 4, 'successfully autovivified lower level';
}

{
    my $a;
    $a[0] = '4';
    $a[1] = '2';
    is $a.join, '42', 'Can autovivify Array';
}

# RT #77048
{
    my Array $a;
    $a[0] = '4';
    $a[1] = '2';
    is $a.join, '42', 'Can autovivify Array-typed scalar';
}

{
    my $h;
    $h<a> = '4';
    $h<b> = '2';
    is $h<a b>.join, '42', 'Can autovivify Hash';
}

{
    my Hash $h;
    $h<a> = '4';
    $h<b> = '2';
    is $h<a b>.join, '42', 'Can autovivify Hash-typed scalar';
}


# vim: ft=perl6
