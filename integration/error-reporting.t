use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 33;

is_run "use v6;\n'a' =~ /foo/", {
    status  => { $_ != 0 },
    out     => '',
    err     => rx/<<2>>/
}, 'Parse error contains line number';

is_run "my \$x = 2 * 3;\ndie \$x", {
    status  => { $_ != 0 },
    out     => '',
    err     => all(rx/6/, rx/<<2>>/),
}, 'Runtime error contains line number';

is_run "use v6;\n\nsay 'Hello';\nsay 'a'.my_non_existent_method_6R5();",
    {
        status  => { $_ != 0 },
        out     => /Hello\r?\n/,
        err     => all(rx/my_non_existent_method_6R5/, rx/<<4>>/),
    }, 'Method not found error mentions method name and line number';

# https://github.com/Raku/old-issue-tracker/issues/1795
is_run 'use v6;
sub bar {
    pfff();
}

bar()',
    {
        status => { $_ != 0 },
        out     => '',
        err     => all(rx/pfff/, rx/<<3>>/),
    }, 'got the right line number for nonexisting sub inside another sub';

is_run 'say 42; nosuchsub()',
    {
        status  => { $_ != 0 },
        out     => '',
        err     => rx/nosuchsub/,
    },
    'non-existing subroutine is caught before run time';

# https://github.com/Raku/old-issue-tracker/issues/1689
{
    subset Even of Int where { $_ %% 2 };
    sub f(Even $x) { $x };
    try { EVAL 'f(3)' };
    my $e = "$!";
    diag "Error message: $e";
    ok $e ~~ /:i 'type check'/,
        'subset type check fail mentions type check';
    ok $e ~~ /:i constraint/,
        'subset type check fail mentions constraint';
}

# https://github.com/Raku/old-issue-tracker/issues/1878
is_run 'use v6;
class A { has $.x is rw };
A.new.x(42);',
    {
        status => { $_ != 0 },
        out     => '',
        err     => rx/<<3>>/,
    }, 'got the right line number for accessors';

# https://github.com/Raku/old-issue-tracker/issues/2300
is_run 'say 0080982',
    {
        status => 0,
        out => "80982\n",
        err => rx/ octal /,
    }, 'use of leading zero causes warning about octal';

# https://github.com/Raku/old-issue-tracker/issues/2011
is_run 'my $ = 2; my $ = 3; say q[alive]',
    {
        status  => 0,
        err     => '',
        out     => "alive\n",
    }, 'multiple anonymous variables do not warn or err out';

# https://github.com/Raku/old-issue-tracker/issues/2744
#?rakudo.jvm todo 'Use of uninitialized value of type Any in numeric context'
is_run 'sub mysub {
        + Any # trigger an uninitialized warning
    };
    mysub()',
    {
        status  => 0,
        err     => /<<2>>/ & /<<mysub>>/,
        out     => '',
    }, 'warning reports correct line number and subroutine';

# https://github.com/Raku/old-issue-tracker/issues/2144
is_run 'die "foo"; END { say "end run" }',
    {
        status => * != 0,
        err    => rx/foo/,
        out    => "end run\n",
    },
    'END phasers are run after die()';

# https://github.com/Raku/old-issue-tracker/issues/2799
{
    try EVAL 'use v6;     # line 1
             # another line so we three in total
             (1 + 2) = 3; # line 3
        ';

    ok ?( $!.backtrace.any.line == 3),
        'correct line number reported for assignment to non-variable';
}

# https://github.com/Raku/old-issue-tracker/issues/2550
#?DOES 3
{
    use lib $?FILE.IO.parent(2).add("packages/FooBarBaz/lib");
    use Foo;
    try dies();
    ok $!, 'it died';
    my $bt = $!.backtrace;
    ok any($bt>>.file) ~~ /Foo\.pm6/, 'found original file name in the backtrace';
    # note that fudging can change the file extension, so don't check
    # for .t here
    ok any($bt>>.file) ~~ /'error-reporting'\./, 'found script file name in the backtrace';

}

my $b = Backtrace.new;
ok $b.full eq $b.full eq $b.full, "Backtrace may be used more than once";

my $b1;
my $b2;

sub a {
  {
    try die("foo");
    $b1 = $!.backtrace;
  }
  $b2 = $!.backtrace;
};

a();
ok $b1 === $b2, "Backtrace does not change on additional .backtrace";

# https://github.com/Raku/old-issue-tracker/issues/4355
{
    is_run 'class RT125495 {
            sub foo( $class, \@args, $object_name ) is export { 42 }
        }',
        {
            status  => { $_ != 0 },
            out     => '',
            err     => all(rx:i/obsolete/, rx/'at' \N+ ':2'/),
        }, 'Error for obsolete syntax contains line number';
}

is_run q:b/sub s1 {\nsub s2 {\nfail("foo")\n}\ns2() }\nmy $a = s1();\nsay $a/, {
            err => rx/sub\ss2.*sub\ss1.*thrown/
        }, "Thrown Failure outputs dual backtraces";

