use v6;
use Test;

plan 2;

# RT #125515
constant $read-file = "t/spec/packages/README".IO;
$read-file.IO.r or bail-out "Missing $read-file that is needed to run a test";

my @got;
for ^400 {
    my $p = $*DISTRO.is-win
        ?? Proc::Async.new( | «cmd /c type $read-file» )
        !! Proc::Async.new( | «/bin/cat    $read-file» );
    my $output = '';
    $p.stdout.tap: -> $s { $output ~= $s; };
    await $p.start;
    @got.push: $output;
}
is @got.unique.elems, 1, 'Proc::Async consistently reads data';

# RT #129291
{
    if $*DISTRO.is-win {
        skip 1, 'not sure how to test input redirection on Windows';
    } else {
        lives-ok
            { for ^400 { my $p = run(:out, :bin, 'ls'); run(:in($p.out), 'true') } },
            "run()ning two procs and passing the :out of one to the :in of the other doesn't segfault";
    }
}
