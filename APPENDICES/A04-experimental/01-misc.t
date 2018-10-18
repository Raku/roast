use v6.c;
use lib $?FILE.IO.parent(3).add: 'packages';
use Test;
use Test::Util;

plan 1;

# This appendix contains features that may already exist in some implementations but the exact
# behaviour is currently not fully decided on.

{
    # This once wrongly reported a multi-dispatch circularity.
    multi rt107638(int $a) { 'ok' }      #OK not used
    multi rt107638(Str $a where 1) { }   #OK not used
    lives-ok { rt107638(1) },
        'native types and where clauses do not cause spurious circularities';
}
