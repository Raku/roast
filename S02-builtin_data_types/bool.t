use v6;

use Test;


# L<S12/Enums/"Two built-in enums are">

plan 20;

# tests True and False are Bool's
isa_ok(Bool::True, Bool);
isa_ok(Bool::False, Bool);

# tests they keep their Bool'ness when stored
my $a = Bool::True;
isa_ok($a, Bool);

$a = Bool::False;
isa_ok($a, Bool);

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
ok(!(~Bool::False), 'stringified False works');
# NOTE. We don't try to freeze ~True into '1'
# and ~False into '' as pugs does now. Maybe we should (?!)

# numification - interaction with +
isa_ok(+Bool::True, Num);
isa_ok(+Bool::False, Num);
is(+Bool::True, '1', 'True numifies to 1');
is(+Bool::False, '0', 'False numifies to 0');
# stringification
is(~Bool::True, '1', 'True stringifies to 1');
is(~Bool::False, '0', 'False stringifies to 0'); 
