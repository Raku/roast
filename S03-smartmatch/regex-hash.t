use v6;
use Test;
plan 4;

#L<S03/"Smart matching"/Regex Hash hash key grep>
{
    my %h = (moep => 'foo', bar => 'baz');
    #?niecza todo
    ok  (/oep/ ~~ %h),      'Regex ~~ Hash (+,1)';
    #?niecza todo
    ok  (/bar/ ~~ %h),      'Regex ~~ Hash (+,2)';
    ok !(/ugh/ ~~ %h),      'Regex ~~ Hash (-,1)';
    ok !(/foo/ ~~ %h),      'Regex ~~ Hash (-,value)';
}

done;

# vim: ft=perl6
