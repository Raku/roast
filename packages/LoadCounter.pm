use v6;

package t::packages::LoadCounter;

$Main::loaded++;

sub import {
    $Main::imported++;
}

sub unimport {
    $Main::imported--;
}
