use v6;

use lib 't/spec/packages';

use Test;
use Test::Util;
plan 7;

# L<S32::IO/Functions/note>

is_run( 'note',
        {
            status => 0,
            out    => '',
            err    => "Noted\n",
        },
        'no-arg form of note' );

is_run( 'note "basic form"',
        {
            status => 0,
            out    => '',
            err    => "basic form\n",
        },
        'basic form of note' );

is_run( 'note "multiple", " ", "params"',
        {
            status => 0,
            out    => '',
            err    => "multiple params\n",
        },
        'note multiple parameters' );

is_run( 'my @a = ("array", "of", "params"); note @a',
        {
            status => 0,
            out    => '',
            err    => "[array of params]\n",
        },
        'note array' );

is_run( 'my $a = <stringify args>; note $a',
        {
            status => 0,
            out    => '',
            err    => "(stringify args)\n",
        },
        'note an array reference' );

is_run( '"method form".note',
        {
            status => 0,
            out    => '',
            err    => "method form\n",
        },
        'method form of note' );

is_run( 'try { note "with try" }',
        {
            status => 0,
            out    => '',
            err    => "with try\n",
        },
        'try { } block does not prevent note() from outputting something' );

# vim: ft=perl6
