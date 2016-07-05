use v6;
use lib <t/spec/packages>;
use Test;
use Test::Util;

plan 1;

# RT#123887
{
    is_run q[say $\\], { :256status, err => /'Confused'/ },
        'spurious backslash at end of file error must ask for semicolon';
}
