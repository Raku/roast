use v6;

# L<S32::IO/IO/=item print>

# doesn't use Test.pm and plan() intentionally

print "1..12\n";

# Tests for print
{
    print "ok 1 - basic form of print\n";
}

{
    print "o", "k 2 - print with multiple parame", "ters (1)\n";

    my @array = ("o", "k 3 - print with multiple parameters (2)\n");
    print @array;
}

{
    my $arrayref = (<ok 4 - print stringifies its args>, "\n");
    print $arrayref;
}

{
   "ok 5 - method form of print\n".print;
}

{
    print "o";
    print "k 6 - print doesn't add newlines\n";
}

# Perl6::Spec::IO mentions
# print FILEHANDLE: LIST
# FILEHANDLE.print(LIST)
#  FILEHANDLE.print: LIST
#  same holds for say, even though it is not (yet?) explicitly mentioned

{
    #?niecza emit #
    print $*OUT: 'ok 7 - print with $*OUT: as filehandle' ~ "\n";
    #?niecza emit print "not ok 7 # TODO\nnot ok 8 # TODO" #
    say $*OUT: 'ok 8 - say with $*OUT: as filehandle';
}

{
    $*OUT.print: 'ok 9 - $*OUT.print: list' ~ "\n";
    $*OUT.say: 'ok 10 - $OUT.say: list';

}

{
    my @array = 'ok', ' ',  '11 - $*OUT.print(LIST)', "\n";
    $*OUT.print(@array);
}

{
    my @array = 'ok', ' ',  '12 - $*OUT.say(LIST)';
    $*OUT.say(@array);
}



# vim: ft=perl6
