use v6;
use Test;
plan 6;

# L<S32::Containers/"Array"/"=item ">

=begin pod

built-in "Array" tests

=end pod

my $array_obj = Array.new(4, 5, 6);
is($array_obj.WHAT.gist, Array.gist, 'Creating a new list object with new works.');
is($array_obj, list(4, 5, 6), 'The list object contains the right values.');
is(+$array_obj, 3, 'Finding the length functions properly.');

{
    use lib "t/spec/packages";
    use Test::Util;
    ok +Array[Int].new(1, 2, 3, 4), "typed array";
    throws_like(q{ Array[Int].new(1, 2, "Foo") }, X::TypeCheck);
    throws_like(q{ Array[Str].new(1, 2, "Foo") }, X::TypeCheck);
}

done;

# vim: ft=perl6
