use v6;

use Test;

plan 29;

# L<S12/"Parallel dispatch"/"Any of the method call forms may be turned into a hyperoperator">
# syn r14547

class Foo {
    has $.count is rw;
    method doit {$.count++}
}

class Bar is Foo {
    method doit {$.count++; callsame;}
}

{
    my @o = (5..10).map({Foo.new(count => $_)});
    is(@o.map({.count}), (5..10), 'object sanity test');
    @o».doit;
    is(@o.map({.count}), (6..11), 'parallel dispatch using » works');
    @o>>.doit;
    is(@o.map({.count}), (7..12), 'parallel dispatch using >> works');
}

{
    my @o = (5..10).map({Foo.new(count => $_)});
    is(@o.map({.count}), (5..10), 'object sanity test');
    lives_ok({@o».?not_here},  'parallel dispatch using @o».?not_here lives');
    lives_ok({@o>>.?not_here}, 'parallel dispatch using @o>>.?not_here lives');
    dies_ok({@o».not_here},    'parallel dispatch using @o».not_here dies');
    dies_ok({@o>>.not_here},   'parallel dispatch using @o>>.not_here dies');

    @o».?doit;
    is(@o.map({.count}), (6..11), 'parallel dispatch using @o».?doit works');
    @o>>.?doit;
    is(@o.map({.count}), (7..12), 'parallel dispatch using @o>>.?doit works');
    is_deeply @o».?not_here, @o.map({ undef }),
              '$obj».?nonexistingmethod returns a list of undefs';
    is_deeply @o».?count, @o.map({.count}),
              '$obj».?existingmethod returns a list of the return values';
}

{
    my @o = (5..10).map({Bar.new(count => $_)});
    is(@o.map({.count}), (5..10), 'object sanity test');
    lives_ok({@o».*not_here},  'parallel dispatch using @o».*not_here lives');
    lives_ok({@o>>.*not_here}, 'parallel dispatch using @o>>.*not_here lives');
    dies_ok({@o».+not_here},   'parallel dispatch using @o».+not_here dies');
    dies_ok({@o>>.+not_here},  'parallel dispatch using @o>>.+not_here dies');

#?rakudo skip '.*, .+ and callsame'
{
    @o».*doit;
    is(@o.map({.count}), (7..12), 'parallel dispatch using @o».*doit works');
    @o».+doit;
    is(@o.map({.count}), (9..14), 'parallel dispatch using @o».*doit works');
}
}

{
    is(<a bc def ghij klmno>».chars,  (1..5), '<list>».method works');
    is(<a bc def ghij klmno>>>.chars, (1..5), '<list>>>.method works');
}

# more return value checking
{
    class PDTest {
        has $.data;
        multi method mul(Int $a) {
            $.data * $a;
        }
        multi method mul(Num $a) {
            $.data * $a.int  * 2
        }
    }

    my @a = (1..3).map: { PDTest.new(data => $_ ) };
    my $method = 'mul';

    is_deeply @a».mul(3), (3, 6, 9),  'return value of @a».method(@args)';
    is_deeply @a»."$method"(3), (3, 6, 9),  '... indirect';

    is_deeply @a».?mul(3), (3, 6, 9), 'return value of @a».?method(@args)';
    is_deeply @a».?"$method"(3), (3, 6, 9), '... indirect';

    #?rakudo 4 todo '.+ and .* parallelized gives'
    is_deeply @a».+mul(2).map({ .sort }), ([2, 4], [4, 8], [6, 12]),
              'return value of @a».+method is a list of lists';
    is_deeply @a».+"$method"(2).map({ .sort }), ([2, 4], [4, 8], [6, 12]),
              '... indirect';

    is_deeply @a».*mul(2).map({ .sort }), ([2, 4], [4, 8], [6, 12]),
              'return value of @a».*method is a list of lists';
    is_deeply @a».*"$method"(2).map({ .sort }), ([2, 4], [4, 8], [6, 12]),
              '... indirect';
}

# vim: ft=perl6
