use v6;
BEGIN { @*INC.push("../packages/") };
use TrigTestSupport;

my $functions_file = "trig_functions";

sub Substitute($str, *%rules) {
    my $result = $str;
    for %rules.keys.sort(*.chars).reverse -> $key {
        $result.=subst: '$' ~ $key, %rules{$key}, :g;
    }
    return $result;
}

sub Type($num, $type) {
    my $typed-num = "($num).$type";
    given $type {
        when "Rat" {
            $typed-num = "({$num}).{$type}(1e-9)";
        }
        when "NotComplex" { 
            $typed-num = "NotComplex.new($num)";
        }
        when "DifferentReal" { 
            $typed-num = "DifferentReal.new($num)";
        }
    }
    $typed-num;
}

sub ForwardTest($str, $angle, $fun, $type, $desired-result-rule, $base = "Radians") {
    my $input_angle = $angle.num($base.eval);
    my $desired-result = eval($desired-result-rule);
    given $type {
        when "Complex" | "NotComplex" { 
            $input_angle = $angle.complex(2, $base.eval);  
            $desired-result = ($angle.num(Radians) + 2i)."$fun"();
        }
    }

    my $typed-angle = Type($input_angle, $type);
    my $typed-result = Type($desired-result, $type);

    Substitute($str, :$fun, :$type, :angle($input_angle), :$typed-angle, :$base, 
               :$desired-result, :$typed-result);
}

sub InverseTest($str, $angle, $fun, $type, $desired-result-rule, $base = "Radians") {
    my $input_angle = $angle.num($base.eval);
    my $desired-result = eval($desired-result-rule);
    given $type {
        when "Complex" | "NotComplex" { 
            $input_angle = ($angle.num(Radians) + 2i)."$fun"($base.eval);
            $desired-result = ($angle.num(Radians) + 2i);
        }
    }

    my $typed-angle = Type($input_angle, $type);
    my $typed-result = Type($desired-result, $type);

    Substitute($str, :$fun, :$type, :angle($input_angle), :$typed-angle, :$base, 
               :$desired-result, :$typed-result);
}

multi sub Atan2Test($str, Real $value, $type1, $base = "Radians") {
    my $desired-result = $value.atan2(1, $base.eval);
    my $type1-value = Type($value, $type1);
    Substitute($str, :$type1, :$base, :$desired-result, :$type1-value);
}

multi sub Atan2Test($str, Real $value1, Real $value2, $type1, $type2, $base = "Radians") {
    my $desired-result = $value1.atan2($value2, $base.eval);
    my $type1-value = Type($value1, $type1);
    my $type2-value = Type($value2, $type2);
    Substitute($str, :$type1, :$type2, :$base, :$desired-result, :$type1-value, :$type2-value);
}

sub grep-and-repeat(@a, $skip-rule) {
    gather loop {
        for @a -> $a {
            if $skip-rule {
                take $a unless $skip-rule.subst('$angle', $a.num(Radians)).eval;
            } else {
                take $a;
            }
        }
    }
}

class TrigFunction
{
    has $.function_name;
    has $.inverted_function_name;
    has $.angle_and_results_name;
    has $.rational_inverse_tests;
    has $.skip;
    has $.desired-result-code;
    has $.complex_check;
    has $.plus_inf;
    has $.minus_inf;
    
    multi method new(Str $function_name is copy, 
                     Str $inverted_function_name is copy;
                     Str $angle_and_results_name is copy,
                     Str $rational_inverse_tests is copy;
                     Str $skip is copy,
                     Str $desired-result-code is copy,
                     Str $complex_check is copy,
                     Str $plus_inf is copy,
                     Str $minus_inf is copy) {
        self.bless(*, 
                   :$function_name, 
                   :$inverted_function_name, 
                   :$angle_and_results_name, 
                   :$rational_inverse_tests,
                   :$skip,
                   :$desired-result-code,
                   :$complex_check,
                   :$plus_inf,
                   :$minus_inf);
    }

