use v6;
use Test;
BEGIN { @*INC.push: 't/spec/packages' };
use Test::Util;

plan 5;

# this used to segfault in rakudo
#?rakudo todo 'nom regression'
is_run(
       'try { 1/0 }; my $x = $!.WHAT; say ~$x',
       { status => 0, out => -> $o {  $o.chars > 2 }},
       'Can stringify $!.WHAT without segfault',
);

#?rakudo todo 'make 1/0 in void context die?'
is_run(
       'try { 1/0; CATCH { when * { say $!.WHAT } }; };',
       { status => 0, out => -> $o { $o.chars > 2 }},
       'Can say $!.WHAT in a CATCH block',
);

is_run(
       '[].WHAT.say',
       { status => 0, out => "Array()\n"},
       'Can [].WHAT.say',
);

# RT #70922
is_run(
    'class A { method postcircumfix:<{ }>() {} }; my &r = {;}; if 0 { if 0 { my $a } }',
    { status => 0, out => '', err => ''},
    'presence of postcircumfix does not lead to redeclaration warnings',
);

eval_dies_ok 'time(1, 2, 3)', 'time() with arguments dies';


