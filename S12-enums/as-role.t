use v6;
use Test;

plan 2;

#L<S12/Enums/"An enum is a low-level class that can function as a role 
# or property">

enum maybe <no yes>;

class Foo does maybe { }

my $x = Foo.new();

is($x.no,  0, 'Can get .no  of enum maybe <no yes>');
is($x.yes, 1, 'Can get .yes of enum maybe <no yes>');


# vim: ft=perl6
