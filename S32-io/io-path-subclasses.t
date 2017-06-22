use v6;
use Test;

plan 8;

# Generic tests of IO::Path::* classes. See also individual io-path-*.t files

{
    my @tests = [ IO::Path::Cygwin, IO::Spec::Cygwin ],
        [ IO::Path::QNX, IO::Spec::QNX ], [ IO::Path::Unix, IO::Spec::Unix ],
        [ IO::Path::Win32, IO::Spec::Win32 ];

    for @tests -> ($subclass, $SPEC) {
        my $p = $subclass.new: "foo", :SPEC(my class Fail {});
        isa-ok $p,      $subclass, '.new returns a subclass of IO::Path';
        isa-ok $p.SPEC, $SPEC,
            '.SPEC is set correctly, even if other value is given to .new';
    }
}

# vim: ft=perl6
