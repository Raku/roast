use Test;

plan 4;

{
    my $enc = Encoding::Registry.find('ascii').encoder();
    is-deeply $enc.encode-chars('foo'), blob8.new(102,111,111),
        'Can use ASCII encoder to encode';
    dies-ok { $enc.encode-chars('foo£') },
        'Dies it try to encode disallowed char';
}

{
    my $enc = Encoding::Registry.find('ascii').encoder(:replacement);
    is-deeply $enc.encode-chars('foo£'), blob8.new(102,111,111,63),
        'ASCII encoder configured to use default ASCII replacement works';
}

{
    my $enc = Encoding::Registry.find('ascii').encoder(:replacement('f'));
    is-deeply $enc.encode-chars('foo£'), blob8.new(102,111,111,102),
        'ASCII encoder configured to use custom replacement works';
}
