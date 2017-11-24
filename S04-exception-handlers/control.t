use v6;

use lib $?FILE.IO.parent(2).add("packages");

use Test;
use Test::Util;

plan 12;

=begin desc

Tests C<CONTROL> blocks.

=end desc

# RT #124255
is_run( 'next; CONTROL { }',
        { status => sub { 0 != $^a },
          out    => '',
          err    => rx/'next'/,
        },
        'next with CONTROL gives error mentioning next' );

{
    my $ok = 0;
    { next; CONTROL { when CX::Next { $ok = 1; } } }
    ok $ok, "next causes CX::Next control exception";
}

{
    my $ok = 0;
    { redo; CONTROL { when CX::Redo { $ok = 1; } } }
    ok $ok, "redo causes CX::Redo control exception";
}

{
    my $ok = 0;
    { last; CONTROL { when CX::Last { $ok = 1; } } }
    ok $ok, "last causes CX::Last control exception";
}

{
    my $ok = 0;
    { succeed; CONTROL { when CX::Succeed { $ok = 1; } } }
    ok $ok, "succeed causes CX::Succeed control exception";
}

{
    my $ok = 0;
    { proceed; CONTROL { when CX::Proceed { $ok = 1; } } }
    ok $ok, "proceed causes CX::Proceed control exception";
}

{
    my $ok = 0;
    { take 1; CONTROL { when CX::Take { $ok = 1; } } }
    ok $ok, "take causes CX::Take control exception";
}

{
    my $ok = 0;
    my $msg;
    { warn 'ing'; CONTROL { when CX::Warn { $ok = 1; $msg = .message; } } }
    ok $ok, "warn causes CX::Warn control exception";
    is $msg, 'ing', "CX::Warn carries the message we warned with";
}

{
    my $ok = 0;
    { emit 1; CONTROL { when CX::Emit { $ok = 1; } } }
    ok $ok, "emit causes CX::Emit control exception";
}

{
    my $ok = 0;
    { done; CONTROL { when CX::Done { $ok = 1; } } }
    ok $ok, "done causes CX::Done control exception";
}

# RT #125339
is_run( 'sub mention-me() { take 1; }; mention-me',
        { status => sub { 0 != $^a },
          out    => '',
          err    => rx/'mention-me'/,
        },
        'take without gather error mentions location' );
