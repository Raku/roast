use v6;

use Test;

plan 19;

# L<S32::Containers/Classes and Roles/"=item Buf">

=begin pod

Tests of Buf/Blob roles

=end pod

{ # coverage; 2016-09-26

like Blob.new(<1 2 3>).WHICH, /^ 'Blob'/, ‘.WHICH indicates it's a Blob’;
is-deeply Blob.new(array[int].new: 1, 2, 3), Blob.new(1,2,3),
    'can construct a Blob from native int array';

throws-like { Blob.allocate: 42, 'you shall not pass!' }, X::TypeCheck,
    'illegal arguments to .allocate throw useful error';

subtest 'Blob.allocate works when allocating from...' => {
    plan 3;
    is-deeply Blob.allocate(10, array[int].new: 1, 2, 3),
        Blob.new(1,2,3,1,2,3,1,2,3,1), 'native int array';
    is-deeply Blob.allocate(10, <1 2 3>),
        Blob.new(1,2,3,1,2,3,1,2,3,1), 'list of values';
    is-deeply Blob.allocate(10, Blob.new: 1, 2, 3),
        Blob.new(1,2,3,1,2,3,1,2,3,1), 'another Blob';
}

is Blob.elems,                1, 'Blob:U has 1 elems';
is Blob.new(<1 2 3>).Numeric, 3, '.Numeric gives  number of elements';
is Blob.new(<1 2 3>).Int,     3, '.Int gives  number of elements';

throws-like { Blob.new.chars }, X::Buf::AsStr, :method<chars>,
    'attempting to call .chars throws';

is  Blob.new(<1 2 3>).gist, 'Blob:0x<01 02 03>', 'gist gives useful value';
is-deeply Blob.new(<1 2 3>).reverse, Blob.new(<3 2 1>),
    '.reverse gives reversed Blob';

is Blob.encoding, Any, 'default provided .encoding gives (Any)';

subtest 'Buf.pop' => {
    plan 3;
    my $b = Buf.new: <42 72 13>;
    is $b.pop, 13, 'popped value is correct';
    is-deeply $b, Buf.new(<42 72>), 'resultant Buf is correct';

    throws-like { Buf.new.pop }, X::Cannot::Empty,
        :action<pop>, :what<Buf>,
    'popping empty Buf throws';
}

subtest 'Buf.shift' => {
    plan 3;
    my $b = Buf.new: <42 72 13>;
    is $b.shift, 42, 'shifted value is correct';
    is-deeply $b, Buf.new(<72 13>), 'resultant Buf is correct';

    throws-like { Buf.new.shift }, X::Cannot::Empty,
        :action<shift>, :what<Buf>,
    'shifting on empty Buf throws';
}

subtest 'Buf.splice' => {
    plan 1;
    subtest '.splice()' => {
        plan 2;
        my $b = Buf.new: <42 72 13>;
        is-deeply $b.splice, Buf.new(<42 72 13>), 'returns entire original Buf';
        is-deeply $b, Buf.new, 'resultant Buf is empty';
    }

    # TODO: test all other candidates
}

subtest 'Buf.push' => {
    plan 5;
    my $b;
    my int $i = 2;

    $b = Buf.new: <42 72 13>;
    is-deeply $b.push($i), Buf.new(<42 72 13 2>),
        '.push(int) returns modified Buf';
    is-deeply $b, Buf.new(<42 72 13 2>), 'Buf after .push(int) is right';

    $b = Buf.new: <42 72 13>;
    is-deeply $b.push(Buf.new: <7 1 3>), Buf.new(<42 72 13 7 1 3>),
        '.push(Blob:D) returns modified Buf';
    is-deeply $b, Buf.new(<42 72 13 7 1 3>), 'Buf after .push(Blob:D) is right';

    throws-like { Buf.new.push: 'you shall not pass!' }, X::TypeCheck,
        'illegal arguments to .push throw';
}

subtest 'Buf.append' => {
    plan 5;
    my $b;
    my int $i = 2;

    $b = Buf.new: <42 72 13>;
    is-deeply $b.append($i), Buf.new(<42 72 13 2>),
        '.append(int) returns modified Buf';
    is-deeply $b, Buf.new(<42 72 13 2>), 'Buf after .append(int) is right';

    $b = Buf.new: <42 72 13>;
    is-deeply $b.append(array[int].new: <7 1 3>), Buf.new(<42 72 13 7 1 3>),
        '.append(native int array) returns modified Buf';
    is-deeply $b, Buf.new(<42 72 13 7 1 3>),
        'Buf after .append(native int array) is right';

    throws-like { Buf.new.append: 'you shall not pass!' }, X::TypeCheck,
        'illegal arguments to .append throw';
}

subtest 'Buf.unshift' => {
    plan 5;
    my $b;
    my int $i = 2;

    $b = Buf.new: <42 72 13>;
    is-deeply $b.unshift($i), Buf.new(<2 42 72 13>),
        '.unshift(int) returns modified Buf';
    is-deeply $b, Buf.new(<2 42 72 13>), 'Buf after .unshift(int) is right';

    $b = Buf.new: <42 72 13>;
    is-deeply $b.unshift(Buf.new: <7 1 3>), Buf.new(<7 1 3 42 72 13>),
        '.unshift(Blob:D) returns modified Buf';
    is-deeply $b, Buf.new(<7 1 3 42 72 13>),
        'Buf after .unshift(Blob:D) is right';

    throws-like { Buf.new.unshift: 'you shall not pass!' }, X::TypeCheck,
        'illegal arguments to .unshift throw';
}

subtest 'Buf.prepend' => {
    plan 7;
    my $b;
    my int $i = 2;

    $b = Buf.new: <42 72 13>;
    is-deeply $b.prepend($i), Buf.new(<2 42 72 13>),
        '.prepend(int) returns modified Buf';
    is-deeply $b, Buf.new(<2 42 72 13>), 'Buf after .prepend(int) is right';

    $b = Buf.new: <42 72 13>;
    is-deeply $b.prepend(Buf.new: <7 1 3>), Buf.new(<7 1 3 42 72 13>),
        '.prepend(Blob:D) returns modified Buf';
    is-deeply $b, Buf.new(<7 1 3 42 72 13>),
        'Buf after .prepend(Blob:D) is right';

    $b = Buf.new: <42 72 13>;
    is-deeply $b.prepend(array[int].new: <7 1 3>), Buf.new(<7 1 3 42 72 13>),
        '.prepend(native int array) returns modified Buf';
    is-deeply $b, Buf.new(<7 1 3 42 72 13>),
        'Buf after .prepend(native int array) is right';

    throws-like { Buf.new.prepend: 'you shall not pass!' }, X::TypeCheck,
        'illegal arguments to .unshift throw';
}


} # </coverage; 2016-09-26>

subtest 'arity-1 infix:<~> works on Blobs' => {
    plan 2;
    constant $b = Buf.new: <42 72 13>;
    is-deeply infix:<~>($b), $b, 'arity-1 infix:<~> is unity';
    is-deeply ([~] [$b]),    $b, '[~] works with array with 1 blob';
}

# vim: ft=perl6
