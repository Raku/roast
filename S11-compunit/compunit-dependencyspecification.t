use v6;
use Test;

plan 6;

#?rakudo.jvm todo 'https://github.com/perl6/nqp/issues/446'
dies-ok { CompUnit::DependencySpecification.new };
dies-ok { CompUnit::DependencySpecification.new(:short-name(1)) };
ok my $ds = CompUnit::DependencySpecification.new(:short-name<Foo>);
is $ds.version-matcher, True;
is $ds.auth-matcher, True;
is $ds.api-matcher, True;

# vim: expandtab shiftwidth=4
