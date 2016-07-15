use v6;
use lib 't/spec/packages';
use Test;
use Test::Util;

plan 46;

my @*MODULES; # needed for calling CompUnit::Repository::need directly
my $precomp-ext    := $*VM.precomp-ext;
my $precomp-target := $*VM.precomp-target;
my @precomp-paths;

my @precompiled = Test::Util::run( q:to"--END--").lines;
    use lib 't/spec/packages';

    for <C A B> {
        my $comp-unit = $*REPO.need(CompUnit::DependencySpecification.new(:short-name("Example::$_")));
        say $comp-unit.precompiled;
    }
    --END--
is @precompiled.elems, 3;
is $_, 'True' for @precompiled;

# RT #122773
my @keys = Test::Util::run( q:to"--END--").lines;
    use lib 't/spec/packages';
    use Example::A;
    use Example::B;

    .say for Example::.keys.sort;
    --END--

#?rakudo.jvm todo 'got: $["B", "C"]'
is-deeply @keys, [<A B C>], 'Diamond relationship';

my @precompiled2 = Test::Util::run( q:to"--END--").lines;
    use lib 't/spec/packages';

    for <T P D N S B G K C E F H R A U> {
        my $comp-unit = $*REPO.need(CompUnit::DependencySpecification.new(:short-name("Example2::$_")));
        say $comp-unit.precompiled;
    }
    --END--
is @precompiled2.elems, 15;
is $_, 'True' for @precompiled2;

# RT #123272
my @keys2 = Test::Util::run( q:to"--END--").lines;
    use v6;
    use lib 't/spec/packages';
    use Example2::T;

    use Example2::G;
    use Example2::F;
    use Example2::A;
    use Example2::U;

    .say for Example2::.keys.sort;
    --END--

#?rakudo.jvm todo 'got: $["C", "K"]'
is-deeply @keys2, [<C D E F H K N P R S>], 'Twisty maze of dependencies, all different';

#?rakudo.moar todo 'RT #122896'
{
    is_run
      'use lib "t/spec/packages";
       use Example::C;
       f();',
       { err => '',
         out => '',
         status => 0,
       },
       'precompile exported cached sub';
}

# RT #76456
{
    my $comp-unit = $*REPO.need(CompUnit::DependencySpecification.new(:short-name<RT76456>));
    ok $comp-unit.precompiled, 'precompiled a parameterized role';
}

#RT #122447
{
    my $comp-unit = $*REPO.need(CompUnit::DependencySpecification.new(:short-name<RT122447>));
    ok $comp-unit.precompiled, 'precompiled a sub with params returning a proxy';
}

#RT #115240
{
    my $comp-unit = $*REPO.need(CompUnit::DependencySpecification.new(:short-name<RT115240>));
    ok $comp-unit.precompiled, 'precomp curried role compose';
}

#RT #126878
{
    my $comp-unit = $*REPO.need(CompUnit::DependencySpecification.new(:short-name<RT126878::Precomp>));
    ok !$comp-unit.precompiled, '"need" survives "no precompilation"';
}

#RT #123276
{
    my @precompiled = Test::Util::run( q:to"--END--").lines;
        use lib 't/spec/packages';

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

    my @keys = Test::Util::run( q:to"--END--").lines;
        use lib 't/spec/packages';
        use RT123276::B::C1;
        use RT123276::B::C2;
        say RT123276::B::C1.^methods
    --END--

    #RT #123276
    #?rakudo.jvm todo 'got: $[]'
    is-deeply @keys, [<(foo)>], 'RT123276';
}

#RT #124162
{
    my $comp-unit = $*REPO.need(CompUnit::DependencySpecification.new(:short-name<RT124162>));
    ok $comp-unit.precompiled, 'precomp of native array parameterization';
}

