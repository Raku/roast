use Test;
plan 19;

# L<S03/Assignment metaoperators/>

{
    my $x;
    $x++;
    ok $x == 1, 'my $x; $x++ works'
}

{
    my Int $x;
    $x++;
    ok $x == 1, 'my Int $x; $x++ works'
}

{
    my $x;
    $x += 1;
    ok $x == 1, 'my $x; $x += 1 works'
}

{
    my Int $x;
    $x += 1;
    ok $x == 1, 'my Int $x; $x += 1 works'
}

{
    my $x;
    $x -= 1;
    ok $x == -1, 'my $x; $x -= 1 works'
}

{
    my Int $x;
    $x -= 1;
    ok $x == -1, 'my Int $x; $x -= 1 works'
}

{
    my $s;
    $s ~= 'ab';
    is $s, 'ab', 'my $s; $s ~= "ab" works'
}

{
    my Str $s;
    $s ~= 'ab';
    is $s, 'ab', 'my Str $s; $s ~= "ab" works'
}

{
    my $x;
    $x *= 2;
    ok $x == 2, 'my $x; $x *= 2 works'
}

{
    my $x;
    $x **= 2;
    ok $x == 1, 'my $x; $x **= 2 works'
}

{
    my Int $x;
    $x *= 2;
    ok $x == 2, 'my Int $x; $x *= 2 works'
}

{
    my Int $x;
    $x **= 2;
    ok $x == 1, 'my Int $x; $x **= 2 works'
}

# http://rt.perl.org/rt3/Ticket/Display.html?id=59982
#?rakudo skip 'RT #59982 (scalar autoviv. with Complex numbers)'
{
    my $x;
    $x = $x + 1i;
    ok $x == 0 + 1i, 'my $x; $x = $x + 1i; works';
}

{
    my $x;
    $x += 1i;
    ok $x == 0 + 1i, 'my $x; $x += 1i; works';
}

{
    my $x;
    $x *= 1i;
    ok $x == 1i, 'my $x; $x *= 1i works';
}

# L<S03/Assignment metaoperators/"If you apply an assignment operator to a
# protoobject">
{
    # yes, this is serious. It's in the specs ;-)
    my Num $x;
    $x *= 5;
    is $x, 5, '*= autovivifies with correct neutral element (with Num proto)';
}

{
    my $x;
    $x *= 5;
    is $x, 5, '*= autovivifies with correct neutral element (without type constraint)';
}

#?rakudo skip 'type constraint on hashes'
{
    my Int %h;
    is  (%h<foo> *= 23), 23, '*= autovivifies with correct neutral element (with Int proto on hash items)';
}

{
    my %h;
    is  (%h<foo> *= 23), 23, '*= autovivifies with correct neutral element (without proto on hash items)';
}
# vim: ft=perl6
