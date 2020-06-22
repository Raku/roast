use v6;
use Test;

constant $repo-path = $?FILE.IO.parent(2).add('packages/curi-install').absolute;
use lib "inst#$repo-path";

plan 19;

# TODO: rename this test to `curi-install.t`

rm_rf $repo-path.IO if $repo-path.IO.e;
$repo-path.IO.mkdir;

# Tests on non-existing repository path
{
    ok $*REPO ~~ CompUnit::Repository::Installable, 'repository does C::R::Installable';
    ok $*REPO ~~ CompUnit::Repository::Locally, 'repository does C::R::Locally';
    ok $*REPO.id, 'repository has an identifier';
    is $*REPO.short-id, 'inst', 'short-id exposes type of repository';
    is $*REPO.loaded.elems, 0, 'no compilation units were loaded so far';
}

my $prefix   = $repo-path.IO.parent(2).add('packages/FooBarBaz/lib');
my %provides = Foo => 'Foo.pm6';
my $dist              = Distribution::Hash.new({ :name<Foo>, :api<1>, :ver(v1.2.3), :%provides }, :$prefix);
my $non-matching-dist = Distribution::Hash.new({ :name<Foo>, :api<2>, :ver(v2.3.4), :%provides }, :$prefix);

$*REPO.install($dist);
$*REPO.install($non-matching-dist);

throws-like { EVAL '$*REPO.install($dist)' },
    Exception,
    message => /'already installed'/,
    "cannot reinstall the very same distribution";

{
    ok $*REPO ~~ CompUnit::Repository::Installable, 'repository does C::R::Installable';
    ok $*REPO ~~ CompUnit::Repository::Locally, 'repository does C::R::Locally';
    ok $*REPO.id, 'repository has an identifier';
    is $*REPO.short-id, 'inst', 'short-id exposes type of repository';
    is $*REPO.loaded.elems, 0, 'no compilation units were loaded so far';
}

isa-ok ::('Foo'), Failure, 'symbol Foo is unknown';

my $cu = $*REPO.need(CompUnit::DependencySpecification.new( :short-name<Foo>, :api-matcher<1> ));

isa-ok $cu, CompUnit, '$*REPO.need returns a CompUnit';
is $cu.short-name, 'Foo', '$*REPO.need returned correct CompUnit';
is $cu.version, v1.2.3, 'Correct API version chosen';

isa-ok ::('Foo'), Failure, 'symbol Foo is unknown after loading it';

GLOBALish.WHO.merge-symbols($cu.handle.globalish-package);

ok ::('Foo') !~~ Failure, 'symbol Foo is known after merging global symbols';

is $*REPO.loaded.elems, 1, 'one CompUnit got loaded';
ok $*REPO.loaded[0].short-name =:= $cu.short-name, 'the loaded CompUnit is the one returned by $*REPO.need';

rm_rf $repo-path.IO;

sub rm_rf(*@files) {
    for @files -> $path {
        if $path.d {
            rm_rf |$path.dir;
            $path.rmdir;
        }
        else {
            unlink $path;
        }
    }
}

# vim: expandtab shiftwidth=4
