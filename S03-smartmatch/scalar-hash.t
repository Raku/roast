use v6;
use Test;
plan 3;

#L<S03/"Smart matching"/Cool Hash hash entry existence>
{
    my %h = (moep => 'foo', bar => Mu);
    #?niecza skip 'TODO'
    ok  ('moep' ~~ %h),     'Cool ~~ Hash (+, True)';
    #?niecza skip 'TODO'
    ok  ('bar' ~~ %h),      'Cool ~~ Hash (+, False)';
    ok !('foo' ~~ %h),      'Cool ~~ Hash (-)';
}

done;

# vim: ft=perl6
