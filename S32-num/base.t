use v6;
use Test;

plan 7;

is  0.base(8),  '0',        '0.base(something)';
is 42.base(10), '42',       '42.base(10)';
is 42.base(16), '2A',       '42.base(16)';
is 42.base(2) , '101010',   '42.base(2)';
is 35.base(36), 'Z',        '35.base(36)';
is 36.base(36), '10',       '36.base(36)';
is (-12).base(16), '-C',    '(-12).base(16)';

# TODO: tests for .base on non-integers
