# http://perl6advent.wordpress.com/2012/12/10/day-10-dont-quote-me-on-it/

use v6;
use Test;
plan 26;

is 'Everybody loves Magical Trevor', q<Everybody loves Magical Trevor>;
is 'Oh wow, it\'s backslashed!', q<Oh wow, it's backslashed!>;
is 'You can include a \\ like this', q<You can include a \ like this>;
is 'Nothing like \n is available', q<Nothing like \n is available>;
is 'And a \ on its own is no problem', q<And a \ on its own is no problem>;

is "Ooh look!\nLine breaks!", q:to"END".chomp;
Ooh look!
Line breaks!
END

my $who = 'Ninochka';
is "Hello, dear $who", q<Hello, dear Ninochka>;

our $Prompt;
our $Response;
sub prompt($str) {
    $Prompt = $str;
    $Response;
}

$Response = 'Jonathan';
is "Hello, { prompt 'Enter your name: ' }!", q<Hello, Jonathan!>;
is $Prompt, q<Enter your name: >;

my @beer = <Chimay Hobgoblin Yeti>;
is "First up, a @beer[0]", q<First up, a Chimay>;
is "Then @beer[1,2].join(' and ')!",q<Then Hobgoblin and Yeti!>;

$Response = 'Starobrno';
is "Tu je &prompt('Ktore pivo chces? ')", q<Tu je Starobrno>;
is $Prompt, q<Ktore pivo chces? >;

is "Please spam me at blackhole@jnthn.net", q<Please spam me at blackhole@jnthn.net>;

is q{C'est la vie}, q:to"END".chomp;
C'est la vie
END

is q{{Unmatched } and { are { OK } in { here}}, q:to"END".chomp;
Unmatched } and { are { OK } in { here
END

sub like($str, $m) {
    my $ok = $str ~~ $m;
    diag "$str does not match"
	unless $ok;
    $ok
}

ok like(qq!Lottery results: {(1..49).roll(6).sort}!, /^'Lottery results:'[' '\d+]**6$/), 'lottery results';

my $pub-with-no-beer = q<Once upon a time, there was a pub. The pub had
lots of awesome beer. One day, a Perl workshop
was held near to the pub. The hackers drank
the pub dry. The pub owner could finally afford
a vacation.
>;

is q:to"THE END", $pub-with-no-beer, 'heredoc auto indent';
    Once upon a time, there was a pub. The pub had
    lots of awesome beer. One day, a Perl workshop
    was held near to the pub. The hackers drank
    the pub dry. The pub owner could finally afford
    a vacation.
    THE END

my @expected-searches = <beer masak vacation whisky>;

my ($input, @searches) = q:to/INPUT/, q:to/SEARCHES/.lines;
    Once upon a time, there was a pub. The pub had
    lots of awesome beer. One day, a Perl workshop
    was held near to the pub. The hackers drank
    the pub dry. The pub owner could finally afford
    a vacation.
    INPUT
    beer
    masak
    vacation
    whisky
    SEARCHES

is $input, $pub-with-no-beer;
is_deeply @searches, @expected-searches;

my @results = gather {
   for @searches -> $s {
   take $input ~~ /$s/
        ?? "Found $s"
        !! "Didn't find $s";
   }
};

is_deeply @results, [q:to"END RESULTS".lines], 'search results';
Found beer
Didn't find masak
Found vacation
Didn't find whisky
END RESULTS

ok like(qq:!s"It costs $10 to {<eat nom>.pick} here.", /^'It costs $10 to '[eat|nom]' here.'$/), 'quoting features';

is Q{$*OS\n&sin(3)}, q:to"END".chomp;
$*OS\n&sin(3)
END

ok like(Q:s{$*OS\n&sin(3)}, /\w+ .*? '\n&sin(3)'/), 'Q:s(...)';

ok like(Q:s:b{$*OS\n&sin(3)}, /\w+ .*? \n '&sin(3)'/), 'Q:s:b(...)';

ok like(Q:s:b:f{$*OS\n&sin(3)}, /\w+ .*? \n '0.14112'\d+$/), 'Q:s:b:f(...)';