# see http://irclog.perlgeek.de/perl6/2015-07-24#i_10947364 and commit c683fe9
#?rakudo.jvm todo 'UnwindException'
is_run 'sub foo { ({a=>1,b=>2}, {c=>3,d=>4}).map({ if (.<a>) {return $_} else { return } }) }; say foo', {
            err => rx:i/Attempt\sto\sreturn\soutside\N+Routine.*in\sblock/
        }, "Correct error and a backtrace for return in mainline code";


# https://github.com/Raku/old-issue-tracker/issues/2802
{
    is_run 'print "a".WHAT',
        {
            status  => 0,
            out     => '',
            err     => all(rx/Str/, rx/\^name|gist|perl|say/)
        }, 'Using type object in string context provides help';
}

# https://github.com/Raku/old-issue-tracker/issues/4614
throws-like 'begin 42', X::Undeclared::Symbols, message => /'BEGIN'/,
    '`BEGIN` suggested when `begin` is used';

# https://github.com/Raku/old-issue-tracker/issues/4917
throws-like 'gather for ^3 -> $a, $b { take 1 }', Exception, backtrace => /line/,
    '`too few positionals` error in gather/for/take includes line number';

# https://github.com/Raku/old-issue-tracker/issues/4462
throws-like ‘%::{''}’, X::Undeclared, line => /^\d+$/,
    Q|useful error message for ‘%::{''}’ construct|;

# https://github.com/Raku/old-issue-tracker/issues/4435
is_run '...', {:out(''), :err{ not $^o.contains: 'Unhandled exception' }},
    'stub code must not produce `Unhandled exception` message';

# https://github.com/Raku/old-issue-tracker/issues/4262
is_run Q[#`{{ my long
	      unfinished comment'],
	      { :out(''), :err{ $^o.contains: 'line 1' }}, 'Unfinished comment error points on correct line';

# https://github.com/Raku/old-issue-tracker/issues/5837
throws-like 'role R-RT130211 { method overload-this(){...} };
             role C-RT130211 { method overload-this(){...} };
             class A does R-RT130211 does C-RT130211 {};',
    X::Comp, :message{ .contains('R-RT130211') and .contains('C-RT130211') },
'all roles with unimplemented method shown in error';


# https://github.com/Raku/old-issue-tracker/issues/5723
group-of 4 => 'X::Multi::NoMatch correct shows named arguments' => {
    my class RT129800 { multi method foo ($) {} }
    throws-like { RT129800.foo: :foo(42) }, X::Multi::NoMatch,
        message => /':foo(Int)'/, 'message mentions our positional';
    throws-like { RT129800.foo: :foo("meow") }, X::Multi::NoMatch,
        message => /':foo(Str)'/, 'type of named is correct';
    throws-like { RT129800.foo: :foo(my class Foo {}) }, X::Multi::NoMatch,
        message => /':foo(Foo)'/, 'custom types detected';
    throws-like { RT129800.foo: :foo(my class Foo {method raku {die}}) },
            X::Multi::NoMatch, message => /':Foo'/,
    'fallback mechanism works';
}

# https://github.com/Raku/old-issue-tracker/issues/5754
subtest 'composition errors do not crash when printing' => {
    plan 2;

    #?rakudo.jvm todo 'StackOverflowError'
    throws-like '-> ::RT129906 { class :: is RT129906 {} }',
        X::Inheritance::Unsupported,  message => /RT129906/,
    'Accessing X::Inheritance::Unsupported.message does not crash';

    #?rakudo.jvm todo 'StackOverflowError'
    throws-like 'class A129906 { ... }; class B129906 '
            ~ 'does A129906 { }; role A129906 { }',
        X::Composition::NotComposable,  message => /129906/,
    'Accessing X::Composition::NotComposable.message does not crash';
}

# https://irclog.perlgeek.de/perl6/2016-12-20#i_13774176
throws-like { await start die 'test' }, Exception,
	backtrace => *.is-runtime.so,
'broken promise exception backtrace knows it is runtime';

# https://github.com/Raku/old-issue-tracker/issues/6148
is_run "\n" x 1336 ~ 'use x $;', {err => /1337/},
    'bad `use` gives line number in error message';

subtest 'Backtrace.gist' => { # https://github.com/rakudo/rakudo/issues/1521
    plan 2;
    sub foo { die };
    try foo;
    like $!.backtrace.gist, /^ 'Backtrace(' \d+ ' frames)' $/,
        'backtrace with multiple frames uses plural "frames" in .gist';

    my $b;
    repeat { $b := Backtrace.new: $++ } until $b.list.elems == 1;
    is $b.gist, 'Backtrace(1 frame)',
        'backtrace with one frame uses singular "frame" in .gist';
}

# vim: expandtab shiftwidth=4
