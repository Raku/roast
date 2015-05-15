use v6;

use Test;
use lib 't/spec/packages';
use Test::Util;

plan 1;

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
