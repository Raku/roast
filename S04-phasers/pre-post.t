use v6;

use Test;
# Test of PRE and POST traits
#
# L<S04/Phasers/"assert precondition at every block ">
# L<S06/Subroutine traits/PRE/POST>

plan 22;

sub foo(Int $i) {
    PRE {
        $i < 5
    }
    return 4;
}

sub bar(Int $i) {
    return 4;
    POST {
        $i < 5;
    }
}

is foo(2), 4, 'sub with PRE  compiles and runs';
is bar(3), 4, 'sub with POST compiles and runs';

throws-like 'foo(10)',
    X::Phaser::PrePost,
    phaser => 'PRE',
    'Violated PRE  throws (catchable) exception';
throws-like 'bar(10)',
    X::Phaser::PrePost,
    phaser => 'POST',
    'Violated POST throws (catchable) exception';

# multiple PREs und POSTs

sub baz (Int $i) {
    PRE {
        $i > 0
    }
    PRE {
        $i < 23
    }
    return 5;
}
is baz(2), 5, 'sub with two PREs compiles and runs';

throws-like 'baz(-1)',
    X::Phaser::PrePost,
    phaser => 'PRE',
    'sub with two PREs fails when first is violated';
throws-like 'baz(42)',
    X::Phaser::PrePost,
    phaser => 'PRE',
    'sub with two PREs fails when second is violated';


sub qox (Int $i) {
    return 6;
    POST {
        $i > 0
    }
    POST {
        $i < 42
    }
}

is qox(23), 6, "sub with two POSTs compiles and runs";
throws-like 'qox(-1)',
    X::Phaser::PrePost,
    phaser => 'POST',
    "sub with two POSTs fails if first POST is violated";
throws-like 'qox(123)',
    X::Phaser::PrePost,
    phaser => 'POST',
    "sub with two POSTs fails if second POST is violated";


class Another {
    method test(Int $x) {
        return 3 * $x;
        POST {
            $_ > 4
        }
    }
}

my $pt = Another.new;
is $pt.test(2), 6, 'POST receives return value as $_ (succeess)';
throws-like '$pt.test(1)',
    X::Phaser::PrePost,
    phaser => 'POST',
    'POST receives return value as $_ (failure)';

{
    my $str;
    {
        PRE  { $str ~= '('; 1 }
        POST { $str ~= ')'; 1 }
        $str ~= 'x';
    }
    is $str, '(x)', 'PRE and POST run on ordinary blocks';
}

{
    my $str;
    {
        POST  { $str ~= ')'; 1 }
        LEAVE { $str ~= ']' }
        ENTER { $str ~= '[' }
        PRE   { $str ~= '('; 1 }
        $str ~= 'x';
    }
    is $str, '([x])', 'PRE/POST run outside ENTER/LEAVE';
}

{
    my $str;
    try {
        {
            PRE     { $str ~= '('; 0 }
            PRE     { $str ~= '*'; 1 }
            ENTER   { $str ~= '[' }
            $str ~= 'x';
            LEAVE   { $str ~= ']' }
            POST    { $str ~= ')'; 1 }
        }
    }
    is $str, '(', 'failing PRE runs nothing else';
}

{
    my $str;
    try {
        {
            POST  { $str ~= 'z'; 1 }
            POST  { $str ~= 'x'; 0 }
            LEAVE { $str ~= 'y' }
        }
    }
    is $str, 'yx', 'failing POST runs LEAVE but not more POSTs';
}

#?niecza skip 'unspecced'
{
    my $str;
    try {
        POST { $str ~= $! // '<undef>'; 1 }
        die 'foo';
    }
    ok $str ~~ /foo/, 'POST runs on exception, with correct $!';
}

#?niecza skip 'unspecced'
#?rakudo todo 'POST and exceptions RT #124961'
{
    my $str;
    try {
        POST { $str ~= (defined $!) ?? 'yes' !! 'no'; 1 }
        try { die 'foo' }
        $str ~= (defined $!) ?? 'aye' !! 'nay';
    }
    is $str, 'ayeno', 'POST has undefined $! on no exception';
}

#?niecza skip 'unspecced'
#?rakudo.moar todo "POST and exceptions RT #124961"
#?rakudo.jvm skip "POST and exceptions RT #124961"
{
    try {
        POST { 0 }
        die 'foo';
    }
    ok $! ~~ /foo/, 'failing POST on exception doesn\'t replace $!';
    # XXX
    # is $!.pending.[-1], 'a POST exception', 'does push onto $!.pending';
}

{
    my sub blockless($x) {
        PRE $x >= 0;
        POST $_ == 4;
        return $x;
    }
    is blockless(4), 4, 'blockless PRE/POST (+)';
    dies-ok  { blockless -4 }, 'blockless PRE/POST (-, 1)';
    dies-ok  { blockless 14 }, 'blockless PRE/POST (-, 2)';
}

# vim: ft=perl6
