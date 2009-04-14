use v6;
use Test;
plan 3;

#L<S12/Method call vs. Subroutine call>

class test {
    method foo($a:) { 'method' }
};
sub foo($a) { 'sub' };
my $obj = test.new;

is foo($obj:),  'method', 'method with colon notation';
is $obj.foo,    'method', 'method with dot notation';
is foo($obj),   'sub', 'adding trailing comma should call the "sub"';

