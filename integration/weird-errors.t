use v6;
use lib $?FILE.IO.parent(2).add("packages");

use Test;
use Test::Util;

plan 33;

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
lives-ok { 1.^methods>>.sort }, 'can use >>.method on result of introspection';

# RT #76946
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

# RT #125227
{
    my $code = q:to'--END--';
        class C {
            has $!x is rw;
        }
        --END--
    is_run(
        $code,
        { status => 0, err => -> $o { $o ~~ /useless/ && $o ~~ /':2'/ } },
        'useless use of is rw reported on meaningful line'
    );
}

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
        err => { m/"No such symbol ':<>'"/ },
    },
    'appropriate error message instead of internal compiler error' );
}

#RT #127504
{
    throws-like { "::a".EVAL }, X::NoSuchSymbol, symbol => "a",
      "test throwing for ::a";
}

# RT #127748
{
    is_run(q:to/SEGV/, { out => "360360\n" }, 'Correct result instead of SEGV');
        my $a = 14;
        while (True) {
            my $z = (2..13).first(-> $x { !($a %% $x) });
            last if (!$z);
            $a += 14
        }
        say $a
        SEGV
}

# RT #127878

sub decode_utf8c {
    my @ints = 103, 248, 111, 217, 210, 97;
    my $b = Buf.new(@ints);
    my Str $u=$b.decode("utf8-c8");
    $u.=subst("a","b");
}
#?rakudo.jvm todo "Unknown encoding 'utf8-c8' RT #127878"
lives-ok &decode_utf8c, 'RT #127878: Can decode and work with interesting byte sequences';

# RT #128368
sub bar() { foo; return 6 }
sub foo() { return 42 }
my $a = 0;
$a += bar for ^158;  # 157 iterations works fine

is $a, 158 * 6, 'SPESH inline works correctly after 158 iterations';

# RT #127473
eval-lives-ok '(;)', '(;) does not explode the compiler';
eval-lives-ok '(;;)', '(;;) does not explode the compiler';
eval-lives-ok '[;]', '[;] does not explode the compiler';
eval-lives-ok '[;0]', '[;0] does not explode the compiler';

# RT #127208
#?rakudo skip 'RT127208'
#?DOES 1
{
    subtest 'accessing Seq from multiple threads does not segfault' => {
        my $code = Q:to/CODE_END/;
            my @primes = grep { .is-prime }, 1 .. *;
            my @p = gather for 4000, 5, 100, 2000 -> $n {
                take start { @primes[$n] }
            }
            .say for await @p;
            CODE_END

        is_run($code, { :status(1|0) }, 'no segfaults') for ^20;
    }
}

# RT #114672
throws-like ｢class A114672 {}; class B114672 is A114672 { has $!x = 5; ｣
    ~ ｢our method foo(A114672:) { say $!x } }; &B::foo(A.new)｣,
    Exception,
'no segfault';

subtest 'using a null string to access a hash does not segfault' => {
    my $code = Q:to/CODE_END/;
        class HasNativeStr { has str $.attr }
        my %h;
        %h{HasNativeStr.new().attr} = 1;
        CODE_END

    is_run($code, { :status(1|0) }, 'no segfault')
}

# RT #128985
is (^1000 .grep: -> $n {([+] ^$n .grep: -> $m {$m and $n %% $m}) == $n }), (0, 6, 28, 496),
    'No SEGV/crash on reduction in grep using %%';

# https://irclog.perlgeek.de/perl6/2017-04-18#i_14443061
is_run ｢class Foo {}; $ = new Foo:｣, {:out(''), :err(''), :0status },
    'new Foo: calling form does not produce unwanted output';
