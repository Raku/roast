use v6;
use Test;
plan 39;

#L<S12/Enumerations/"Two built-in enumerations are">

# tests True and False are Bool's
isa_ok(Bool::True, Bool);
isa_ok(Bool::False, Bool);

# tests they keep their Bool'ness when stored
my $a = Bool::True;
isa_ok($a, Bool);

$a = Bool::False;
isa_ok($a, Bool);

# tests that Bool.Bool works
isa_ok (Bool::True).Bool, Bool, "Bool.Bool is a Bool";
isa_ok (Bool::False).Bool, Bool, "Bool.Bool is a Bool";
is (Bool::True).Bool, Bool::True, "Bool.Bool works for True";
is (Bool::False).Bool, Bool::False, "Bool.Bool works for False";

# tests that ?Bool works
isa_ok ?(Bool::True), Bool, "?Bool is a Bool";
isa_ok ?(Bool::False), Bool, "?Bool is a Bool";
is ?(Bool::True), Bool::True, "?Bool works for True";
is ?(Bool::False), Bool::False, "?Bool works for False";

# tests they work with && and ||
Bool::True  && pass('True works');
Bool::False || pass('False works');

# tests they work with !
!Bool::True  || pass('!True works');
!Bool::False && pass('!False works');

# tests True with ok()
ok(Bool::True, 'True works');

# tests False with ok() and !
ok(!Bool::False, 'False works');

# tests Bool stringification - interaction with ~
isa_ok(~Bool::True, Str);
isa_ok(~Bool::False, Str);
ok(~Bool::True, 'stringified True works');
ok(~Bool::False, 'stringified False is true');
# NOTE. We don't try to freeze ~True into '1'
# and ~False into '' as pugs does now. Maybe we should (?!)

# numification - interaction with +
ok(+Bool::True ~~ Num);
ok(+Bool::False ~~ Num);
is(+Bool::True, '1', 'True numifies to 1');
is(+Bool::False, '0', 'False numifies to 0');
# stringification
is(~Bool::True, 'True', 'True stringifies to True');
is(~Bool::False, 'False', 'False stringifies to False');

# Arithmetic operations
my $bool = Bool::False;
is(++$bool, Bool::True, 'Increment of Bool::False produces Bool::True');
is(++$bool, Bool::True, 'Increment of Bool::True still produces Bool::True');
is(--$bool, Bool::False, 'Decrement of Bool::True produces Bool::False');
is(--$bool, Bool::False, 'Decrement of Bool::False produces Bool::False');

# RT #65514
{
    ok (0 but Bool::True), 'Bool::True works with "but"';
    is (0 but Bool::True), 0, 'Bool::True works with "but"';
    ok !('RT65514' but Bool::False), 'Bool::False works with "but"';
    is ('RT65514' but Bool::False), 'RT65514', 'Bool::False works with "but"';
}

#?rakudo skip 'RT 66576: .name method on bool values'
{
    is Bool::True.key, 'True', 'Bool::True.key works (is "True")';
    is Bool::False.key, 'False', 'Bool::False.key works (is "False")';
}

isa_ok ('RT71462' ~~ Str), Bool;

done_testing;

# vim: ft=perl6
