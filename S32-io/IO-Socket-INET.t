use Test;

plan 32;

my $localhost = '0.0.0.0';
my $host      = '127.0.0.1';

# test 2 does echo protocol - Internet RFC 862
do-test
    # server
    {
        # we are handling only one request/reply
        my $client = $^server.accept();
        my $received = $client.recv();
        $client.print( $received );
        $client.close;
        $^server.close;
    },
    # client
    {
        my $expected = [~] flat '0'..'9', 'a'..'z';

        $^client.print( $expected );
        my $received = $client.recv();
        $^client.close();

        is $received, $expected, "echo server and client";
    };

# test 3 does discard protocol - Internet RFC 863
do-test
    # server
    {
        # we are handling only one request/reply
        my $client = $^server.accept();
        my $received = $client.recv();
        $client.close;
        $^server.close;
    },
    # client
    {
        $^client.print( [~] flat '0'..'9', 'a'..'z' );
        my $received = $client.recv();
        $^client.close();

        nok $received, "discard server and client";
    };

# test 4 tests recv with a parameter
do-test
    # server
    {
        # we are handling only one request/reply
        my $client = $^server.accept();
        # Also sends two 3 byte unicode characters
        $client.print(join '',  '0'..'9', 'a'..'z',
        chr(0xA001),  chr(0xA002) );
        $client.close;
        $^server.close;
    },
    # client
    {
        my $received;

        is $^client.recv(7), '0123456', "received first 7 characters";
        is $^client.recv(3), '789', "received next 3 characters";
        is $^client.recv(26), ([~] 'a' .. 'z'), "remaining 26 were buffered";

        # Multibyte characters
        # https://github.com/Raku/old-issue-tracker/issues/2981

        $received = $^client.recv(1);
        is $received, chr(0xA001), "received {chr 0xA001}";
        is $received.chars, 1, "... which is 1 character";

        $received = $^client.recv(1);
        is $received.chars, 1, "received another character";
        # https://github.com/Raku/old-issue-tracker/issues/2981

        is $received, chr(0xA002), "combined the bytes form {chr 0xA002}";

        $^client.close();
    };

# test 5 tests get()
do-test
    # server
    {
        # we are handling only one request/reply
        my $client = $^server.accept();

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

        $client.close;
        $^server.close;
    },
    # client
    {
        my $received;

        is $^client.get(), "'Twas brillig, and the slithy toves",
          "get() with default separator";
        is $^client.get(), 'Did gyre and gimble in the wabe;',
          "default separator";

        $received = $^client.get();
        is $received, 'All mimsy were the borogoves,',
          "\\r\\n separator";
        # https://github.com/Raku/old-issue-tracker/issues/2627

        is $received.encode('ascii').elems, 29,
          "\\r was not left behind on the string";

        $^client.nl-in = '.';
        is $^client.get(), 'And the mome raths outgrabe',
          ". as a separator";

        $^client.nl-in = '!';
        is $^client.get(), 'O frabjous day',
          "! separator not at end of string";

        is $^client.get(), ' Callooh',
          "Multiple separators not at end of string";
        is $^client.get(), ' Callay',
          "! separator at end of string";

        $^client.close();
    };

# don't explode when an nl-in is set before the first get()
do-test
    # server
    {
        # we are handling only one request/reply
        my $client = $^server.accept();

        # default line separator
        use newline :lf;
        $client.print("All mimsy were the borogoves,\r\n");
        $client.print("And the mome raths outgrabe.\r\n");

        $client.close;
        $^server.close;
    },
    # client
    {
        my $received;

        $^client.nl-in = "\r\n";

        $received = $^client.get();
        is $received, 'All mimsy were the borogoves,',
          "first get after creation came after first set of nl-in";

        $received = $^client.get();
        is $received, 'And the mome raths outgrabe.',
          "another get for good measure.";

        $^client.close();
    };

# https://github.com/Raku/old-issue-tracker/issues/2593
do-test
    # server
    {
        # we are handling only one request/reply
        my $client = $^server.accept();

        for ^4 {
            $client.print( $_ x 4096 );
        }

        $client.close;
        $^server.close;
    },
    # client
    {
        my $received = $^client.read( 4096 * 4 );

        is $received[0].chr, '0', "received first character";
        is $received[*-1].chr, '3', "received last character";
        is $received.bytes, 4096 * 4, "total amount";

        $^client.close();
    };

# for test 7 and 8
my $file = $*PROGRAM-NAME.IO.dirname.IO.add("socket-test.bin");
my Buf[uint8] $binary .= new( ^256 .roll(4000) );

# test 7 tests recv with binary data
do-test
    # server
    {
        # we are handling only one request/reply
        my $client = $^server.accept();

        $client.write( $binary );

        $client.close;
        $^server.close;
    },
    # client
    {
        my $received = $^client.read( $binary.elems );

        #?rakudo.jvm todo 'problem with equivalence of Buf objects'
        is-deeply $received, $binary, "successful read binary data";

        $^client.close();
    };

