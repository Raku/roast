use v6;
use Test;

plan 3;

lives-ok { 4.HOW.HOW }, 'Can access meta class of meta class';

#?rakudo.jvm todo 'got X::Method::NotFound, RT #130470'
throws-like 'my $x; ($x = "hi").HOW = Block;', X::Assignment::RO,
            'Cannot assign to .HOW';

# RT #76928
{
    sub RT76928(%h?) { %h.HOW }
    lives-ok { RT76928() }, 'Can call .HOW on an optional sub parameter';
}

# vim: ft=perl6
