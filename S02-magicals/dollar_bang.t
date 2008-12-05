use v6;

use Test;

plan 10;

=begin desc

This test tests the C<$!> builtin.

=end desc

# L<S04/"Exceptions"/"A bare die/fail takes $! as the default argument.">

##?rakudo 3 skip 'unimpl $!'

eval 'nonexisting_subroutine()'; 
ok defined($!), 'nonexisting sub in eval makes $! defined';
eval 'nonexisting_subroutine()'; 
ok $!, 'Calling a nonexisting subroutine sets $!';

undefine $!;
# XXX nonexisting_subroutine is detectable at compile time,
# this test should be fixed somehow
try { nonexisting_subroutine; };
ok $! !~~ undef, 'Calling a nonexisting subroutine defines $!';
try { nonexisting_subroutine; };
ok $!, 'Calling a nonexisting subroutine sets $!';

undefine $!;
my $called;
sub foo(Str $s) { return $called++ };
my @a;
try { foo(@a,@a) };
ok $!, 'Calling a subroutine with a nonmatching signature sets $!';
ok !$called, 'The subroutine also was not called';

undefine $!;
try { 1 / 0 };
ok $!, 'Dividing one by zero sets $!';

sub incr ( $a is rw ) { $a++ };
undefine $!;
try { incr(19) };
#?rakudo todo 'containers/values'
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

# vim: ft=perl6
