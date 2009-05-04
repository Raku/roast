# t/spec/S32-io/IO-Socket-INET.pl
# run by IO-Socket-INET.sh, which is run by IO-Socket-INET.t

# May 2009: script laden with commented out warnings that
# can be removed after stability of tests has been confirmed
# on multiple operating systems.

use v6;

constant PF_INET     = 2; # these should move into a file,
constant SOCK_STREAM = 1; # but what name and directory?
constant TCP         = 6;
my ( $test, $port, $server_or_client ) = @*ARGS;
my $host = '127.0.0.1';

given $test {

    when 2 { # test number 2 - echo protocol, RFC 862
        if $server_or_client eq 'server' {
            # warn "SERVER TEST=$test PORT=$port";
            my $server = IO::Socket::INET.socket( PF_INET, SOCK_STREAM, TCP );
            $server.bind( $host, int($port) );
            $server.listen(); # should accept max queue size parameter
            # warn "SERVER LISTENING";
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
            sleep 1; # crude, sorry
            my $client = IO::Socket::INET.new;
            $client.open( $host, int($port) );
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
            $server.bind( $host, int($port) );
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
            $client.open( $host, int($port) );
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
}

=begin pod

=end pod
