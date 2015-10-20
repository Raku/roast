use v6;
use Test;

plan 6;

throws-like { CompUnit::DependencySpecification.new }, X::Attribute::Required,
throws-like { CompUnit::DependencySpecification.new(:short-name(1)) }, X::TypeCheck::Assignment;
ok my $ds = CompUnit::DependencySpecification.new(:short-name<Foo>);
is $ds.version-matcher, True;
is $ds.auth-matcher, True;
is $ds.api-matcher, True;

# vim: ft=perl6
