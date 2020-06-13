use v6.d;

# Will return a PseudoStash from 6.c because 6.d doesn't define it
sub pseudo-stash is export {
    MY::
}

# vim: expandtab shiftwidth=4
