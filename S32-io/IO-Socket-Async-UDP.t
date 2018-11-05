use v6;
use Test;

plan 5;

my $hostname = 'localhost';
my $port = 5001;

{
    my $s = IO::Socket::Async.bind-udp($hostname, $port);
    dies-ok { IO::Socket::Async.bind-udp($hostname, $port) },
        'Error on trying to re-use port with UDP bind';
    $s.close;
}

# Promise used to check listener received the correct data.
my Promise $rec-prom;
my $s = IO::Socket::Async.bind-udp($hostname, $port);
my $tap = $s.Supply.tap: -> $chars {
    if $chars.chars > 0 {
        $rec-prom.keep($chars);
    }
}

# Client print-to
{
    $rec-prom .= new;
    my $c = IO::Socket::Async.udp();
    $c.print-to($hostname, $port, "Unusually Dubious Protocol");
    is $rec-prom.result, "Unusually Dubious Protocol", "Sent/received data with UDP (print)";
    $c.close;
}

# Client write-to
{
    $rec-prom .= new;
    my $c = IO::Socket::Async.udp();
    $c.write-to($hostname, $port, "Unhelpful Dataloss Protocol".encode('ascii'));
    is $rec-prom.result, "Unhelpful Dataloss Protocol", "Sent/received data with UDP (write)";
    $c.close;
}

#?rakudo.jvm skip 'nqp::filenofh not yet implemented on the JVM'
{
    my $c = IO::Socket::Async.udp();
    cmp-ok $s.native-descriptor, '>', -1, 'server file descriptor makes sense';
    cmp-ok $c.native-descriptor, '>', -1, 'client file descriptor makes sense';
    $c.close;
}

$s.close;
