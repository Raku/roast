use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 49;

my @*MODULES; # needed for calling CompUnit::Repository::need directly

BEGIN my $lib-path = $?FILE.IO.parent(2).IO;
my $example-lib-prefix = $lib-path.add('packages/Example/lib').absolute;
my $example2-lib-prefix = $lib-path.add('packages/Example2/lib').absolute;

my @precompiled = Test::Util::run( "use lib $example-lib-prefix.perl();\n" ~ q:to"--END--").lines;
    for <C A B> {
        my $comp-unit = $*REPO.need(CompUnit::DependencySpecification.new(:short-name("Example::$_")));
        say $comp-unit.precompiled;
    }
    --END--
is @precompiled.elems, 3;
is $_, 'True' for @precompiled;

# RT #122773
my @keys = Test::Util::run( "use lib $example-lib-prefix.perl();\n" ~ q:to"--END--").lines;
    use Example::A;
    use Example::B;

    .say for Example::.keys.sort;
    --END--

#?rakudo.jvm todo 'got: $["B", "C"]'
is-deeply @keys, [<A B C>], 'Diamond relationship';
my @precompiled2 = Test::Util::run( "use lib $example2-lib-prefix.perl();\n" ~ q:to"--END--").lines;
    for <T P D N S B G K C E F H R A U> {
        my $comp-unit = $*REPO.need(CompUnit::DependencySpecification.new(:short-name("Example2::$_")));
        say $comp-unit.precompiled;
    }
    --END--
is @precompiled2.elems, 15;
is $_, 'True' for @precompiled2;

# RT #123272
my @keys2 = Test::Util::run( "use lib $example2-lib-prefix.perl();\n" ~ q:to"--END--").lines;
    use Example2::T;

    use Example2::G;
    use Example2::F;
    use Example2::A;
    use Example2::U;

    .say for Example2::.keys.sort;
    --END--

#?rakudo.jvm todo 'got: $["C", "K"]'
is-deeply @keys2, [<C F K P>], 'Twisty maze of dependencies, all different';

#?rakudo.moar todo 'RT #122896'
#?rakudo.js todo 'RT #122896'
{
    is_run
      "use lib $example-lib-prefix.perl();\n" ~
      'use Example::C;
       f();',
       { err => '',
         out => '',
         status => 0,
       },
       'precompile exported cached sub';
}

# RT #76456
{
    use lib $?FILE.IO.parent(2).add("packages/RT76456/lib");
    my $comp-unit = $*REPO.need(CompUnit::DependencySpecification.new(:short-name<RT76456>));
    ok $comp-unit.precompiled, 'precompiled a parameterized role';
}

#RT #122447
{
    use lib $?FILE.IO.parent(2).add("packages/RT122447/lib");
    my $comp-unit = $*REPO.need(CompUnit::DependencySpecification.new(:short-name<RT122447>));
    ok $comp-unit.precompiled, 'precompiled a sub with params returning a proxy';
}

#RT #115240
{
    use lib $?FILE.IO.parent(2).add("packages/RT115240/lib");
    my $comp-unit = $*REPO.need(CompUnit::DependencySpecification.new(:short-name<RT115240>));
    ok $comp-unit.precompiled, 'precomp curried role compose';
}

#RT #126878
{
    use lib $?FILE.IO.parent(2).add("packages/RT126878/lib");
    my $comp-unit = $*REPO.need(CompUnit::DependencySpecification.new(:short-name<RT126878::Precomp>));
    ok !$comp-unit.precompiled, '"need" survives "no precompilation"';
}

