use v6;

use lib $?FILE.IO.parent(2).add("packages");

use Test;
use Test::Util;
plan 17;

# L<S29/Context/=item die>

=begin pod

Tests for the die() builtin

=end pod

{
    ok( !defined( try { die "foo"; 1; } ), 'die in try cuts off execution');
    my $error = $!;
    is($error, 'foo', 'got $! correctly');
}

my $foo = "-foo-";
try { $foo = die "bar" };
$foo; # this is testing for a bug where an error is stored into $foo in
      # the above EVAL; unfortunately the if below doesn't detect this on it's
      # own, so this lone $foo will die if the bug is present
ok($foo eq "-foo-");

sub recurse {
  my $level=@_[0];
  $level>0 or die "Only this\n";
  recurse(--$level);
}
try { recurse(1) };
is($!, "Only this\n", 'die() in recursively called sub');

# die in if,map,grep etc.
is ({ try { eager map    { die }, 1,2,3 }; 42 }()), 42, "die in map";
is ({ try { eager grep   { die }, 1,2,3 }; 42 }()), 42, "die in grep";
is ({ try { eager sort   { die }, 1,2,3 }; 42 }()), 42, "die in sort";
is ({ try { reduce -> $a,$b { die }, 1,2,3 }; 42 }()), 42, "die in reduce";

is ({ try { for 1,2,3 { die }; 23 }; 42 }()), 42, "die in for";
is ({ try { if 1 { die } else { die } }; 42 }()), 42, "die in if";

my sub die_in_return () { return die };
is ({ try { die_in_return(); 23 }; 42 }()), 42, "die in return";

{
    my $msg = 'RT #67374';
    try { die $msg };
    is "$!", $msg, 'die with argument sets $!';
    try { die };
    #?rakudo todo 'RT #67374'
    is "$!", $msg, 'die with no argument uses $!';
}

is_run( 'die "first line"',
        { status => sub { 0 != $^a },
          out    => '',
          err    => rx/'first line'/,
        },
        'die with no output' );

is_run( 'say "hello"; die "Nos morituri te salutant!\n"',
        { status => sub { 0 != $^a },
          out    => "hello\n",
          err    => rx/'Nos morituri te salutant!' \n/,
        },
        'say something and die' );

# If one of the above tests caused weird continuation bugs, the following line
# will be executed multiple times, resulting in a "too many tests run" error
# (which is what we want). (Test primarily aimed at PIL2JS)
is 42-19, 23, "basic sanity";

# RT #125573
is_run( 'use Test; pass; die "uh-oh"',
        { status => sub { 0 != $^a },
          out    => rx/'ok 1 -'/,
          err    => rx/'uh-oh'/,
        },
        'die() in combination with Test.pm6 exists non-zero-ish' );


# vim: ft=perl6
