use v6;
use Test;

plan 2;

# RT #125515
my @got;
for ^100 {
    my $p = $*DISTRO.is-win
        ?? Proc::Async.new( | < cmd /c type README.md > )
        !! Proc::Async.new( | < /bin/cat README.md > );
    my $output = '';
    $p.stdout.tap: -> $s { $output ~= $s; };
    await $p.start;
    @got.push: $output;
}
is @got.unique.elems, 1, 'Proc::Async consistently reads data';

# RT #128291
{
    if $*DISTRO.is-win {
        skip 1, 'not sure how to test input redirection on Windows';
    } else {
        lives-ok
            { for ^10000 { my $p = run(:out, :bin, 'ls'); run(:in($p.out), 'true') } },
            "run()ning two procs and passing the :out of one to the :in of the other doesn't hang";
    }
}
