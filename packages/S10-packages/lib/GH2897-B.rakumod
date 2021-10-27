use v6;
unit module GH2897-B;
use GH2897-A;

our &my-counter is export;

BEGIN {
    &my-counter = gen-counter;
}

# vim: expandtab shiftwidth=4
