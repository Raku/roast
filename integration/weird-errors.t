use v6;
use Test;
BEGIN { @*INC.push: 't/spec/packages' };
use Test::Util;

plan 7;

# this used to segfault in rakudo
#?niecza skip 'todo'
is_run(
       'try { die 42 }; my $x = $!.WHAT; say $x',
       { status => 0, out => -> $o {  $o.chars > 2 }},
       'Can stringify $!.WHAT without segfault',
);

#?niecza skip 'todo'
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
is_run(
    'class A { method postcircumfix:<{ }>() {} }; my &r = {;}; if 0 { if 0 { my $a #OK not used' ~
     "\n" ~ '} }',
    { status => 0, out => '', err => ''},
    'presence of postcircumfix does not lead to redeclaration warnings',
);

eval_dies_ok 'time(1, 2, 3)', 'time() with arguments dies';

# RT #76996
#?niecza todo
lives_ok { 1.^methods>>.sort }, 'can use >>.method on result of introspection';

# RT #76946
#?niecza skip 'todo'
lives_ok { Any .= (); CATCH { when X::AdHoc {1} } }, 'Typed, non-internal exception';

