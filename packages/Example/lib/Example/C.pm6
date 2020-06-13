use v6;
use experimental :cached;

package Example::C {
    # https://github.com/Raku/old-issue-tracker/issues/3539
    # snick in a test for RT #122896
    sub f () is cached is export { }
}

# vim: expandtab shiftwidth=4
