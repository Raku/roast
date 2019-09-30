use v6.d;
use Test;
use lib $?FILE.IO.parent(2).add: 'packages/Test-Helpers';
use lib $?FILE.IO.parent(2).add: 'packages/S14-roles/lib';
use Test::Util;

plan 2;

subtest "Basic role language revision", {
    my @rev-map = :c<c>, :d<d>, :e<e.PREVIEW>;

    plan 3 * @rev-map;

    for @rev-map -> (:key($rev), :value($use-rev)) {
        is_run q<use v6.> ~ $use-rev ~ q<; role R { }; print R.^candidates[0].^language-revision>,
                { :out($rev), :err(""), :exitcode(0) },
                "role language revision is expected '$rev'";
        is_run qq<use v6.{$use-rev};>
                ~ q:to/PUN/,
                    role R { }
                    print R.new.^language-revision
                    PUN
                { :out($rev), :err(""), :exitcode(0) },
                "pun language revision is expected '$rev'";
        is_run qq<use v6.{$use-rev};>
                ~ q:to/PUN/,
                    role R { }
                    role R[::T] { has T $.attr; }
                    my $r = R[Str].new;
                    print $r.^language-revision, "/", $r.^roles[0].^language-revision
                    PUN
                { :out("{$rev}/{$rev}"), :err(""), :exitcode(0) },
                "parameterized pun language revision is expected '$rev'";
    }
}

subtest "Multi-module and multi-version", {
    plan 3;
    use Ver6e;

    subtest "Type object language revisions", {
        plan 3;
        is-deeply VerRole.^candidates.map( *.^language-revision ), <c e>,
                  "role candidates are coming from different language revisions";
        is VerRole.new.^language-revision, 'c', "pun of role defined in 6.c remains 6.c";
        is VerRole[Str].new.^language-revision, 'e', "pun of role defined in 6.e remains 6.e";
    }

    subtest "Cross-boundary compatibility", {
        plan 2;
        # Because parameterized role comes from a 6.e module
        throws-like 'my class C does VerRole[Int] { }', X::Comp::AdHoc,
                    'class from v6.d is not compatible with a role from v6.e';
        # Because unparameterized role comes from a 6.c module
        lives-ok { my class C does VerRole { } }, 'class from v6.d can consume a v6.c role';
    }

    subtest "Cross-boundary mixins", {
        plan 2;

        throws-like 'my class C { }; my $v = C.new but VerRole[Int]', X::AdHoc,
                    'mixin of v6.e role into incompatible v6.d class throws';
        lives-ok { my class C { }; my $v = C.new but VerRole }, "mixin of v6.c role into a v6.d class";
    }
}

done-testing;
