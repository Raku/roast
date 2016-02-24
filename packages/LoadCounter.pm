use v6.c;

unit module t::packages::LoadCounter;

$Main::loaded++;

sub import {
    $Main::imported++;
}

sub unimport {
    $Main::imported--;
}

# vim: ft=perl6
