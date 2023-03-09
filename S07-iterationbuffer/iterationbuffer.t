use Test;

plan 34;

isa-ok (my $ib := IterationBuffer.new), IterationBuffer;
is $ib.elems, 0, 'no elements';
is-deeply $ib.AT-POS(0), Mu, 'element 0 uninitialized';

is-deeply $ib.push(42), 42, 'was the value 42 returned';
is $ib.elems, 1, 'one element';
is-deeply $ib.AT-POS(0), 42, 'element initialized';

is-deeply $ib.unshift(666), 666, 'was the value 666 returned';
is $ib.elems, 2, 'two elements';
is-deeply $ib.AT-POS(0), 666, 'element initialized';
is-deeply $ib.AT-POS(1), 42, 'element moved';

is-deeply $ib.BIND-POS(2, 137), 137, 'was the value 137 returned';
is $ib.elems, 3, 'three elements';
is-deeply $ib.AT-POS(0), 666, 'element stayed';
is-deeply $ib.AT-POS(1), 42, 'element stayed';
is-deeply $ib.AT-POS(2), 137, 'element initialized';

is-deeply $ib.List, (666,42,137), 'coercion to List ok';
is-deeply $ib.Slip, (666,42,137).Slip, 'coercion to Slip ok';
is-deeply $ib.Seq, (666,42,137).Seq, 'coercion to Seq ok';

isa-ok (my $ib2 := IterationBuffer.new(<a b c>)), IterationBuffer;
is-deeply $ib2.List, <a b c>, 'did it get initialized properly';
is $ib2.elems, 3, 'three elements';

is-deeply $ib.append($ib2), $ib, 'appending returns invocant';
is $ib.elems, 6, 'six elements';
is-deeply $ib.List, (666,42,137,"a","b","c"), 'appended properly';
is $ib2.elems, 3, 'three elements unchanged';
is-deeply $ib2.List, <a b c>, 'original unchanged';

is-deeply $ib.prepend($ib2), $ib, 'prepending returns invocant';
is $ib.elems, 9, 'nine elements';
is-deeply $ib.List, ("a","b","c",666,42,137,"a","b","c"), 'prepended properly';
is $ib2.elems, 3, 'three elements unchanged';
is-deeply $ib2.List, <a b c>, 'original unchanged';

is-deeply $ib.clear, Nil, 'resetting returns Nil';
is $ib.elems, 0, 'no elements';
is-deeply $ib2.List, <a b c>, 'original unchanged';

# vim: expandtab shiftwidth=4
