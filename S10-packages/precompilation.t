use Test;
use lib 't/spec/packages';
use Test::Util;

plan 8;

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
is_deeply @keys, [<A B C>], 'Diamond Relationship';

unlink $_ for @precomp-paths;

# RT #76456
{
    my $cur  = CompUnitRepo::Local::File.new("t/spec/packages");

    my ($cu) = $cur.candidates('RT76456');
    ok $cu.precomp(:force), 'precompiled a parameterized role';
    unlink $cu.precomp-path if $cu.precomp-path.IO.e;
}

