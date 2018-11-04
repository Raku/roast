use v6;
use lib $?FILE.IO.parent(2).add("packages/Test-Helpers");
use Test;
use Test::Util;

plan 1;

# RT#123887
{
    is_run q[say $\\], { :1status, err => /'Confused'/ },
        'spurious backslash at end of file error must ask for semicolon';
}
