use v6;

use Test;
plan 3;

=begin pod

P5 module import test

=end pod

unless (try { EVAL("1", :lang<perl5>) }) {
    skip-rest;
    exit;
}

eval-lives-ok(q[
use Text::Wrap:from<Perl5> 'wrap';
is(Text::Wrap::wrap('foo', 'bar', 'baz'), 'foobaz', "import p5 module");
#?rakudo skip "importing of functions NYI RT #124646"
{
is(wrap('foo', 'bar', 'baz'), 'foobaz', "import p5 module");
}
],"parse :from<Perl5> syntax");

# vim: ft=perl6
