use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;


my sub gen-dist-files(%d) {
    my &to-json := -> $o { Rakudo::Internals::JSON.to-json($o) }
    my $dist-dir = make-temp-dir;
    $dist-dir.IO.child('META6.json').spurt(to-json(%d));
    for %d<provides>.grep(*.defined) {
        my $to = $dist-dir.IO.child(.value) andthen {.parent.mkdir unless .parent.e}
        $to.spurt: (qq|unit module {.key}; | ~ q|our sub source-file is export { $?FILE }|);
    }
    for %d<resources>.grep(*.defined) -> $path {
        my $resources-dir = $dist-dir.child('resources');
        my $to = $path ~~ m/^libraries\/(.*)/
            ?? $resources-dir.add('libraries').add( $*VM.platform-library-name($0.Str.IO) )
            !! $resources-dir.add($path);
        $to.parent.mkdir unless $to.parent.e;
        $to.spurt: (qq|resource|);
    }
    return $dist-dir.IO;
}

my sub dependencyspecification(%_) {
    CompUnit::DependencySpecification.new(
        short-name      => %_<name>,
        auth-matcher    => %_<auth>                    // True,
        version-matcher => %_<ver version>.first(*.so) // True,
        api-matcher     => %_<api>                     // True,
    )
}

todo 'Requires PRs 1125 and 1132';
subtest 'Basic recommendation manager queries' => {
    my %meta1      = %( :perl<6.c>, :name<XXX>, :ver<1>, :api<1>, :auth<foo>, :provides(:XXX<lib/XXX.pm6>) );
    my %meta2      = %( :perl<6.c>, :name<XXX>, :ver<1>, :api<2>, :auth<bar>, :provides(:XXX<lib/XXX.pm6>) );
    my $dist1-dir  = gen-dist-files(%meta1);
    my $dist2-dir  = gen-dist-files(%meta2);
    my $cuspec1    = dependencyspecification(%meta1);
    my $cuspec2    = dependencyspecification(%meta2);

    subtest 'CompUnit::Repository::FileSystem' => {
        my $cur1 = CompUnit::Repository::FileSystem.new(prefix => $dist1-dir.absolute);
        my $cur2 = CompUnit::Repository::FileSystem.new(prefix => $dist2-dir.absolute);

        subtest 'sanity' => {
            ok $cur1;
            is $cur1.candidates(dependencyspecification(%( :name<X> ))).elems, 0;
            is $cur1.candidates(dependencyspecification(%( :name<XXX> ))).elems, 1;

            ok $cur2;
            is $cur2.candidates(dependencyspecification(%( :name<X> ))).elems, 0;
            is $cur2.candidates(dependencyspecification(%( :name<XXX> ))).elems, 1;
        }

        # XXX:auth<foo>:api<1>
        is $cur1.candidates($cuspec1).elems, 1;
        is $cur1.candidates($cuspec2).elems, 0;
        is $cur1.candidates(dependencyspecification(%( :name<XXX>, :api<1> ))).elems, 1;
        is $cur1.candidates(dependencyspecification(%( :name<XXX>, :api<2> ))).elems, 0;

        is $cur2.candidates($cuspec1).elems, 0;
        is $cur2.candidates($cuspec2).elems, 1;
        is $cur2.candidates(dependencyspecification(%( :name<XXX>, :api<1> ))).elems, 0;
        is $cur2.candidates(dependencyspecification(%( :name<XXX>, :api<2> ))).elems, 1;

        isnt $cur1.candidates(dependencyspecification(%( :name<XXX>, :api<1> ))).head.meta<api>, $cur2.candidates(dependencyspecification(%( :name<XXX>, :api<2> ))).head.meta<api>;
        nok $cur1.candidates(dependencyspecification(%( :name<XXX>, :api<1> ))).head eqv $cur2.candidates(dependencyspecification(%( :name<XXX>, :api<2> ))).head;
    }

    subtest 'CompUnit::Repository::Installation' => {
        my $cur   = CompUnit::Repository::Installation.new(prefix => make-temp-dir().absolute);
        my $dist1 = Distribution::Path.new($dist1-dir);
        my $dist2 = Distribution::Hash.new(%meta2, prefix => $dist2-dir);

        subtest 'sanity' => {
            ok $cur;
            is $cur.candidates($cuspec1).elems, 0;
            is $cur.candidates($cuspec2).elems, 0;
            is $cur.installed.grep(*.defined).elems, 0; # TODO: make .installed() return Empty?
        }

        # XXX:auth<foo>:api<1>
        ok $cur.install($dist1);
        is $cur.candidates($cuspec1).elems, 1;
        is $cur.candidates($cuspec2).elems, 0;
        is $cur.installed.grep(*.defined).elems, 1;
        is $cur.candidates(dependencyspecification(%( :name<XXX>, :api<1> ))).elems, 1;

        # XXX:auth<bar>:api<2>
        ok $cur.install($dist2);
        is $cur.candidates($cuspec1).elems, 1;
        is $cur.candidates($cuspec2).elems, 1;
        is $cur.installed.grep(*.defined).elems, 2;
        is $cur.candidates(dependencyspecification(%( :name<XXX>, :api<2> ))).elems, 1;

        # xxx: makes sure :api querying works
        isnt $cur.candidates(dependencyspecification(%( :name<XXX>, :api<1> ))).head.meta<api>, $cur.candidates(dependencyspecification(%( :name<XXX>, :api<2> ))).head.meta<api>;
        nok $cur.candidates(dependencyspecification(%( :name<XXX>, :api<1> ))).head eqv $cur.candidates(dependencyspecification(%( :name<XXX>, :api<2> ))).head;

        # handle search for `XXX` (e.g. not explicitly XXX:auth<foo> or XXX:auth<bar>)
        my $cuspec-any-auth = dependencyspecification(%( :name<XXX> ));
        is $cur.candidates($cuspec-any-auth).elems, 2;

        # uninstall dist 1 of 2: XXX:auth<foo>
        ok $cur.uninstall($cur.candidates($cuspec1).head);
        is $cur.candidates($cuspec1).elems, 0;
        is $cur.candidates($cuspec2).elems, 1;
        is $cur.installed.grep(*.defined).elems, 1;

        # uninstall dist 2 of 2: XXX:auth<bar>
        ok $cur.uninstall($cur.candidates($cuspec2).head);
        is $cur.candidates($cuspec1).elems, 0;
        is $cur.candidates($cuspec2).elems, 0;
        is $cur.installed.grep(*.defined).elems, 0;
    }

    subtest '::FileSystem distributions can usually be installed to ::Installation' => {
        # Also tests resources/libraries/* platform-library-name
        my %meta = %(
            perl => '6.c',
            name => 'XXX::Old',
            auth => 'foo',
            provides => {
                'XXX' => 'lib/XXX.pm6',
            },
            resources => [
                'config.txt',
                'libraries/foo'
            ],
        );

        # Try with a META6.json (-I.) and without a META6.json (-Ilib)
        for gen-dist-files(%meta).absolute, gen-dist-files(%meta).child('lib').absolute -> $prefix {
            # Add a bin/my-script to the dist
            my $bin-dir = $prefix.IO.basename eq 'lib'
                ?? $prefix.IO.parent.child('bin')
                !! $prefix.IO.child('bin');
            $bin-dir.mkdir unless $bin-dir.e;
            $bin-dir.child('my-script').spurt('use XXX; sub MAIN() { say source-file(); say %?RESOURCES<config.txt>; say %?RESOURCES<libraries/foo>; exit 0 }');

            my $dist = CompUnit::Repository::FileSystem.new(:$prefix).candidates('XXX').head;
            my $resource-universal-path = 'resources/libraries/foo';
            my $resource-platform-path  = $dist.meta<files>.hash{$resource-universal-path};

            ok $dist.meta<files>.hash<resources/config.txt>;
            is $dist.meta<files>.hash{$resource-universal-path}, $resource-platform-path;
            ok $dist.meta<files>.hash<bin/my-script>;

            is $dist.content('lib/XXX.pm6').open(:bin).slurp.decode, 'unit module XXX; our sub source-file is export { $?FILE }';
            is $dist.content('resources/config.txt').open(:bin).slurp.decode, 'resource';
            is $dist.content($resource-platform-path).open(:bin).slurp.decode, 'resource';
            is $dist.content('bin/my-script').open(:bin).slurp.decode, 'use XXX; sub MAIN() { say source-file(); say %?RESOURCES<config.txt>; say %?RESOURCES<libraries/foo>; exit 0 }';

            subtest 'Installation' => {
                my $repo = CompUnit::RepositoryRegistry.repository-for-spec("inst#" ~ make-temp-dir().child('my-repo').absolute);
                my $cu-depspec = CompUnit::DependencySpecification.new(:short-name<XXX>);

                ok $repo.install($dist);
                is $repo.candidates($cu-depspec).elems, 1;
                ok $repo.resolve($cu-depspec);
            }
        }
    }
}


done-testing;
