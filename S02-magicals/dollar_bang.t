use v6;

use Test;

plan 16;

=begin desc

This test tests the C<$!> builtin.

=end desc

# L<S04/"Exceptions"/A bare die/fail takes $! as the default argument>

try { die "foo" };
ok defined($!), 'error in try makes $! defined';
try { 1 };
#?niecza todo
nok $!.defined, 'successful try { } resets $!';

try { 1.nonexisting_method; };
ok $!.defined, 'Calling a nonexisting method defines $!';

my $called;
sub foo(Str $s) { return $called++ };    #OK not used
my @a;
try { eval 'foo(@a,@a)' };
ok $!.defined, 'Calling a subroutine with a nonmatching signature sets $!';
ok !$called, 'The subroutine also was not called';

try { 1 div 0 };
ok $!.defined, 'Dividing one by zero sets $!';

sub incr ( $a is rw ) { $a++ };
try { incr(19) };
ok $!.defined, 'Modifying a constant sets $!';

try {
    try {
        die 'qwerty';
    }
    ok ~($!) ~~ /qwerty/, 'die sets $! properly';
    die; # use the default argument
}
#?rakudo todo 'stringification of $!'
#?niecza todo
ok ~($!) ~~ /qwerty/, 'die without argument uses $! properly';

# RT #70011
#?niecza skip 'undefine and Exception NYI'
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
    #?rakudo skip 'spec change pending (?)'
    ok ($!), '$! as boolean works (true)';

    try { eval q[ die('farewell'); ] };
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
