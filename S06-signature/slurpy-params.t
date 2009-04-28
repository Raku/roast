use v6;
use Test;

# L<S06/List parameters/Slurpy parameters>

plan 14;

sub xelems(*@args) { @args.elems }
sub xjoin(*@args)  { @args.join('|') }

is xelems(1),          1,        'Basic slurpy params 1';
is xelems(1, 2, 5),    3,        'Basic slurpy params 2';

is xjoin(1),           '1',      'Basic slurpy params 3';
is xjoin(1, 2, 5),     '1|2|5',  'Basic slurpy params 4';

sub mixed($pos1, *@slurp) { "|$pos1|" ~ @slurp.join('!') }

is mixed(1),           '|1|',    'Positional and slurp params';
is mixed(1, 2, 3),     '|1|2!3', 'Positional and slurp params';
dies_ok { mixed()},              'at least one arg required';

#?rakudo skip 'types on slurpy params'
{
    sub x_typed_join(Int *@args){ @args.join('|') }
    is x_typed_join(1),           '1',      'Basic slurpy params with types 1';
    is x_typed_join(1, 2, 5),     '1|2|5',  'Basic slurpy params with types 2';
    dies_ok { x_typed_join(3, 'x') }, 'Types on slurpy params are checked';
}

sub first_arg      ( *@args         ) { ~@args[0]; }
sub first_arg_rw   ( *@args is rw   ) { ~@args[0]; }
sub first_arg_copy ( *@args is copy ) { ~@args[0]; }

is first_arg(1, 2, 3),      '1',  'can grab first item of a slurpy array';
is first_arg_rw(1, 2, 3),   '1',  'can grab first item of a slurpy array (is rw)';
is first_arg_copy(1, 2, 3), '1',  'can grab first item of a slurpy array (is copy)';

# test that shifting works
{
    sub func(*@m) {
        @m.shift;
        return @m;
    }
    is_deeply(func(5), [], "Shift from an array function argument works", :todo<bug>);
}


# vim: ft=perl6
