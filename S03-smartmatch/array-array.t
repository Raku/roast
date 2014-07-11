use v6;
use Test;
plan 36;

#L<S03/Smart matching/arrays are comparable>
{
    ok((("blah", "blah") ~~ ("blah", "blah")), "qw/blah blah/ .eq");
    ok(!((1, 2) ~~ (1, 1)), "1 2 !~~ 1 1");
    ok(!((1, 2, 3) ~~ (1, 2)), "1 2 3 !~~ 1 2");
    ok(!((1, 2) ~~ (1, 2, 3)), "1 2 !~~ 1 2 3");
    ok(!([] ~~ [1]), "array smartmatch boundary conditions");
    ok(!([1] ~~ []), "array smartmatch boundary conditions");
    ok(([] ~~ []), "array smartmatch boundary conditions");
    ok(([1] ~~ [1]), "array smartmatch boundary conditions");
    #?niecza todo
    ok((1,2,3,4) ~~ (1,*), 'array smartmatch dwims * at end');
    #?niecza todo
    ok((1,2,3,4) ~~ (1,*,*), 'array smartmatch dwims * at end (many *s)');
    #?niecza todo
    ok((1,2,3,4) ~~ (*,4), 'array smartmatch dwims * at start');
    #?niecza todo
    ok((1,2,3,4) ~~ (*,*,4), 'array smartmatch dwims * at start (many *s)');
    #?niecza todo
    ok((1,2,3,4) ~~ (1,*,3,4), 'array smartmatch dwims * 1 elem');
    #?niecza todo
    ok((1,2,3,4) ~~ (1,*,*,3,4), 'array smartmatch dwims * 1 elem (many *s)');
    #?niecza todo
    ok((1,2,3,4) ~~ (1,*,4), 'array smartmatch dwims * many elems');
    #?niecza todo
    ok((1,2,3,4) ~~ (1,*,*,4), 'array smartmatch dwims * many elems (many *s)');
    #?niecza todo
    ok((1,2,3,4) ~~ (*,3,*), 'array smartmatch dwims * at start and end');
    #?niecza todo
    ok((1,2,3,4) ~~ (*,*,3,*,*), 'array smartmatch dwims * at start and end (many *s)');
    #?niecza todo
    ok((1,2,3,4) ~~ (*,1,2,3,4), 'array smartmatch dwims * can match nothing at start');
    #?niecza todo
    ok((1,2,3,4) ~~ (*,*,1,2,3,4), 'array smartmatch dwims * can match nothing at start (many *s)');
    #?niecza todo
    ok((1,2,3,4) ~~ (1,2,*,3,4), 'array smartmatch dwims * can match nothing in middle');
    #?niecza todo
    ok((1,2,3,4) ~~ (1,2,*,*,3,4), 'array smartmatch dwims * can match nothing in middle (many *s)');
    #?niecza todo
    ok((1,2,3,4) ~~ (1,2,3,4,*), 'array smartmatch dwims * can match nothing at end');
    #?niecza todo
    ok((1,2,3,4) ~~ (1,2,3,4,*,*), 'array smartmatch dwims * can match nothing at end (many *s)');
    ok(!((1,2,3,4) ~~ (1,*,3)), '* dwimming does not cause craziness');
    ok(!((1,2,3,4) ~~ (*,5)), '* dwimming does not cause craziness');
    ok(!((1,2,3,4) ~~ (1,3,*)), '* dwimming does not cause craziness');

    # now try it with arrays as well
    my @a = 1, 2, 3;
    my @b = 1, 2, 4;
    my @m = (*, 2, *); # m as "magic" ;-)

    ok (@a ~~  @a), 'Basic smartmatching on arrays (positive)';
    ok (@a !~~ @b), 'Basic smartmatching on arrays (negative)';
    ok (@b !~~ @a), 'Basic smartmatching on arrays (negative)';
    #?niecza todo
    ok (@a ~~  @m), 'Whatever dwimminess in arrays';
    ok (@a ~~ (1, 2, 3)), 'smartmatch Array ~~ List';
    ok ((1, 2, 3) ~~ @a), 'smartmatch List ~~ Array';
    #?niecza todo
    ok ((1, 2, 3) ~~ @m), 'smartmatch List ~~ Array with dwim';

    ok (1 ~~ *,1,*),     'smartmatch with Array RHS co-erces LHS to list';
    ok (1..10 ~~ *,5,*), 'smartmatch with Array RHS co-erces LHS to list';
}

done;

# vim: ft=perl6
