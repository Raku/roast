# t/spec/S32-io/IO-Socket-INET.pl
# run by IO-Socket-INET.sh, which is run by IO-Socket-INET.t

# May 2009: script laden with commented out warnings that
# can be removed after stability of tests has been confirmed
# on multiple operating systems.

use v6.c;

constant PF_INET     = 2; # these should move into a file,
constant SOCK_STREAM = 1; # but what name and directory?
constant TCP         = 6;

my ( $test, $port, $server_or_client ) = @*ARGS;
$port = $port.Int;
my $host = '127.0.0.1';
my $server_ready_flag_fn = 't/spec/S32-io/server-ready-flag';

given $test {

    when 2 { # test number 2 - echo protocol, RFC 862
        if $server_or_client eq 'server' {
            # warn "SERVER TEST=$test PORT=$port";
            my $server = IO::Socket::INET.new(:localhost($host), :localport($port), :listen);
            # warn "SERVER LISTENING";
            my $fd = open( $server_ready_flag_fn, :w );
            $fd.close();
            while my $client = $server.accept() {
                # warn "SERVER ACCEPTED";
                my $received = $client.recv();
                # warn "SERVER RECEIVED '$received'";
                $client.print( $received );
                # warn "SERVER REPLIED";
                $client.close();
            }
        }
        else { # $server_or_client eq 'client'
            # warn "CLIENT TEST=$test PORT=$port";
            # avoid a race condition, where the client tries to
            # open() before the server gets to accept().
            until $server_ready_flag_fn.IO ~~ :e { sleep(0.1) }
            unlink $server_ready_flag_fn;
            my $client = IO::Socket::INET.new(:$host, :$port);
            # warn "CLIENT OPENED";
            $client.print( [~] flat '0'..'9', 'a'..'z' );
            # warn "CLIENT SENT";
            my $received = $client.recv();
            # warn "CLIENT RECEIVED '$received'";
            # let IO-Socket-INET.t judge the pass/fail
            say "echo '$received' received";
            $client.close();
        }
    }

    when 3 { # test number 3 - discard protocol, RFC 863
        if $server_or_client eq 'server' {
            # warn "SERVER TEST=$test PORT=$port";
            my $server = IO::Socket::INET.new(:localhost($host), :localport($port), :listen);
            my $fd = open( $server_ready_flag_fn, :w );
            $fd.close();
            # warn "SERVER LISTENING";
            while my $client = $server.accept() {
                # warn "SERVER ACCEPTED";
                my $received = $client.recv();
                # warn "SERVER RECEIVED '$received'";
                $client.close(); # without sending anything back
            }
        }
        else { # $server_or_client eq 'client'
            # warn "CLIENT TEST=$test PORT=$port";
            until $server_ready_flag_fn.IO ~~ :e { sleep(0.1) }
            unlink $server_ready_flag_fn;
            my $client = IO::Socket::INET.new(:$host, :$port);
            # warn "CLIENT OPENED";
            $client.print( [~] flat '0'..'9', 'a'..'z' );
            # warn "CLIENT SENT";
            my $received = $client.recv();
            # warn "CLIENT RECEIVED '$received'";
            # let IO-Socket-INET.t judge the pass/fail
            say "discard '$received' received";
            $client.close();
        }
    }

    when 4 { # test number 4 - recv with parameter
        if $server_or_client eq 'server' {
            my $server = IO::Socket::INET.new(:localhost($host), :localport($port), :listen);
            my $fd = open( $server_ready_flag_fn, :w );
            $fd.close();
            while my $client = $server.accept() {
                # Also sends two 3 byte unicode characters
                $client.print(join '',  '0'..'9', 'a'..'z',
                        chr(0xA001),  chr(0xA002) );
                $client.close();
            }
        }
        else {
            until $server_ready_flag_fn.IO ~~ :e { sleep(0.1) }
            unlink $server_ready_flag_fn;
            my $sock = IO::Socket::INET.new(:$host, :$port);
            # Tests that if we do not receive all the data available
            # it is buffered correctly for when we do request it
            say $sock.recv(7); # 0123456
            say $sock.recv(3); # 789
            say $sock.recv(26); # a-z
            # All is left are the two 3 byte characters 
            my $unifirst = $sock.recv(1);
            say $unifirst;
            say $unifirst.chars;
            # get second character
            my $unisecond = $sock.recv(1);
            say $unisecond.chars;
            # join it together
            say $unisecond;
            $sock.close();
        }
    }

    when 5 { # test number 5 - get()
        if $server_or_client eq 'server' {
            my $server = IO::Socket::INET.new(:localhost($host), :localport($port), :listen);
            my $fd = open($server_ready_flag_fn, :w);
            $fd.close();
            while my $client = $server.accept() {
                # default line separator
                use newline :lf;
                $client.print("'Twas brillig, and the slithy toves\n");
                $client.print("Did gyre and gimble in the wabe;\n");
                # custom line separator: \r\n
                $client.print("All mimsy were the borogoves,\r\n");
                # another custom separator: .
                $client.print("And the mome raths outgrabe.");
                # separator not at the end of the sent data: !
                $client.print("O frabjous day! Callooh! Callay!");
                $client.close();
            }
        } else { # client
            until $server_ready_flag_fn.IO ~~ :e { sleep(0.1) }
            unlink $server_ready_flag_fn;
            my $sock = IO::Socket::INET.new(:$host, :$port);
            # Default separator should handle \n and \r\n
            say $sock.get();
            say $sock.get();
            my $crlf-line = $sock.get();
            say $crlf-line;
            say $crlf-line.encode('ascii').elems;
            $sock.nl-in = '.';
            say $sock.get();
            $sock.nl-in = '!';
            say $sock.get();
            say $sock.get(); # will begin
            say $sock.get(); # with a space
            $sock.close();
        }
    }

    when 6 { # RT #116288, test number 6 - read with parameter
        if $server_or_client eq 'server' {
            my $server = IO::Socket::INET.new(:localhost($host), :localport($port), :listen);
            my $fd = open( $server_ready_flag_fn, :w );
            $fd.close();
            while my $client = $server.accept() {
                # send 4 packets á 4096 bytes
                for ^4 {
                    $client.print( $_ x 4096 );
                    sleep 1;
                }
                $client.close();
            }
        }
        else {
            until $server_ready_flag_fn.IO ~~ :e { sleep(0.1) }
            unlink $server_ready_flag_fn;
            my $sock = IO::Socket::INET.new(:$host, :$port);
            # .read will give us 16kB of data even it recvs several chunks of smaller size
            my $collected = $sock.read( 4096 * 4 );
            say $collected[0].chr;
            say $collected[ 4096 * 4 - 1 ].chr;
            say $collected.bytes;
            $sock.close();
        }
    }

    # for test 7 and 8
    my Buf $binary = slurp( 't/spec/S32-io/socket-test.bin', bin => True );

    when 7 { # test number 7 - write/read binary data
        if $server_or_client eq 'server' {
            my $server = IO::Socket::INET.new(:localhost($host), :localport($port), :listen);
            my $fd = open( $server_ready_flag_fn, :w );
            $fd.close();
            if my $client = $server.accept() {
                # send binary data á 4096 bytes
                $client.write( $binary );
                $client.close();
            }
        }
        else {
            until $server_ready_flag_fn.IO ~~ :e { sleep(0.1) }
            unlink $server_ready_flag_fn;
            my $sock = IO::Socket::INET.new(:$host, :$port);
            my $recv = $sock.read( $binary.elems() );
            say $binary eqv $recv ?? 'OK-7' !! 'NOK-7';
            $sock.close();
        }
    }

    when 8 { # test number 8 - write/recv binary data
        if $server_or_client eq 'server' {
            my $server = IO::Socket::INET.new(:localhost($host), :localport($port), :listen);
            my $fd = open( $server_ready_flag_fn, :w );
            $fd.close();
            if my $client = $server.accept() {
                # send binary data á 4096 bytes
                $client.write( $binary );
                $client.close();
            }
        }
        else {
            until $server_ready_flag_fn.IO ~~ :e { sleep(0.1) }
            unlink $server_ready_flag_fn;
            my $sock = IO::Socket::INET.new(:$host, :$port);
            my Buf $recv = Buf.new;
            my Buf $chunk;
            # in binary mode it will return a Buf, not Str
            while $chunk = $sock.recv( 4096, bin => True ) {
                $recv ~= $chunk;
            }
            say $binary.elems eqv $recv.elems ?? 'OK-8' !! 'NOK-8';
            $sock.close();
        }
    }

    when 9 { # test number 9 - recv one byte at a time
        if $server_or_client eq 'server' {
            my $server = IO::Socket::INET.new(:localhost($host), :localport($port), :listen);
            my $fd = open( $server_ready_flag_fn, :w );
            $fd.close();
            while my $client = $server.accept() {
                # send 4 byte string in one packet
                $client.print( 'xxxx' );
                $client.close();
            }
        }
        else {
            until $server_ready_flag_fn.IO ~~ :e { sleep(0.1) }
            unlink $server_ready_flag_fn;
            my $sock = IO::Socket::INET.new(:$host, :$port);
            # .read one byte at a time
            my $collected = $sock.read( 1 );
            $collected ~= $sock.read( 1 );
            $collected ~= $sock.read( 1 );
            $collected ~= $sock.read( 1 );
            say $collected[0].chr;
            say $collected[3].chr;
            say $collected.bytes;
            $sock.close();
        }
    }

    when 10 { # test number 10 - echo protocol, RFC 862, with connect/listen methods
        if $server_or_client eq 'server' {
            # warn "SERVER TEST=$test PORT=$port";
            my $server = IO::Socket::INET.listen($host, $port);
            # warn "SERVER LISTENING";
            my $fd = open( $server_ready_flag_fn, :w );
            $fd.close();
            while my $client = $server.accept() {
                # warn "SERVER ACCEPTED";
                my $received = $client.recv();
                # warn "SERVER RECEIVED '$received'";
                $client.print( $received );
                # warn "SERVER REPLIED";
                $client.close();
            }
        }
        else { # $server_or_client eq 'client'
            # warn "CLIENT TEST=$test PORT=$port";
            # avoid a race condition, where the client tries to
            # open() before the server gets to accept().
            until $server_ready_flag_fn.IO ~~ :e { sleep(0.1) }
            unlink $server_ready_flag_fn;
            my $client = IO::Socket::INET.connect($host, $port);
            # warn "CLIENT OPENED";
            $client.print( [~] flat '0'..'9', 'a'..'z' );
            # warn "CLIENT SENT";
            my $received = $client.recv();
            # warn "CLIENT RECEIVED '$received'";
            # let IO-Socket-INET.t judge the pass/fail
            say "echo '$received' received";
            $client.close();
        }
    }
}

=begin pod

=end pod
