use Test;
plan 30;

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

is &foo.WHY, "hi\nthere", 'two subs on a line - first come, first served';
ok !&bar.WHY.defined, 'two subs on a line - first come, first served';

sub one { #= first
#= second
}
#= third

is &one.WHY, 'first second third', 'trailing same line + inner line + next outer line';

sub two() {}
my $four = 2 + 2;
#= not attached

todo 'being picky about attaching of declarative comments NYI', 1;
ok !&two.WHY.defined, 'non-comment, non-whitespace comments should prevent trailing comments from binding';

sub
three {
#= yet another comment
}

is &three.WHY, 'yet another comment', "declaration start on its own line shouldn't stop trailing comments";

sub four {}
#| before five
#= after four
sub five {}

# XXX this may be wrong...
is &four.WHY, 'after four', "comments shouldn't interfere with each other";
is &five.WHY, 'before five', "comments shouldn't interfere with each other";

class A {
    has $.first; has $.second; #= comment
}

my $first  = A.^attributes.first(*.name eq '$!first');
my $second = A.^attributes.first(*.name eq '$!second');

todo 'two attrs on a line WIP', 2;
is $first.WHY, 'comment', 'two attrs on a line - first come, first served';
ok !$second.WHY.defined, 'two attrs on a line - first come, first served' or diag($second.WHY);

skip 'interleaved trailing WIP', 1;
#`(
class B {
    has         #= first trailing
    $.attribute #= second trailing
    = 17;
}

my $first = B.^attributes.first(*.name eq '$!attribute');
is $first.WHY, 'first trailing second trailing', 'interleaved trailing';
)

sub six(Str $param1, Str $param2) {
#= trailing comment for six
}

my ( $param1, $param2 ) = &six.signature.params;

is &six.WHY, 'trailing comment for six', "params shouldn't interfere with sub's trailing comments";
ok !$param1.WHY.defined, "params shouldn't interfere with sub's trailing comments" or diag($param1.WHY);
ok !$param2.WHY.defined, "params shouldn't interfere with sub's trailing comments" or diag($param2.WHY);

sub seven(
    Str $param
)
#= trailing comment
{
}

todo 'comment betwixt signature and block WIP', 1;
is &seven.WHY, 'trailing comment', 'sub trailing comments may be between signature and block';

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

skip 'supersede NYI', 1;

#`(
#| first definition
sub ten {}

#| second definition
supersede sub ten {}

# XXX is this correct?
is &ten.WHY, 'second definition';
)

#| leading comment for eleven



sub eleven {}



#= trailing comment for eleven

is &eleven.WHY, "leading comment for eleven\ntrailing comment for eleven", "space separation shouldn't hurt";

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
