use v6;
use Test;

# L<S32::Containers/"Array"/"=item unshift">

=begin description

Unshift tests

=end description

plan 57;

# basic unshift tests

{
    my @unshift = ();

    is(+@unshift, 0, 'we have an empty array');

    unshift(@unshift, 1);
    is(+@unshift, 1, 'we have 1 element in the array');
    is(@unshift[0], 1, 'we found the right element');

    unshift(@unshift, 2);
    is(+@unshift, 2, 'we have 2 elements in the array');
    is(@unshift[0], 2, 'we found the right element');
    is(@unshift[1], 1, 'we found the right element');

    unshift(@unshift, 3);
    is(+@unshift, 3, 'we have 3 element in the array');
    is(@unshift[0], 3, 'we found the right element');
    is(@unshift[1], 2, 'we found the right element');
    is(@unshift[2], 1, 'we found the right element');

    unshift(@unshift, 4);
    is(+@unshift, 4, 'we have 4 element in the array');
    is(@unshift[0], 4, 'we found the right element');
    is(@unshift[1], 3, 'we found the right element');
    is(@unshift[2], 2, 'we found the right element');
    is(@unshift[3], 1, 'we found the right element');
}

# try other variations on calling unshift()

{
    my @unshift = ();

    my $val = 100;

    unshift @unshift, $val;
    is(+@unshift, 1, 'we have 1 element in the array');
    is(@unshift[0], $val, 'unshift @array, $val worked');

    @unshift.unshift(200);
    is(+@unshift, 2, 'we have 2 elements in the array');
    is(@unshift[0], 200, '@unshift.unshift(200) works');
    is(@unshift[1], $val, 'unshift @array, $val worked');

    @unshift.unshift(400);
    is(+@unshift, 3, 'we have 3 elements in the array');
    is(@unshift[0], 400, '@unshift.unshift(400) works');
    is(@unshift[1], 200, '@unshift.unshift(200) works');
    is(@unshift[2], $val, 'unshift @array, $val worked');
}

# try unshifting more than one element

{
    my @unshift = ();

    unshift @unshift, (1, 2, 3);
    is(+@unshift, 3, 'we have 3 elements in the array');
    is(@unshift[0], 1, 'got the expected element');
    is(@unshift[1], 2, 'got the expected element');
    is(@unshift[2], 3, 'got the expected element');

    my @val2 = (4, 5);
    unshift @unshift, @val2;
    is(+@unshift, 5, 'we have 5 elements in the array');
    is(@unshift[0], 4, 'got the expected element');
    is(@unshift[1], 5, 'got the expected element');
    is(@unshift[2], 1, 'got the expected element');
    is(@unshift[3], 2, 'got the expected element');
    is(@unshift[4], 3, 'got the expected element');

    unshift @unshift, 6, 7, 8;
    is(+@unshift, 8, 'we have 8 elements in the array');
    is(@unshift[0], 6, 'got the expected element');
    is(@unshift[1], 7, 'got the expected element');
    is(@unshift[2], 8, 'got the expected element');
    is(@unshift[3], 4, 'got the expected element');
    is(@unshift[4], 5, 'got the expected element');
    is(@unshift[5], 1, 'got the expected element');
    is(@unshift[6], 2, 'got the expected element');
    is(@unshift[7], 3, 'got the expected element');
}

# now for the unshift() on an uninitialized array issue
{
    my @unshift;

    unshift @unshift, 42;
    is(+@unshift, 1, 'we have 1 element in the array');
    is(@unshift[0], 42, 'got the element expected');

    unshift @unshift, 2000;
    is(+@unshift, 2, 'we have 2 elements in the array');
    is(@unshift[0], 2000, 'got the element expected');
    is(@unshift[1], 42, 'got the element expected');
}

# testing some edge cases
{
    my @unshift = 0 ... 5;
    is(+@unshift, 6, 'starting length is 6');

    unshift(@unshift);
    is(+@unshift, 6, 'length is still 6');

    @unshift.push();
    is(+@unshift, 6, 'length is still 6');
}

# testing some error cases
{
    eval_dies_ok('unshift()    ', 'unshift() requires arguments');
    eval_dies_ok('42.unshift(3)', '.unshift should not work on scalars');
}

# Push with Inf arrays (waiting on answers to perl6-compiler email)
# {
#     my @unshift = 1 .. Inf;
#     # best not to uncomment this it just go on forever
#     todo_throws_ok { 'unshift @unshift, 10' }, '?? what should this error message be ??', 'cannot unshift onto a Inf array';
# }

# RT #69548
{
     my $x = 1;
     my @a = ();
     unshift @a, $x;
     ++$x;

     is @a[0], 1, 'New element created by unshift(@a, $x) isn\'t affected by changes to $x';
}

# RT #69548
{
    my $x = 1;
    my @a = ();
    unshift @a, $x;
    ++@a[0];

    is $x, 1, '$x isn\'t affected by changes to new element created by unshift(@a, $x)';
}

{
    my @a = <b c>;
    @a.unshift(0);
    is @a.join(','), '0,b,c', 'can unshift an element that boolifies to False';
}


# RT 119061
#?niecza todo "https://github.com/sorear/niecza/issues/184"
{
    my Int @a;
    dies_ok( { @a.unshift: "a" }, "cannot unshift strings onto in Int array" );
}

# vim: ft=perl6
