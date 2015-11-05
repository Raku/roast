use v6;
use Test;

plan 3;

{
    use newline :lf;
    is "\n".encode('ascii'), Buf.new(0x0A), 'use newline :lf influences \n';
}
{
    use newline :cr;
    is "\n".encode('ascii'), Buf.new(0x0D), 'use newline :cr influences \n';
}
{
    use newline :crlf;
    is "\n".encode('ascii'), Buf.new(0xD, 0x0A), 'use newline :crlf influences \n';
}
