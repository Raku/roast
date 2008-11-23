use v6;
use Test;

plan 8;

sub xelems(*@args) { @args.elems }
sub xjoin(*@args)  { @args.join('|') }

is xelems(1),          1,        'Basic slurpy params 1';
is xelems(1, 2, 5),    3,        'Basic slurpy params 2';

is xjoin(1),           '1',      'Basic slurpy params 3';
is xjoin(1, 2, 5),     '1|2|5',  'Basic slurpy params 4';

sub mixed($pos1, *@slurp) { "|$pos1|" ~ @slurp.join('!') }

is mixed(1),           '|1|',    'Positional and slurp params';
is mixed(1, 2, 3),     '|1|2!3', 'Positional and slurp params';

#?rakudo skip 'types on slurpy params'
{
    sub x_typed_join(Int *@args){ @args.join('|') }
    is x_typed_join(1),           '1',      'Basic slurpy params with types 1';
    is x_typed_join(1, 2, 5),     '1|2|5',  'Basic slurpy params with types 2';
}

# vim: ft=perl6
