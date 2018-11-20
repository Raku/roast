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

plan 60 * $iterations;

=begin pod

 Hyper operators L<S03/"Hyper operators">

=end pod

for @infixes -> $name, &op, &metaop {
    my @a = 1..5;
    my @reset = @a;
    my @b = 6..10;

    # @a >>op<< @b
    my @result = (^@a).map: { op(@a[$_], @b[$_]) }
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
    @result = (^@a).map: { op(@a[$_], 3) }
    dies-ok { @a >>[&op]<< 3 }, "@a >>$name\<< 3 dies";
    dies-ok { @a <<[&op]<< 3 }, "@a <<$name\<< 3 dies";
    is-deeply @a <<[&op]>> 3, @result, "@a <<$name>> 3";
    is-deeply @a >>[&op]>> 3, @result, "@a >>$name>> 3";

    # @a >>op=<< 3
    dies-ok { @a >>[&metaop]<< 3 }, "@a >>$name=<< 3 dies";
    dies-ok { @a <<[&metaop]<< 3 }, "@a <<$name=<< 3 dies";
    is-deeply @a <<[&metaop]>> 3, @result, "@a <<$name=>> 3";
    is-deeply @a, @result, "@a assigned from @a <<$name=>> 3";
    @a = @reset;
    is-deeply @a >>[&metaop]>> 3, @result, "@a >>$name=>> 3";
    is-deeply @a, @result, "@a assigned from @a >>$name=>> 3";
    @a = @reset;

    # 3 >>op<< @a
    @result = (^@a).map: { op(3, @a[$_]) }
    dies-ok { 3 >>[&op]<< @a }, "3 >>$name\<< @a dies";
    dies-ok { 3 >>[&op]>> @a }, "3 >>$name>> @a dies";
    is-deeply 3 <<[&op]>> @a, @result, "3 <<$name>> @a";
    is-deeply 3 <<[&op]<< @a, @result, "3 <<$name\<< @a";

    # 3 >>op=<< @a
    dies-ok { 3 >>[&metaop]<< @a }, "3 >>$name=<< @a dies";
    dies-ok { 3 >>[&metaop]>> @a }, "3 >>$name=>> @a dies";
    dies-ok { 3 <<[&metaop]>> @a }, "3 <<$name=>> @a dies";
    dies-ok { 3 <<[&metaop]<< @a }, "3 <<$name=<< @a dies";

    my %a = "a".."e" Z=> 1..5;
    my %reset = %a;
    my %b = "a".."e" Z=> 6..10;

    # %a >>op<< %b
    my %result = %a.map: { .key => op(.value, %b{.key}) }
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
    my %result = %a.map: { .key => op(.value, 3) }
    dies-ok { %a >>[&op]<< 3 }, "%a >>$name\<< 3 dies";
    dies-ok { %a <<[&op]<< 3 }, "%a <<$name\<< 3 dies";
    is-deeply %a <<[&op]>> 3, %result, "%a <<$name>> 3";
    is-deeply %a >>[&op]>> 3, %result, "%a >>$name>> 3";

    # %a >>op=<< 3 
    dies-ok { %a >>[&metaop]<< 3 }, "%a >>$name=<< 3 dies";
    dies-ok { %a <<[&metaop]<< 3 }, "%a <<$name=<< 3 dies";
    is-deeply %a <<[&metaop]>> 3, %result, "%a <<$name=>> 3";
    is-deeply %a, %result, "%a assigned from %a <<$name=>> 3";
    %a = %reset;
    is-deeply %a >>[&metaop]>> 3, %result, "%a >>$name=>> 3";
    is-deeply %a, %result, "%a assigned from %a >>$name=>> 3";
    %a = %reset;

    # 3 >>op<< %a
    my %result = %a.map: { .key => op(3, .value) }
    dies-ok { 3 >>[&op]<< %a }, "3 >>$name\<< %a dies";
    dies-ok { 3 >>[&op]>> %a }, "3 >>$name>> %a dies";
    is-deeply 3 <<[&op]>> %a, %result, "3 <<$name>> %a";
    is-deeply 3 <<[&op]<< %a, %result, "3 <<$name\<< %a";

    # 3 >>op<< %a
    dies-ok { 3 >>[&metaop]<< %a }, "3 >>$name=<< %a dies";
    dies-ok { 3 >>[&metaop]>> %a }, "3 >>$name=>> %a dies";
    dies-ok { 3 <<[&metaop]>> %a }, "3 <<$name=>> %a dies";
    dies-ok { 3 <<[&metaop]<< %a }, "3 <<$name=<< %a dies";
}

# vim: ft=perl6
