use v6;

use Test;

plan 4;

=begin pod

Tests of roles with submethods

# L<S14/Roles>
# L<S12/Submethods>

=end pod


role AddBuild
{
    has $.did_build = 0;
    submethod BUILD ( $self: )   #OK not used
    {
        $!did_build = 1;
    }
}

class MyClass does AddBuild {}

my $class = MyClass.new();
ok( $class.did_build, 'Class that does role should do submethods of role' );


role WithSM {
    submethod ouch() { 'the pain' }
    submethod conf() { 'FAIL' }
}

class Parent does WithSM {
    submethod conf() { 'correct' }
}
class Child is Parent { }

is Parent.ouch(), 'the pain', 'submethod composes ok...';
is Parent.conf(), 'correct',  'submethod in class wins';
#?pugs todo
dies_ok { Child.ouch() },     'composed submethod acts like one';

# vim: ft=perl6