#RT #123276
{
    my $rt123276-lib-prefix = $lib-path.add('packages/RT123276/lib').absolute;

    my @precompiled = Test::Util::run( "use lib $rt123276-lib-prefix.perl();\n" ~ q:to"--END--").lines;
        my $name = 'RT123276';

        for "{$name}", "{$name}::B::C1", "{$name}::B::C2" -> $module-name {
            my $comp-unit = $*REPO.need(
                CompUnit::DependencySpecification.new(:short-name($module-name))
            );
            say $comp-unit.precompiled;
        }
        --END--
    is @precompiled.elems, 3, "tried to precompile all 3 modules";
    is $_, 'True' for @precompiled;

    my @keys = Test::Util::run( "use lib $rt123276-lib-prefix.perl();\n" ~ q:to"--END--").lines;
        use RT123276::B::C1;
        use RT123276::B::C2;
        say RT123276::B::C1.^methods.grep( *.name ne "BUILDALL" )
        --END--

    #RT #123276
    is-deeply @keys, [<(foo)>], 'RT123276';
}

#RT #124162
{
    use lib $?FILE.IO.parent(2).add("packages/RT124162/lib");
    my $comp-unit = $*REPO.need(CompUnit::DependencySpecification.new(:short-name<RT124162>));
    ok $comp-unit.precompiled, 'precomp of native array parameterization';
}

{
    my $internarray-lib-prefix = $lib-path.add('packages/InternArray/lib').absolute;
    #?rakudo todo 'no 6model parametrics interning yet'
    is_run
      "use InternArrayA;
       use InternArrayB;
       print a().WHAT =:= b().WHAT",
      { err    => '',
        out    => "True",
        status => 0,
      },
      :compiler-args['-I', $internarray-lib-prefix],

      'precompile load of both and identity check passed';
}


# RT #125090
{
    use lib $?FILE.IO.parent(2).add("packages/RT125090/lib");
    my $comp-unit = $*REPO.need(CompUnit::DependencySpecification.new(:short-name<RT125090>));
    ok $comp-unit.precompiled, 'precomp of BEGIN using $*KERNEL and $*DISTRO';
}

# RT #125245
{
    use lib $?FILE.IO.parent(2).add("packages/RT125245/lib");
    my $comp-unit = $*REPO.need(CompUnit::DependencySpecification.new(:short-name<RT125245>));
    ok $comp-unit.precompiled, 'precomp of assignment to variable using subset type';
}

# RT #127176
{
    my $rt127176-lib-prefix = $lib-path.add('packages/RT127176/lib').absolute;

    is_run '',
       {
         out    => '',
         err    => { not $_ ~~ / ( "SORRY!" .*) ** 2 / },
         status => { $_ != 0 },
       },
       :compiler-args['-I', $rt127176-lib-prefix, '-M', 'RT127176'],
       'no duplicate compilation error';
}

# RT #128156
{
    my $rt128156-lib-prefix = $lib-path.add('packages/RT128156/lib').absolute;

    use lib $?FILE.IO.parent(2).add("packages/RT128156/lib");

    # precompile it in a different process
    run $*EXECUTABLE, '-I', $rt128156-lib-prefix, '-e', 'use RT128156::One;';
    # trigger recompilation
    my $trigger-file = $rt128156-lib-prefix.IO.add('RT128156/Two.pm6');
    $trigger-file.IO.spurt($trigger-file.slurp);
    my $comp-unit = $*REPO.need(CompUnit::DependencySpecification.new(:short-name<RT128156::One>));
    ok $comp-unit.handle.globalish-package<RT128156>.WHO<One Two Three>:exists.all,
       'GLOBAL symbols exist after re-precompiled';

    # Run another test where a source file is changed after precompilation.
    # The dependency layout is: A -> B -> C -> D
    #                            `-> C -> D
    my $before    = run $*EXECUTABLE, '-I', $rt128156-lib-prefix, '-M', 'A', '-e', '';
    $trigger-file = $rt128156-lib-prefix.IO.add('C.pm6');
    $trigger-file.spurt($trigger-file.slurp);
    my $after     = run $*EXECUTABLE,'-I', $rt128156-lib-prefix,'-M','A','-e','';
    is $before.status, 0, 'Can precompile modules before touching source file';
    is $after.status,  0, 'Can precompile modules after touching source file';
}

