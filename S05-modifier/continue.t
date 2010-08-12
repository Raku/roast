use v6;
use Test;

plan *;

#L<S05/Modifiers/"The :c">

my regex simple { . a };
my $string = "1a2a3a";

{
    $string ~~ m:c/<&simple>/;
    is(~$/, '1a', "match first 'a'");
    $string ~~ m:c/<&simple>/;
    is(~$/, '2a', "match second 'a'");
    $string ~~ m:c/<&simple>/;
    is(~$/, '3a', "match third 'a'");
    $string ~~ m:c/<&simple>/;
    is(~$/, '', "no more 'a's to match");
}

{
    my $m = $string.match(/.a/);
    is(~$m, '1a', "match first 'a'");
    $m = $string.match(/.a/, :c(2));
    is(~$m, '2a', "match second 'a'");
    $m = $string.match(/.a/, :c(4));
    is(~$m, '3a', "match third 'a'");
}

# this batch not starting on the exact point, and out of order
{
    my $m = $string.match(/.a/, :c(0));
    is(~$m, '1a', "match first 'a'");
    $m = $string.match(/.a/, :c(3));
    is(~$m, '3a', "match third 'a'");
    $m = $string.match(/.a/, :c(1));
    is(~$m, '2a', "match second 'a'");
}

{
    my $m = $string.match(/.a/);
    is(~$m, '1a', "match first 'a'");
    $m = $string.match(/.a/, :continue(2));
    is(~$m, '2a', "match second 'a'");
    $m = $string.match(/.a/, :continue(4));
    is(~$m, '3a', "match third 'a'");
}

done_testing;

# vim: syn=perl6 sw=4 ts=4 expandtab
