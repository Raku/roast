use v6;
use Test;

plan 4;

isa-ok qp{foo}, IO::Path, 'qp{foo} creates a IO::Path object.';
isa-ok qp{/foo}, IO::Path, 'qp{/foo} creates a IO::Path object.';
isa-ok qp{foo/bar}, IO::Path, 'qp{foo/bar} creates a IO::Path object.';
isa-ok qp{/foo/bar}, IO::Path, 'qp{/foo/bar} creates a IO::Path object.';

# vim: ft=perl6
