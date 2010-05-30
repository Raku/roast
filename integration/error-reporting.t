use v6;
use Test;

plan 2;

BEGIN { @*INC.push('t/spec/packages') };

use Test::Util;

is_run "use v6;\n'a' =~ /foo/", {
    status  => { $_ != 0 },
    out     => '',
    err     => rx/line \s+ 2>>/
}, 'Parse error contains line number';

is_run "my \$x = 2 * 3;\ndie \$x", {
    status  => { $_ != 0 },
    out     => '',
    err     => all(rx/6/, rx/'line 2'>>/),
}, 'Runtime error contains line number';
