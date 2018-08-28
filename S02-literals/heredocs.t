use v6;
use lib $?FILE.IO.parent(2).add("packages");
use Test;
use Test::Util;
plan 33;

my $foo = "FOO";
my $bar = "BAR";

sub no-r(Str $in) { $in.subst("\r\n", "\n", :g) }

# L<S02/Heredocs/Heredocs are no longer written>
{ # qq:to
    my @q = ();

    @q = qq:to/FOO/;
blah
$bar
blah
$foo
FOO

    is(+@q, 1, "q:to// is singular");
    is(no-r(@q[0]), "blah\nBAR\nblah\nFOO\n", "here doc interpolated");
};

{ # qq:to
    my @q = ();

    @q = qq:to/FOO/;
        blah
        $bar
        blah
        $foo
        FOO

    is(no-r(@q[0]), "blah\nBAR\nblah\nFOO\n", "here doc interpolating with indentation");
};

# L<S02/Optional whitespace/Heredocs allow optional whitespace>
{ # q:to indented
    my @q = ();

    @q = q:to/FOO/;
        blah blah
        $foo
        FOO

    is(+@q, 1, "q:to// is singular, also when indented");
    is(no-r(@q[0]), "blah blah\n\$foo\n", "indentation stripped");
};

{ # q:heredoc backslash bug
        my @q = q:heredoc/FOO/
yoink\n
splort\\n
FOO
;
        is(+@q, 1, "q:heredoc// is singular");
        is(no-r(@q[0]), "yoink\\n\nsplort\\n\n", "backslashes");
}

my $multiline = "Hello\nWorld";

# some dedent tests
{
    my @q = qq:to/END/;
        first line
        $multiline
        another line
        END

    is no-r(@q[0]), "first line\nHello\nWorld\nanother line\n", "indent with multiline interpolation";
}

$multiline = "Hello\n    World";
{
    my @q = qq:to/END/;
        first line
        $multiline
        another line
        END

    is no-r(@q[0]), "first line\nHello\n    World\nanother line\n", "indent with multiline interpolation with spaces at the beginning";
}
{
    my @q = qq:to/END/;
        first line
        $multiline        something
        another line
        END

    is no-r(@q[0]), "first line\nHello\n    World        something\nanother line\n", "extra spaces after interpolation will be kept";
}

{
    my ($one, $two) = <foo bar>;
    my @q = qq:to/END/;
        {$one}{$two}
        stuff
        END

    is no-r(@q[0]), "foobar\nstuff\n", "interpolations without constant strings in the middle";

    my @q2 = qq:to/END/;
        stuff
        {$one}{$two}
        END

    is no-r(@q2[0]), "stuff\nfoobar\n", "interpolations at the very end";

    my @q3 = qq:to/END/;
        line one

        line two

        $one
        END

    is no-r(@q3[0]), "line one\n\nline two\n\nfoo\n", "empty lines";
}

{
    my @q = qq:to/END/;
		stuff
		stuff
		END

    is no-r(@q[0]), "stuff\nstuff\n", "Tabs get correctly removed";

    my @q2 = qq:to/END/;
	    stuff
	    barfoo
	    END

    is no-r(@q2[0]), "stuff\nbarfoo\n", "mixed tabs and spaces get correctly removed";

    my @q3 = qq:to/END/;
        	line one
	        line two
		END

    is no-r(@q3[0]), "line one\nline two\n", "mixing tabs and spaces even more evil-ly";
}

# RT #117853
{
    constant TEXT = q :to 'END';
    Hello world
    :)
    END

    is no-r(TEXT), "Hello world\n:)\n", "Constant heredocs work";
}

# RT #117705
{
    my $eefee = q:to<END>;


something


END
    is no-r($eefee), "\n\nsomething\n\n\n", 'Heredoc leading and trailing empty lines';

    my $none = q:to<END>;
END
    is $none, "", 'Completely empty heredoc';

    my $e = q:to<END>;

END
    is no-r($e), "\n", 'Heredoc one empty line';
    my $ee = q:to<END>;


END
    is no-r($ee), "\n\n", 'Heredoc two empty lines';

}

# RT #120895
{
    #  Should also try this with varying $?TABSTOP when that gets implemented

    # Take care to keep tabs and spaces as is here
    ok ([eq] no-r(Q:to<MAKEFILE1>),
        foo: bar
        	echo 'AGAIN';
        bar:
        	echo 'OHAI';
        MAKEFILE1
            no-r(Q:to<MAKEFILE2>),
        foo: bar
        	echo 'AGAIN';
        bar:
		echo 'OHAI';
        MAKEFILE2
            no-r(Q:to<MAKEFILE3>),
	foo: bar
		echo 'AGAIN';
	bar:
		echo 'OHAI';
        MAKEFILE3
            no-r(Q:to<MAKEFILE4>),
        foo: bar
        	echo 'AGAIN';
        bar:
		echo 'OHAI';
	MAKEFILE4
        "foo: bar\n\techo 'AGAIN';\nbar:\n\techo 'OHAI';\n"),
        "Heredoc tab explosion makefile use case is usesul.";
}

#?rakudo skip 'RT #131927'
{
    # Don't change the space in front of any of these, or you'll change the test!

    # 4 spaces are present between the beginning of the line and the heredoc body
    my @q1 = q:to/END/;
    line one
    	line two
    END
    is   no-r(@q1[0]), "line one\n\tline two\n",   'trim 4 spaces, leave leading tab in line two';
    isnt no-r(@q1[0]), "line one\n    line two\n", 'should not contain 4 leading spaces at line two.';

    # Same exact heredoc body, except it is moved to the right one space
    # 5 spaces are present between the beginning of the line and the heredoc body
    my @q2 = q:to/END/;
     line one
     	line two
     END
     is no-r(@q2[0]),   "line one\n\tline two\n",  'trim 5 spaces, leave leading tab in line two';
     isnt no-r(@q2[0]), "line one\n   line two\n", 'should not contain 3 leading spaces in line two.';

    # Same heredoc body as the first, except moved to the right two spaces
    # 6 spaces are present between the beginning of the line and the heredoc body
    my @q3 = q:to/END/;
      line one
      	line two
      END
    is no-r(@q3[0]),   "line one\n\tline two\n", 'trim 6 spaces, leave leading tab in line two';
    isnt no-r(@q3[0]), "line one\n  line two\n", 'should not contain 2 leading spaces in line two';

    # Same heredoc body as the first, except moved to the right three spaces
    # 7 spaces are present between the beginning of the line and the heredoc body
    my @q4 = q:to/END/;
       line one
       	line two
       END
    is no-r(@q4[0]),   "line one\n\tline two\n", 'trim 7 leading spaces, leave leading tab in line two';
    isnt no-r(@q4[0]), "line one\n line two\n",  'should not contain 1 leading space in line two';

    # ONLY TEST THAT PASSES
    # Same heredoc body as the first, except moved to the right four spaces
    # 8 spaces are present between the beginning of the line and the heredoc body
    my @q5 = q:to/END/;
        line one
        	line two
        END
    is no-r(@q5[0]),   "line one\n\tline two\n", 'trim 8 leading spaces, leave leading tab in line two';

    # Same heredoc body as the first, except moved to the right five spaces
    # 9 spaces are present between the beginning of the line and the heredoc body
    my @q6 = q:to/END/;
         line one
         	line two
         END
    is   no-r(@q6[0]), "line one\n\tline two\n",      'trim 9 leading spaces, leave leading tab in line two';
    isnt no-r(@q6[0]), "line one\n       line two\n", 'should not contain 7 leading spaces in line two';
}
