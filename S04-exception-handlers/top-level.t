use v6.c;

use Test;

plan 1;

sub foo { die };
foo;

CATCH {
    when * {
        pass 'Top-level handler caught exception'
    }
}
