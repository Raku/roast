use v6;

# L<S16/"Input and Output"/=item print>

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
    print $*DEFOUT: 'ok 7 - print with $*DEFOUT: as filehandle' ~ "\n";
    say $*DEFOUT: 'ok 8 - say with $*DEFOUT: as filehandle';
}

{
    $*DEFOUT.print: 'ok 9 - $*DEFOUT.print: list' ~ "\n";
    $*DEFOUT.say: 'ok 10 - $DEFOUT.say: list';

}

{
    my @array = 'ok', ' ',  '11 - $*DEFOUT.print(LIST)', "\n";
    $*DEFOUT.print(@array);
}

{
    my @array = 'ok', ' ',  '12 - $*DEFOUT.say(LIST)';
    $*DEFOUT.say(@array);
}


