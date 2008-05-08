use v6;

use Test;

plan 19;

# L<S02/"Names and Variables"/"formatted representation"
#   of "any scalar value" ".fmt('%03d')">
{
    is "Hi".fmt("[%s]"), "[Hi]", 'fmt() works with %s';
    is '3.141'.fmt("[%d]"), "[3]",  "fmt() works with %d";
    is (5.6).fmt('%f'), '5.6', 'fmt() works with %f';
}

# L<S02/"Names and Variables"/"format an array value" 
#   "supply a second argument">
{
    is (1.3,2.4,3).fmt("%d", "_"), "1_2_3", "fmt() works with plain lists";
    
    my @list = 'a'..'c';
    is @list.fmt('<%s>', ':'), '<a>:<b>:<c>', 'fmt() works with @ array';

    my $list = ['a', 'b', 'c'];
    is $list.fmt('[%s]', ','), '[a],[b],[c]', 'fmt() works with Array object';

    # single elem Array:
    $list = ['a'];
    is $list.fmt('<<%s>>', '!!!'), '<<a>>', 'fmt() works for single elem array';
}

# L<S02/"Names and Variables"/"hash value" "formats for both key and value">
{
    my $hash = {
        a => 1.3,
        b => 2.4,
    };
    my $str = $hash.fmt("%s:%d", "_");
    if $str eq "a:1_b:2" || $str eq "b:2_a:1" {
        pass "fmt() works with hashes";
    } else {
        flunk "fmt() fails to work with hashes";
    }
}

# L<S02/"Names and Variables"/"list of pairs" "formats for both key and value">
{
    # a single pair:
    my $pair = (100 => 'lovely');
    is $pair.fmt("%d ==> %s"), "100 ==> lovely", '.fmt works with a single pair';

    # list of a single pair:
    my @pairs = (100 => 'lovely');
    is(@pairs.fmt("%d ==> %s", "\n"), "100 ==> lovely", '.fmt works with lists of a single pair');

    # list of pair:
    my @pairs = (a => 1.3, b => 2.4);
    is @pairs.fmt("%s:%d", "_"), "a:1_b:2", "fmt() works with lists of pairs";
    is @pairs.fmt("(%s => %f)", ""), "(a => 1.3)(b => 2.4)",
        "fmt() works with lists of pairs";
}

# Test defaults on $comma
{
    is([1..3].fmt("%d"), "1 2 3", 'default $comma for array');

    my $hash = {
        a => 1.3,
        b => 2.4,
    };
    my $str = $hash.fmt("%s:%d");
    if $str eq "a:1\nb:2" || $str eq "b:2\na:1" {
        pass 'default $comma works with hashes';
    } else {
        flunk 'default $comma jfails to work with hashes';
    }
}

# Some failure modes
{
    eval_dies_ok '(1).fmt()', 'scalar .fmt fails without $fmt';
    eval_dies_ok '(1=>"a").fmt()', 'pair .fmt fails without $fmt';
    eval_dies_ok '(1,2).fmt()', 'list .fmt fails without $fmt';
    eval_dies_ok '[1,2].fmt()', 'array .fmt fails without $fmt';
    eval_dies_ok '{1=>"a"}.fmt()', 'hash .fmt fails without $fmt';
}
