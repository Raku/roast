use v6.c;
use Test;

plan 6;

{
    use newline :lf;
    is "\n".encode('ascii'), Buf.new(0x0A), 'use newline :lf influences \n';
    is Buf.new(0x0A).decode('ascii'), "\n", 'use newline :lf decodes to \n';
}
{
    use newline :cr;
    is "\n".encode('ascii'), Buf.new(0x0D), 'use newline :cr influences \n';
    is Buf.new(0x0D).decode('ascii'), "\n", 'use newline :cr decodes to \n';
}
{
    use newline :crlf;
    is "\n".encode('ascii'), Buf.new(0xD, 0x0A), 'use newline :crlf influences \n';
    is Buf.new(0xD, 0x0A).decode('ascii'), "\n", 'use newline :crlf decodes to \n';
}
