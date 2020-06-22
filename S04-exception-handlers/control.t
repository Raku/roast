use v6;
use Test;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 15;

=begin desc

Tests C<CONTROL> blocks.

=end desc

# https://github.com/Raku/old-issue-tracker/issues/3774
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

# https://github.com/Raku/old-issue-tracker/issues/4300
is_run( 'sub mention-me() { take 1; }; mention-me',
        { status => sub { 0 != $^a },
          out    => '',
          err    => rx/'mention-me'/,
        },
        'take without gather error mentions location' );

# Custom control exceptions achievable by doing `X::Control`.
{
    my class CX::Whatever does X::Control {
        method message { "<whatever control exception>" }
    }

    my @controls;
    my @catches;
    do {
        CX::Whatever.new.throw;
        CONTROL {
            default {
                push @controls, $_;
            }
        }
        CATCH {
            default {
                push @catches, $_;
            }
        }
    }

    is @controls.elems, 1, 'Exception doing X::Control caught by CONTROL block';
    is @catches.elems, 0, 'Exception doing X::Control not caught by CATCH block';
    isa-ok @controls[0], CX::Whatever, 'Correct control exception type';
}

# vim: expandtab shiftwidth=4
