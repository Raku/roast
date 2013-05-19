use v6;
use Test;

plan 11;
# L<S16::IO/IO/=head2 Special Quoting Syntax>

# basic
#?rakudo skip "two terms in a row / unrecognized adverb"
{
	#?niecza 2 skip "Unhandled exception"
	isa_ok qp{/path/to/file}, IO::Path;
	isa_ok q:p{/path/to/file}, IO::Path;
	is qp{/path/to/file}.path, "/path/to/file";
	is q:p{/path/to/file}.path, "/path/to/file";
}

#with interpolation
#?rakudo skip "undeclared routine / urecognized adverb"
{
	my $dir = "/tmp";
	my $file = "42";
	#?niecza skip "too late for: qq"
	isa_ok qp:qq{$dir/$file}, IO::Path;
	isa_ok qq:p{$dir/$file}, IO::Path;

	#?niecza skip "too late for: qq"
	is qp:qq{$dir/$file}.path, "/tmp/42";
	is qq:p{$dir/$file}.path, "/tmp/42";
}

# :win constraints
#?rakudo skip "two terms in a row"
#?niecza skip "confused"
{
	isa_ok p:win{C:\Program Files\MS Access\file.file}, IO::Path;

	# backlash quoting should be disabled
	ok p:win{c:\no}.path ~~ /no$/;
}

# :unix constraints
#?rakudo skip "Unsupported use of /s"
#?niecza skip "Unsupported use of suffix regex modifiers"
{
	isa_ok p:unix{/usr/src/bla/myfile?:%.file}, IO::Path;
}

