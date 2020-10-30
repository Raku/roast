use v6.e.PREVIEW;
use Test;

plan 1;

sub rmro-match(Mu \type, @exp, Str:D $msg, :$unhid = 0) is test-assertion {
    my @got := ( $unhid ?? type.^mro_unhidden(:roles) !! type.^mro(:roles) )[0..*-3];
    unless @got.elems == @exp.elems {
        flunk $msg;
        diag "expected: " ~ @exp.elems ~ " elements\n" ~
             "     got: " ~ @got.elems ~ " elements";
        return;
    }
    my $last_class := type;
    for ^@exp.elems -> $i {
        my $exp := @exp[$i]<>;
        unless type ~~ $exp {
            flunk $msg;
            diag "type object " ~ type.^name ~ " doesn't match expected " ~ $exp.^name;
            return;
        }
        if $exp.HOW.archetypes.composable {
            $exp := try $last_class.^concretization($exp, :local);
        }
        else {
            $last_class := $exp;
        }
        my $got := @got[$i]<>;
        unless $got =:= $exp {
            flunk($msg);
            diag "at position $i:\n" ~
                 "expected: " ~ $exp.^name ~ " of " ~ $exp.HOW.^name ~ "\n" ~
                 "     got: " ~ $got.^name ~ " of " ~ $got.HOW.^name;
            return;
        }
    }
    pass $msg;
}

subtest "Rolified MRO", {
    plan 10;
    {
        my class C1 { }
        my role R2a { }
        my class C2 does R2a is C1 { }
        my class C3 is C2 { }

        rmro-match C3, (C3, C2, R2a, C1), "basic mro with roles";
    }
    {
        my class C1 { }
        my role R2a { }
        my role R2a[::T] { }
        my class C2 does R2a[Int] is C1 { }
        my class C3 is C2 { }

        rmro-match C3, (C3, C2, R2a[Int], C1), "basic mro with parameterized roles";
    }
    {
        my class C1 { }
        my role R2a is C1 { }
        my class C2 does R2a { }
        my class C3 is C2 { }

        rmro-match C3, (C3, C2, R2a, C1), "mro with roles: parent on a role";
    }
    {
        my class C1 { }
        my role R2a is C1 { }
        my class C2 does R2a { }
        my class C3 hides C2 { }

        rmro-match C3, :unhid, (C3, C1), "mro with roles: hiding a class hides its roles";
        rmro-match C3, (C3, C2, R2a, C1), "mro with roles: .^mro method ignores hiding";
    }
    {
        my class C1 { }
        my class C2 is C1 { }
        my role R3b is C2 { }
        my role R3a is hidden does R3b { }
        my class C3 is R3a { }

        rmro-match C3, :unhid, (C3, C2, C1), "mro with roles: puned 'is hidden' role hides its roles too";
    }
    {
        my class C1 { }
        my class C2 is C1 { }
        my role R3b is C2 { }
        my role R3a is C2 { }
        my role R3a[::T] is hidden does R3b { }
        my class C3 is R3a[Str] { }

        rmro-match C3, :unhid, (C3, C2, C1), "mro with roles: puned parameterized 'is hidden' role hides its roles too";
    }
    {
        my class C1 { }
        my class C2 is C1 { }
        my role R3b is C2 { }
        my role R3a does R3b { }
        my class C3 hides R3a { }

        rmro-match C3, :unhid, (C3, C2, C1), "mro with roles: 'hides' on a role hides its roles too";
    }
    {
        my class C1 { }
        my class C2 is C1 { }
        my role R3b is C2 { }
        my role R3a { }
        my role R3a[::T] does R3b { }
        my class C3 hides R3a[Str] { }

        rmro-match C3, :unhid, (C3, C2, C1), "mro with roles: 'hides' on a parameterized role hides its roles too";
    }
    {
        my class C1 { }
        my class C2 is C1 { }
        my role R3b hides C2 { }
        my role R3a does R3b { }
        my class C3 does R3a { }

        rmro-match C3, :unhid, (C3, R3a, R3b, C1), "mro with roles: 'hides' used with a role is preserved";
    }
}

done-testing;

# vim: expandtab shiftwidth=4
