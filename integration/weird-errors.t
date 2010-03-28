use v6;
use Test;
BEGIN { @*INC.push: 't/spec/packages' };
use Test::Util;

plan 3;

# this used to segfault in rakudo
is_run(
       'try { 1/0 }; my $x = $!.WHAT; say ~$x',
       { status => 0, out => sub { .chars > 2 }},
       'Can stringify $!.WHAT without segfault',
);

is_run(
       'try { 1/0; CATCH { when * { say $!.WHAT } }; };',
       { status => 0, out => sub { .chars > 2 }},
       'Can say $!.WHAT in a CATCH block',
);

is_run(
       '[].WHAT.say',
       { status => 0, out => "Array()\n"},
       'Can [].WHAT.say',
);



