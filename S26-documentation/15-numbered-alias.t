use v6;
use Test;

# Test implementation of S26 :numbered alias ('#') for abbreviated,
# paragraph, and delimited blocks.

plan 1;

my $tnum = 0;
my $p = -1;
my $o;

# abbreviated blocks ==========================================
subtest ':numbered alias abbreviated blocks' => {

plan 19;

=para # foo
info

$o = $=pod[++$p]; sayo($o);

=defn # foo
info

$o = $=pod[++$p]; sayo($o, :defn);

=line # foo
info

$o = $=pod[++$p]; sayo($o);

=head # foo
info

$o = $=pod[++$p]; sayo($o);

=code # foo
info

$o = $=pod[++$p]; sayo($o);

=input # foo
info

$o = $=pod[++$p]; sayo($o);

=output # foo
info

$o = $=pod[++$p]; sayo($o);

=table # foo
info

$o = $=pod[++$p]; sayo($o);

=Foo # foo
info

$o = $=pod[++$p]; sayo($o);

}

# paragraph blocks ==========================================
#?rakudo skip ':numbered alias paragraph blocks'
{

 plan 19;

 =for para
 # foo
 info

 $o = $=pod[++$p]; sayo($o);

 =for defn
 # foo
 info

 $o = $=pod[++$p]; sayo($o, :defn);

 =for line
 # foo
 info

 $o = $=pod[++$p]; sayo($o);

 =for head
 # foo
 info

 $o = $=pod[++$p]; sayo($o);

 =for code
 # foo
 info

 $o = $=pod[++$p]; sayo($o);

 =for input
 # foo
 info

 $o = $=pod[++$p]; sayo($o);

 =for output
 # foo
 info

 $o = $=pod[++$p]; sayo($o);

 =for table
 # foo
 info

 $o = $=pod[++$p]; sayo($o);

 =for Foo
 # foo
 info

 $o = $=pod[++$p]; sayo($o);

}

# delimited blocks ==========================================
#?rakudo skip ":numbered alias delimited blocks"
{

plan 19;

=begin para
# foo
info
=end para

$o = $=pod[++$p]; sayo($o);

=begin defn
# foo
info
=end defn

$o = $=pod[++$p]; sayo($o, :defn);

=begin line
# foo
info
=end line

$o = $=pod[++$p]; sayo($o);

=begin head
# foo
info
=end head

$o = $=pod[++$p]; sayo($o);

=begin code
# foo
info
=end code

$o = $=pod[++$p]; sayo($o);

=begin input
# foo
info
=end input

$o = $=pod[++$p]; sayo($o);

=begin output
# foo
info
=end output

$o = $=pod[++$p]; sayo($o);

=begin table
# foo
info
=end table

$o = $=pod[++$p]; sayo($o);

=begin Foo
# foo
info
=end Foo

$o = $=pod[++$p]; sayo($o);

}

#===============================================
sub sayo($o, :$defn) is test-assertion {
    is $o.config<numbered>:exists, True, 'is config<numbered>:exists';
    ok $o.config<numbered>, 'ok config<numbered>';
    if $defn {
       is $o.term, 'foo', 'is term "foo"';
    }
    else {
         #isa-ok $o.contents[0], 'Str', 'foo info';
    }
}

# vim: expandtab shiftwidth=4
