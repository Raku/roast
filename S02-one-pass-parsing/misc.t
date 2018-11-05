use v6.d;
use lib $?FILE.IO.parent(2).add("packages");
use Test;
use Test::Util;

plan 1;

# RT#123887
{
    is_run q[say $\\], { :1status, err => /'Confused'/ },
        'spurious backslash at end of file error must ask for semicolon';
}
