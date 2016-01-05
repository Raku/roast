use v6;
use Test;
use lib 't/spec/packages';
use Test::Util;

plan 19;

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

is_run(
       '[].WHAT.say',
       { status => 0, out => "(Array)\n"},
       'Can [].WHAT.say',
);

# RT #70922
is_run(
    'class A { method postcircumfix:<{ }>() {} }; my &r = {;}; if 0 { if 0 { my $a #OK not used' ~
     "\n" ~ '} }',
    { status => 0, out => '', err => ''},
    'presence of postcircumfix does not lead to redeclaration warnings',
);

my $code = q:to'--END--';
    my $x;
    multi sub foo($n where True) { temp $x; }
    foo($_) for 1 ... 1000;
    print 'alive';
    --END--

# RT #123686 & RT #124318
is_run(
       $code,
       { status => 0, out => "alive"},
       'multi sub with where clause + temp stress',
);

throws-like { EVAL 'time(1, 2, 3)' },
  X::Undeclared::Symbols,
  'time() with arguments dies';

# RT #76996
#?niecza todo
lives-ok { 1.^methods>>.sort }, 'can use >>.method on result of introspection';

# RT #76946
#?niecza skip 'todo'
lives-ok { Any .= (); CATCH { when X::Method::NotFound {1} } }, 'Typed, non-internal exception';

# RT #90522
{
    my $i = 0;
    sub foo {
        return if ++$i == 50;
        EVAL 'foo';
    }
    lives-ok { foo }, 'can recurse many times into &EVAL';
}

# RT #77246
{
    throws-like { EVAL '_~*.A' },
      X::Undeclared::Symbols,
      'weird string that once parsed in rakudo';
}

# RT #115284
{
    lives-ok { EVAL 'say(;:[])' }, 'weird code that used to parsefail rakudo';
}

# RT #76432
{
    lives-ok { EVAL 'class A {
        has %!x;
    
        method m {
            sub foo {
            }
    
            %!x<bar> = 42;
        }
    }' }, "still able to parse statement after sub decl ending in newline";
}

# RT #116268
{
    try EVAL '
        proto bar {*}
        multi bar ($baz) { "BAZ" }
        class Blorg {
            method do_stuff { bar "baz" }
        }
        Blorg.new.do_stuff
    ';
    ok ~$! ~~ / 'Calling bar(' .*? 'will never work' .*? 'proto' /, "fails correctly";
}

# RT #123570
{
    is ((((6103515625/5) * 4 + 123327057) ** 2) % 6103515625),
        (((1220703125 * 4 + 123327057) ** 2) % 6103515625),
        "at one point rakudo evaluated the first expression to 0, RT #123570"
}

# RT #125365
is_run(
       '0.^methods(:all).sort',
       { status => 0, err => -> $o {  $o.chars > 2 }},
       'sorting method list does not segfault',
);

# RT #123684
is_run '{;}',
    {
        status => 0,
        err    => '',
    },
    'empty code block does not crash (used to do that on JVM)';

{
    is_run('(1,2,3).map({ die "oh noes" })',
    {
        out => '',
        err => { .chars < 256 && m/'oh noes'/ },
    },
    'concise error message when sinking last statement in a file' );
}

#RT #119999
#?rakudo todo 'Feels like a bogus test in light of recent changes'
throws-like { EVAL '&&::{}[];;' },
  X::Undeclared::Symbols,
  "Doesn't die with weird internal error";

#RT #115326
{
    is_run('(:::[])',
    {
        out => '',
        err => { m/'Could not locate compile-time value'/ },
    },
    'appropriate error message instead of internal compiler error' );
}
