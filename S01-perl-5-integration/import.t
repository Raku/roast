use v6;

use Test;
plan 3;

=begin pod

P5 module import test

=end pod

unless (try { EVAL("1", :lang<Perl5>) }) {
    skip-rest;
    exit;
}

eval-lives-ok(q[
use Text::Wrap:from<Perl5> 'wrap';
is(Text::Wrap::wrap('foo', 'bar', 'baz'), 'foobaz', "import p5 module");
is(wrap('foo', 'bar', 'baz'), 'foobaz', "import p5 module");
],"parse :from<Perl5> syntax");

# vim: ft=perl6
