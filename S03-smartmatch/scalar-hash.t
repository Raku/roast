use v6;
use Test;
plan 3;

#L<S03/"Smart matching"/Scalar Hash hash entry existence>
{
    my %h = (moep => 'foo', bar => Mu);
    ok  ('moep' ~~ %h),     'Scalar ~~ Hash (+, True)';
    ok  ('bar' ~~ %h),      'Scalar ~~ Hash (+, False)';
    ok !('foo' ~~ %h),      'Scalar ~~ Hash (-)';
}

done_testing;

# vim: ft=perl6
