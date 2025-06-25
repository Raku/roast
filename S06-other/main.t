use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

use lib $*PROGRAM.parent(2).add("packages/HasMain/lib");

plan 23;

## If this test file is fudged, then MAIN never executes because
## the fudge script introduces an C<exit(1)> into the mainline.
## This definition prevents that insertion from having any effect.  :-)
sub exit { }

# L<S06/Declaring a C<MAIN> subroutine/>

sub MAIN($a, $b, *@c) {
    ok(1, 'MAIN called correctly');
    is($a, 'a', 'first positional param set correctly');
    is($b, 'b', 'second positional param set correctly');
    is(~@c, 'c d e', 'slurpy param set correctly');
}

@*ARGS = <a b c d e>;

ok( @*ARGS == 5, '@*ARGS has correct elements');

# https://github.com/Raku/old-issue-tracker/issues/2844
lives-ok { require HasMain }, 'MAIN in a module did not get executed';

# https://github.com/Raku/old-issue-tracker/issues/4527
is_run 'sub MAIN() { map { print "ha" }, ^3 }',
    {
        out => "hahaha",
    },
    'MAIN return value is sunk';


# https://github.com/Raku/old-issue-tracker/issues/5808
subtest 'MAIN can take type-constraint using Enums' => {
    plan 3;

    my $code = Q:to/END/;
        enum Hand <Rock Paper Scissors>;
        sub MAIN (Hand $hand, Hand :$pos-hand) {
            print "pass";
        }
    END
    is_run $code, :args[<Rock>                    ], { :out<pass>, :err('') }, 'positional works';
    is_run $code, :args[<--pos-hand=Scissors Rock>], { :out<pass>, :err('') }, 'positional + named works';
    is_run $code, :args[<Hand>                    ], { :out{not .contains: 'pass'}, :err(/'=<Hand>'/) },
        'name of enum itself is not valid and usage message prints the name of the enum';
}

subtest 'MAIN can take type-constraint using Enums that contain values that shadow CORE types' => {
    plan 3;

    my $code = Q:to/END/;
        enum Shadow <Label Hash Lock>;
        sub MAIN (Shadow $shadow, Shadow :$pos-shadow) {
            print "pass";
        }
    END
    is_run $code, :args[<Lock>                   ], { :out<pass>, :err('') }, 'positional works';
    is_run $code, :args[<--pos-shadow=Label Lock>], { :out<pass>, :err('') }, 'positional + named works';
    is_run $code, :args[<Shadow>                 ], { :out{not .contains: 'pass'}, :err(/'=<Shadow>'/) },
        'name of enum itself is not valid and usage message prints the name of the enum';
}

subtest '%*SUB-MAIN-OPTS<named-anywhere>', {
    plan 3;

    is_run ｢
        sub MAIN ($a, $b, :$c, :$d) { print "fail" }
        sub GENERATE-USAGE(|) { "pass" }
    ｣, :args[<1 --c=2 3 --d=4>], {:out(''), :err("pass\n"), :2status},
    'no opts set does not allow named args anywhere';

    is_run ｢
        (my %*SUB-MAIN-OPTS)<named-anywhere> = False;
        sub MAIN ($a, $b, :$c, :$d) { print "fail" }
        sub GENERATE-USAGE(|) { "pass" }
    ｣, :args[<1 --c=2 3 --d=4>], {:out(''), :err("pass\n"), :2status},
    '<named-anywhere> set to false does not allow named args anywhere';

    is_run ｢
        (my %*SUB-MAIN-OPTS)<named-anywhere> = True;
        sub MAIN ($a, $b, :$c, :$d) { print "pass" }
        sub GENERATE-USAGE(|) { print "fail" }
    ｣, :args[<1 --c=2 3 --d=4>], {:out<pass>, :err(''), :0status},
    '<named-anywhere> set to true allows named args anywhere';
}

# https://github.com/rakudo/rakudo/issues/3929
{
    is_run 'sub MAIN($a is rw) { }; sub GENERATE-USAGE(|) { print "usage" }', :args[],
      { :out<usage>, :err{ .contains("'is rw'") }, :2status },
      'Worry about "is rw" on parameters of MAIN';
}