    my sub notgrep(@a, Mu $condition) {
        gather for @a -> $a {
            take $a if $a ~~ $condition;
        }
    }

    method dump_forward_tests($file) {
         my $setup_block = $skip ?? "next if " ~ $.skip.subst('$angle', '$angle.num(Radians)') ~ ";" !! "";

        my $code = q[
            # $.function_name tests

            my $base_list = (TrigTest::official_bases() xx *).flat;
            my $iter_count = 0;
            for $.angle_and_results_name -> $angle
            {
                $.setup_block
                my $desired-result = $.desired-result-code;

                # Num.$.function_name tests -- very thorough
                is_approx($angle.num(Radians).$.function_name, $desired-result, 
                          "Num.$.function_name - {$angle.num(Radians)} default");
                for TrigTest::official_bases() -> $base {
                    is_approx($angle.num($base).$.function_name($base), $desired-result, 
                              "Num.$.function_name - {$angle.num($base)} $base");
                }

                # Complex.$.function_name tests -- also very thorough
                my Complex $zp0 = $angle.complex(0.0, Radians);
                my Complex $sz0 = $desired-result + 0i;
                my Complex $zp1 = $angle.complex(1.0, Radians);
                my Complex $sz1 = $.complex_check($zp1);
                my Complex $zp2 = $angle.complex(2.0, Radians);
                my Complex $sz2 = $.complex_check($zp2);
                
                is_approx($zp0.$.function_name, $sz0, "Complex.$.function_name - $zp0 default");
                is_approx($zp1.$.function_name, $sz1, "Complex.$.function_name - $zp1 default");
                is_approx($zp2.$.function_name, $sz2, "Complex.$.function_name - $zp2 default");
                
                for TrigTest::official_bases() -> $base {
                    my Complex $z = $angle.complex(0.0, $base);
                    is_approx($z.$.function_name($base), $sz0, "Complex.$.function_name - $z $base");
                
                    $z = $angle.complex(1.0, $base);
                    is_approx($z.$.function_name($base), $sz1, "Complex.$.function_name - $z $base");
                
                    $z = $angle.complex(2.0, $base);
                    is_approx($z.$.function_name($base), $sz2, "Complex.$.function_name - $z $base");
                }
            }
            
            is($.function_name(Inf), $.plus_inf, "$.function_name(Inf) - default");
            is($.function_name(-Inf), $.minus_inf, "$.function_name(-Inf) - default");
            given $base_list.shift
            {
                is($.function_name(Inf,  $_), $.plus_inf, "$.function_name(Inf) - $_");
                is($.function_name(-Inf, $_), $.minus_inf, "$.function_name(-Inf) - $_");
            }
        ];
        $code.=subst: '$.function_name', $.function_name, :g;
        $code.=subst: '$.inverted_function_name', $.inverted_function_name, :g;
        $code.=subst: '$.setup_block', $setup_block, :g;
        $code.=subst: '$.desired-result-code', $.desired-result-code, :g;
        $code.=subst: '$.complex_check', $.complex_check, :g;
        $code.=subst: '$.angle_and_results_name', $.angle_and_results_name, :g;
        $code.=subst: '$.rational_inverse_tests', $.rational_inverse_tests, :g;
        $code.=subst: '$.plus_inf', $.plus_inf, :g;
        $code.=subst: '$.minus_inf', $.minus_inf, :g;
        $code.=subst: / ^^ ' ' ** 12 /, '', :g;

        $file.say: $code;
        
        # next block is bordering on evil, and hopefully can be cleaned up in the near future
        my $base_list = (<Radians Degrees Gradians Circles> xx *).flat;
        my $angle_list = grep-and-repeat($.angle_and_results_name.eval, $.skip);
        my $fun = $.function_name;
        for <Num Rat Complex Str NotComplex DifferentReal> -> $type {
            $file.say: "# $type tests";
            unless $type eq "Num" || $type eq "Complex" {
                $file.say: ForwardTest('is_approx($typed-angle.$fun, $desired-result, "$type.$fun - $angle");', 
                                        $angle_list.shift, $fun, $type, $.desired-result-code);
                $file.say: ForwardTest('is_approx($typed-angle.$fun($base), $desired-result, "$type.$fun($base) - $angle");', 
                                        $angle_list.shift, $fun, $type, $.desired-result-code, $base_list.shift);
            }
            
            $file.say: ForwardTest('is_approx($typed-angle.$fun(:base($base)), $desired-result, "$type.$fun(:base($base)) - $angle");', 
                                    $angle_list.shift, $fun, $type, $.desired-result-code, $base_list.shift);

            $file.say: ForwardTest('is_approx($fun($typed-angle), $desired-result, "$fun($type) - $angle");', 
                                    $angle_list.shift, $fun, $type, $.desired-result-code);
            $file.say: ForwardTest('is_approx($fun($typed-angle, $base), $desired-result, "$fun($type, $base) - $angle");', 
                                    $angle_list.shift, $fun, $type, $.desired-result-code, $base_list.shift);
            
            $file.say: ForwardTest('is_approx($fun(:x($typed-angle)), $desired-result, "$fun(:x($type)) - $angle");', 
                                    $angle_list.shift, $fun, $type, $.desired-result-code);
            $file.say: ForwardTest('is_approx($fun(:x($typed-angle), :base($base)), $desired-result, "$fun(:x($type), :base($base)) - $angle");', 
                                    $angle_list.shift, $fun, $type, $.desired-result-code, $base_list.shift);
            
            $file.say: "";
        }
        
        $file.say: "# Int tests";
        $file.say: ForwardTest('is_approx($typed-angle.$fun(:base($base)), $desired-result, "$type.$fun(:base($base)) - $angle");', 
                                $angle_list.shift, $fun, "Int", $.desired-result-code, "Degrees");
        $file.say: ForwardTest('is_approx($fun($typed-angle, $base), $desired-result, "$fun($type, $base) - $angle");', 
                                $angle_list.shift, $fun, "Int", $.desired-result-code, "Degrees");
        {
            my $good_angle;
            while $good_angle = $angle_list.shift {
                last if $good_angle.rat(Gradians).Int == $good_angle.num(Gradians);
            }
            $file.say: ForwardTest('is_approx($fun(:x($typed-angle), :base($base)), $desired-result, "$fun(:x($type), :base($base)) - $angle");', 
                                    $good_angle, $fun, "Int", $.desired-result-code, "Gradians");
        }
    }
    
