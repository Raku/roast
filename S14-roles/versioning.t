use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use lib $*PROGRAM.parent(2).add: 'packages/S14-roles/lib';
use Test::Util;

plan 4;

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
    plan 4;
    use Ver6c;
    use Ver6d;
    use Ver6e;
    is-deeply VerRole.^candidates.map( ~ *.^language-revision ), <c d e>,
              "role candidates are coming from different language revisions";
    is VerRole.new.^language-revision, 'c',
      "pun of role defined in 6.c remains 6.c";
    is VerRole[Str].new.^language-revision, 'd',
      "pun of role defined in 6.d remains 6.d";
    is VerRole[Str,Str].new.^language-revision, 'e',
      "pun of role defined in 6.e remains 6.e";
}

subtest "Enum", {
    plan 3;
    use Ver6c;
    use Ver6d;
    use Ver6e;

    is Enum-v6c.^language-revision, 'c', "enum for v6.c";
    is Enum-v6d.^language-revision, 'd', "enum for v6.e";
    is Enum-v6e.^language-revision, 'e', "enum for v6.d";
}

my $METHOD := Mu.can("POPULATE") ?? "POPULATE" !! "BUILDALL";

subtest "Submethods" => {
    plan 7;
    my @compiler-args = '-I' ~ $*PROGRAM.parent(2).add: 'packages/S14-roles/lib';
    is_run q:s:to/V6C/,
            use v6.c;
            use Ver6e;
            class C does R6e_1 { }
            print C.^language-revision, ": ", C.^submethod_table.keys.grep(* ne '$METHOD').join(" ");
            V6C
        :@compiler-args,
        { :err(""), :out("c: ") },
        "6.c class consuming 6.e role doesn't receive role's submethods";

    is_run q:s:to/V6C/,
            use v6.c;
            use Ver6c;
            use Ver6e;
            class C does R6e_1 does R6c_1 { }
            print C.^language-revision, ": ", C.^submethod_table.keys.grep(* ne '$METHOD').sort.join(" ");
            V6C
        :@compiler-args,
        { :err(""), :out("c: r6c") },
        "6.c class consuming both 6.c and 6.e roles only gets submethods from 6.c role";

    is_run q:s:to/V6E/,
            use v6.e.PREVIEW;
            use Ver6e;
            class C does R6e_1 { }
            print C.^language-revision, ": ", C.^submethod_table.keys.grep(* ne '$METHOD').join(" ");
            V6E
        :@compiler-args,
        { :err(""), :out("e: ") },
        "6.e class consuming 6.e role doesn't receive role's submethods";

    is_run q:s:to/V6E/,
            use v6.e.PREVIEW;
            use Ver6c;
            use Ver6e;
            class C does R6e_1 does R6c_1 { }
            print C.^language-revision, ": ", C.^submethod_table.keys.grep(* ne '$METHOD').join(" ");
            V6E
        :@compiler-args,
        { :err(""), :out("e: ") },
        "6.e class consuming both 6.c and 6.e roles gets submethods from neither";

    #?rakudo.jvm todo 'got out: "c: "'
    is_run q:to/V6C/,
            use v6.c;
            use Ver6e;
            use Ver6c;
            my @stages;
            class C does R6e_2[@stages] does R6c_2[@stages] { }
            C.new;
            print C.^language-revision, ": ", @stages.join(" ");
            V6C
        :@compiler-args,
        { :err(""), :out("c: R6e_2.BUILD R6c_2.BUILD R6e_2.TWEAK R6c_2.TWEAK") },
        "6.c class with no own constructors: 6.c and 6.e roles constructors are ran";

    #?rakudo.jvm todo 'got out: "c: "'
    is_run q:to/V6C/,
            use v6.c;
            use Ver6e;
            use Ver6c;
            my @stages;
            class C does R6e_2[@stages] does R6c_2[@stages] {
                submethod BUILD {}
                submethod TWEAK {}
            }
            C.new;
            print C.^language-revision, ": ", @stages.join(" ");
            V6C
        :@compiler-args,
        { :err(""), :out("c: R6e_2.BUILD R6e_2.TWEAK") },
        "6.c class with own constructors blocks 6.c role constructors, but not 6.e";

    #?rakudo.jvm todo 'got out: "e: "'
    is_run q:to/V6E/,
            use v6.e.PREVIEW;
            use Ver6e;
            use Ver6c;
            my @stages;
            class C does R6e_2[@stages] does R6c_2[@stages] {
                submethod BUILD {}
                submethod TWEAK {}
            }
            C.new;
            print C.^language-revision, ": ", @stages.join(" ");
            V6E
        :@compiler-args,
        { :err(""), :out("e: R6e_2.BUILD R6c_2.BUILD R6e_2.TWEAK R6c_2.TWEAK") },
        "6.e class with own constructors doesn't block neither 6.e, nor 6.c constructors";
}

# vim: expandtab shiftwidth=4
