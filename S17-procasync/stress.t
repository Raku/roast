use v6;
use Test;

plan 1;

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