    method dump_inverse_tests($file) {
        my $setup_block = $skip ?? "next if " ~ $.skip.subst('$angle', '$angle.num(Radians)') ~ ";" !! "";

        my $code = q[
            # $.inverted_function_name tests

            for $.angle_and_results_name -> $angle
            {
                $.setup_block
                my $desired-result = $.desired-result-code;

                # Num.$.inverted_function_name tests -- thorough
                is_approx($desired-result.Num.$.inverted_function_name.$.function_name, $desired-result, 
                          "Num.$.inverted_function_name - {$angle.num(Radians)} default");
                for TrigTest::official_bases() -> $base {
                    is_approx($desired-result.Num.$.inverted_function_name($base).$.function_name($base), $desired-result,
                              "Num.$.inverted_function_name - {$angle.num($base)} $base");
                }
                
                # Num.$.inverted_function_name(Complex) tests -- thorough
                for ($desired-result + 0i, $desired-result + .5i, $desired-result + 2i) -> $z {
                    is_approx($.function_name($.inverted_function_name($z)), $z, 
                              "$.inverted_function_name(Complex) - {$angle.num(Radians)} default");
                    is_approx($z.$.inverted_function_name.$.function_name, $z, 
                              "Complex.$.inverted_function_name - {$angle.num(Radians)} default");
                    for TrigTest::official_bases() -> $base {
                        is_approx($z.$.inverted_function_name($base).$.function_name($base), $z, 
                                  "Complex.$.inverted_function_name - {$angle.num($base)} $base");
                    }
                }
            }
        ];
        $code.=subst: '$.function_name', $.function_name, :g;
        $code.=subst: '$.inverted_function_name', $.inverted_function_name, :g;
        $code.=subst: '$.setup_block', $setup_block, :g;
        $code.=subst: '$.desired-result-code', $.desired-result-code, :g;
        $code.=subst: '$.angle_and_results_name', $.angle_and_results_name, :g;
        $code.=subst: '$.rational_inverse_tests', $.rational_inverse_tests, :g;
        $code.=subst: '$.plus_inf', $.plus_inf, :g;
        $code.=subst: '$.minus_inf', $.minus_inf, :g;
        $code.=subst: / ^^ ' ' ** 12 /, '', :g;
        
        $file.say: $code;
        
        # next block is bordering on evil, and hopefully can be cleaned up in the near future
        my $base_list = (<Radians Degrees Gradians Circles> xx *).flat;
        my $angle_list = grep-and-repeat(notgrep($.angle_and_results_name.eval, 
                                                 {0 < $_.num(Radians) < pi / 2}), $.skip);
        my $fun = $.function_name;
        my $inv = $.inverted_function_name;
        for <Num Rat Complex Str NotComplex DifferentReal> -> $type {
            $file.say: "# $type tests";
            unless $type eq "Num" || $type eq "Complex" {
                $file.say: InverseTest('is_approx(($typed-result).$fun, $angle, "$type.$fun - $angle");', 
                                        $angle_list.shift, $inv, $type, $.desired-result-code);
                $file.say: InverseTest('is_approx($typed-result.$fun($base), $angle, "$type.$fun($base) - $angle");', 
                                        $angle_list.shift, $inv, $type, $.desired-result-code, $base_list.shift);
            }

            $file.say: InverseTest('is_approx($typed-result.$fun(:base($base)), $angle, "$type.$fun(:base($base)) - $angle");', 
                                    $angle_list.shift, $inv, $type, $.desired-result-code, $base_list.shift);

            $file.say: InverseTest('is_approx($fun($typed-result), $angle, "$fun($type) - $angle");', 
                                    $angle_list.shift, $inv, $type, $.desired-result-code);
            $file.say: InverseTest('is_approx($fun($typed-result, $base), $angle, "$fun($type, $base) - $angle");', 
                                    $angle_list.shift, $inv, $type, $.desired-result-code, $base_list.shift);

            $file.say: InverseTest('is_approx($fun(:x($typed-result)), $angle, "$fun(:x($type)) - $angle");', 
                                    $angle_list.shift, $inv, $type, $.desired-result-code);
            $file.say: InverseTest('is_approx($fun(:x($typed-result), :base($base)), $angle, "$fun(:x($type), :base($base)) - $angle");', 
                                    $angle_list.shift, $inv, $type, $.desired-result-code, $base_list.shift);

            $file.say: "";
        }
    }
}

