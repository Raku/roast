use v6;
use Test;
plan 1;

# RT #86340
# The [=] operator is fiddly and complier should not allow it

throws-like 'my ($a, $b) = (1,2); my @c = [=] $a, $b;',
    X::Syntax::CannotMeta, 'dies on fiddly code';

