use v6;
use Test;
use lib $?FILE.IO.parent(2).add: 'packages/Test-Helpers';
use Test::Util;


subtest "CompUnit::Repository::FileSystem with META6.json" => {
    my $lib-one = $?FILE.IO.parent(2).add: 'packages/EmulatesCurrentDistributionOne';
    my $lib-two = $?FILE.IO.parent(2).add: 'packages/CurrentDistributionOne';

    {
         my $proc = run :out, :!err, $*EXECUTABLE.absolute,
            '-I', $lib-one,
            '-M', 'CurrentDistributionOne',
            '-e',
            'print(distribution())';
        is $proc.exitcode, 0;
        is $proc.out.slurp(:close), '42';
    }

    {
         my $proc = run :out, :!err, $*EXECUTABLE.absolute,
            '-I', $lib-two, '-I', $lib-one,
            '-M', 'CurrentDistributionOne',
            '-e',
            'print(distribution())';
        is $proc.exitcode, 0;
        isnt $proc.out.slurp(:close), '42';
    }
}

subtest "CompUnit::Repository::Installation" => {
    my $cur           = CompUnit::Repository::Installation.new(prefix => make-temp-dir().absolute);
    my $lib           = $cur.path-spec;
    my $dist-path-one = Distribution::Path.new($?FILE.IO.parent(2).add('packages/EmulatesCurrentDistributionOne'));
    my $dist-path-two = Distribution::Path.new($?FILE.IO.parent(2).add('packages/CurrentDistributionOne'));

    $cur.install($dist-path-one);
    {
         my $proc = run :out, :!err, $*EXECUTABLE.absolute,
            '-I', $lib,
            '-M', 'CurrentDistributionOne',
            '-e',
            'print(distribution())';
        is $proc.exitcode, 0;
        is $proc.out.slurp(:close), '42';
    }

    $cur.install($dist-path-two);
    {
         my $proc = run :out, :!err, $*EXECUTABLE.absolute,
            '-I', $lib,
            '-M', 'CurrentDistributionOne',
            '-e',
            'print(distribution())';
        is $proc.exitcode, 0;
        isnt $proc.out.slurp(:close), '42';
    }
}


done-testing;
