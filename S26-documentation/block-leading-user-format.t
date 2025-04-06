use lib $?FILE.IO.parent(2).add($*SPEC.catdir(<packages Test-Helpers lib>));
use Test;
use Test::Util;

plan 2;

# tests user option with environment variable:
#   RAKUDO_POD_DECL_BLOCK_USER_FORMAT
my $envvar = 'RAKUDO_POD_DECL_BLOCK_USER_FORMAT';

# the test scripts

my $s1 = q:to<HERE1>;
#|  line 1
#| 
#| line 2
sub foo {}
#= line 3
#= 
#= line 4

HERE1

my $s2 = q:to<HERE2>;
#|  line 1
#| 
#| line 2
my $str = foo {}
#= line 3
#= 
#= line 4

HERE2

# hash for actual runs of test pairs (without and with the env var)
# key: the test string
#   values: array of the exact value of the two tests' expected results
my %h = [
    $s1 => [
        "sub foo()\nline 1 line 2\nline 3 line 4\n",
        "sub foo()\n line 1\nline 2\nline 3 line 4\n",
    ],
];

for %h.keys -> $s {
    my $r1wo = %h{$s}[0];
    my $r1w  = %h{$s}[1];

    # test 1: the test without the envvar (default)
    {
        is_run $s,                   # the code script
        {
            #:in, :args, :err,           # not yet used
            :out($r1wo),                 # exact expected output
            :status(0),
        },
        "without env var '$envvar'", # test description
        :compiler-args['--doc'];
    }

    # test 2: the test with the envvar
    {
        (temp %*ENV){$envvar} = 1;
        #?rakudo todo 'fixed in RakuAST'
        is_run $s,                   # the code script
        {
            #:in, :args, :err,           # not yet used
            :out($r1w),                  # exact expected output
            :status(0),
        },
        "with env var '$envvar'",    # test description
        :compiler-args['--doc'];
    }
}

# vim: expandtab shiftwidth=4
