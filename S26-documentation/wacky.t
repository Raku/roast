use Test;
plan 29;

# a bunch of weird behaviors I've thought of while reading and implementing S26.
# some of these may belong in other tests, but here's a nice dumping ground for
# them for now.

#| hello
is sub {
}.WHY, 'hello', 'leading document within an anoymous sub';

is sub {
#= hello
}.WHY, 'hello', 'trailing document within an anoymous sub';

#| hi
sub foo {} ; sub bar {}
#= there

todo 'needs RakuAST', 2;
is &foo.WHY, "hi", 'leading attaches to first';
is &bar.WHY, "there", 'trailing attaches to last';

sub one { #= first
#= second
}

is &one.WHY, 'first second', 'trailing same line + inner line';

sub two() {}
#= attached

is &two.WHY, 'attached', 'complete sub attaches ok on next line';

sub three {
#= yet another comment
}

is &three.WHY, 'yet another comment', "declaration start on its own line";

sub four {}
#= after four
#| before five
sub five {}

is &four.WHY, 'after four', "comments shouldn't interfere with each other";
is &five.WHY, 'before five', "comments shouldn't interfere with each other";

class A {
    has $.first; has $.second; #= comment
}

my $first  = A.^attributes.first(*.name eq '$!first');
my $second = A.^attributes.first(*.name eq '$!second');

ok !$first.WHY.defined, 'two attrs on a line, first ignored';
is $second.WHY, 'comment', 'two attrs on a line, last binds';

class B {
    has $.attribute #= first trailing
    #= second trailing
    = 17;
}

$first = B.^attributes.first(*.name eq '$!attribute');
todo 'needs RakuAST', 1;
is $first.WHY, 'first trailing second trailing', 'interleaved trailing';

sub six(Str $param1, Str $param2) {
#= trailing comment for param2
}

my ( $param1, $param2 ) = &six.signature.params;

todo 'needs RakuAST', 1;
ok !&six.WHY.defined, "does not bind to sub";;
ok !$param1.WHY.defined, "does not bind to first parameter";
todo 'needs RakuAST', 1;
is $param2.WHY, 'trailing comment for param2', "last on line binds";

sub seven(
    Str $param
)
#= trailing comment
{
}

($param1,) = &seven.signature.params;
ok !$param1.WHY.defined, 'does not bind to anything';

sub eight( #| leading for param
    Str $param
) {}

my ( $param ) = &eight.signature.params;

ok !&eight.WHY.defined;
is $param.WHY, 'leading for param';

sub nine( #= sub comment
    Str $param
) {}

( $param ) = &nine.signature.params;

is &nine.WHY, 'sub comment';
ok !$param.WHY.defined;

#| leading comment for eleven



sub eleven {}
#= trailing comment for eleven

is &eleven.WHY, "leading comment for eleven\ntrailing comment for eleven",
  "space separation ok for leading, not for trailing";

my @pod_headers = (
    'pod',
    'comment',
    'table',
    'code',
);

for @pod_headers -> $chunk {
    my $ok = 1;

    EVAL "=for $chunk\n\$ok = 0";

    ok $ok, "=for $chunk";

    $ok = 1;

    EVAL "=$chunk\n\$ok = 0";

    ok $ok, "=$chunk";
}

# vim: expandtab shiftwidth=4
