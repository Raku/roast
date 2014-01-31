use v6;
use Test;

plan 7;

is q:to"FIN", "Hello again.\n", 'basic heredoc with :to';
Hello again.
FIN

my $str = q[q:to"noend";
HELLO WORLD noend
];

eval_dies_ok $str, 'Runaway multiline is an error';

is q:to[finished], "  Hello there\n    everybody\n", "indention of heredocs
(1)";
  Hello there
    everybody
finished

my $first = q:to/END/;
HELLO
  WORLD
END

my $second = q:to/END/;
    HELLO
      WORLD
    END

is $first, $second, "Indention stripped to end delimiter indention";

my $dlrs = 21;
my $cnts = 18;

is q:to/EOF/.chop, '$dlrs dollars and {$cnts} cents.', 'no interpolation by
default';
$dlrs dollars and {$cnts} cents.
EOF

#?rakudo todo ':c in heredocs'
is q:to:c/EOF/.chop, '$dlrs dollars and 18 cents.', ':c enables closure compilation';
$dlrs dollars and {$cnts} cents.
EOF

is qq:to/EOF/.chop, '21 dollars and 18 cents.', 'heredocs with qq interpolate';
$dlrs dollars and {$cnts} cents.
EOF
