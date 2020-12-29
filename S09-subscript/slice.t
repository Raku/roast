use v6;
use Test;

# L<S09/Subscript and slice notation>
# (Could use an additional smart link)

=begin pod

Testing array slices.

=end pod

plan 35;

{   my @array = (3,7,9,11);

    is-deeply(@array[0,1,2], (3,7,9),   "basic slice");
    is-deeply(@array[(0,1,2)], (3,7,9), "basic slice, explicit list");

    is-deeply(@array[0,0,2,1,1,2], (3, 3, 9, 7, 7, 9),
      "basic slice, duplicate indices");

    my @slice = (1,2);

    is-deeply(@array[@slice], (7,9),      "slice from array, part 2");
    is-deeply(@array[@slice[1]], (9),     "slice from array slice, part 1");
    is-deeply(@array[@slice[0,1]], (7,9), "slice from array slice, part 2");
    is-deeply(@array[0..1], (3,7),	   "range from array");
    # https://github.com/rakudo/rakudo/issues/2185
    is-deeply(@array[0,(1,2)], (3,(7,9)),	   "nested slice");
    is-deeply(@array[0,1..2], (3,(7,9)),	   "slice plus range from array");
    is-deeply(@array[0..1,2,3], ((3,7),9,11), "range plus slice from array");
    is-deeply(@array[0...3], (3,7,9,11),  "finite sequence slice");
    is-deeply(@array[0...*], (3,7,9,11),  "infinite sequence slice");
    is-deeply(@array[0,2...*], (3,9),     "infinite even sequence slice");
    is-deeply(@array[1,3...*], (7,11),    "infinite even sequence slice");
}

# Behaviour assumed to be the same as Perl
{   my @array  = <a b c d>;
    my @slice := @array[1,2];
    is ~(@slice = <A B C D>), "A B",
        "assigning a slice too many items yields a correct return value";
}

# Slices on array literals
{   is ~(<a b c d>[1,2]),   "b c", "slice on array literal";
    is ~([<a b c d>][1,2]), "b c", "slice on arrayitem literal";
}

# Calculated slices
{   my @array = (3,7,9);
    my %slice = (0=>3, 1=>7, 2=>9);
    is((3,7,9), [@array[%slice.keys].sort],    "values from hash keys, part 1");
    is((3,7,9), [@array[%slice.keys.sort]],    "values from hash keys, part 2");
    is((3,7,9), [@array[(0,1,1) >>+<< (0,0,1)]], "calculated slice: hyperop");
}


# slices with empty ranges
{
    my @array = 1, 2, 3;
    my @other = @array[2..1];
    is +@other, 0, '@array[2..1] is an empty slice';
}

# https://github.com/Raku/old-issue-tracker/issues/556
#?rakudo skip '*..* does not slice'
{
    eval-lives-ok '(0,1)[ * .. * ]', 'Two Whatever stars slice lives';
    is EVAL('(0,1)[ * .. * ]'), [0, 1], 'Two Whatever stars slice';
}

# https://github.com/Raku/old-issue-tracker/issues/676
{
    my @array = <1 2 3>;
    isa-ok @array, Array;
    ok @array[0..1] ~~ Positional;

    ok @array[0..0] ~~ Positional, 'slice with one element is a list';
    my $zero = 0;
    ok @array[$zero..$zero] ~~ Positional,
           'slice with one element specified by variables';
}

# https://github.com/Raku/old-issue-tracker/issues/2614
{
    my @a1 = 1,2,3,4, 5;
    my @a2 = @a1[2 ..^ @a1];
    my @a3 = @a2[1..^ @a2];
    is @a3.join('|'), '4|5', 'can use 1..^@a for subscripting';
}

# https://github.com/Raku/old-issue-tracker/issues/3251
#?rakudo skip '.= with non-identifier postfixes'
{
    my @a = 42..50;
    is @a .= [1,2], (43,44), 'did we return right slice';;
    is @a, (43,44), 'did we assign slice ok';
}

# https://github.com/Raku/old-issue-tracker/issues/3643
{
    my $b = Buf.new(0, 0);
    $b[0, 1] = 2, 3;
    is-deeply $b, Buf.new(2, 3), 'can assign to a Buf slice';
}

# https://github.com/Raku/old-issue-tracker/issues/6419
{
    my %h;
    %h<a> = ('1','3','4');
    is-deeply %h<a>[*], ('1', '3', '4'), '[*] slice returns all elements of a list of hash value';
}

# https://github.com/rakudo/rakudo/issues/1320
subtest 'no "drift" when re-using lazy iterable for indexing' => {
    plan 3;
    my @a = <a b>;
    my @idx := (0…*).cache;
    is-deeply gather {@a[@idx].take xx 10}, @a.List xx 10,
        'more indexes than els';

    my @idx2 := (lazy 1,).cache;
    is-deeply gather {@a[@idx2].take xx 10}, (@a[1],) xx 10,
        'fewer indexes than els';

    my @idx3 := 0, 1, 2, |(lazy 3, 4), 5, 6;
    is-deeply <a b>[@idx3], <a b>,
        'lazy iterable with iterator starting non-lazy';
}

# https://github.com/rakudo/rakudo/issues/2872
subtest 'infinite ranges and whatever stars' => {
    plan 6;
    is-deeply (^3)[0 ..  Inf],       (0, 1, 2), 'Inf range inclusive';
    is-deeply (^3)[0 ..^ Inf],       (0, 1, 2), 'Inf range exclusive';
    is-deeply (^3)[0 ..  *],         (0, 1, 2), 'Whatever range inclusive';
    is-deeply (^3)[0 ..^ *],         (0, 1, 2), 'Whatever range exclusive';
    is        (^3)[*-1],             2,         'Whatever callable';
    is        (^3)[{ $^elems - 1 }], 2,         'Callable';
}

# https://github.com/Raku/old-issue-tracker/issues/6233
subtest 'nested slices' => {
    plan 5;
    is-deeply ("a".."z")[(3, (4, (5,)))],    ("d", ("e", ("f",))),                'Nested slice, no adverbs';
    is-deeply ("a".."z")[(3, (4, (5,)))]:p,  (3 => "d", (4 => "e", (5 => "f",))), 'Nested slice, p adverb';
    is-deeply ("a".."z")[(3, (4, (5,)))]:k,  (3, (4, (5,))),                      'Nested slice, k adverb';
    is-deeply ("a".."z")[(3, (4, (5,)))]:v,  ("d", ("e", ("f",))),                'Nested slice, v adverb';
    is-deeply ("a".."z")[(3, (4, (5,)))]:kv, (3, "d", (4, "e", (5, "f"))),        'Nested slice, kv adverb';
}

# vim: expandtab shiftwidth=4
