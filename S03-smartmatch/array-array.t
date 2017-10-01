use v6;
use Test;
plan 69;

#L<S03/Smart matching/arrays are comparable>
{
    ok((("blah", "blah") ~~ ("blah", "blah")), "qw/blah blah/ .eq");
    ok(!((1, 2) ~~ (1, 1)), "1 2 !~~ 1 1");
    ok(!((1, 2, 3) ~~ (1, 2)), "1 2 3 !~~ 1 2");
    ok(!((1, 2) ~~ (1, 2, 3)), "1 2 !~~ 1 2 3");
    ok(!([] ~~ [1]), "list smartmatch boundary conditions");
    ok(!([1] ~~ []), "list smartmatch boundary conditions");
    ok(([] ~~ []), "list smartmatch boundary conditions");
    ok(([1] ~~ [1]), "list smartmatch boundary conditions");
    ok((1,2,3,4) ~~ (1,**), 'list smartmatch dwims ** at end');
    ok((1,2,3,4) ~~ (1,**,**), 'list smartmatch dwims ** at end (many *s)');
    ok((1,2,3,4) ~~ (**,4), 'list smartmatch dwims ** at start');
    ok((1,2,3,4) ~~ (**,**,4), 'list smartmatch dwims ** at start (many **s)');
    ok((1,2,3,4) ~~ (1,**,3,4), 'list smartmatch dwims ** 1 elem');
    ok((1,2,3,4) ~~ (1,**,**,3,4), 'list smartmatch dwims ** 1 elem (many **s)');
    ok((1,2,3,4) ~~ (1,**,4), 'list smartmatch dwims ** many elems');
    ok((1,2,3,4) ~~ (1,**,**,4), 'list smartmatch dwims ** many elems (many **s)');
    ok((1,2,3,4) ~~ (**,3,**), 'list smartmatch dwims ** at start and end');
    ok((1,2,3,4) ~~ (**,**,3,**,**), 'list smartmatch dwims ** at start and end (many **s)');
    ok((1,2,3,4) ~~ (**,1,2,3,4), 'list smartmatch dwims ** can match nothing at start');
    ok((1,2,3,4) ~~ (**,**,1,2,3,4), 'list smartmatch dwims ** can match nothing at start (many **s)');
    ok((1,2,3,4) ~~ (1,2,**,3,4), 'list smartmatch dwims ** can match nothing in middle');
    ok((1,2,3,4) ~~ (1,2,**,**,3,4), 'list smartmatch dwims ** can match nothing in middle (many **s)');
    ok((1,2,3,4) ~~ (1,2,3,4,**), 'list smartmatch dwims ** can match nothing at end');
    ok((1,2,3,4) ~~ (1,2,3,4,**,**), 'list smartmatch dwims ** can match nothing at end (many **s)');
    ok(!((1,2,3,4) ~~ (1,**,3)), '** dwimming does not cause craziness');
    ok(!((1,2,3,4) ~~ (**,5)), '** dwimming does not cause craziness');
    ok(!((1,2,3,4) ~~ (1,3,**)), '** dwimming does not cause craziness');

    # now try it with arrays as well
    my @a = 1, 2, 3;
    my @b = 1, 2, 4;
    my @m = (**, 2, **); # m as "magic" ;-)

    ok (@a ~~  @a), 'Basic smartmatching on arrays (positive)';
    ok (@a !~~ @b), 'Basic smartmatching on arrays (negative)';
    ok (@b !~~ @a), 'Basic smartmatching on arrays (negative)';
    ok (@a ~~  @m), 'Whatever dwimminess in arrays';
    ok (@a ~~ (1, 2, 3)), 'smartmatch Array ~~ List';
    ok ((1, 2, 3) ~~ @a), 'smartmatch List ~~ Array';
    ok ((1, 2, 3) ~~ @m), 'smartmatch List ~~ Array with dwim';

    ## the next test is bogus, since ~~ has a tighter precendence than comma
    ## with rakudo 2016.08.1-194-g0cf7128 there is no coercion to list
    ## when using parentheses: 1 ~~ (**,1,**) returns False
    ## cmp. http://irclog.perlgeek.de/perl6/2016-09-15#i_13217141
    ## TODO modify test to whatever the answer to "is the LHS coerced" is
    ok (1 ~~ **,1,**),     'smartmatch with Array RHS co-erces LHS to list';
    ok (1..10 ~~ (**,5,**)), 'smartmatch with List RHS co-erces LHS to list';

    # now test that each element does smartmatching
    ok(((<blah blah>) ~~ (/^bl/, /ah$/)), "smartmatch regex");
    ok(((<blah blah>) ~~ (Str, Cool)), "smartmatch types");
    ok((<1 2.3 4.5e6 7+8i> ~~ (Int, Rat, Num, Complex)), "smartmatch numeric types");
    ok((<1 2.3 4.5e6 7+8i> ~~ (Str, Str, Str, Str)), "smartmatch allomorphic types");
    ok(!((1, 2) ~~ (*, 1)), "1 2 !~~ * 1");
    ok(!((1, 2, 3) ~~ (*, *)), "1 2 3 !~~ * *");
    ok(!((1, 2) ~~ (*, *, 3)), "1 2 !~~ * * 3");
    ok(!([] ~~ [*]), "list smartmatch boundary conditions");
    ok(!([1] ~~ [slip]), "list smartmatch boundary conditions");
    ok(([] ~~ [slip]), "list smartmatch boundary conditions");
    ok(([1] ~~ [*]), "list smartmatch boundary conditions");
    ok((1,2,3,4) ~~ (*,**), 'list smartmatch dwims ** at end');
    ok((1,2,3,4) ~~ (*,**,**), 'list smartmatch dwims ** at end (many *s)');
    ok((1,2,3,4) ~~ (**,*), 'list smartmatch dwims ** at start');
    ok((1,2,3,4) ~~ (**,**,*), 'list smartmatch dwims ** at start (many **s)');
    ok((1,2,3,4) ~~ (1,**,3,*), 'list smartmatch dwims ** 1 elem');
    ok((1,2,3,4) ~~ (1,**,**,3,{ $_ > 3}), 'list smartmatch dwims ** 1 elem (many **s)');
    ok((1,2,3,4) ~~ (*,**,4), 'list smartmatch dwims ** many elems');
    ok((1,2,3,4) ~~ (Numeric,**,**,Cool), 'list smartmatch dwims ** many elems (many **s)');
    ok((1,2,3,4) ~~ (**,* == 3,**), 'list smartmatch dwims ** at start and end');
    ok((1,2,3,4) ~~ (**,**,/3/,**,**), 'list smartmatch dwims ** at start and end (many **s)');
    ok((1,2,3,4) ~~ (**,1,|((* > 1) xx 3)), 'list smartmatch dwims ** can match nothing at start');
    ok((1,2,3,4) ~~ (**,**,*,2,3,4), 'list smartmatch dwims ** can match nothing at start (many **s)');
    ok((1,2,3,4) ~~ (1,2,**,3,4), 'list smartmatch dwims ** can match nothing in middle');
    ok((1,2,3,4) ~~ (1,*,**,**,*,4), 'list smartmatch dwims ** can match nothing in middle (many **s)');
    ok((1,2,3,4) ~~ (1,2,3,*,**), 'list smartmatch dwims ** can match nothing at end');
    ok((1,2,3,4) ~~ (*,*,*,4,**,**), 'list smartmatch dwims ** can match nothing at end (many **s)');
    ok(!((1,2,3,4) ~~ (*,**,3)), '** dwimming does not cause craziness');
    ok(!((1,2,3,4) ~~ (**,* == 5)), '** dwimming does not cause craziness');
    ok(!((1,2,3,4) ~~ (1,/3/,**)), '** dwimming does not cause craziness');

}

# RT#123144
{
    eval-lives-ok '["a","b","c"] ~~ [**, "b", "c"]', "Str and Whatever (1)";
    eval-lives-ok '[1,2,3] ~~ [**, "b", "c"]', "Str and Whatever (2)";
}

subtest '~~ with lazy iterables never throws' => {
    plan 4;
    is-deeply [1...*] ~~ (1...*), False, 'lazy ~~ lazy is False';
    is-deeply [1, 2 ] ~~ [1...*], False, 'non-lazy ~~ lazy is False';
    is-deeply [1...*] ~~ [1, 2 ], False, 'lazy ~~ non-lazy is False';

    my $iter := [1...*];
    is-deeply $iter ~~ $iter, True, 'lazy ~~ lazy is True when same object';
}

# vim: ft=perl6
