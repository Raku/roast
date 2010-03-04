use v6;
use Test;

# Maybe someone can put in a better smartlink? --lue
# L<S32::IO/"A file test, where X is one of the letters listed below.">

plan 6;

#Str methods
##existence
is 'pi.txt'.e, 1, 'It exists';
is 'xyzzy'.e, 0, "It doesn't";

##is empty
is 'empty.txt'.z, 1, 'Is empty';
is 'pi.txt'.z, 0, 'Is not';

##file size
is 'empty.txt'.s, 0, 'No size';
is 'pi.txt'.s, 11, 'size of file'; #if this test fails, check the size of pi.txt first, and change if necessary :)
