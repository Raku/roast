use v6;
use Test;
BEGIN { @*INC.push('t/spec/packages/') };
use Test::Util;
plan 6;

# L<S32::IO/IO::Writeable::Encoded/=item multi note>

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

#?rakudo todo 'nom regression'
is_run( 'my @a = ("array", " of ", "params"); note @a',
        {
            status => 0,
            out    => '',
            err    => "array of params\n",
        },
        'note array' );

is_run( 'my $a = <stringify args>; note $a',
        {
            status => 0,
            out    => '',
            err    => "stringify args\n",
        },
        'note an array reference' );

#?rakudo todo 'nom regression'
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

done;

# vim: ft=perl6
