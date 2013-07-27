use v6;
use Test;

plan 41;

diag "{elapsed} starting tests";
my $elapsed;
sub elapsed {
    state $last = time;
    LEAVE $last = time;
    return "[{ $elapsed = time - $last }s]";
}
my $toolong = 5;

# L<S32::IO/IO::Socket::INET>

# Testing socket must solve 2 problems: find an unused port to bind to,
# and fork a client process before the server is blocked in accept().

my $host = '127.0.0.1';   # or 'localhost' may be friendlier

# To find an free port, list the ports currently in use.
my ( @ports, $netstat_cmd, $netstat_pat, $received, $expected );
given $*OS {
    when 'linux' {
        $netstat_cmd = "netstat --tcp --all --numeric";
        $netstat_pat = rx{ State .+? [ ^^ .+? ':' (\d+) .+? ]+ $ };
    }
    when 'darwin' {
        $netstat_cmd = "netstat -f inet -p tcp -a -n";
        $netstat_pat = rx{ [ ^^  .+? '.' (\d+) ' ' .+? ]+ $ };
    }
    when 'solaris' {
        $netstat_cmd = "netstat -an -P tcp -f inet";
        $netstat_pat = rx{ [ ^^  .+? '.' (\d+) ' ' .+? ]+ $ }; # same as darwin
    }
    when 'MSWin32' {
        $netstat_cmd = "netstat -n";
        $netstat_pat = rx{ State .+? [ ^^ .+? ':' (\d+) .+? ]+ $ }; # same as linux
    }
    default {
        skip_rest('Operating system not yet supported');
        exit 0;
    }
    # TODO: other operating systems; *BSD etc.	 
}
$received = qqx{$netstat_cmd};                    # refactor into 1 line after
if $received ~~ $netstat_pat { @ports = $/.list; }  # development complete
                         # was @ports = $/[]      in Rakudo/alpha
                         #     @ports = $/[0] also now in master
#warn @ports.elems ~ " PORTS=" ~ @ports;

# sequentially search for the first unused port
my $port = 1024;
while $port < 65535 && $port==any(@ports) { $port++; }
if $port >= 65535 {
    diag "no free port; aborting";
    skip_rest 'No port free - cannot test';
    exit 0;
}
diag "{elapsed} Testing on port $port";


