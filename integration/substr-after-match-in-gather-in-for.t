use v6.c;
use Test;

plan 1;

lives-ok( {
    for "par 1", "par 2" -> $p {
        gather {
            my $c = $p;                 # make an rw copy
            while $c ~~ /\s/ {
                $c .= substr($/.from);  # remove everything before the ws
                while $c ~~ /^\s/ {     # ...and all ws in beginning of str
                    $c .= substr(1);
                }
            }
        }
    }
}, 'lexicals are bound the way they should, instead of horribly wrong');