# test 8 tests recv with binary data.
do-test
    # server
    {
        # we are handling only one request/reply
        my $client = $^server.accept();

        $client.write( $binary );

        $client.close;
        $^server.close;
    },
    # client
    {
        my Buf $received = Buf.new;
        my Buf $chunk;

        # will read in 4 chunks
        # in binary mode it will return a Buf, not Str
        while $chunk = $^client.recv( $binary.elems div 4, bin => True ) {
            $received ~= $chunk;
        }

        is $received, $binary, "successful received binary data";

        $^client.close();
    };

# test 9 tests one-byte .read calls
# When .read is called, it grabs a chunk of data and caches what we don't
# immediately use. This is testing for a moarbug where that cache would get
# wiped out
do-test
    # server
    {
        # we are handling only one request/reply
        my $client = $^server.accept();

        $client.print( 'xxxx' );

        $client.close;
        $^server.close;
    },
    # client
    {
        my $received = $^client.read( 1 );
        $received ~= $^client.read( 1 );
        $received ~= $^client.read( 1 );
        $received ~= $^client.read( 1 );

        is $received, 'xxxx'.encode('ISO-8859-1'), "test moar cache by reading per byte";

        $^client.close();
    };

# test 10 tests mixing binary and non binary access.
do-test
    # server
    {
        # we are handling only one request/reply
        my $client = $^server.accept();
        # Also sends two 3 byte unicode characters
        $client.print(join '',  '0'..'9', 'a'..'z');
        $client.close;
        $^server.close;
    },
    # client
    {
        my $received;

        is $^client.recv(7), '0123456', "received first 7 characters";
        is $^client.recv(3, :bin).decode, '789', "received next 3 characters";
        is $^client.recv(26), ([~] 'a' .. 'z'), "remaining 26 were buffered";

        $^client.close();
    };

# https://github.com/rakudo/rakudo/issues/1721
{
  my $str := "foo\nbar\r\nmeows\n";
  do-test
    # server
    {
        # we are handling only one request/reply
        my $client := $^server.accept;
        $client.print: $str;
        $client.close;
        $^server.close;
    },
    # client
    {
        is-deeply $^client.lines.head(100), $str.lines,
            'can read correct lines from client without any hangs';
        $^client.close();
    }
}

{ # https://github.com/rakudo/rakudo/issues/1738
    my $sync := Channel.new;
    start {
        my $server := IO::Socket::INET.new:
          :$localhost, :0localport, :listen;
        $sync.send: $server.localport;
        my $client := $server.accept;
        $client.print: "Test passed\n";
        $client.close;
        $server.close;
    }
    is IO::Socket::INET.new(
        :!listen, # <-- testing on purpose with :!listen set
        :$host, :port($sync.receive)
    ).get, 'Test passed', 'can connect as client when :$listen is set to False';
}

if $*DISTRO.is-win            or  # test for WSL below
   $*KERNEL.name eq "linux"   and $*KERNEL.release ~~ /:i <?wb>Microsoft<?wb>/ {
    # https://github.com/Raku/old-issue-tracker/issues/6094
    skip 'Winsock 1 second delay for connection failure RT #130892', 1
}
else {
    # MoarVM #234
    eval-lives-ok 'for ^2000 { IO::Socket::INET.new( :0port, :host<127.0.0.1> ); CATCH {next}; next }',
                  'Surviving without SEGV due to incorrect socket connect/close handling';
}

{
    my Int:D $family = (0...*).first(ProtocolFamily.^enum_value_list.none);
    dies-ok {
        my IO::Socket::INET:D $server .= new: :$localhost, :0localport, :$family;
        $server.close;
    }, 'IO::Socket::INET.new Int:D families not corresponding to any ProtocolFamily:D do not typecheck';
}

sub do-test(Block $b-server, Block $b-client) {
    my $sync   = Channel.new;
    my $thread = Thread.start(
        {
            my $server = IO::Socket::INET.new(:$localhost, :localport(0), :listen);

            $sync.send($server.localport);

            $b-server($server);
        }
    );

    my $client = IO::Socket::INET.new(:$host, :port($sync.receive));
    $b-client($client);
    $thread.finish;
}

=begin pod

=head1 Raku Internet Sockets Testing
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
UDP. Concurrent connections (needs threads).

=head1 SEE ALSO

 echo    L<http://www.ietf.org/rfc/rfc862.txt> port  7
 discard L<http://www.ietf.org/rfc/rfc863.txt> port  9
 chargen L<http://www.ietf.org/rfc/rfc864.txt> port 19
 daytime L<http://www.ietf.org/rfc/rfc867.txt> port 13
 time    L<http://www.ietf.org/rfc/rfc868.txt> port 37

=end pod

# vim: expandtab shiftwidth=4
