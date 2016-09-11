use v6;
use lib 't/spec/packages';

use Test;
plan 27;

use Test::Util;

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

# RT #75446
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

# RT #74348
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

# RT #76112
is_run 'use v6;
class A { has $.x is rw };
A.new.x(42);',
    {
        status => { $_ != 0 },
        out     => '',
        err     => rx/<<3>>/,
    }, 'got the right line number for accessors';

# RT #80982
is_run 'say 0080982',
    {
        status => 0,
        out => "80982\n",
        err => rx/ octal /,
    }, 'use of leading zero causes warning about octal';

# RT #76986
#?niecza todo
is_run 'my $ = 2; my $ = 3; say q[alive]',
    {
        status  => 0,
        err     => '',
        out     => "alive\n",
    }, 'multiple anonymous variables do not warn or err out';

# RT #112724
#?rakudo.jvm todo "nigh"
#?rakudo.moar todo "nigh"
is_run 'sub mysub {
        + Any # trigger an uninitialized warning
    };
    mysub()',
    {
        status  => 0,
        err     => /<<2>>/ & /<<mysub>>/,
        out     => '',
    }, 'warning reports correct line number and subroutine';

# RT #77736
#?niecza todo
is_run 'die "foo"; END { say "end run" }',
    {
        status => * != 0,
        err    => rx/foo/,
        out    => "end run\n",
    },
    'END phasers are run after die()';

# RT #113848
{
    try EVAL 'use v6;     # line 1
             # another line so we three in total
             (1 + 2) = 3; # line 3
        ';

    #?niecza skip "Unable to resolve method backtrace in type Str"
    ok ?( $!.backtrace.any.line == 3),
        'correct line number reported for assignment to non-variable';
}

# RT #103034
#?niecza skip 'sub ucfirst($thing) is export(:DEFAULT) blows up'
#?DOES 3
{
    use lib 't/spec/packages';
    use Foo;
    try dies();
    ok $!, 'RT #103034 -- died';
    my $bt = $!.backtrace;
    ok any($bt>>.file) ~~ /Foo\.pm/, 'found original file name in the backtrace';
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

# RT #125495
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

is_run 'sub s1 { sub s2 { fail("foo"); }; s2()(); }; s1();', {
            err => rx/sub\ss2.*sub\ss1.*thrown<-[s]>+sub\ss1/
        }, "Thrown Failure outputs dual backtraces";

# see http://irclog.perlgeek.de/perl6/2015-07-24#i_10947364 and commit c683fe9
#?rakudo.jvm todo 'UnwindException'
is_run 'sub foo { ({a=>1,b=>2}, {c=>3,d=>4}).map({ if (.<a>) {return $_} else { return } }) }; say foo', {
            err => rx:i/Attempt\sto\sreturn\soutside\N+Routine.*in\sblock/
        }, "Correct error and a backtrace for return in mainline code";


# RT #113888
{
    is_run 'print "a".WHAT',
        {
            status  => 0,
            out     => '',
            err     => all(rx/Str/, rx/\^name|gist|perl|say/)
        }, 'Using type object in string context provides help';
}

# RT #128803
{
    is_run '*...‘WAT’', {
        err => rx/^ [ <!after 'SORRY'> . ]+ $/,
    }, 'runtime time errors do not contain ==SORRY==';
}

# RT #126264
throws-like 'begin 42', X::Undeclared::Symbols, message => /'BEGIN'/,
    '`BEGIN` suggested when `begin` is used';

# RT #127012
throws-like 'gather for ^3 -> $a, $b { take 1 }', Exception, backtrace => /line/,
    '`too few positionals` error in gather/for/take includes line number';

# RT #125772
throws-like ‘%::{''}’, X::Undeclared, line => /^\d+$/,
    Q|useful error message for ‘%::{''}’ construct|;


# RT #125680
is_run '...', {:out(''), :err{ not $^o.contains: 'Unhandled exception' }},
    'stub code must not produce `Unhandled exception` message';

# vim: ft=perl6
