use v6;

use lib 't/spec/packages';

use Test;
use Test::Util;

plan 16;

# L<S32::IO/IO::Writeable::Encoded/"it is a compiler error">

throws-like 'say', X::Comp::Group, 'bare say is a compiler error';
throws-like 'print', X::Comp::Group, 'bare print is a compiler error';
throws-like 'put', X::Comp::Group, 'bare put is a compiler error';
throws-like 'put for 1', Exception, '`put for ...` throws';

is_run 'say ()',    {:0status, :out("()\n"), :err('')}, 'say ()';
is_run 'say("")',   {:0status, :out(  "\n"), :err('')}, 'say("")';
is_run 'say()',     {:0status, :out(  "\n"), :err('')}, 'say()';

is_run 'put ()',    {:0status, :out(  "\n"), :err('')}, 'put ()';
is_run 'put("")',   {:0status, :out(  "\n"), :err('')}, 'put("")';
is_run 'put()',     {:0status, :out(  "\n"), :err('')}, 'put()';

is_run 'print ()',  {:0status, :out(    ''), :err('')}, 'print ()';
is_run 'print("")', {:0status, :out(    ''), :err('')}, 'print("")';
is_run 'print()',   {:0status, :out(    ''), :err('')}, 'print()';


# RT #61494
{
    throws-like 'say for 1', X::Obsolete, 'say for 1  is an error';

    # Note: the two spaces between 'say' and 'for' are significant:
    throws-like 'say  for 1', X::Obsolete, 'say  for 1  is an error';
}

# RT #74822
is_run( 'my %h= flat <a b c> Z 1,2,3; for %h.sort(*.key) { .say }',
        {
            status => 0,
            out    => "a => 1\nb => 2\nc => 3\n",
            err    => '',
        },
        'for %h { .say } (RT #74822)' );

# vim: ft=perl6