# https://github.com/rakudo/rakudo/issues/1803
{
    is_run '@*ARGS = 42; sub MAIN($x) { say $x }', :args[],
      { :out("42\n"), :err(''), :0status },
      'non-string values in @*ARGS do not crash'
}

# https://github.com/rakudo/rakudo/issues/2445
{
    is_run 'my %*SUB-MAIN-OPTS = :named-anywhere; sub MAIN(|c) { say c }',
      :args<--foo foo>,
      { :out(qq|\\("foo", :foo(Bool::True))\n|), :err(''), :0status },
      'named arguments are also captured'
}

# https://github.com/rakudo/rakudo/issues/2794
{
    is_run 'sub MAIN(*@a) { say .raku for @a }',
      :args<True False Less More BigEndian>,
      { :out(q:to/OUTPUT/), :err(''), :0status },
      Bool::True
      Bool::False
      Order::Less
      Order::More
      Endian::BigEndian
      OUTPUT
      'enums are converted'
}

# https://github.com/rakudo/rakudo/issues/5759
{
    is_run 'my %*SUB-MAIN-OPTS = :bundling; sub MAIN(|c) { say c }',
      :args("-ab",),
      { :out(qq|\\(:a(Bool::True), :b(Bool::True))\n|), :err(''), :0status },
      'bundling works';

    is_run 'my %*SUB-MAIN-OPTS = :coerce-allomorphs-to(Str); sub MAIN(|c) { say c }',
      :args("42",),
      { :out(qq|\\("42")\n|), :err(''), :0status },
      'coercing to Str works';

    is_run 'my %*SUB-MAIN-OPTS = :coerce-allomorphs-to(Int); sub MAIN(|c) { say c }',
      :args("42",),
      { :out(qq|\\(42)\n|), :err(''), :0status },
      'coercing to Int works';

    is_run 'my %*SUB-MAIN-OPTS = :allow-no; sub MAIN(|c) { say c }',
      :args<--no-foo --/bar>,
      { :out(qq|\\(:bar(Bool::False), :foo(Bool::False))\n|), :err(''), :0status },
      'allow-no works';

    is_run 'my %*SUB-MAIN-OPTS = :numeric-suffix-as-value; sub MAIN(|c) { say c }',
      :args("-j2",),
      { :out(qq|\\(:j(IntStr.new(2, \"2\")))\n|), :err(''), :0status },
      'numeric-suffix-as-value works';
}

# https://github.com/rakudo/rakudo/issues/5159
{
    is_run 'sub MAIN(:$o, :@t) { dd $o }', :args<--o --t=a>,
      { :out(""), :err("Bool::True\n"), :0status },
      'Bool with named arg array and one arg works';
    is_run 'sub MAIN(:$o, :@t) { dd $o }', :args<--o --t=a --t=b>,
      { :out(""), :err("Bool::True\n"), :0status },
      'Bool with named arg array and two args works';
}

subtest 'MAIN can take type-constraint using an Enum declared in a separate scope' => {
    plan 3;

    my $code = Q:to/END/;
        module M { enum E is export <F G> }
        import M;
        sub MAIN (E $f, E :$g) {
            print "pass";
        }
    END
    is_run $code, :args[<F>                      ], { :out<pass>, :err('') }, 'positional works';
    is_run $code, :args[<--g=G F>                ], { :out<pass>, :err('') }, 'positional + named works';
    is_run $code, :args[<E>                      ], { :out{not .contains: 'pass'}, :err(/'=<E>'/) },
            'name of enum itself is not valid and usage message prints the name of the enum';
}

subtest 'MAIN can take type-constraint using a subset declared in a separate scope' => {
    plan 3;

    my $code = Q:to/END/;
        module M { subset S is export where / 'ok' / }
        import M;
        # Named arguments with subset types need to have a conformant default value
        sub MAIN (S $s-pos, S :$s-named = "ok") {
            print "pass";
        }
    END
    is_run $code, :args[<ok>                     ], { :out<pass>, :err('') }, 'positional works';
    is_run $code, :args[<--s-named=ok ok>        ], { :out<pass>, :err('') }, 'positional + named works';
    is_run $code, :args[<S>                      ], { :out{not .contains: 'pass'}, :err(/'[=S]'/) },
            'name of subset itself is not valid and usage message prints the name of the subset';
}

# vim: expandtab shiftwidth=4
