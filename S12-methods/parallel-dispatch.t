use v6;

use Test;

plan 21;

# L<S12/"Parallel dispatch"/"Any of the method call forms may be turned into a hyperoperator">
# syn r14547

class Foo {
    has $.count;
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
}

{
    my @o = (5..10).map({Bar.new(count => $_)});
    is(@o.map({.count}), (5..10), 'object sanity test');
    lives_ok({@o».*not_here},  'parallel dispatch using @o».*not_here lives');
    lives_ok({@o>>.*not_here}, 'parallel dispatch using @o>>.*not_here lives');
    dies_ok({@o».+not_here},   'parallel dispatch using @o».+not_here dies');
    dies_ok({@o>>.+not_here},  'parallel dispatch using @o>>.+not_here dies');

    @o».*doit;
    is(@o.map({.count}), (7..12), 'parallel dispatch using @o».*doit works');
    @o».+doit;
    is(@o.map({.count}), (9..14), 'parallel dispatch using @o».*doit works');
}

{
    is(<a bc def ghij klmno>».chars,  (1..5), '<list>».method works');
    is(<a bc def ghij klmno>>>.chars, (1..5), '<list>>>.method works');
}

# L<S12/"Parallel dispatch"/"To hyperoperate over the values of a junction">
{
    my $junc = 'a'|'bc'|'def';
    is($junc.values».chars,  (1..3), 'junction.values».method works');
    is($junc.values>>.chars, (1..3), 'junction.values>>.method works');
}
