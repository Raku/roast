use v6.d;

unit module LoadCounter;

$Main::loaded++;

sub import {
    $Main::imported++;
}

sub unimport {
    $Main::imported--;
}

# vim: ft=perl6
