use v6;

unit module t::packages::LoadCounter;

$Main::loaded++;

sub import {
    $Main::imported++;
}

sub unimport {
    $Main::imported--;
}

# vim: ft=perl6
