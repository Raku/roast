use v6;

use Test;

plan 17;

#?pugs emit skip_rest('parameterized roles'); exit;
#?pugs emit =begin SKIP

role R1[::T] { }
role R1[::T1, ::T2] { }
class C1 { }
class C2 is C1 { }
class C3 { }

# Subtyping with a single role parameter which is a class type.
ok(R1[C1] ~~ R1,      'basic sanity');
ok(R1[C1] ~~ R1[C1],  'basic sanity');
ok(R1[C2] ~~ R1[C1],  'subtyping by role parameters (one param)');
ok(R1[C1] !~~ R1[C2], 'subtyping by role parameters (one param)');
ok(R1[C3] !~~ R1[C1], 'subtyping by role parameters (one param)');

# Subtyping with nested roles.
ok(R1[R1[C1]] ~~ R1,          'basic sanity');
ok(R1[R1[C1]] ~~ R1[R1[C1]],  'basic sanity');
ok(R1[R1[C2]] ~~ R1[R1[C1]],  'subtyping by role parameters (nested)');
ok(R1[R1[C1]] !~~ R1[R1[C2]], 'subtyping by role parameters (nested)');
ok(R1[R1[C3]] !~~ R1[R1[C1]], 'subtyping by role parameters (nested)');

# Subtyping with multiple role parameters.
ok(R1[C1,C3] ~~ R1,         'basic sanity');
ok(R1[C1,C3] ~~ R1[C1,C3],  'basic sanity');
ok(R1[C2,C3] ~~ R1[C1,C3],  'subtyping by role parameters (two params)');
ok(R1[C2,C2] ~~ R1[C1,C1],  'subtyping by role parameters (two params)');
ok(R1[C1,C1] !~~ R1[C2,C2], 'subtyping by role parameters (two params)');
ok(R1[C1,C2] !~~ R1[C2,C1], 'subtyping by role parameters (two params)');
ok(R1[C2,C1] !~~ R1[C1,C3], 'subtyping by role parameters (two params)');


# vim: ft=perl6
