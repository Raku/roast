# http://perl6advent.wordpress.com/2012/12/15/day-15-phasers-set-to-stun/
use v6;
use Test;

our $in_prompt;
our $run-time;
$run-time = True;
ok $run-time, "post INIT";

class C {
    method issue_prompt($ctx, $cur_file) {
	ENTER $in_prompt = True;
	LEAVE $in_prompt = False;

	# Lots of stuff here
	is_deeply $in_prompt, True, 'ENTER phaser';
    }
}

is_deeply $in_prompt, Any, 'pre ENTER/LEAVE';

C.issue_prompt(42, 'foo');
is_deeply $in_prompt, False, 'LEAVE phaser';

sub Open($file, :$w) {
    plan 11;
    nok $run-time, "INIT sub call";
    is $file, 'logfile', 'INIT sub arg';
    is_deeply $w, True, 'INIT sub arg';
    return 42;
}

sub log($msg) {
    my $fh = INIT Open("logfile", :w);
    is $fh, 42, 'INIT runtime assign';
}

log('hi');

my %scores = (
    alice => 3,
    bob => 2,
    camelia => 42
    );

my $output;
{

    temp $*OUT = class {
	method print(*@args) {
	    $output ~= @args.join;
	}
    }

    for %scores.kv -> $player, $score {
	FIRST say "Score\tPlayer";
	FIRST say "-----\t------";
	LAST  say "-----\t------";

	NEXT (state $best_score) max= $score;
	LAST say "BEST SCORE: $best_score";

	say "$score\t$player";
    }
}

#?rakudo.moar todo 'RT121722'
#?rakudo.jvm todo 'Hash ordering quirk'
is $output, q:to"END", 'FIRST/NEXT/LAST example';
Score	Player
-----	------
3	alice
2	bob
42	camelia
-----	------
BEST SCORE: 42
END

my @success;
my @failure;

sub process($file) {
    KEEP push @success, $file;
    UNDO push @failure, $file;

    return $file ~~ /bad/ ?? Mu !! True;
}

for <yay yippe sinbad good baddie> {
    process($_)
}

is_deeply @success, [qw<yay yippe good>], 'KEEP';
is_deeply @failure, [qw<sinbad baddie>], 'UNDO';

# vim: ft=perl6
