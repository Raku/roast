use v6;

use Test;

# L<S32::Containers/Array/=item end>

=begin docs

Array .end tests
=end docs

plan 14;

# basic array .end tests

{ # invocant style
    my @array;
    is(@array.end, -1, 'we have an empty array');

    @array = 1...43;
    is(@array.end, 42, 'index of last element is 42 after assignment');

    @array.pop;
    is(@array.end, 41, 'index of last element is 41 after pop');

    @array.shift;
    is(@array.end, 40, 'index of last element is 40 after shift');

    @array.unshift('foo');
    is(@array.end, 41, 'index of last element is 41 after unshift');

    @array.push('bar');
    is(@array.end, 42, 'index of last element is 42 after push');
}

{ # non-invocant style
    my @array;
    is(end(@array), -1, 'we have an empty array');

    @array = (1...43);
    is(end(@array), 42, 'index of last element is 42 after assignment');

    @array.pop;
    is((end @array), 41, 'index of last element is 41 after pop');

    shift @array;
    is((end @array), 40, 'index of last element is 40 after shift');

    unshift @array, 'foo';
    is(end(@array), 41, 'index of last element is 41 after unshift');

    push @array, 'bar';
    is(end(@array), 42, 'index of last element is 42 after push');
}

is  3.end, 0,  'Scalars look like wrapped in a single-item list';

# test some errors
{
    eval_dies_ok ' end() ', '... end() dies without an argument';
}
#vim: ft=perl6