sub OpenAndStartOutputFile($output_file)
{
    my $file = open $output_file, :w or die "Unable to open $output_file $!\n";

    $file.say: '# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead

use v6;
use Test;
BEGIN { @*INC.push("t/spec/packages/") };
use TrigTestSupport;
';
    
    return $file;
}

sub CloseOutputFile($file)
{
    # the {} afer 'vim' just generate an empty string.
    # this is to avoid the string constant being interpreted as a modeline
    # here in generate-tests.pl
    $file.say: "done_testing;";
    $file.say: "";
    $file.say: '# vim: ft=perl6 nomodifiable';
    $file.close;
}

my $file;

my $functions = open $functions_file, :r or die "Unable to open $functions_file: $!\n";

my Str $function_name;
my Str $inverted_function_name;
my Str $angle_and_results_name;
my Str $rational_inverse_tests;
my Str $desired-result-code;
my Str $skip;
my Str $complex_check;
my Str $plus_inf;
my Str $minus_inf;
for $functions.lines {
    when /^'#'/ { } # skip comment lines
    when /Function\:\s+(.*)/ {
        $function_name = ~$0; 
        $inverted_function_name = "a$0";
        $angle_and_results_name = "";
        $rational_inverse_tests = "(-2/2, -1/2, 1/2, 2/2)";
        $skip = "";
        $desired-result-code = "";
        $complex_check = "";
        $plus_inf = "NaN";
        $minus_inf = "NaN";
        
        $file = OpenAndStartOutputFile($function_name ~ ".t");
    }
    when /skip\:\s+(.*)/ { $skip = ~$0; }
    when /desired_result\:\s+(.*)/ { $desired-result-code = ~$0; }
    when /loop_over\:\s+(.*)/ { $angle_and_results_name = ~$0; }
    when /inverted_function\:\s+(.*)/ { $inverted_function_name = ~$0; }
    when /rational_inverse_tests\:\s+(.*)/ { $rational_inverse_tests = ~$0; }
    when /complex_check\:\s+(.*)/ { $complex_check = ~$0; }
    when /plus_inf\:\s+(.*)/ { $plus_inf = ~$0; }
    when /minus_inf\:\s+(.*)/ { $minus_inf = ~$0; }
    when /End/ {
        say :$function_name.perl;
        my $tf = TrigFunction.new($function_name, $inverted_function_name, $angle_and_results_name, 
                                  $rational_inverse_tests, $skip, $desired-result-code,
                                  $complex_check, $plus_inf, $minus_inf);
        $tf.dump_forward_tests($file);
        $tf.dump_inverse_tests($file);
        CloseOutputFile($file);
    }
}

