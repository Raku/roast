use v6;

use lib $?FILE.IO.parent(2).add("packages");

use Test;
use ContainsUnicode;

plan 37;

# L<S12/"Parallel dispatch"/"Any of the method call forms may be turned into a hyperoperator">
# syn r14547

class Foo {
    trusts GLOBAL;
    has $.count is rw;
    method doit {$.count++}
    method !priv {$.count++}
}

class Bar is Foo {
    method doit {$.count++;}
}

{
    my @o = (5..10).map({Foo.new(count => $_)});
    is(@o.map({.count}), (5..10), 'object sanity test');
    @o».doit;
    is(@o.map({.count}), (6..11), 'parallel dispatch using » works');
    @o>>.doit;
    is(@o.map({.count}), (7..12), 'parallel dispatch using >> works');
    @o»!Foo::priv;
    is(@o.map({.count}), (8..13), 'parallel dispatch to a private using »! works');
    @o>>!Foo::priv;
    is(@o.map({.count}), (9..14), 'parallel dispatch to a private using >>! works');
}

{
    my @o = (5..10).map({Foo.new(count => $_)});
    is(@o.map({.count}), (5..10), 'object sanity test');
    lives-ok({@o».?not_here},  'parallel dispatch using @o».?not_here lives');
    lives-ok({@o>>.?not_here}, 'parallel dispatch using @o>>.?not_here lives');
    dies-ok({@o».not_here},    'parallel dispatch using @o».not_here dies');
    dies-ok({@o>>.not_here},   'parallel dispatch using @o>>.not_here dies');

    @o».?doit;
    is(@o.map({.count}), (6..11), 'parallel dispatch using @o».?doit works');
    @o>>.?doit;
    is(@o.map({.count}), (7..12), 'parallel dispatch using @o>>.?doit works');
    is (@o».?not_here).map({ $_ === Nil }).join(", "), @o.map({ True }).join(", "),
       '$obj».?nonexistingmethod returns a list of Nil';
    is (@o».?count).join(", "), @o.map({.count}).join(", "),
       '$obj».?existingmethod returns a list of the return values';
}

{
    my @o = (5..10).map({Bar.new(count => $_)});
    is(@o.map({.count}), (5..10), 'object sanity test');
    lives-ok({@o».*not_here},  'parallel dispatch using @o».*not_here lives');
    lives-ok({@o>>.*not_here}, 'parallel dispatch using @o>>.*not_here lives');
    dies-ok({@o».+not_here},   'parallel dispatch using @o».+not_here dies');
    dies-ok({@o>>.+not_here},  'parallel dispatch using @o>>.+not_here dies');

    @o».*doit;
    is(@o.map({.count}), (7..12), 'parallel dispatch using @o».*doit works');
    @o».+doit;
    is(@o.map({.count}), (9..14), 'parallel dispatch using @o».*doit works');
}

{
    is(<a bc def ghij klmno>».chars,  (1, 2, 3, 4, 5), '<list>».method works');
    is(<a bc def ghij klmno>>>.chars, (1, 2, 3, 4, 5), '<list>>>.method works');
}

{
    my @a = -1, 2, -3;
    my @b = -1, 2, -3;
    @a».=abs;
    is(@a, [1,2,3], '@list».=method works');
    @b>>.=abs;
    is(@b, [1,2,3], '@list>>.=method works');
}

# more return value checking
{
    class PDTest {
        has $.data;
        multi method mul(Int $a) {
            $.data * $a;
        }
        multi method mul(Num $a) {
            $.data * $a.Int  * 2
        }
    }

    my @a = (1..3).map: { PDTest.new(data => $_ ) };
    my $method = 'mul';

    is (@a».mul(3)).join(", "), (3, 6, 9).join(", "),  'return value of @a».method(@args)';
    is (@a»."$method"(3)).join(", "), (3, 6, 9).join(", "),  '... indirect';
      
    is (@a».?mul(3)).join(", "), (3, 6, 9).join(", "), 'return value of @a».?method(@args)';
    is (@a».?"$method"(3)).join(", "), (3, 6, 9).join(", "), '... indirect';

    #?rakudo 4 todo 'is-deeply does not think map results are the same as list on LHS'
    is-deeply @a».+mul(2), ([2, 4], [4, 8], [6, 12]),
              'return value of @a».+method is a list of lists';
    is-deeply @a».+"$method"(2), ([2, 4], [4, 8], [6, 12]),
              '... indirect';

    is-deeply @a».*mul(2), ([2, 4], [4, 8], [6, 12]),
              'return value of @a».*method is a list of lists';
    is-deeply @a».*"$method"(2), ([2, 4], [4, 8], [6, 12]),
              '... indirect';
}

# test postcircumfix parallel dispatch
{
    is (a => 1, a => 2)>>.<a>, '1 2',   # METHOD TO SUB CASUALTY
        '>>.<a>';
}

{
    is uc-and-join('foo', 'bar'), 'FOO, BAR',
        'parallel dispatch with » works in modules too';

}

# RT #77436
{
    is (1,2,3)».$( * + 42 ), [43, 44, 45], '$( ) after dotty parallel dispatch';
    is (1,2,3)».&( * + 42 ), [43, 44, 45], '&( ) after dotty parallel dispatch';
}

# vim: ft=perl6
