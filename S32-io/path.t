use v6;
use Test;

plan 4;

isa_ok qp{foo}, Path, 'qp{foo} creates a Path object.';
isa_ok qp{/foo}, Path, 'qp{/foo} creates a Path object.';
isa_ok qp{foo/bar}, Path, 'qp{foo/bar} creates a Path object.';
isa_ok qp{/foo/bar}, Path, 'qp{/foo/bar} creates a Path object.';

# vim: ft=perl6
