use v6;

use Test;

plan 18;

=begin desc

This test tests the C<$!> builtin.

=end desc

# L<S04/"Exceptions"/A bare die/fail takes $! as the default argument>

eval 'nonexisting_subroutine()';
ok defined($!), 'nonexisting sub in eval makes $! defined';
eval 'nonexisting_subroutine()';
ok $!, 'Calling a nonexisting subroutine sets $!';
try { 1 };
nok $!.defined, 'successful try { } resets $!';

try { 1.nonexisting_method; };
ok $!.defined, 'Calling a nonexisting method defines $!';
try { 1.nonexisting_method; };
ok $!, 'Calling a nonexisting smethod sets $!';

my $called;
sub foo(Str $s) { return $called++ };    #OK not used
my @a;
try { foo(@a,@a) };
ok $!, 'Calling a subroutine with a nonmatching signature sets $!';
ok !$called, 'The subroutine also was not called';

try { 1 div 0 };
ok $!, 'Dividing one by zero sets $!';

sub incr ( $a is rw ) { $a++ };
try { incr(19) };
ok $!, 'Modifying a constant sets $!';

try {
    try {
        die 'qwerty';
    }
    ok ~($!) ~~ /qwerty/, 'die sets $! properly';
    die; # use the default argument
}
#?rakudo todo 'stringification of $!'
ok ~($!) ~~ /qwerty/, 'die without argument uses $! properly';

# RT #70011
#?rakudo skip 'nom regression'
{
    undefine $!;
    try { die('goodbye'); }
    ok defined( $!.perl ), '$! has working Perl 6 object methods after try';
    ok ($!.WHAT ~~ Exception), '$! is Exception object after try';
    # - S04-statements/try.t tests $! being set after try.
    # - S29-context/die.t tests $! being set after die.
    # - also tested more generically above.
    # So no need to test the value of #! again here.
    #is $!, 'goodbye', '$! has correct value after try';
    ok ($!), '$! as boolean works (true)';

    eval q[ die('farewell'); ];
    ok defined($!.perl), '$! has working Perl 6 object methods after eval';
    ok ($!.WHAT ~~ Exception), '$! is Exception object after eval';
    # Although S29-context/die.t tests $! being set after die, it's not
    # from within an eval, so we test the eval/die combination here.
    # As that file (and also S04-statements/try.t) do equality comparisons
    # rather than pattern matches, we check equality here, too.
    is $!, 'farewell', '$! has correct value after eval';

    try { 1; }
    ok (! $!), '$! as boolean works (false)';
}

# vim: ft=perl6
