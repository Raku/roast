# http://perl6advent.wordpress.com/2010/12/03/day-3-file-operations/

use v6;
use Test;

plan 12;

sub temp_name(Str $fnbase is copy) {
    $fnbase ~= '-' ~ $*PID if defined $*PID;
    $fnbase ~= '-' ~ 1_000_000.rand.Int;
    $fnbase ~= '.tmp';
    return $fnbase;
}

# Directories

# Make sure roast root is our current directory
chdir $?FILE.IO.parent(2);

my @roast-files = map {$_.relative}, dir;
my @roast-expected = <TODO LICENSE README.md>;
ok @roast-expected (<=) @roast-files, "dir"
   or diag "missing: {@roast-expected (-) @roast-files}";

my @test-files = (dir 't').map: *.relative ;
my @test-expected = (<fudge fudgeandrun>.map: {  ("t/" ~ $_ ~ ".t").IO }).map: *.relative;
ok @test-expected (<=) @test-files, 'dir'
   or diag "got: {@test-files} missing: {@test-expected (-) @test-files}";

my $fh = open 'TODO';

is $fh.gist.substr(0,2), 'IO', 'IO handle gist';
is $fh.getc, 'T', 'first char of TODO';
is $fh.get.chomp, 'ODO items for the Raku Test Suite', 'first line of TODO';

my $new = temp_name 'new';
$fh.close; $fh = open "$new", :w; # open for writing

is $fh.gist.substr(0,2), 'IO', 'IO handle gist';

is-deeply $fh.print('foo'), True, 'print';

is-deeply $fh.say('bar'), True, 'say';

$fh.close;

is slurp($new).chomp, 'foobar', 'slurp';

is-deeply 'LICENSE'.IO ~~ :e, True, 'IO :e';
is-deeply 'LICENSE'.IO ~~ :d, False, 'IO :d';
is-deeply 'LICENSE'.IO ~~ :f, True, 'IO :e';

# tidy up
try unlink $new;






# vim: expandtab shiftwidth=4
