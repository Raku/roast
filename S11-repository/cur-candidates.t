use v6;
use Test;
use lib $?FILE.IO.parent(2).add: 'packages/Test-Helpers';
use Test::Util;


my sub dependencyspecification(%_) {
    CompUnit::DependencySpecification.new(
        short-name      => %_<name>,
        auth-matcher    => %_<auth>                    // True,
        version-matcher => %_<ver version>.first(*.so) // True,
        api-matcher     => %_<api>                     // True,
    )
}


subtest 'Basic recommendation manager queries' => {
    my %meta1 = %( :perl<6.c>, :name<XXX>, :ver<1>, :api<1>, :auth<foo>, :provides(:XXX<lib/XXX.pm6>) );
    %meta1 does role :: {
        has $.to-json = q:to/END_JSON/
            {
                "perl" : "6.c",
                "name" : "XXX",
                "ver"  : "1",
                "api"  : "1",
                "auth" : "foo",
                "provides" : {
                    "XXX" : "lib/XXX.pm6"
                }
            }
            END_JSON
    }

    my %meta2 = %( :perl<6.c>, :name<XXX>, :ver<1>, :api<2>, :auth<bar>, :provides(:XXX<lib/XXX.pm6>) );
    %meta2 does role :: {
        has $.to-json = q:to/END_JSON/
            {
                "perl" : "6.c",
                "name" : "XXX",
                "ver"  : "1",
                "api"  : "2",
                "auth" : "bar",
                "provides" : {
                    "XXX" : "lib/XXX.pm6"
                }
            }
            END_JSON
    }

    my $dist1-dir  = make-test-dist(%meta1).prefix;
    my $dist2-dir  = make-test-dist(%meta2).prefix;
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
        my %meta = %( :perl<6.c>, :name<XXX::Old>, :auth<foo>, :provides(:XXX<lib/XXX.pm6>), :resources(<config.txt libraries/foo>) );
        %meta does role :: {
            has $.to-json = q:to/END_JSON/
                {
                    "perl" : "6.c",
                    "name" : "XXX::Old",
                    "auth" : "foo",
                    "provides" : {
                        "XXX" : "lib/XXX.pm6"
                    },
                    "resources" : [
                        "config.txt",
                        "libraries/foo"
                    ]
                }
                END_JSON
        }

        # Try with a META6.json (-I.) and without a META6.json (-Ilib)
        with make-test-dist(%meta) {
            for "{$_.prefix}", "{$_.prefix}/lib" -> $prefix {
                # Add a bin/my-script to the dist
                my $bin-dir = $prefix.IO.basename eq 'lib'
                    ?? $prefix.IO.parent.child('bin')
                    !! $prefix.IO.child('bin');
                $bin-dir.mkdir unless $bin-dir.e;
                $bin-dir.child('my-script').spurt('use XXX; sub MAIN($name-path) { print resources(){$name-path} }');

                my $dist = CompUnit::Repository::FileSystem.new(:$prefix).candidates('XXX').head;
                my $resource-universal-path = 'resources/libraries/foo';
                my $resource-platform-path  = $dist.meta<files>.hash{$resource-universal-path};

                ok $dist.meta<files>.hash<resources/config.txt>;
                is $dist.meta<files>.hash{$resource-universal-path}, $resource-platform-path;
                ok $dist.meta<files>.hash<bin/my-script>;

                ok $dist.content('resources/config.txt').open(:bin).slurp.decode.chars;
                ok $dist.content($resource-universal-path).open(:bin).slurp.decode.chars;
                ok $dist.content('lib/XXX.pm6').open(:bin).slurp.decode.contains('resources is export');
                is $dist.content('bin/my-script').open(:bin).slurp.decode, 'use XXX; sub MAIN($name-path) { print resources(){$name-path} }';

                my $test-resources-script = $dist.content('bin/my-script').open(:bin).slurp.decode;
                ok run(:out, $*EXECUTABLE, '-I', $prefix, '-e', $test-resources-script, 'config.txt').out.slurp(:close).ends-with('config.txt');
                ok run(:out, $*EXECUTABLE, '-I', $prefix, '-e', $test-resources-script, 'libraries/foo').out.slurp(:close).ends-with($resource-platform-path.IO.basename);
                is run(:out, $*EXECUTABLE, '-I', $prefix, '-e', $test-resources-script, 'doesnt-exist').out.slurp(:close).chars, 0;

                subtest 'Installation' => {
                    my $repo = CompUnit::RepositoryRegistry.repository-for-spec("inst#" ~ make-temp-dir().child('my-repo').absolute);
                    my $cu-depspec = CompUnit::DependencySpecification.new(:short-name<XXX>);

                    is $repo.candidates($cu-depspec).elems, 0;
                    nok $repo.resolve($cu-depspec);

                    ok $repo.install($dist);
                    is $repo.candidates($cu-depspec).elems, 1;
                    ok $repo.resolve($cu-depspec);

                    is $repo.files('bin/my-script').elems, 1;

                    my $proc = run :out, $*EXECUTABLE, '-I', $repo.path-spec, '-e', 'CompUnit::RepositoryRegistry.run-script("my-script")', 'config.txt';
                    is $proc.exitcode, 0;
                    ok $proc.out.slurp(:close).ends-with('.txt'); # filename will be SOMEHASH.txt so jut check for the extension
                }
            }
        }
    }
}


done-testing;

# vim: expandtab shiftwidth=4