{
    my $module-name-a = 'InternArrayA';
    my $output-path-a = "t/spec/packages/" ~ $module-name-a ~ '.pm.' ~ $precomp-ext;
    unlink $output-path-a; # don't care if failed
    is_run
      'my constant VALUE = array[uint32].new;
       sub a() is export { VALUE }',
      { err    => '',
        out    => '',
        status => 0,
      },
      :compiler-args[
        '--target', $precomp-target,
        '--output', $output-path-a,
      ],
      "precomp of native array parameterization intern test (a)";
    ok $output-path-a.IO.e, "did we create a $output-path-a";

    my $module-name-b = 'InternArrayB';
    my $output-path-b = "t/spec/packages/" ~ $module-name-b ~ '.pm.' ~ $precomp-ext;

    unlink $output-path-b; # don't care if failed

    is_run
      'my constant VALUE = array[uint32].new;
       sub b() is export { VALUE }',
      { err    => '',
        out    => '',
        status => 0,
      },
      :compiler-args[
        '--target', $precomp-target,
        '--output', $output-path-b,
      ],
      "precomp of native array parameterization intern test (b)";
    ok $output-path-b.IO.e, "did we create a $output-path-b";

    #?rakudo.jvm todo 'no 6model parametrics interning yet'
    #?rakudo.moar todo 'no 6model parametrics interning yet'
    is_run
      "use $module-name-a;
       use $module-name-b;
       print a().WHAT =:= b().WHAT",
      { err    => '',
        out    => "True",
        status => 0,
      },
      :compiler-args['-I', 't/spec/packages'],
      'precompile load of both and identity check passed';

    unlink $_ for $output-path-a, $output-path-b; # don't care if failed
}


# RT #125090
{
    my $comp-unit = $*REPO.need(CompUnit::DependencySpecification.new(:short-name<RT125090>));
    ok $comp-unit.precompiled, 'precomp of BEGIN using $*KERNEL and $*DISTRO';
}

# RT #125245
{
    my $comp-unit = $*REPO.need(CompUnit::DependencySpecification.new(:short-name<RT125245>));
    ok $comp-unit.precompiled, 'precomp of assignment to variable using subset type';
}

# RT #127176
{
    is_run '',
       {
         out    => '',
         err    => { not $_ ~~ / ( "SORRY!" .*) ** 2 / },
         status => { $_ != 0 },
       },
       :compiler-args['-I', 't/spec/packages', '-M', 'RT127176'],
       'no duplicate compilation error';
}

# RT #128156
{
    # precompile it in a different process
    run $*EXECUTABLE,'-I','t/spec/packages','-e','use RT128156::One;';
    # trigger recompilation
    my $trigger-file = 't/spec/packages/RT128156/Two.pm6'.IO;
    $trigger-file.IO.spurt($trigger-file.slurp);
    my $comp-unit = $*REPO.need(CompUnit::DependencySpecification.new(:short-name<RT128156::One>));
    ok $comp-unit.handle.globalish-package.WHO<RT128156>.WHO<One Two Three>:exists.all,
       'GLOBAL symbols exist after re-precompiled';

    # Run another test where a source file is change after precompilation.
    # The dependency layout is: A -> B -> C -> D
    #                            `-> C -> D
    my $before    = run $*EXECUTABLE,'-I','t/spec/packages/RT128156','-M','A','-e','';
    $trigger-file = 't/spec/packages/RT128156/C.pm6'.IO;
    $trigger-file.IO.spurt($trigger-file.slurp);
    my $after     = run $*EXECUTABLE,'-I','t/spec/packages/RT128156','-M','A','-e','';
    is $before.status, 0, 'Can precompile modules before touching source file';
    is $after.status,  0, 'Can precompile modules after touching source file';
}

# RT #128156 (another)
{
    # Test file content actually changing (so that the precomp SHA changes)
    run $*EXECUTABLE,'-I','t/spec/packages','-e','need RT128156::Top1; need RT128156::Top2;';
    my $trigger-file = 't/spec/packages/RT128156/Needed.pm6';
    for 1..2 -> $i {
        # Alternates putting a '#' at the end of a file
        my $new-content = $trigger-file.IO.slurp.subst(/$/,"#").subst(/"##"$/,"");
        $trigger-file.IO.spurt($new-content);
        my $output = run $*EXECUTABLE,:out,'-I','t/spec/packages','-e','
             need RT128156::Top1;
             need RT128156::Top2;
             .say for GLOBAL::.keys.sort;
             ';
        is $output.out.slurp-rest,"Needed\nTop1\nTop2\n","$i. changing SHA of dependency doesn't break re-precompilation";
    }
}