# RT #128156 (another)
{
    my $rt128156-lib-prefix = $lib-path.add('packages/RT128156/lib').absolute;

    # Test file content actually changing (so that the precomp SHA changes)
    run $*EXECUTABLE, '-I', $rt128156-lib-prefix, '-e', 'need RT128156::Top1; need RT128156::Top2;';
    my $trigger-file = $rt128156-lib-prefix.IO.add('RT128156/Needed.pm6');
    for 1..2 -> $i {
        # Alternates putting a '#' at the end of a file
        my $new-content = $trigger-file.IO.slurp.subst(/$/,"#").subst(/"##"$/,"");
        $trigger-file.spurt($new-content);
        my $output = run :out, $*EXECUTABLE, '-I', $rt128156-lib-prefix, '-e','
             need RT128156::Top1;
             need RT128156::Top2;
             .say for MY::.keys.grep(/Needed|Top/).sort;
             ';
        is $output.out.slurp,"Top1\nTop2\n","$i. changing SHA of dependency doesn't break re-precompilation";
    }
}

{
    my $rt128156-lib-prefix = $lib-path.add('packages/RT128156/lib').absolute;

    run $*EXECUTABLE,'-I', $rt128156-lib-prefix,'-e','need RT128156::Top1;';
    my $trigger-file = $rt128156-lib-prefix.IO.add('RT128156/Needed.pm6');
    for 1..2 -> $i {
        my $old-content = $trigger-file.slurp;
        $trigger-file.spurt('class Needed { method version() { ' ~ $i ~ ' } }');
        my $output = run :out, $*EXECUTABLE, '-I', $rt128156-lib-prefix, '-e','
             need RT128156::Top1;
             print Top1.version-of-needed;
             ';
        is $output.out.slurp, $i, "$i. change in source file of dependency detected";
        $trigger-file.spurt($old-content);
    }
}

# RT #112626
{
    my $rt112626-lib-prefix = $lib-path.add('packages/RT112626/lib').absolute;

    # Run the test twice, so the first time precompiles the modules
    #?rakudo.jvm todo "Invalid typename 'RT112626::Class1' in parameter declaration"
    for ^2 {
        is_run ｢use RT112626::Conflict; say 'pass'｣, {:out("pass\n"), :err('')},
            :compiler-args['-I', $rt112626-lib-prefix],
        "roles in precompiled modules recognize type names (run $_)";
    }
}

# RT #129266
subtest 'precompiled module constants get updated on change' => {
    plan 2;

    BEGIN my $rt129266-lib-prefix = $lib-path.add('packages/RT129266/lib').absolute;
    constant $module = $rt129266-lib-prefix.IO.add('RT129266/Foo.pm6');
    constant $module-content = $module.slurp;
    LEAVE $module.spurt: $module-content;

    is_run ｢use RT129266::Bar; say var() eq '«VALUE»' ?? 'pass' !! 'fail'｣,
        :compiler-args['-I', $rt129266-lib-prefix],
        {:out("pass\n"), :err('')},
    "original content has correct value";

    $module.spurt: $module-content.subst: '«VALUE»', '«NEW»';

    is_run ｢use RT129266::Bar; say var() eq '«NEW»' ?? 'pass' !! 'fail'｣,
        :compiler-args['-I', $rt129266-lib-prefix],
        {:out("pass\n"), :err('')},
    "modified content has updated";
}

# RT#131924
with make-temp-dir() -> $dir {
    $dir.add('Simple131924.pm6').spurt: ｢
        unit class Simple131924; sub buggy-str is export { “: {‘’}\n\r” ~ “\n\r” }
    ｣;

    for ^2 { # do two runs: 1 x without pre-existing precomp + 1 x with
        is_run 'use lib \qq[$dir.absolute().perl()]; use Simple131924; print buggy-str() eq “: \n\r\n\r”',
             {:out<True>, :err(''), :0status},
	     'no funny business with precompiled string strands (\qq[$_])';
    }
}
