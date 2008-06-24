use v6;

use Test;


# XXX unspecced but implicit - needs validation

plan 18;

# tests True and False are Bool's
isa_ok( True, 'Bool' );
isa_ok( False, 'Bool' );

# tests they keep their Bool'ness when stored
my $a = True;
isa_ok( $a, 'Bool' );

my $a = False;
isa_ok( $a, 'Bool' );

# tests they work with && and ||
True  && pass( 'True works' );
False || pass( 'False works' );

# tests they work with !
!True  || pass( '!True works' );
!False && pass( '!False works' );

# tests True with ok()
ok( True, 'True works' );

# tests False with ok() and !
ok( !False, 'False works' );

# tests Bool stringification - interaction with ~
isa_ok( ~True, 'Str' );
isa_ok( ~False, 'Str' );
ok( ~True, 'stringified True works' );
ok( !(~False), 'stringified False works' );
# NOTE. We don't try to freeze ~True into '1'
# and ~False into '' as pugs does now. Maybe we should (?!)

# numification - interaction with +
isa_ok( +True, 'Num' );
isa_ok( +False, 'Num' );
is( +True, '1', 'True numifies to 1' );
is( +False, '0', 'False numifies to 0' );
