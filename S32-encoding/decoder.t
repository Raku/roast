use Test;

plan 1;


# https://github.com/rakudo/rakudo/issues/2158
{
    my $str = 'I ❤ Perl6!';
    my $buf = $str.encode('utf8-c8');
    
    my $decoder = Encoding::Registry.find('utf8-c8').decoder(:translate-nl);

    $decoder.add-bytes($buf.subbuf(0, 8));
    $decoder.add-bytes($buf.subbuf(8));    

    ok $decoder.consume-all-chars().chars == $str.chars
        && $decoder.bytes-available == 0,
        'utf8-c8 decoder processes all bytes of all buffers';
}
# vim: ft=perl6 expandtab sw=4
