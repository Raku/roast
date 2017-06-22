use v6;
use Test;

plan 13;

# Covers RT #126315 (which wanted the right thing of recv) and RT #116288
# (difference between recv and read semantics).

my $hostname = 'localhost';
my $port = 5002;

my ($send-rest, $client);

IO::Socket::Async.listen($hostname, $port).tap(-> $conn {
    $conn.print('first thing');
    await $send-rest;
    $conn.print('another thing');
    $conn.close;
});

$send-rest = Promise.new;
for ^10 {
    $client = IO::Socket::INET.new(:host("$hostname:$port"));
    last;
    CATCH { default { sleep 0.2; } }
}
is $client.recv, 'first thing', 'can recv immediately with recv (chars)';
$send-rest.keep(True);
is $client.recv, 'another thing', 'can recv rest afterwards (chars)';
$client.close;

$send-rest = Promise.new;
$client = IO::Socket::INET.new(:host("$hostname:$port"));
is $client.recv(20), 'first thing', 'recv char count is not lower limit (chars)';
$send-rest.keep(True);
is $client.recv(2), 'an', 'recv argument serves as upper limit (chars)';
$client.close;

$send-rest = Promise.new;
$client = IO::Socket::INET.new(:host("$hostname:$port"));
is $client.recv(:bin).decode('ascii'), 'first thing',
    'can recv immediately with recv (bytes)';
$send-rest.keep(True);
is $client.recv(:bin).decode('ascii'), 'another thing',
    'can recv rest afterwards (bytes)';
$client.close;

$send-rest = Promise.new;
$client = IO::Socket::INET.new(:host("$hostname:$port"));
is $client.recv(20, :bin).decode('ascii'), 'first thing',
    'recv char count is not lower limit (bytes)';
$send-rest.keep(True);
is $client.recv(2, :bin).decode('ascii'), 'an',
    'recv argument serves as upper limit (bytes)';
$client.close;

$send-rest = Promise.new;
$client = IO::Socket::INET.new(:host("$hostname:$port"));
is $client.recv(Inf), 'first thing', 'recv with Inf works (chars 1)';
$send-rest.keep(True);
is $client.recv(Inf), 'another thing', 'recv with Inf works (chars 2)';
$client.close;

$send-rest = Promise.new;
my $p = start {
    $client = IO::Socket::INET.new(:host("$hostname:$port"));
    my $res1 = $client.read(20);
    my $res2 = $client.read(20);
    $client.close;
    ($res1, $res2)
}
sleep 1;
is $p.status, Planned,
    'read blocks until it has enough data';
$send-rest.keep(True);
is $p.result[0].decode('ascii'), 'first thinganother t',
    'read gets the chars from across low level socket reads';
is $p.result[1].decode('ascii'), 'hing',
    'read stops blocking when server closes connection';
