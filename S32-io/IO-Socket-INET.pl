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
                $client.send( $received );
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
            my $server = IO::Socket::INET.new(:localhost($host), :localport($port), :listen);
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
            my $client = IO::Socket::INET.new(:$host, :$port);
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
            my $server = IO::Socket::INET.new(:localhost($host), :localport($port), :listen);
            my $fd = open( $server_ready_flag_fn, :w );
            $fd.close();
            while my $client = $server.accept() {
                # Also sends two 3 byte unicode characters
                $client.send(join '',  '0'..'9', 'a'..'z',
                        chr(0xbeef),  chr(0xbabe) );
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
            my $beef = $sock.recv(1);
            say $beef;
            say $beef.chars;
            # get second character
            my $babe = $sock.recv(1);
            say $babe.chars;
            # join it together
            say $babe;
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
            until $server_ready_flag_fn.IO ~~ :e { sleep(0.1) }
            unlink $server_ready_flag_fn;
            my $sock = IO::Socket::INET.new(:$host, :$port);
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
