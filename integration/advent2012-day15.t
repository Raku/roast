# http://perl6advent.wordpress.com/2012/12/15/day-15-phasers-set-to-stun/
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
	is-deeply $in_prompt, True, 'ENTER phaser';
    }
}

is-deeply $in_prompt, Any, 'pre ENTER/LEAVE';

C.issue_prompt(42, 'foo');
is-deeply $in_prompt, False, 'LEAVE phaser';

sub Open($file, :$w) is test-assertion {
    plan 11;
    nok $run-time, "INIT sub call";
    is $file, 'logfile', 'INIT sub arg';
    is-deeply $w, True, 'INIT sub arg';
    return 42;
}

sub log($msg) is test-assertion {
    my $fh = INIT Open("logfile", :w);
    is $fh, 42, 'INIT runtime assign';
}

log('hi');

# use array rather than hash - guaranteed order
my @scores = (
    alice => 3,
    bob => 2,
    camelia => 42
    );

my $output;
{

    my $*OUT = class {
	method print(*@args) {
	    $output ~= @args.join;
	}
    }

    for @scores {
        my ($player,$score) = .kv;
	FIRST say "Score\tPlayer";
	FIRST say "-----\t------";
	LAST  say "-----\t------";

	NEXT (state $best_score) max= $score;
	LAST say "BEST SCORE: $best_score";

	say "$score\t$player";
    }
}

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

is-deeply @success, [qw<yay yippe good>], 'KEEP';
is-deeply @failure, [qw<sinbad baddie>], 'UNDO';

# vim: expandtab shiftwidth=4
