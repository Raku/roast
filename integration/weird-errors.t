use v6;
use Test;
BEGIN { @*INC.push: 't/spec/packages' };
use Test::Util;

plan 6;

# this used to segfault in rakudo
is_run(
       'try { die 42 }; my $x = $!.WHAT; say $x',
       { status => 0, out => -> $o {  $o.chars > 2 }},
       'Can stringify $!.WHAT without segfault',
);

is_run(
       'try { die 42; CATCH { when * { say $!.WHAT } }; };',
       { status => 0, out => -> $o { $o.chars > 2 }},
       'Can say $!.WHAT in a CATCH block',
);

#?niecza todo
is_run(
       '[].WHAT.say',
       { status => 0, out => "Array()\n"},
       'Can [].WHAT.say',
);

# RT #70922
#?niecza todo "Frustating -- seems to fail because of other warnings"
is_run(
    'class A { method postcircumfix:<{ }>() {} }; my &r = {;}; if 0 { if 0 { my $a } }',
    { status => 0, out => '', err => ''},
    'presence of postcircumfix does not lead to redeclaration warnings',
);

eval_dies_ok 'time(1, 2, 3)', 'time() with arguments dies';

# RT #76996
#?niecza todo
lives_ok { 1.^methods>>.sort }, 'can use >>.method on result of introspection';

