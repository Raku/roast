use v6;
use Test;

plan 1;

{
    my $p = Publish.for(1..5);
    my $c = $p.Channel;
    my @a;
    loop {
        winner(
            $c      => { say "pushing"; @a.push($^val) },
            default => { say "done"; @a.push("done"); last }
        );
    }
    is ~@a, "1 2 3 4 5 done", "Publish.for and .Channel work";
}
