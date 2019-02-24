use v6.c;
use Test;

constant $path = 't/spec/packages/curli-install';
use lib "inst#$path";

plan 18;

rm_rf $path.IO if $path.IO.e;

# Tests on non-existing repository path
{
    ok $*REPO ~~ CompUnit::Repository::Installable, 'repository does C::R::Installable';
    ok $*REPO ~~ CompUnit::Repository::Locally, 'repository does C::R::Locally';
    ok $*REPO.id, 'repository has an identifier';
    is $*REPO.short-id, 'inst', 'short-id exposes type of repository';
    is $*REPO.loaded.elems, 0, 'no compilation units were loaded so far';
}
my $prefix   = $path.IO.parent;
my %provides = Foo => 'Foo.pm';
my $dist = Distribution::Hash.new({ :name<Foo>, :%provides }, :$prefix);

$*REPO.install($dist);

throws-like { EVAL q[$*REPO.install($dist)] },
    X::AdHoc,
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

my $cu = $*REPO.need(CompUnit::DependencySpecification.new( :short-name<Foo> ));

isa-ok $cu, CompUnit, '$*REPO.need returns a CompUnit';
is $cu.short-name, 'Foo', '$*REPO.need returned correct CompUnit';

isa-ok ::('Foo'), Failure, 'symbol Foo is unknown after loading it';

GLOBALish.WHO.merge-symbols($cu.handle.globalish-package);

ok ::('Foo') !~~ Failure, 'symbol Foo is known after merging global symbols';

is $*REPO.loaded.elems, 1, 'one CompUnit got loaded';
ok $*REPO.loaded[0].short-name =:= $cu.short-name, 'the loaded CompUnit is the one returned by $*REPO.need';

rm_rf $path.IO;

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
