use Test;

plan 21;

my $said;
sub say(*@a) { $said = @a>>.gist.join }   # don't care about the new line

{
    my $a = 42;
    say "value = $a";
    is $said, q/value = 42/
}

{
    my $a = 42;
    say Q/foo $a \n/;
    is $said, q/foo $a \n/;
}

{
    my $a = 42;
    say Q:s/foo $a\n/;
    is $said, q/foo 42\n/;
    say Q:b/foo $a\n/;
    is $said, q/foo $a
/;
    say Q:s:b/foo $a\n/;
    is $said, q/foo 42
/;
}

{
    my $a = 42;
    say Q :scalar :array :hash :function :closure :backslash /foo $a\n/;
    is $said, q/foo 42
/;
}

{
    my $a = 42;
    say Q:s:a:h:f:c:b/foo $a\n/;
    is $said, q/foo 42
/;
}

{
    my $a = 42;
    say Q:f:s:b:a:c:h/foo $a\n/;
    is $said, q/foo 42
/;
}

{
    my $a = 42;
    say Q:double/foo $a\n/;
    is $said, q/foo 42
/;
    say Q:qq/foo $a\n/;
    is $said, q/foo 42
/;
}

{
    my $a = 42;
    say qq/foo "$a"\n/;
    is $said, q/foo "42"
/;
}

{
    say qq:!s:!c/foo "$x{$y}"\n/;
    is $said, q/foo "$x{$y}"
/;
}

{
    my $w = 'World';
    say qqx/echo Hello $w/;
    is $said, q/Hello World
/;
}

{
    my @a = 'foo','bar',q/'first/,q/second'/;
    for qw/ foo bar 'first second' / Z @a -> $string, $result {
        say $string;
        is $said, $result;
    }
}

{
    my @a = 'foo','bar',q/first second/;
    for qww/ foo bar 'first second' / Z @a -> $string, $result {
        say $string;
        is $said, $result;
    }
}

{
    my $a = 'world';
    say qqto/FOO/;
        Hello $a
        FOO
    is $said, q/Hello world
/;
}