# output the atan2 file, a special case

$file = OpenAndStartOutputFile("atan2.t");
$file.say: q[
# atan2 tests

# First, test atan2 with x = 1

for TrigTest::sines() -> $angle
{
    next if abs(cos($angle.num(Radians))) < 1e-6;     
	my $desired-result = sin($angle.num(Radians)) / cos($angle.num(Radians));

    # Num.atan2 tests
    is_approx($desired-result.Num.atan2.tan, $desired-result, 
              "Num.atan2() - {$angle.num(Radians)} default");
    is_approx($desired-result.Num.atan2(1.Num).tan, $desired-result, 
              "Num.atan2(1.Num) - {$angle.num(Radians)} default");
    for TrigTest::official_bases() -> $base {
        is_approx($desired-result.Num.atan2(:base($base)).tan($base), $desired-result, 
                  "Num.atan2() - {$angle.num($base)} $base");
        is_approx($desired-result.Num.atan2(1.Num, $base).tan($base), $desired-result, 
                  "Num.atan2(1.Num) - {$angle.num($base)} $base");
    }
}

# check that the proper quadrant is returned

is_approx(atan2(4, 4, Degrees), 45, "atan2(4, 4) is 45 degrees");
is_approx(atan2(-4, 4, Degrees), -45, "atan2(-4, 4) is -45 degrees");
is_approx(atan2(4, -4, Degrees), 135, "atan2(4, -4) is 135 degrees");
is_approx(atan2(-4, -4, Degrees), -135, "atan2(-4, -4) is -135 degrees");
];

my $base_list = (<Radians Degrees Gradians Circles> xx *).flat;
my @values = (-100, -10, -1, -.1, .1, 1, 10, 100);

sub filter-type(@values is copy, $type) {
    given $type {
        when "Int" {
            @values.=grep({ $_ == $_.Int });
        }
    }
    @values;
}