if $*OS eq any <linux darwin solaris MSWin32> { # please add more valid OS names

    my $is-win;
    $is-win = True if $*OS eq 'MSWin32';

    # test 2 does echo protocol - Internet RFC 862
    if $is-win {
        $received = qqx{t\\spec\\S32-io\\IO-Socket-INET.bat 2 $port};
    } else {
        $received = qqx{sh t/spec/S32-io/IO-Socket-INET.sh 2 $port};
    }
    #warn "TEST 2 $received";
    $expected = "echo '0123456789abcdefghijklmnopqrstuvwxyz' received\n";
    is $received, $expected, "{elapsed} echo server and client";
    nok $elapsed > $toolong, "finished in time #1";

    # test 3 does discard protocol - Internet RFC 863
    if $is-win {
        $received = qqx{t\\spec\\S32-io\\IO-Socket-INET.bat 3 $port};
    } else {
        $received = qqx{sh t/spec/S32-io/IO-Socket-INET.sh 3 $port};
    }
    #warn "TEST 3 $received";
    $expected = "discard '' received\n";
    is $received, $expected, "{elapsed} discard server and client";
    nok $elapsed > $toolong, "finished in time #2";

    # test 4 tests recv with a parameter
    if $is-win {
        $received = qqx{t\\spec\\S32-io\\IO-Socket-INET.bat 4 $port};
    } else {
        $received = qqx{sh t/spec/S32-io/IO-Socket-INET.sh 4 $port};
    }
    $expected = $received.split("\n");
    my $i = 0;
    is $expected[$i++], '0123456', "{elapsed} received first 7 characters";
    nok $elapsed > $toolong, "finished in time #3";
    is $expected[$i++], '789', "{elapsed} received next 3 characters";
    nok $elapsed > $toolong, "finished in time #4";
    is $expected[$i++], 'abcdefghijklmnopqrstuvwxyz', "{elapsed} remaining 26 were buffered";
    nok $elapsed > $toolong, "finished in time #5";
    # Multibyte characters
    # RT #115862
    is $expected[$i], chr(0xbeef), "{elapsed} received {chr 0xbeef}";
    nok $elapsed > $toolong, "finished in time #6";
    $i++;
    is $expected[$i++], 1, "{elapsed} ... which is 1 character";
    nok $elapsed > $toolong, "finished in time #7";
    is $expected[$i++], 1, "{elapsed} received another character";
    nok $elapsed > $toolong, "finished in time #8";
    # RT #115862
    is $expected[$i], chr(0xbabe), "{elapsed} combined the bytes form {chr 0xbabe}";
    nok $elapsed > $toolong, "finished in time #9";
    $i++;

    # test 5 tests get()
    if $is-win {
        $received = qqx{t\\spec\\S32-io\\IO-Socket-INET.bat 5 $port};
    } else {
        $received = qqx{sh t/spec/S32-io/IO-Socket-INET.sh 5 $port};
    }
    $expected = $received.split("\n");
    $i = 0;
    is $expected[$i++], "'Twas brillig, and the slithy toves",
      "{elapsed} get() with default separator";
    nok $elapsed > $toolong, "finished in time #10";
    is $expected[$i++], 'Did gyre and gimble in the wabe;',
      "{elapsed} default separator";
    nok $elapsed > $toolong, "finished in time #11";
    is $expected[$i++], 'All mimsy were the borogoves,',
      "{elapsed} \\r\\n separator";
    nok $elapsed > $toolong, "finished in time #12";
    is $expected[$i++], 'And the mome raths outgrabe',
      "{elapsed} . as a separator";
    nok $elapsed > $toolong, "finished in time #13";
    is $expected[$i++], 'O frabjous day',
      "{elapsed} ! separator not at end of string";
    nok $elapsed > $toolong, "finished in time #14";
    is $expected[$i++], ' Callooh',
      "{elapsed} Multiple separators not at end of string";
    nok $elapsed > $toolong, "finished in time #15";
    is $expected[$i++], ' Callay',
      "{elapsed} ! separator at end of string";

    # RT #116288, test 6 tests read with a parameter
    if $is-win {
        $received = qqx{t\\spec\\S32-io\\IO-Socket-INET.bat 6 $port};
    } else {
        $received = qqx{sh t/spec/S32-io/IO-Socket-INET.sh 6 $port};
    }
    $expected = $received.split("\n");
    $i = 0;
    is $expected[$i++], '0', "{elapsed} received first character";
    nok $elapsed > $toolong, "finished in time #16";
    is $expected[$i++], '3', "{elapsed} received last character";
    nok $elapsed > $toolong, "finished in time #17";
    is $expected[$i++], 4096 * 4, "{elapsed} total amount ";
    nok $elapsed > $toolong, "finished in time #18";

    # test 7 tests recv with binary data
    if $is-win {
        $received = qqx{t\\spec\\S32-io\\IO-Socket-INET.bat 7 $port};
    } else {
        $received = qqx{sh t/spec/S32-io/IO-Socket-INET.sh 7 $port};
    }
    $expected = $received.split("\n");
    is $expected[0], 'OK-7', "{elapsed} successful read binary data";
    nok $elapsed > $toolong, "finished in time #19";

    # test 8 tests recv with binary data.
    if $is-win {
        $received = qqx{t\\spec\\S32-io\\IO-Socket-INET.bat 8 $port};
    } else {
        $received = qqx{sh t/spec/S32-io/IO-Socket-INET.sh 8 $port};
    }
    $expected = $received.split("\n");
    is $expected[0], 'OK-8', "{elapsed} successful received binary data";
    nok $elapsed > $toolong, "finished in time #20";
}
else {
    skip "OS '$*OS' shell support not confirmed", 1;
}


=begin pod

=head1 Perl 6 Internet Sockets Testing
The initial use of the BSD Sockets library by Parrot and Rakudo happened
without a formal test suite, slowing development and causing occasional
random errors. This set of tests aims to ensure the future stability of
of the Sockets library integration, and to help enhance Rakudo's
IO::Socket::INET class in the 'setting'.

The BSD Sockets functions provide server and client functions that run
synchronously, blocking and waiting indefinitely for communication from
a remote process. Sockets testing therefore requires separate server and
client processes or threads. Rakudo does not currently fork or thread,
so these tests employ a unix shell script that uses the & symbol to fork
background processes. When Rakudo starts forking or threading, this
testing solution should be refactored down to just the main script.

=head1 Scope of tests
To date, only single TCP sessions have been tested, and only on Linux.
The Internet standard protocols are used, except that a dynamic port
number above the first 1024 is used so that superuser (root) privileges
are not required. Execution time is 5 to 10 seconds.

=head1 TODO
UDP. Unix sockets. Concurrent connections (needs threads).

=head1 SEE ALSO

 echo    L<http://www.ietf.org/rfc/rfc862.txt> port  7
 discard L<http://www.ietf.org/rfc/rfc863.txt> port  9
 chargen L<http://www.ietf.org/rfc/rfc864.txt> port 19
 daytime L<http://www.ietf.org/rfc/rfc867.txt> port 13
 time    L<http://www.ietf.org/rfc/rfc868.txt> port 37

=end pod

# vim: ft=perl6
