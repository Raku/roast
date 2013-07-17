use v6;
use Test;

plan 16;

BEGIN { @*INC.push('t/spec/packages') };

use Test::Util;

is_run "use v6;\n'a' =~ /foo/", {
    status  => { $_ != 0 },
    out     => '',
    err     => rx/<<2>>/
}, 'Parse error contains line number';

#?rakudo.jvm todo "nigh"
is_run "my \$x = 2 * 3;\ndie \$x", {
    status  => { $_ != 0 },
    out     => '',
    err     => all(rx/6/, rx/<<2>>/),
}, 'Runtime error contains line number';

#?rakudo.jvm todo "nigh"
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
    try { eval 'f(3)' };
    my $e = "$!";
    diag "Error message: $e";
    ok $e ~~ /:i 'type check'/,
        'subset type check fail mentions type check';
    ok $e ~~ /:i constraint/,
        'subset type check fail mentions constraint';
}

# RT #76112
#?rakudo.jvm todo "nigh"
is_run 'use v6;
class A { has $.x is rw };
A.new.x(42);',
    {
        status => { $_ != 0 },
        out     => '',
        err     => rx/<<3>>/,
    }, 'got the right line number for accessors';

# RT #80982
#?rakudo.jvm todo "nigh"
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
    try eval '          # line 1
        use v6;         # line 2
        (1 + 2) = 3;    # line 3
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
    ok $!, 'RT 103034 -- died';
    my $bt = $!.backtrace;
    #?rakudo.jvm todo "nigh"
    ok any($bt>>.file) ~~ /Foo\.pm/, 'found original file name in the backtrace';
    # note that fudging can change the file extension, so don't check
    # for .t here
    ok any($bt>>.file) ~~ /'error-reporting'\./, 'found script file name in the backtrace';

}

# vim: ft=perl6
