use v6;
use Test;

plan 4;

# L<S17/Atomic Code blocks>
my ($x, $y);
sub c {
    $x -= 3; $y += 3;
    $x < 10 or defer;
}
sub d {
    $x += 3; $y -= 3;
    $y < 10 or defer;
}
#?pugs todo 'unimpl'
ok EVAL( q{
contend {
    # ...
    maybe { c() } maybe { d() };
    # ...
} } )
    ,'contend/maybe/defer construct';
# L<S17/Atomic Code blocks/maybe>
#?pugs todo 'unimpl'
ok EVAL( q{
    maybe { c() };
} ),'method <maybe> known';

# L<S17/Atomic Code blocks/defer>
ok c(),'method <defer> known';

# L<S17/Atomic Code blocks/contend>
sub e {
    my $x; return ++$x;
}
ok contend { e(); },'method <contend> known';

# vim: ft=perl6
