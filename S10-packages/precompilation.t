use v6;
use lib 't/spec/packages';
use Test;
use Test::Util;

plan 39;

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

is-deeply @keys2, [<C D E F H K N P R S>], 'Twisty maze of dependencies, all different';

#?rakudo.jvm skip 'RT #122896'
#?rakudo.moar skip 'RT #122896'
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

    #?rakudo.jvm todo 'RT #123276'
    #?rakudo.moar todo 'RT #123276'
    is-deeply @keys, [<foo>], 'RT123276';
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
