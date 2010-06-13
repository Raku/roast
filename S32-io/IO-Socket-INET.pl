# t/spec/S32-io/IO-Socket-INET.pl
# run by IO-Socket-INET.sh, which is run by IO-Socket-INET.t

# May 2009: script laden with commented out warnings that
# can be removed after stability of tests has been confirmed
# on multiple operating systems.

use v6;

# use Perl 5 style subs for constants until 'constant' works again
sub PF_INET     { 2 } # constant PF_INET     = 2; # these should move into a file,
sub SOCK_STREAM { 1 } # constant SOCK_STREAM = 1; # but what name and directory?
sub TCP         { 6 } # constant TCP         = 6;
my ( $test, $port, $server_or_client ) = @*ARGS;
my $host = '127.0.0.1';

given $test {

    when 2 { # test number 2 - echo protocol, RFC 862
        if $server_or_client eq 'server' {
            # warn "SERVER TEST=$test PORT=$port";
            my $server = IO::Socket::INET.socket( PF_INET, SOCK_STREAM, TCP );
            $server.bind( $host, $port.Int );
            $server.listen(); # should accept max queue size parameter
            # warn "SERVER LISTENING";
            my $fd = open( 't/spec/S32-io/server-ready-flag', :w );
            $fd.close();
            while my $client = $server.accept() {
                # warn "SERVER ACCEPTED";
                my $received = $client.recv();
                # warn "SERVER RECEIVED '$received'";
                $client.send( $received );
                # warn "SERVER REPLIED";
                $client.close();
            }
        }
        else { # $server_or_client eq 'client'
            # warn "CLIENT TEST=$test PORT=$port";
            # avoid a race condition, where the client tries to
            # open() before the server gets to accept().
            until 't/spec/S32-io/server-ready-flag' ~~ :e { sleep(1) }
            my $client = IO::Socket::INET.new;
            $client.open( $host, $port.Int );
            # warn "CLIENT OPENED";
            $client.send( [~] '0'..'9', 'a'..'z' );
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
            my $server = IO::Socket::INET.socket( PF_INET, SOCK_STREAM, TCP );
            $server.bind( $host, $port.Int );
            $server.listen(); # should accept max queue size parameter
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
            # avoid a race condition, where the client tries to
            # open() before the server gets to accept().
            sleep 1; # crude, sorry
            my $client = IO::Socket::INET.new;
            $client.open( $host, $port.Int );
            # warn "CLIENT OPENED";
            $client.send( [~] '0'..'9', 'a'..'z' );
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
            my $server = IO::Socket::INET.socket(PF_INET, SOCK_STREAM, TCP);
            $server.bind($host, $port.Int);
            $server.listen();
            my $fd = open( 't/spec/S32-io/server-ready-flag', :w );
            $fd.close();
            while my $client = $server.accept() {
                # Also sends two 3 byte unicode characters
                $client.send(([~] '0'..'9', 'a'..'z') 
                    ~ "{chr 0xbeef}{chr 0xbabe}");
                $client.close();
            }
        }
        else {
            my $sock = IO::Socket::INET.new;
            until 't/spec/S32-io/server-ready-flag' ~~ :e { sleep(1) }
            $sock.open($host, $port.Int);
            # Tests that if we do not receive all the data available
            # it is buffered correctly for when we do request it
            say $sock.recv(7); # 0123456
            say $sock.recv(3); # 789
            say $sock.recv(26); # a-z
            # All is left are the two 3 byte characters 
            my $beef = $sock.recv(3);
            say $beef;
            say $beef.bytes;
            # get two bytes now
            my $babe = $sock.recv(2);
            say $babe.bytes;
            # join it together
            $babe ~= $sock.recv(1);
            say $babe;
            say $babe.bytes;
            $sock.close();
        }
    }

    when 5 { # test number 5 - get()
        if $server_or_client eq 'server' {
            my $server = IO::Socket::INET.socket(PF_INET, SOCK_STREAM, TCP);
            $server.bind($host, $port.Int);
            $server.listen();
            my $fd = open('t/spec/S32-io/server-ready-flag', :w);
            $fd.close();
            while my $client = $server.accept() {
                # default line separator
                $client.send("'Twas brillig, and the slithy toves\n");
                $client.send("Did gyre and gimble in the wabe;\n");
                # custom line separator: \r\n
                $client.send("All mimsy were the borogoves,\r\n");
                # another custom separator: .
                $client.send("And the mome raths outgrabe.");
                # separator not at the end of the sent data: !
                $client.send("O frabjous day! Callooh! Callay!");
                $client.close();
            }
        } else { # client
            my $sock = IO::Socket::INET.new;
            until 't/spec/S32-io/server-ready-flag' ~~ :e { sleep(1) }
            $sock.open($host, $port.Int);
            say $sock.get();
            say $sock.get();
            $sock.input-line-separator = "\r\n";
            say $sock.get();
            $sock.input-line-separator = '.';
            say $sock.get();
            $sock.input-line-separator = '!';
            say $sock.get();
            say $sock.get(); # will begin
            say $sock.get(); # with a space
            $sock.close();
        }
    }
}

=begin pod

=end pod
