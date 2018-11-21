use v6;
use Test;

# some custom ops
sub cst (\a,\b) { "foo"     }
sub csta(\a,\b) { a = "foo" }

# Just add infixes here, test count will adjust accordingly
my @infixes =
#  name      op    metaop
   "~",    &[~],    &[~=],
   "+",    &[+],    &[+=],
   "-",    &[-],    &[-=],
   "*",    &[*],    &[*=],
   "×",    &[×],    &[×=],
   "/",    &[/],    &[/=],
   "÷",    &[÷],    &[÷=],
  "**",   &[**],   &[**=],
   "%",    &[%],    &[%=],
   "x",    &[x],    &[x=],
 "div",  &[div],  &[div=],
 "max",  &[max],  &[max=],
 "min",  &[min],  &[min=],
 "mod",  &[mod],  &[mod=],
 "gcd",  &[gcd],  &[gcd=],
 "lcm",  &[lcm],  &[lcm=],
  "+|",   &[+|],   &[+|=],
  "+&",   &[+&],   &[+&=],
  "+^",   &[+^],   &[+^=],
  "~|",   &[~|],   &[~|=],
  "~&",   &[~&],   &[~&=],
  "~^",   &[~^],   &[~^=],
 "cst",    &cst,    &csta,
#  "xx",  &[xx],   &[xx=],  # ops creating Seq are flaky
;
my $iterations = @infixes / 3;

plan 162 * $iterations;

=begin pod

 Hyper operators L<S03/"Hyper operators">

=end pod

