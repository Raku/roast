use v6;
use Test;
BEGIN { @*INC.push: 't/spec/packages' };
use Test::Util;

plan 1;

# this used to segfault in rakudo
is_run(
       'try { 1/0 }; my $x = $!.WHAT; say ~$x',
       { status => 0, out => sub { .chars > 2 }},
       'Can stringify $!.WHAT without segfault',
);




