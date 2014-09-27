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

my @rakudo-files = map {~$_}, dir;
my @rakudo-expected = <Makefile VERSION CREDITS LICENSE>;
ok @rakudo-expected (<=) @rakudo-files, "dir"
   or diag "missing: {@rakudo-expected (-) @rakudo-files}";

my @test-files = map *.subst('\\', '/'), dir 't';
my @test-expected = <t/spectest.data>;
ok @test-expected (<=) @test-files, 'dir'
   or diag "got: {@test-files} missing: {@test-expected (-) @test-files}";

my $fh = open 'CREDITS';

is $fh.gist.substr(0,2), 'IO', 'IO handle gist';
is $fh.getc, '=', 'first char of CREDITS';
is $fh.get.chomp, 'pod', 'first line of CREDITS';

my $new = temp_name 'new';
$fh.close; $fh = open "$new", :w; # open for writing

is $fh.gist.substr(0,2), 'IO', 'IO handle gist';

is_deeply $fh.print('foo'), True, 'print';

is_deeply $fh.say('bar'), True, 'say';

$fh.close;

is slurp($new).chomp, 'foobar', 'slurp';

is_deeply 'LICENSE'.IO ~~ :e, True, 'IO :e';
is_deeply 'LICENSE'.IO ~~ :d, False, 'IO :d';
is_deeply 'LICENSE'.IO ~~ :f, True, 'IO :e';

# tidy up
try unlink $new;





