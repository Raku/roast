use v6;
use Test;

plan 2;

# L<S06/Required parameters/"Passing a named argument that cannot be bound to
# a normal subroutine is also a fatal error.">

{
    # see http://rt.perl.org/rt3/Ticket/Display.html?id=54812
    sub a($x = 4) {
        return $x;
    }
    is a(3), 3, 'Can pass positional arguments';
    #?rakudo todo 'Named args, RT #54812'
    eval_dies_ok('a(g=>7)', 'Dies on passing superflous arguments');
}
