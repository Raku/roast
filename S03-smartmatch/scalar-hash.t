use v6;
use Test;
plan 3;

#L<S03/"Smart matching"/Cool Hash hash entry existence>
{
    my %h = (moep => 'foo', bar => Mu);
    #?niecza todo
    ok  ('moep' ~~ %h),     'Cool ~~ Hash (+, True)';
    #?niecza todo
    ok  ('bar' ~~ %h),      'Cool ~~ Hash (+, False)';
    ok !('foo' ~~ %h),      'Cool ~~ Hash (-)';
}

done;

# vim: ft=perl6
