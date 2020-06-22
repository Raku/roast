use v6;
use Test;

plan 9;

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

# https://github.com/Raku/old-issue-tracker/issues/5531
isnt IO::Path::QNX.new("-a").absolute, '',
    '.absolute on paths starting with `-` does not produce empty string (QNX)';

# vim: expandtab shiftwidth=4
