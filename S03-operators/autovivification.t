use Test;
plan 23;

# L<S03/Assignment operators/>

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

{
    my $x;
    $x = $x + 1i;
    is_approx($x, 0 + 1i, 'my $x; $x = $x + 1i; works');
}

{
    my $x;
    $x += 1i;
    is_approx($x, 0 + 1i, 'my $x; $x += 1i; works');
}

{
    my $i **= $i;
    is $i, 1, 'my $i **= $i';
}

{
    my $x;
    $x *= 1i;
    is_approx($x, 1i, 'my $x; $x *= 1i works');
}

# L<S03/Assignment operators/"If you apply an assignment operator to a
# container">
{
    # yes, this is serious. It's in the specs ;-)
    my Int $x;
    $x *= 5;
    is $x, 5, '*= autovivifies with correct neutral element (with Num proto)';
}

{
    my $x;
    $x *= 5;
    is $x, 5, '*= autovivifies with correct neutral element (without type constraint)';
}

{
    my Int %h;
    is  (%h<foo> *= 23), 23, '*= autovivifies with correct neutral element (with Int proto on hash items)';
}

{
    my %h;
    is  (%h<foo> *= 23), 23, '*= autovivifies with correct neutral element (without proto on hash items)';
}

{
    my @empty;
    is +@empty, 0, 'Sanity: empty array, @empty, has 0 elements'; 

    my $before =  @empty.perl;
    @empty[5] ~~ /nothing/;
    my $after = @empty.perl;

    #?pugs 2 todo 'bugs'
    is +@empty,0,'empty array, @empty, has 0 elements';

    is $after,$before,"Array elements are not auto-vivified by smartmatch";
}

# vim: ft=perl6
