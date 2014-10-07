use Test;
use lib 't/spec/packages';
use Test::Util;

plan 11;

my @precomp-paths;

%*ENV<PERL6LIB> = 't/spec/packages';

for <C A B> {
    my $path = "t/spec/packages/Example/{$_}.pm";
    my $precomp-path = $path ~ '.' ~ $*VM.precomp-ext;
    unlink $precomp-path if $precomp-path.IO.e;
    ok CompUnit.new($path).precomp, "precomp Example::$_";
    ok $precomp-path.IO.e, "created $precomp-path";
    @precomp-paths.push: $precomp-path;
}

my @keys = Test::Util::run( q:to"--END--").lines;
    use Example::A;
    use Example::B;

    .say for Example::.keys.sort;
    --END--

#?rakudo.jvm todo 'RT #122773'
#?rakudo.moar todo 'RT #122773'
is_deeply @keys, [<A B C>], 'Diamond relationship';

#?rakudo.jvm todo 'RT #122896'
#?rakudo.moar todo 'RT #122896'
is_run 'use Example::C; f();', { err => '', out => '', status => 0 }, 'precompile exported cached sub';

unlink $_ for @precomp-paths;

# RT #76456
{
    my $cur  = CompUnitRepo::Local::File.new("t/spec/packages");

    my ($cu) = $cur.candidates('RT76456');
    ok $cu.precomp(:force), 'precompiled a parameterized role';
    unlink $cu.precomp-path if $cu.precomp-path.IO.e;
}

#RT #122447
{
    # also a test of precompilation from the command line
    my $module-name = 'RT122447';
    my $output-path = "t/spec/packages/" ~ $module-name ~ '.pm.' ~ $*VM.precomp-ext;
    unlink $output-path if $output-path.IO.e;
    is_run 'sub foo($bar) { Proxy.new( FETCH => sub (|) { }, STORE => sub (|) { } ) }', { err => '', out => '', status => 0 }, :compiler-args['--target', $*VM.precomp-target, '--output', $output-path ], 'precompile sub with params returning a proxy';

    is_run '0', { err => '', out => '', status => 0 }, :compiler-args['-I', 't/spec/packages', '-M', $module-name], 'precomile load - from the command line';
    unlink $output-path if $output-path.IO.e;
}
