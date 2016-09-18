use v6;

use Test;

plan 22;

# L<S09/Autovivification/In Perl 6 these read-only operations are indeed non-destructive:>
{
    my %h;
    my $b = %h<a><b>;
    is %h.keys.elems, 0, "fetching doesn't autovivify.";
    ok $b === Any, 'and the return value is not defined';
}

{
    my %h;
    my $exists = %h<a><b>:exists;
    is %h.keys.elems, 0, "exists doesn't autovivify.";
    ok $exists === False, '... and it returns the right value';
}

# L<S09/Autovivification/But these bindings do autovivify:>
{
    my %h;
    bar(%h<a><b>);
    is %h.keys.elems, 0, "in ro arguments doesn't autovivify.";
}

{
    my %h;
    my $b := %h<a><b>;
    #?niecza todo "https://github.com/sorear/niecza/issues/176"
    is %h.keys.elems, 0, 'binding does not immediately autovivify';
    ok $b === Any, '... to an undefined value';
    $b = 42;
    is %h.keys.elems, 1, '.. but autovivifies after assignment';
    is %h<a><b>, 42, 'having it in there';
    ok %h<a><b> =:= $b, 'check binding';
}

{
    my %h;
    my $b = \(%h<a><b>);
    is %h.keys.elems, 0, 'capturing does not autovivify';
}

{
    my %h;
    foo(%h<a><b>);
    #?niecza todo "https://github.com/sorear/niecza/issues/176"
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
    push    %h<s-push><a>, 1, 2;
    unshift %h<s-unsh><b>, 3, 4;
    append  %h<s-appe><c>, 5, 6;
    prepend %h<s-prep><d>, 7, 8;
            %h<m-push><1>.push:    <a b c>;
            %h<m-unsh><2>.unshift: <d e f>;
            %h<m-appe><3>.append:  <g h i>;
            %h<m-prep><4>.prepend: <j k l>;

    is %h.keys.elems, 8, 'successfully autovivified lower level';

    subtest 'can autovivify in...' => {
        plan 2;
        subtest '...sub form of...' => {
            plan 4;
            is-deeply %h<s-push><a>, [  1,  2  ], 'push';
            is-deeply %h<s-unsh><b>, [  3,  4  ], 'unshift';
            is-deeply %h<s-appe><c>, [  5,  6  ], 'append';
            is-deeply %h<s-prep><d>, [  7,  8  ], 'prepend';
        }
        subtest '...method form of...' => {
            plan 4;
            is-deeply %h<m-push><1>, [ <a b c>,], 'push';
            is-deeply %h<m-unsh><2>, [ <d e f>,], 'unshift';
            is-deeply %h<m-appe><3>, [|<g h i> ], 'append';
            is-deeply %h<m-prep><4>, [|<j k l> ], 'prepend';
        }
    }
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