for @infixes -> $name, &op, &metaop {
    my $a = 1;
    my $reset = $a;
    my $b = 6;
    my $result = op($a, $b);

    # $a >>op<< $b
    is-deeply $a >>[&op]<< $b, $result, "\$a >>$name\<< \$b";
    is-deeply $a <<[&op]<< $b, $result, "\$a <<$name\<< \$b";
    is-deeply $a <<[&op]>> $b, $result, "\$a <<$name>> \$b";
    is-deeply $a >>[&op]>> $b, $result, "\$a >>$name>> \$b";

    # $a >>op=<< $b
    is-deeply $a >>[&metaop]<< $b, $result, "\$a >>$name=<< \$b";
    is-deeply $a, $result, "\$a assigned from \$a >>$name=<< \$b";
    $a = $reset;
    is-deeply $a <<[&metaop]<< $b, $result, "\$a <<$name=<< \$b";
    is-deeply $a, $result, "\$a assigned from \$a <<$name=<< \$b";
    $a = $reset;
    is-deeply $a <<[&metaop]>> $b, $result, "\$a <<$name=>> \$b";
    is-deeply $a, $result, "\$a assigned from \$a <<$name=>> \$b";
    $a = $reset;
    is-deeply $a >>[&metaop]>> $b, $result, "\$a >>$name=>> \$b";
    is-deeply $a, $result, "\$a assigned from \$a >>$name=>> \$b";
    $a = $reset;

    # ordinary array initialization
    my @a = 1..5;
    my @reset = @a;
    my @b = 6..10;
    my @result = (^@a).map: { op(@a[$_], @b[$_]) }
    my @resultop3 = (^@a).map: { op(@a[$_], 3) }
    my @result3op = (^@a).map: { op(3, @a[$_]) }

    # typed array initialization
    my Cool @ac = 1..5;
    my Cool @resetc = @ac;
    my Cool @bc = 6..10;
    my Cool @resultc = (^@ac).map: { op(@ac[$_], @bc[$_]) }
    my Cool @resultop3c = (^@ac).map: { op(@ac[$_], 3) }
    my Cool @result3opc = (^@ac).map: { op(3, @ac[$_]) }

    for (
        @a, @b, @reset, @result, @resultop3, @result3op,
        @ac, @bc, @resetc, @resultc, @resultop3c, @result3opc,
    
    ) -> @a, @b, @reset, @result, @resultop3, @result3op {

        # @a >>op<< @b
        is-deeply @a >>[&op]<< @b, @result, "@a >>$name\<< @b";
        is-deeply @a <<[&op]<< @b, @result, "@a <<$name\<< @b";
        is-deeply @a <<[&op]>> @b, @result, "@a <<$name>> @b";
        is-deeply @a >>[&op]>> @b, @result, "@a >>$name>> @b";

        # @a >>op=<< @b
        is-deeply @a >>[&metaop]<< @b, @result, "@a >>$name=<< @b";
        is-deeply @a, @result, "@a assigned from @a >>$name=<< @b";
        @a = @reset;
        is-deeply @a <<[&metaop]<< @b, @result, "@a <<$name=<< @b";
        is-deeply @a, @result, "@a assigned from @a <<$name=<< @b";
        @a = @reset;
        is-deeply @a <<[&metaop]>> @b, @result, "@a <<$name=>> @b";
        is-deeply @a, @result, "@a assigned from @a <<$name=>> @b";
        @a = @reset;
        is-deeply @a >>[&metaop]>> @b, @result, "@a >>$name=>> @b";
        is-deeply @a, @result, "@a assigned from @a >>$name=>> @b";
        @a = @reset;

        # @a >>op<< 3
        dies-ok { @a >>[&op]<< 3 }, "@a >>$name\<< 3 dies";
        dies-ok { @a <<[&op]<< 3 }, "@a <<$name\<< 3 dies";
        is-deeply @a <<[&op]>> 3, @resultop3, "@a <<$name>> 3";
        is-deeply @a >>[&op]>> 3, @resultop3, "@a >>$name>> 3";

        # @a >>op=<< 3
        dies-ok { @a >>[&metaop]<< 3 }, "@a >>$name=<< 3 dies";
        dies-ok { @a <<[&metaop]<< 3 }, "@a <<$name=<< 3 dies";
        is-deeply @a <<[&metaop]>> 3, @resultop3, "@a <<$name=>> 3";
        is-deeply @a, @resultop3, "@a assigned from @a <<$name=>> 3";
        @a = @reset;
        is-deeply @a >>[&metaop]>> 3, @resultop3, "@a >>$name=>> 3";
        is-deeply @a, @resultop3, "@a assigned from @a >>$name=>> 3";
        @a = @reset;

        # 3 >>op<< @a
        dies-ok { 3 >>[&op]<< @a }, "3 >>$name\<< @a dies";
        dies-ok { 3 >>[&op]>> @a }, "3 >>$name>> @a dies";
        is-deeply 3 <<[&op]>> @a, @result3op, "3 <<$name>> @a";
        is-deeply 3 <<[&op]<< @a, @result3op, "3 <<$name\<< @a";

        # 3 >>op=<< @a
        dies-ok { 3 >>[&metaop]<< @a }, "3 >>$name=<< @a dies";
        dies-ok { 3 >>[&metaop]>> @a }, "3 >>$name=>> @a dies";
        dies-ok { 3 <<[&metaop]>> @a }, "3 <<$name=>> @a dies";
        dies-ok { 3 <<[&metaop]<< @a }, "3 <<$name=<< @a dies";
    }

    # ordinary hashes initialization
    my %a = "a".."e" Z=> 1..5;
    my %reset = %a;
    my %b = "a".."e" Z=> 6..10;
    my %result = %a.map: { .key => op(.value, %b{.key}) }
    my %resultop3 = %a.map: { .key => op(.value, 3) }
    my %result3op = %a.map: { .key => op(3, .value) }

    # typed hashes initialization
    my Cool %ac = %a;
    my Cool %resetc = %ac;
    my Cool %bc = %b;
    my Cool %resultc = %result;
    my Cool %resultop3c = %resultop3;
    my Cool %result3opc = %result3op;

    # object hashes initialization
    my %ao{Any} = %a;
    my %reseto{Any} = %ao;
    my %bo{Any} = %b;
    my %resulto{Any} = %result;
    my %resultop3o{Any} = %resultop3;
    my %result3opo{Any} = %result3op;

    for (
        %a, %b, %reset, %result, %resultop3, %result3op,
        %ac, %bc, %resetc, %resultc, %resultop3c, %result3opc,
        %ao, %bo, %reseto, %resulto, %resultop3o, %result3opo,
    
    ) -> %a, %b, %reset, %result, %resultop3, %result3op {

        # %a >>op<< %b
        is-deeply %a >>[&op]<< %b, %result, "%a >>$name\<< %b";
        is-deeply %a <<[&op]<< %b, %result, "%a <<$name\<< %b";
        is-deeply %a <<[&op]>> %b, %result, "%a <<$name>> %b";
        is-deeply %a >>[&op]>> %b, %result, "%a >>$name>> %b";

        # %a >>op=<< %b
        is-deeply %a >>[&metaop]<< %b, %result, "%a >>$name=<< %b";
        is-deeply %a, %result, "%a assigned from %a >>$name=<< %b";
        %a = %reset;
        is-deeply %a <<[&metaop]<< %b, %result, "%a <<$name=<< %b";
        is-deeply %a, %result, "%a assigned from %a <<$name=<< %b";
        %a = %reset;
        is-deeply %a <<[&metaop]>> %b, %result, "%a <<$name=>> %b";
        is-deeply %a, %result, "%a assigned from %a <<$name=>> %b";
        %a = %reset;
        is-deeply %a >>[&metaop]>> %b, %result, "%a >>$name=>> %b";
        is-deeply %a, %result, "%a assigned from %a >>$name=>> %b";
        %a = %reset;

        # %a >>op<< 3 
        dies-ok { %a >>[&op]<< 3 }, "%a >>$name\<< 3 dies";
        dies-ok { %a <<[&op]<< 3 }, "%a <<$name\<< 3 dies";
        is-deeply %a <<[&op]>> 3, %resultop3, "%a <<$name>> 3";
        is-deeply %a >>[&op]>> 3, %resultop3, "%a >>$name>> 3";

        # %a >>op=<< 3 
        dies-ok { %a >>[&metaop]<< 3 }, "%a >>$name=<< 3 dies";
        dies-ok { %a <<[&metaop]<< 3 }, "%a <<$name=<< 3 dies";
        is-deeply %a <<[&metaop]>> 3, %resultop3, "%a <<$name=>> 3";
        is-deeply %a, %resultop3, "%a assigned from %a <<$name=>> 3";
        %a = %reset;
        is-deeply %a >>[&metaop]>> 3, %resultop3, "%a >>$name=>> 3";
        is-deeply %a, %resultop3, "%a assigned from %a >>$name=>> 3";
        %a = %reset;

        # 3 >>op<< %a
        dies-ok { 3 >>[&op]<< %a }, "3 >>$name\<< %a dies";
        dies-ok { 3 >>[&op]>> %a }, "3 >>$name>> %a dies";
        is-deeply 3 <<[&op]>> %a, %result3op, "3 <<$name>> %a";
        is-deeply 3 <<[&op]<< %a, %result3op, "3 <<$name\<< %a";

        # 3 >>op<< %a
        dies-ok { 3 >>[&metaop]<< %a }, "3 >>$name=<< %a dies";
        dies-ok { 3 >>[&metaop]>> %a }, "3 >>$name=>> %a dies";
        dies-ok { 3 <<[&metaop]>> %a }, "3 <<$name=>> %a dies";
        dies-ok { 3 <<[&metaop]<< %a }, "3 <<$name=<< %a dies";
    }
}

# vim: ft=perl6
