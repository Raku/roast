use Test;
plan 16;

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

#?rakudo todo 'default value for infix:<*=>'
{
    my Int $x;
    $x *= 2;
    ok $x == 0, 'my Int $x; $x *= 2 works'
}

#?rakudo todo 'default value for infix:<*=>'
{
    my Int $x;
    $x **= 2;
    ok $x == 0, 'my Int $x; $x **= 2 works'
}

# L<S03/Assignment metaoperators/"If you apply an assignment operator to a
# protoobject">
#?rakudo skip 'treat Int as conforming to Num'
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

#?rakudo skip 'get_iter() not implemented in class Integer'
{
    my Int %h;
    is  (%h<foo> *= 23), 23, '*= autovivifies with correct neutral element (with Int proto on hash items)';
}

{
    my %h;
    is  (%h<foo> *= 23), 23, '*= autovivifies with correct neutral element (without proto on hash items)';
}
# vim: ft=perl6