for <Num Rat Int Str DifferentReal> -> $type1 {
    $file.say: "# $type1 tests";
    
    unless $type1 eq "Num" {
        $file.say: Atan2Test('is_approx($type1-value.atan2, $desired-result, "$type1.atan2");', 
                             filter-type(@values, $type1).pick, $type1);
        $file.say: "#?rakudo todo 'Cannot tell difference between TrigBase and Int'";
        $file.say: Atan2Test('is_approx($type1-value.atan2($base), $desired-result, "$type1.atan2($base)");', 
                             filter-type(@values, $type1).pick, $type1, $base_list.shift);
    }

    $file.say: Atan2Test('is_approx($type1-value.atan2(:base($base)), $desired-result, "$type1.atan2(:base($base))");', 
                         filter-type(@values, $type1).pick, $type1, $base_list.shift);
    $file.say: Atan2Test('is_approx(atan2($type1-value), $desired-result, "atan2($type1)");', 
                         filter-type(@values, $type1).pick, $type1);
    $file.say: "#?rakudo todo 'Cannot tell difference between TrigBase and Int'";
    $file.say: Atan2Test('is_approx(atan2($type1-value, $base), $desired-result, "atan2($type1, $base)");', 
                         filter-type(@values, $type1).pick, $type1, $base_list.shift);

    $file.say: Atan2Test('is_approx(atan2(:y($type1-value)), $desired-result, "atan2(:y($type1))");', 
                         filter-type(@values, $type1).pick, $type1);
    $file.say: Atan2Test('is_approx(atan2(:y($type1-value), :base($base)), $desired-result, "atan2(:y($type1), :base($base))");', 
                         filter-type(@values, $type1).pick, $type1, $base_list.shift);
    $file.say: "";
    
    for <Num Rat Int Str DifferentReal> -> $type2 {
        $file.say: "# $type1 vs $type2 tests";
        
        $file.say: Atan2Test('is_approx($type1-value.atan2($type2-value), $desired-result, "$type1.atan2($type2)");', 
                             filter-type(@values, $type1).pick, filter-type(@values, $type2).pick, $type1, $type2);
        $file.say: Atan2Test('is_approx($type1-value.atan2($type2-value, $base), $desired-result, "$type1.atan2($type2, $base)");', 
                             filter-type(@values, $type1).pick, filter-type(@values, $type2).pick, $type1, $type2, $base_list.shift);
        $file.say: Atan2Test('is_approx($type1-value.atan2($type2-value, :base($base)), $desired-result, "$type1.atan2($type2, :base($base))");', 
                             filter-type(@values, $type1).pick, filter-type(@values, $type2).pick, $type1, $type2, $base_list.shift);
        $file.say: Atan2Test('is_approx(atan2($type1-value, $type2-value), $desired-result, "atan2($type1, $type2)");', 
                             filter-type(@values, $type1).pick, filter-type(@values, $type2).pick, $type1, $type2);
        $file.say: Atan2Test('is_approx(atan2($type1-value, $type2-value, $base), $desired-result, "atan2($type1, $type2, $base)");', 
                             filter-type(@values, $type1).pick, filter-type(@values, $type2).pick, $type1, $type2, $base_list.shift);
        $file.say: Atan2Test('is_approx(atan2(:y($type1-value), :x($type2-value)), $desired-result, "atan2(:y($type1), :x($type2))");', 
                             filter-type(@values, $type1).pick, filter-type(@values, $type2).pick, $type1, $type2);
        $file.say: Atan2Test('is_approx(atan2(:y($type1-value), :x($type2-value), :base($base)), $desired-result, "atan2(:y($type1), :x($type2), :base($base))");', 
                             filter-type(@values, $type1).pick, filter-type(@values, $type2).pick, $type1, $type2, $base_list.shift);
        $file.say: "";
    }
}

CloseOutputFile($file);

# vim: ft=perl6
