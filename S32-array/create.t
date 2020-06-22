use v6;
use Test;
plan 12;

# L<S32::Containers/"Array"/"=item ">

=begin pod

built-in "Array" tests

=end pod

my $array_obj = Array.new(4, 5, 6);
is($array_obj.WHAT.gist, Array.gist, 'Creating a new list object with new works.');
is($array_obj, list(4, 5, 6), 'The list object contains the right values.');
is(+$array_obj, 3, 'Finding the length functions properly.');

{
    ok +Array[Int].new(1, 2, 3, 4), "typed array";
    throws-like(q{ Array[Int].new(1, 2, "Foo") }, X::TypeCheck);
    throws-like(q{ Array[Str].new(1, 2, "Foo") }, X::TypeCheck);
}

{ # coverage; 2016-09-21
    is-deeply circumfix:<[ ]>(), [], 'circumfix:<[ ]>() creates Array';
    is-deeply [],                [], '[ ] creates Array';
}

# https://github.com/Raku/old-issue-tracker/issues/6009
eval-lives-ok ｢
       (1,2,3).Array[0]++ == 1 or die;
    ++((1,2,3).Array[1])  == 3 or die;
｣, 'array elements get writable containers';

# https://github.com/Raku/old-issue-tracker/issues/5706
{ 
    subtest 'Array.clone [partially-reified]' => {
        plan 7;

        my @a = 1, {rand} … *;
        my @b = @a.clone;
        is-deeply @a[^20], @b[^20], 'clone and original array share reifier';

        @b[5] = 42;
        cmp-ok @a[5], '!=', 42, 'changing clone does not impact original';
        @a[3] = 72;
        cmp-ok @b[3], '!=', 72, 'changing original does not impact clone';

        @a.unshift: 100;    is-deeply @b[0], 1,   'unshifting original';
        @b.unshift: 200;    is-deeply @a[0], 100, 'unshifting clone';
        @a.shift;           is-deeply @b[0], 200, 'shifting original';
        @b.shift; @b.shift; is-deeply @a[0], 1,   'shifting clone';
    }

    subtest 'Array.clone [fully-reified]' => {
        plan 9;

        my @a = 1, 2, 3, 4;
        my @b = @a.clone;
        is-deeply @a, @b, 'clone and original array have same values';

        @b[3] = 42;
        cmp-ok @a[3], '!=', 42, 'changing clone does not impact original';
        @a[2] = 72;
        cmp-ok @b[2], '!=', 72, 'changing original does not impact clone';

        @b.push: 42;        is-deeply +@b, 1+@a, 'pushing to clone';
        @a.append: 42, 72;  is-deeply +@a, 1+@b, 'pushing to original';
        @a.unshift: 100;    is-deeply @b[0], 1,   'unshifting original';
        @b.unshift: 200;    is-deeply @a[0], 100, 'unshifting clone';
        @a.shift;           is-deeply @b[0], 200, 'shifting original';
        @b.shift; @b.shift; is-deeply @a[0], 1,   'shifting clone';
    }

    is-deeply Array.clone, Array, 'Array:U clone gives an Array:U';
}

# vim: expandtab shiftwidth=4
