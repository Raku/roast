use v6;

use Test;

plan 1;

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

# vim: ft=perl6
