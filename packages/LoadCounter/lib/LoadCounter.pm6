use v6;

unit module LoadCounter;

$Main::loaded++;

sub import {
    $Main::imported++;
}

sub unimport {
    $Main::imported--;
}

# vim: expandtab shiftwidth=4
