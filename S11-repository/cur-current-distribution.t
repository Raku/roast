use v6;
use Test;
use lib $?FILE.IO.parent(2).add: 'packages/Test-Helpers';
use Test::Util;


subtest "CompUnit::Repository::FileSystem without META6.json" => {
    my $lib-one = $?FILE.IO.parent(2).add: 'packages/CurrentDistributionOne/lib';
    my $lib-two = $?FILE.IO.parent(2).add: 'packages/CurrentDistributionTwo/lib';

    {
         my $proc = run :!out, :!err, $*EXECUTABLE.absolute,
            '-I', $lib-one, '-I', $lib-two,
            '-M', 'CurrentDistributionOne', '-M', 'CurrentDistributionTwo',
            '-e',
            'exit(!$?DISTRIBUTION.defined)';
        is $proc.exitcode, 1;
    }

    {
         my $proc = run :!out, :!err, $*EXECUTABLE.absolute,
            '-I', $lib-one,
            '-M', 'CurrentDistributionOne',
            '-e',
            'exit(!CurrentDistributionOne::distribution.meta{"provides"}{"CurrentDistributionOne"}.defined)';
        is $proc.exitcode, 0;
    }

    {
         my $proc = run :!out, :!err, $*EXECUTABLE.absolute,
            '-I', $lib-one, '-I', $lib-two,
            '-M', 'CurrentDistributionTwo',
            '-e',
            'exit(!CurrentDistributionTwo::distribution.meta{"provides"}{"CurrentDistributionTwo"}.defined)';
        is $proc.exitcode, 0;
    }
}

subtest "CompUnit::Repository::FileSystem with META6.json" => {
    my $lib-one = $?FILE.IO.parent(2).add: 'packages/CurrentDistributionOne';
    my $lib-two = $?FILE.IO.parent(2).add: 'packages/CurrentDistributionTwo';

    {
         my $proc = run :!out, :!err, $*EXECUTABLE.absolute,
            '-I', $lib-one, '-I', $lib-two,
            '-M', 'CurrentDistributionOne', '-M', 'CurrentDistributionTwo',
            '-e',
            'exit(!$?DISTRIBUTION.defined)';
        is $proc.exitcode, 1;
    }

    {
         my $proc = run :!out, :!err, $*EXECUTABLE.absolute,
            '-I', $lib-one,
            '-M', 'CurrentDistributionOne',
            '-e',
            'exit(!CurrentDistributionOne::distribution.meta{"provides"}{"CurrentDistributionOne"}.defined)';
        is $proc.exitcode, 0;
    }

    {
         my $proc = run :!out, :!err, $*EXECUTABLE.absolute,
            '-I', $lib-one, '-I', $lib-two,
            '-M', 'CurrentDistributionTwo',
            '-e',
            'exit(!CurrentDistributionTwo::distribution.meta{"provides"}{"CurrentDistributionTwo"}.defined)';
        is $proc.exitcode, 0;
    }
}

subtest "CompUnit::Repository::Installation" => {
    my $dist-path-one = Distribution::Path.new($?FILE.IO.parent(2).add('packages/CurrentDistributionOne'));
    my $dist-path-two = Distribution::Path.new($?FILE.IO.parent(2).add('packages/CurrentDistributionTwo'));
    my $cur           = CompUnit::Repository::Installation.new(prefix => make-temp-dir().absolute);
    my $lib           = $cur.path-spec;

    $cur.install($dist-path-one);
    $cur.install($dist-path-two);

    {
         my $proc = run :!out, :!err, $*EXECUTABLE.absolute,
            '-I', $lib,
            '-M', 'CurrentDistributionOne', '-M', 'CurrentDistributionTwo',
            '-e',
            'exit(!$?DISTRIBUTION.defined)';
        is $proc.exitcode, 1;
    }

    {
         my $proc = run :!out, :!err, $*EXECUTABLE.absolute,
            '-I', $lib,
            '-M', 'CurrentDistributionOne',
            '-e',
            'exit(!CurrentDistributionOne::distribution.meta{"provides"}{"CurrentDistributionOne"}.defined)';
        is $proc.exitcode, 0;
    }

    {
         my $proc = run :!out, :!err, $*EXECUTABLE.absolute,
            '-I', $lib,
            '-M', 'CurrentDistributionTwo',
            '-e',
            'exit(!CurrentDistributionTwo::distribution.meta{"provides"}{"CurrentDistributionTwo"}.defined)';
        is $proc.exitcode, 0;
    }
}


done-testing;

# vim: expandtab shiftwidth=4
