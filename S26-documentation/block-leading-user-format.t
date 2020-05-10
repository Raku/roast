use v6;
use Test;

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
        is-run $s,                   # the code script
        "without env var '$envvar'", # test description
        :compiler-args['--doc'],
        #:in, :args, :err,           # not yet used
        :out($r1wo),                 # exact expected output
        :exitcode(0);
    }

    # test 2: the test without the envvar (default)
    {
        (temp %*ENV){$envvar} = 1;
        is-run $s,                   # the code script
        "with env var '$envvar'",    # test description
        :compiler-args['--doc'],
        #:in, :args, :err,           # not yet used
        :out($r1w),                  # exact expected output
        :exitcode(0);
    }


}

sub is-run (
    Str() $code, $desc = "$code runs",
    Stringy :$in, :@compiler-args, :@args, :$out = '', :$err = '', :$exitcode = 0
) is export {
    my @proc-args = flat do if $*DISTRO.is-win {
        # $*EXECUTABLE is a batch file on Windows, that goes through cmd.exe
        # and chokes on standard quoting. We also need to remove any newlines
        <cmd.exe  /S /C>, $*EXECUTABLE, @compiler-args, '-e',
        ($code,  @args).subst(:g, "\n", " ")
    }
    else {
        $*EXECUTABLE, @compiler-args, '-e', $code, @args
    }

    with run :in, :out, :err, @proc-args {
        $in ~~ Blob ?? .in.write: $in !! .in.print: $in if $in;
        $ = .in.close;
        my $proc-out      = .out.slurp: :close;
        my $proc-err      = .err.slurp: :close;
        my $proc-exitcode = .exitcode;

        my $wanted-exitcode = $exitcode // 0;
        my $wanted-out      = $out    // '';
        my $wanted-err      = $err    // '';

        subtest $desc => {
            plan 3;
            cmp-ok $proc-out,      '~~', $wanted-out,      'STDOUT';
            cmp-ok $proc-err,      '~~', $wanted-err,      'STDERR';
            cmp-ok $proc-exitcode, '~~', $wanted-exitcode, 'Exit code';
        }
    }
}
