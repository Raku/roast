use v6;
use Test;
plan *;

#L<S12/Method call vs. Subroutine call>

class test {
    method foo($a:) { 'method' }   #OK not used
};
sub foo($a) { 'sub' };   #OK not used
my $obj = test.new;

#?rakudo skip 'confused near "($obj:),  "'
is foo($obj:),  'method', 'method with colon notation';
is $obj.foo,    'method', 'method with dot notation';
is foo($obj),   'sub', 'adding trailing comma should call the "sub"';

# RT #69610
{
    class RT69610 {
        our method rt69610() {
            return self;
        }
    }

    ok( { "foo" => &RT69610::rt69610 }.<foo>( RT69610.new ) ~~ RT69610,
        "Can return from method called from a hash lookup (RT 69610)" );
}

done_testing;

# vim: ft=perl6
