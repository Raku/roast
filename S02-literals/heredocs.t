use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 42;

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

# https://github.com/Raku/old-issue-tracker/issues/3121
{
    constant TEXT = q :to 'END';
    Hello world
    :)
    END

    is no-r(TEXT), "Hello world\n:)\n", "Constant heredocs work";
}

# https://github.com/Raku/old-issue-tracker/issues/3110
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

# https://github.com/Raku/old-issue-tracker/issues/3299
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

# https://github.com/Raku/old-issue-tracker/issues/6456
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

# Add missing tests for odd cases

# Multiple heredocs on a single line
{
    my ($a, $b, $c) = q:to/END/, q:to/END/, q:to/END/;
    a
    END
    b
    END
    c
    END

    is $a.trim, 'a', "heredoc list element 0";
    is $b.trim, 'b', "heredoc list element 1";
    is $c.trim, 'c', "heredoc list element 2";
}

# A working example of using a heredoc
# in a function call:
{
    sub f($s) { $s }
    my $a = 'foo';
    my $b = f(qq:to/END/);
        $a
        END
    is $b.trim, 'foo', "heredoc in a function call";
}

# A working example of using a heredoc
# in a block (from Synopsis 2):
eval-lives-ok q{
    BEGIN { say q:to/END/ }
        Say me!
        END
}, "heredoc ok in block 1";

# Fail on using in a block (see issue #4539)
# Following is the original code that worked that Jonathan
# said should NOT have worked.
#
# After his suggested change was made, the code properly fails
# because $a in the line following the block is not defined.
eval-dies-ok q{
    sub f() { my $a = 'foo'; qq:to/END/ }
       $a
       END
}, "heredoc fails in block 2a";

# The code above can be made to work by declaring $a
# before the block (but don't forget about the newline
# added to every line in the heredoc):
{
    my $a;
    sub f() { $a = 'foo'; qq:to/END/ }
       $a
       END
    my $b = f;
    is $b.trim, 'foo', "heredoc made to work in block 2b";
}

# The following code (based on @jnthn's code) illustrates the correct way
# to use a heredoc in a block without using variables
# outside of the block:
eval-lives-ok q{
    my $x;
    if $x { say q:to/END/ }
       This is alright
       END
}, "heredoc ok in block 3";

# The following code (based on @jnthn's code) illustrates the incorrect way
# to use a heredoc in a block by attempting use of a variable outside of
# of the block:
eval-dies-ok q{
    my $x;
    if $x { my $var = 42; say qq:to/END/ }
       Should not be able to use $var
       END
}, "heredoc fails in block 4";

# vim: expandtab shiftwidth=4
