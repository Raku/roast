use v6;

use Test;
plan 1;

=begin pod

P5 module import test

=end pod

unless (try { eval("1", :lang<perl5>) }) {
    skip_rest;
    exit;
}

eval q[
use Text::Wrap:from<perl5> 'wrap';
is(wrap('foo', 'bar', 'baz'), 'foobaz', "import p5 module");
] or die $!.perl;

# vim: ft=perl6
