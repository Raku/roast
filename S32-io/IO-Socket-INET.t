use v6;
use Test;

plan 3;

# L<S32::IO/IO::Socket::INET>

# Testing socket must solve 2 problems: find an unused port to bind to,
# and fork a client process before the server is blocked in accept().

my $host = '127.0.0.1';   # or 'localhost' may be friendlier

# To find an free port, list the ports currently in use.
my ( @ports, $netstat_cmd, $netstat_pat, $received, $expected );
given $*OS {
    when 'linux' {
        $netstat_cmd = "netstat --tcp --all --numeric";
        $netstat_pat = regex { State .+? [ ^^ .+? ':' (\d+) .+? ]+ $ };
    }
    when 'darwin' {
        $netstat_cmd = "netstat -f inet -p tcp -a -n";
        $netstat_pat = regex { [ ^^  .+? '.' (\d+) ' ' .+? ]+ $ };
    }
    default {
        skip_rest('Operating system not yet supported');
        exit 0;
    }
    # TODO: when 'Win32' etc.
}
$received = qqx{$netstat_cmd};                    # refactor into 1 line after
if $received ~~ $netstat_pat { @ports = $/[]; }   # development complete
#warn @ports.elems ~ " PORTS=" ~ @ports;

# sequentially search for the first unused port
my $port = 1024;
while $port < 65535 && $port==any(@ports) { $port++; }
if $port > 65535 { 
    diag "no free port; abortin"; 
    skip_rest 'No port free - cannot test';
    exit 0;
}
diag "Testing on port $port";

# test 1 creates a TCP socket but does not use it.
constant PF_INET     = 2; # these should move into a file,
constant SOCK_STREAM = 1; # but what name and directory?
constant TCP         = 6;
my $server = IO::Socket::INET.socket( PF_INET, SOCK_STREAM, TCP );
isa_ok $server, IO::Socket::INET;
# Do not bind to this socket in the parent process, that would prevent a
# child process from using it.

if $*OS eq any <linux darwin> { # please add more valid OS names

    # test 2 does echo protocol - Internet RFC 862
    $received = qqx{sh t/spec/S32-io/IO-Socket-INET.sh 2 $port};
    #warn "TEST 2 $received";
    $expected = "echo '0123456789abcdefghijklmnopqrstuvwxyz' received\n";
    is $received, $expected, "echo server and client";

    # test 3 does discard protocol - Internet RFC 863
    $received = qqx{sh t/spec/S32-io/IO-Socket-INET.sh 3 $port};
    #warn "TEST 3 $received";
    $expected = "discard '' received\n";
    is $received, $expected, "discard server and client";
}
else {
    # eg Win32 shell script needs writing
    skip 1, "OS '$*OS' shell support not confirmed";
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
