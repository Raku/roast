use v6;
use Test;

plan 3;

my $s-address = '0.0.0.0';
my $c-address = '127.0.0.1';
my $port    = 5001;

{
    my $sock = IO::Socket::Async.bind-udp($s-address, $port);
    dies-ok { IO::Socket::Async.bind-udp($s-address, $port) },
        'Error on trying to re-use port with UDP bind';
    $sock.close;
}

# Promise used to check listener received the correct data.
my $rec-prom;

# Listener
{
    my $sock = IO::Socket::Async.bind-udp($s-address, $port);
    my $tap = $sock.Supply.tap: -> $chars {
        if $chars.chars > 0 {
            $rec-prom.keep($chars);
        }
    }
}

# Client print-to
{
    $rec-prom = Promise.new;
    my $sock = IO::Socket::Async.udp();
    $sock.print-to($c-address, $port, "Unusually Dubious Protocol");
    is $rec-prom.result, "Unusually Dubious Protocol", "Sent/received data with UDP (print)";
    $sock.close;
}

# Client write-to
{
    $rec-prom = Promise.new;
    my $sock = IO::Socket::Async.udp();
    $sock.write-to($c-address, $port, "Unhelpful Dataloss Protocol".encode('ascii'));
    is $rec-prom.result, "Unhelpful Dataloss Protocol", "Sent/received data with UDP (write)";
    $sock.close;
}

# vim: expandtab shiftwidth=4
