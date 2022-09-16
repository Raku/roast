use Test;
use lib $?FILE.IO.parent(2).add('packages/Test-Helpers');
use lib $?FILE.IO.parent(2).add('packages/' ~ $?FILE.IO.parent(1).basename ~ '/multi-version/');
use Test::Util;
use MultiVer;

plan 5;

srand Date.today.DateTime.posix;

sub is-output(Proc:D $p, Str:D $message = "script output", *%matchers) is test-assertion {
    subtest $message => {
        for %matchers.kv -> $key, $matcher {
            my $pattr = $p."$key"();
            $pattr .= slurp if $pattr ~~ IO::Handle;
            cmp-ok $pattr, &[~~], $matcher, $key;
        }
    }
}

sub make_dep_spec(%vers, @keys) {
    @keys.map({ ":$_\<" ~ %vers{$_} ~ ">" }).join
}

subtest "Basics" => {
    is MultiVer.^ver, v0.0.42, "default 'ver' is picked from META6.json";
    is MultiVer.^api, v0.1.1,  "default 'api' is picked from META6.json";
    is MultiVer.^auth, 'ecosys:raku',  "default 'auth' is picked from META6.json";
    is MultiVer::Foo.^ver, v0.0.2, "version can be explicitly overriden";
    is MultiVer::Foo.^api, v0.1.1, "omitted key is still picked from META6.json";
}

# List of versions for CURFS distributions
my @fs-versions =
    { :api<0.0.11>, :ver<0.1.11>, :auth<fs:raku> },
    { :api<0.0.12>, :ver<0.1.12>, :auth<fs:raku> },
    { :api<0.0.13>, :ver<0.1.13>, :auth<fs:raku> };

# List of versions for Installation distributions
my @inst-versions =
    { :api<0.2.11>, :ver<0.3.11>, :auth<inst:raku> },
    { :api<0.2.12>, :ver<0.3.12>, :auth<inst:raku> },
    { :api<0.2.13>, :ver<0.3.13>, :auth<inst:raku> };

# For error testing
my @bad-versions =
    { :ver<99>, :message('bad version') },
    { :api<13>, :message('bad api') },
    { :auth<bad:one>, :message('bad auth') },
    { :ver<0.1.12>, :api<13>, :message('ver is good but api is not') },
    { :ver<0.112>, :api<0.0.11>, :message('api is good but ver is not') },
    { :api<0.0.13>, :ver<0.1.13>, :auth<bad:one>, :message('both ver and api are good but not auth') },
    ;

sub test-good(MultiVer:D $mv, @versions, :@compiler-args) is test-assertion {
    subtest "Good dependencies" => {
        plan +@versions * 3;
        for <ver api>.combinations(1..*) -> @keys {
            my $code = "use MVDist;\nprint " ~ @keys.map({ qq[":$_\<", MVDist.^$_, ">"] }).join(", ") ~ ";";
            for @versions -> %good {
                my $dep_spec = make_dep_spec(%good, @keys);
                my $st-dist = $mv.make-dist(:dist<TestDist>, fields => {:$dep_spec}, :standalone);
                subtest "with " ~ $dep_spec => {
                    plan 2;
                    is-output
                        $mv.run-standalone($code, :use-lib), "basic use",
                        :out($dep_spec), :err(''), :exitcode(0);
                    is-output
                        $mv.run-standalone('EVAL ' ~ $code.raku ~ ';', :use-lib), "use within EVAL",
                        :out($dep_spec), :err(''), :exitcode(0);
                }
            }
        }
    }
}

sub test-bad(MultiVer:D $mv, @versions, :@compiler-args) is test-assertion {
    subtest "Bad dependencies" => {
        plan +@versions;
        for @versions -> %bad {
            my $dep_spec = make_dep_spec(%bad, %bad.keys.grep(<api ver auth>.any));
            my $st-dist = $mv.make-dist(:dist<TestDist>, fields => {:$dep_spec}, :standalone);
            is-output
                $mv.run-standalone('use MVDist;', :use-lib),
                %bad<message> ~ " (dep.spec: $dep_spec)",
                :out(''), :err(/"Could not find MVDist:" \w+/), :exitcode(1);
        }
    }
}

subtest "FileSystem repository" => {
    plan 2;

    my $mv = MultiVer.new;
    for @fs-versions -> %fields {
        $mv.make-dist(:%fields);
    }

    test-good($mv, @fs-versions);
    test-bad($mv, @bad-versions);
}

subtest "Installation repository" => {
    plan 3;
    my $mv = MultiVer.new;
    for @inst-versions -> %fields {
        $mv.install-dist(:%fields);
    }

    subtest "Control" => {
        plan 2;
        my @installed = $mv.inst-repo.installed;
        is +@installed, +@inst-versions, "all distros are installed";
        ok @installed.map(*.meta<name>).all eq 'MVDist', "all installed distros are ours";
    }

    test-good($mv, @inst-versions);
    test-bad($mv, @bad-versions);
}

subtest "Mix FileSystem and Installation" => {
    plan 2;

    my $mv = MultiVer.new;
    for @fs-versions -> %fields {
        $mv.make-dist(:%fields);
    }
    for @inst-versions -> %fields {
        $mv.install-dist(:%fields);
    }

    test-good($mv, (@fs-versions, @inst-versions).flat);
    test-bad($mv, @bad-versions);
}

subtest "Specification Syntax Error" => {
    plan 2;
    my $mv = MultiVer.new;

    $mv.make-dist(fields => @fs-versions.head);
    $mv.make-dist(:dist<TestDist>, fields => {:dep_spec(':?')}, :standalone);
    is-output
        $mv.run-standalone('CATCH { say .^name; }; EVAL "use MVDist;"', :use-lib), "bad spec line causes an error",
        :out(/^"X::CompUnit::META::DependencySyntax" >>/), :err(/:i sorry .* "invalid syntax"/), :exitcode(1);

    $mv.make-dist(:dist<TestDist>, fields => {:dep_spec(':api(no_ver)')}, :standalone);
    is-output
        $mv.run-standalone('CATCH { say .^name; }; EVAL "use MVDist;"', :use-lib), "bad spec line causes an error",
        :out(/^"X::CompUnit::META::DependencySyntax" >>/), :err(/:i sorry .* "undeclared routine" .* no_ver/), :exitcode(1);
}