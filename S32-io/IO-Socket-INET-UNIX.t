use v6;
use Test;

plan 8;

if $*DISTRO.is-win {
    skip-rest 'UNIX socket support on Windows NYI';
} else {
    my IO::Socket::INET:_ $server;
    my IO::Socket::INET:_ $client;
    my IO::Socket::INET:_ $accepted;
    my IO::Path:D         $path      = $?FILE.IO.sibling: 'test.sock';
    my Str:D              $sent      = 'Hello, world!';
    my Str:_              $received;
    LEAVE $path.unlink if $path.e;

    lives-ok {
        $server = IO::Socket::INET.listen: $path, family => PF_UNIX;
    }, 'can create TCP UNIX socket servers';
    lives-ok {
        $client = IO::Socket::INET.connect: $path, family => PF_UNIX;
    }, 'can create TCP UNIX socket clients';
    lives-ok {
        $accepted = $server.accept;
    }, 'can accept connections to TCP UNIX socket servers';

    lives-ok {
        $client.print: $sent;
    }, 'can write data to TCP UNIX sockets';
    lives-ok {
        $received = $accepted.recv;
    }, 'can receive data from TCP UNIX sockets...';
    is $received, $sent, '...which matches the original data sent';

    lives-ok {
        $client.close;
    }, 'can close TCP UNIX socket clients';
    lives-ok {
        $server.close;
    }, 'can close TCP UNIX socket servers';
}

# vim: ft=perl6
