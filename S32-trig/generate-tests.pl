use v6;

my $functions_file = "trig_functions";
my $prelude_file = "TrigTestSupport";
my $output_file = "new_trig.t";

class TrigFunction
{
    has $.function_name;
    has $.inverted_function_name;
    has $.angle_and_results_name;
    has $.rational_inverse_tests;
    has $.setup_block;
    has $.complex_check;
    has $.plus_inf;
    has $.minus_inf;
    
    multi method new(Str $function_name is copy, 
                     Str $inverted_function_name is copy;
                     Str $angle_and_results_name is copy,
                     Str $rational_inverse_tests is copy;
                     Str $setup_block is copy,
                     Str $complex_check is copy,
                     Str $plus_inf is copy,
                     Str $minus_inf is copy) {
        self.bless(*, 
                   :$function_name, 
                   :$inverted_function_name, 
                   :$angle_and_results_name, 
                   :$rational_inverse_tests,
                   :$setup_block,
                   :$complex_check,
                   :$plus_inf,
                   :$minus_inf);
    }
        
    method dump_forward_tests($file) {
        my $code = q[
            # $.function_name tests

            my $base_list = (@official_bases xx *).flat;
            my $iter_count = 0;
            for $.angle_and_results_name -> $angle
            {
                $.setup_block

                # Num.$.function_name tests -- very thorough
                is_approx($angle.num(Radians).$.function_name, $desired_result, 
                          "Num.$.function_name - {$angle.num(Radians)} default");
                for @official_bases -> $base {
                    is_approx($angle.num($base).$.function_name($base), $desired_result, 
                              "Num.$.function_name - {$angle.num($base)} $base");
                }

                # Complex.$.function_name tests -- also very thorough
                my Complex $zp0 = $angle.complex(0.0, Radians);
                my Complex $sz0 = $desired_result + 0i;
                my Complex $zp1 = $angle.complex(1.0, Radians);
                my Complex $sz1 = $.complex_check($zp1);
                my Complex $zp2 = $angle.complex(2.0, Radians);
                my Complex $sz2 = $.complex_check($zp2);
                
                is_approx($zp0.$.function_name, $sz0, "Complex.$.function_name - $zp0 default");
                is_approx($zp1.$.function_name, $sz1, "Complex.$.function_name - $zp1 default");
                is_approx($zp2.$.function_name, $sz2, "Complex.$.function_name - $zp2 default");
                
                for @official_bases -> $base {
                    my Complex $z = $angle.complex(0.0, $base);
                    is_approx($z.$.function_name($base), $sz0, "Complex.$.function_name - $z $base");
                
                    $z = $angle.complex(1.0, $base);
                    is_approx($z.$.function_name($base), $sz1, "Complex.$.function_name - $z $base");
                
                    $z = $angle.complex(2.0, $base);
                    is_approx($z.$.function_name($base), $sz2, "Complex.$.function_name - $z $base");
                }
                
                # now that we've established the math works,
                # less thorough tests for everything else
                next if $iter_count++ !% 7;

                # $.function_name(Num)
                is_approx($.function_name($angle.num(Radians)), $desired_result, 
                          "$.function_name(Num) - {$angle.num(Radians)} default");
                given $base_list.shift {
                    is_approx($.function_name($angle.num($_), $_), $desired_result, 
                              "$.function_name(Num) - {$angle.num($_)} $_");
                }
                
                # $.function_name(:x(Num))
                is_approx($.function_name(:x($angle.num(Radians))), $desired_result, 
                          "$.function_name(:x(Num)) - {$angle.num(Radians)} default");
                given $base_list.shift {
                    is_approx($.function_name(:x($angle.num($_)), :base($_)), $desired_result, 
                              "$.function_name(:x(Num)) - {$angle.num($_)} $_");
                }

                # $.function_name(Rat)
                is_approx($.function_name($angle.rat(Radians)), $desired_result, 
                          "$.function_name(Rat) - {$angle.rat(Radians)} default");
                given $base_list.shift {
                    is_approx($.function_name($angle.rat($_), $_), $desired_result, 
                              "$.function_name(Rat) - {$angle.rat($_)} $_");
                }

                # $.function_name(:x(Rat))
                is_approx($.function_name(:x($angle.rat(Radians))), $desired_result, 
                          "$.function_name(:x(Rat)) - {$angle.rat(Radians)} default");
                given $base_list.shift {
                    is_approx($.function_name(:x($angle.rat($_)), :base($_)), $desired_result, 
                              "$.function_name(:x(Rat)) - {$angle.rat($_)} $_");
                }

                # Rat.$.function_name tests
                is_approx($angle.rat(Radians).$.function_name, $desired_result, 
                          "Rat.$.function_name - {$angle.rat(Radians)} default");
                given $base_list.shift {
                    is_approx($angle.rat($_).$.function_name($_), $desired_result, 
                              "Rat.$.function_name - {$angle.rat($_)} $_");
                }

                # $.function_name(Int)
                is_approx($.function_name($angle.int(Degrees), Degrees), $desired_result, 
                          "$.function_name(Int) - {$angle.int(Degrees)} degrees");
                is_approx($angle.int(Degrees).$.function_name(Degrees), $desired_result, 
                          "Int.$.function_name - {$angle.int(Degrees)} degrees");

                # $.function_name(Complex) tests
                is_approx($.function_name($zp0), $sz0, "$.function_name(Complex) - $zp0 default");
                is_approx($.function_name($zp1), $sz1, "$.function_name(Complex) - $zp1 default");
                is_approx($.function_name($zp2), $sz2, "$.function_name(Complex) - $zp2 default");
                
                given $base_list.shift {
                    my Complex $z = $angle.complex(0.0, $_);
                    is_approx($.function_name($z, $_), $sz0, "$.function_name(Complex) - $z $_");
                
                    $z = $angle.complex(1.0, $_);
                    is_approx($.function_name($z, $_), $sz1, "$.function_name(Complex) - $z $_");
                                    
                    $z = $angle.complex(2.0, $_);
                    is_approx($.function_name($z, $_), $sz2, "$.function_name(Complex) - $z $_");
                }
                
                is_approx($angle.str(Radians).$.function_name, $desired_result, 
                          "Str.$.function_name - {$angle.str(Radians)} default");
                given $base_list.shift {
                    is_approx($angle.str($_).$.function_name($_), $desired_result, 
                              "Str.$.function_name - {$angle.str($_)} $_");
                }
                
                # $.function_name(Str)
                is_approx($.function_name($angle.str(Radians)), $desired_result, 
                          "$.function_name(Str) - {$angle.str(Radians)} default");
                given $base_list.shift {
                    is_approx($.function_name($angle.str($_), $_), $desired_result, 
                              "$.function_name(Str) - {$angle.str($_)} $_");
                }
                
                # $.function_name(:x(Str))
                is_approx($.function_name(:x($angle.str(Radians))), $desired_result, 
                          "$.function_name(:x(Str)) - {$angle.str(Radians)} default");
                given $base_list.shift {
                    is_approx($.function_name(:x($angle.str($_)), :base($_)), $desired_result, 
                              "$.function_name(:x(Str)) - {$angle.str($_)} $_");
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
        $code.=subst: '$.setup_block', $.setup_block, :g;
        $code.=subst: '$.complex_check', $.complex_check, :g;
        $code.=subst: '$.angle_and_results_name', $.angle_and_results_name, :g;
        $code.=subst: '$.rational_inverse_tests', $.rational_inverse_tests, :g;
        $code.=subst: '$.plus_inf', $.plus_inf, :g;
        $code.=subst: '$.minus_inf', $.minus_inf, :g;
        $code.=subst: / ^^ ' ' ** 12 /, '', :g;

        $file.say: $code;
    }
    
    method dump_inverse_tests($file) {
        my $code = q[
            # $.inverted_function_name tests

            for $.angle_and_results_name -> $angle
            {
                $.setup_block

                # Num.$.inverted_function_name tests -- thorough
                is_approx($desired_result.Num.$.inverted_function_name.$.function_name, $desired_result, 
                          "Num.$.inverted_function_name - {$angle.num(Radians)} default");
                for @official_bases -> $base {
                    is_approx($desired_result.Num.$.inverted_function_name($base).$.function_name($base), $desired_result,
                              "Num.$.inverted_function_name - {$angle.num($base)} $base");
                }
                
                # Num.$.inverted_function_name(Complex) tests -- thorough
                for ($desired_result + 0i, $desired_result + .5i, $desired_result + 2i) -> $z {
                    is_approx($.function_name($.inverted_function_name($z)), $z, 
                              "$.inverted_function_name(Complex) - {$angle.num(Radians)} default");
                    is_approx($z.$.inverted_function_name.$.function_name, $z, 
                              "Complex.$.inverted_function_name - {$angle.num(Radians)} default");
                    for @official_bases -> $base {
                        is_approx($z.$.inverted_function_name($base).$.function_name($base), $z, 
                                  "Complex.$.inverted_function_name - {$angle.num($base)} $base");
                    }
                }
                
                # less thorough tests
                next if $iter_count++ !% 7;
                
                # $.inverted_function_name(Num) tests
                is_approx($.function_name($.inverted_function_name($desired_result)), $desired_result, 
                          "$.inverted_function_name(Num) - {$angle.num(Radians)} default");
                given $base_list.shift {
                    is_approx($.function_name($.inverted_function_name($desired_result, $_), $_), $desired_result, 
                              "$.inverted_function_name(Num) - {$angle.num($_)} $_");
                }
                
                # $.inverted_function_name(:x(Num))
                is_approx($.function_name($.inverted_function_name(:x($desired_result))), $desired_result, 
                          "$.inverted_function_name(:x(Num)) - {$angle.num(Radians)} default");
                given $base_list.shift {
                    is_approx($.function_name($.inverted_function_name(:x($desired_result), 
                                                                       :base($_)), 
                                              $_), $desired_result, 
                              "$.inverted_function_name(:x(Num)) - {$angle.num($_)} $_");
                }
                
                # Rat.$.inverted_function_name tests -- thorough
                is_approx($desired_result.Rat.$.inverted_function_name.$.function_name, $desired_result, 
                          "Rat.$.inverted_function_name - {$angle.num(Radians)} default");
                given $base_list.shift {
                    is_approx($desired_result.Rat.$.inverted_function_name($_).$.function_name($_), $desired_result,
                              "Rat.$.inverted_function_name - {$angle.num($_)} $_");
                }
                
                # $.inverted_function_name(Rat) tests
                is_approx($.function_name($.inverted_function_name($desired_result.Rat)), $desired_result, 
                          "$.inverted_function_name(Rat) - {$angle.num(Radians)} default");
                given $base_list.shift {
                    is_approx($.function_name($.inverted_function_name($desired_result.Rat, $_), $_), $desired_result, 
                              "$.inverted_function_name(Rat) - {$angle.num($_)} $_");
                }
                
                # $.inverted_function_name(:x(Rat))
                is_approx($.function_name($.inverted_function_name(:x($desired_result.Rat))), $desired_result, 
                          "$.inverted_function_name(:x(Rat)) - {$angle.num(Radians)} default");
                given $base_list.shift {
                    is_approx($.function_name($.inverted_function_name(:x($desired_result.Rat), 
                                                                       :base($_)), 
                                              $_), $desired_result, 
                              "$.inverted_function_name(:x(Rat)) - {$angle.num($_)} $_");
                }
                
                # Str.$.inverted_function_name tests -- thorough
                is_approx($desired_result.Str.$.inverted_function_name.$.function_name, $desired_result, 
                          "Str.$.inverted_function_name - {$angle.num(Radians)} default");
                given $base_list.shift {
                    is_approx($desired_result.Str.$.inverted_function_name($_).$.function_name($_), $desired_result,
                              "Str.$.inverted_function_name - {$angle.num($_)} $_");
                }
                
                # $.inverted_function_name(Str) tests
                is_approx($.function_name($.inverted_function_name($desired_result.Str)), $desired_result, 
                          "$.inverted_function_name(Str) - {$angle.num(Radians)} default");
                given $base_list.shift {
                    is_approx($.function_name($.inverted_function_name($desired_result.Str, $_), $_), $desired_result, 
                              "$.inverted_function_name(Str) - {$angle.num($_)} $_");
                }
                
                # $.inverted_function_name(:x(Str))
                is_approx($.function_name($.inverted_function_name(:x($desired_result.Str))), $desired_result, 
                          "$.inverted_function_name(:x(Str)) - {$angle.num(Radians)} default");
                given $base_list.shift {
                    is_approx($.function_name($.inverted_function_name(:x($desired_result.Str), 
                                                                       :base($_)), 
                                              $_), $desired_result, 
                              "$.inverted_function_name(:x(Str)) - {$angle.num($_)} $_");
                }
                
                # $.inverted_function_name(Complex) tests
                for ($desired_result + 0i, $desired_result + .5i, $desired_result + 2i) -> $z {
                    is_approx($.function_name($.inverted_function_name($z)), $z, 
                              "$.inverted_function_name(Complex) - {$angle.num(Radians)} default");
                    given $base_list.shift {
                        is_approx($.function_name($.inverted_function_name($z, $_), $_), $z, 
                                  "$.inverted_function_name(Complex) - {$angle.num($_)} $_");
                    }
                    is_approx($z.$.inverted_function_name.$.function_name, $z, 
                              "Complex.$.inverted_function_name - {$angle.num(Radians)} default");
                    given $base_list.shift {
                        is_approx($z.$.inverted_function_name($_).$.function_name($_), $z, 
                                  "Complex.$.inverted_function_name - {$angle.num($_)} $_");
                    }
                }
            }
            
            for $.rational_inverse_tests -> $desired_result
            {
                next unless $desired_result.denominator == 1;
                
                # $.inverted_function_name(Int) tests
                is_approx($.function_name($.inverted_function_name($desired_result.numerator)), $desired_result, 
                          "$.inverted_function_name(Int) - $desired_result default");
                given $base_list.shift {
                    is_approx($.function_name($.inverted_function_name($desired_result.numerator, $_), $_), $desired_result, 
                              "$.inverted_function_name(Int) - $desired_result $_");
                }
                
                # Int.$.inverted_function_name tests
                is_approx($desired_result.numerator.$.inverted_function_name.$.function_name, $desired_result, 
                          "Int.$.inverted_function_name - $desired_result default");
                given $base_list.shift {
                    is_approx($desired_result.numerator.$.inverted_function_name($_).$.function_name($_), $desired_result,
                              "Int.$.inverted_function_name - $desired_result $_");
                }
            }
        ];
        $code.=subst: '$.function_name', $.function_name, :g;
        $code.=subst: '$.inverted_function_name', $.inverted_function_name, :g;
        $code.=subst: '$.setup_block', $.setup_block, :g;
        $code.=subst: '$.angle_and_results_name', $.angle_and_results_name, :g;
        $code.=subst: '$.rational_inverse_tests', $.rational_inverse_tests, :g;
        $code.=subst: '$.plus_inf', $.plus_inf, :g;
        $code.=subst: '$.minus_inf', $.minus_inf, :g;
        $code.=subst: / ^^ ' ' ** 12 /, '', :g;
        
        $file.say: $code;
    }
}

sub OpenAndStartOutputFile($output_file)
{
    my $file = open $output_file, :w or die "Unable to open $output_file $!\n";

    $file.say: '# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead';

    my $prelude = open $prelude_file, :r or die "Unable to open $prelude_file: $!\n";
    for $prelude.lines -> $line {
        $file.say: $line;
    }
    
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

my $in_setup = Bool::False;
my Str $function_name;
my Str $inverted_function_name;
my Str $angle_and_results_name;
my Str $rational_inverse_tests;
my Str $setup_block;
my Str $complex_check;
my Str $plus_inf;
my Str $minus_inf;
for $functions.lines {
    when /^'#'/ { } # skip comment lines
    when $in_setup && /^\s/ { $setup_block ~= $_; }
    $in_setup = Bool::False;
    when /Function\:\s+(.*)/ {
        $function_name = ~$0; 
        $inverted_function_name = "a$0";
        $angle_and_results_name = "";
        $rational_inverse_tests = "(-2/2, -1/2, 1/2, 2/2)";
        $setup_block = "";
        $complex_check = "";
        $plus_inf = "NaN";
        $minus_inf = "NaN";
        
        $file = OpenAndStartOutputFile($function_name ~ ".t");
    }
    when /setup:/ { $in_setup = Bool::True; }
    when /loop_over\:\s+(.*)/ { $angle_and_results_name = ~$0; }
    when /inverted_function\:\s+(.*)/ { $inverted_function_name = ~$0; }
    when /rational_inverse_tests\:\s+(.*)/ { $rational_inverse_tests = ~$0; }
    when /complex_check\:\s+(.*)/ { $complex_check = ~$0; }
    when /plus_inf\:\s+(.*)/ { $plus_inf = ~$0; }
    when /minus_inf\:\s+(.*)/ { $minus_inf = ~$0; }
    when /End/ {
        my $tf = TrigFunction.new($function_name, $inverted_function_name, $angle_and_results_name, 
                                  $rational_inverse_tests, $setup_block, $complex_check, $plus_inf, $minus_inf);
        $tf.dump_forward_tests($file);
        $tf.dump_inverse_tests($file);
        CloseOutputFile($file);
    }
}

# output the atan2 file, a special case

$file = OpenAndStartOutputFile("atan2.t");
$file.say: q[
# atan2 tests

# First, test atan2 with the default $x parameter of 1

for @sines -> $angle
{
    next if abs(cos($angle.num(Radians))) < 1e-6;     
	my $desired_result = sin($angle.num(Radians)) / cos($angle.num(Radians));

    # atan2(Num) tests
    is_approx(tan(atan2($desired_result)), $desired_result, 
              "atan2(Num) - {$angle.num(Radians)} default");
    
    # atan2(:y(Num))
    is_approx(tan(atan2(:y($desired_result))), $desired_result, 
              "atan2(:y(Num)) - {$angle.num(Radians)} default");
    given $base_list.shift {
        is_approx(tan(atan2(:y($desired_result), :base($_)), 
                      $_), $desired_result, 
                  "atan2(:y(Num)) - {$angle.num($_)} $_");
    }
    
    # Num.atan2 tests
    is_approx($desired_result.Num.atan2.tan, $desired_result, 
              "atan2(Num) - {$angle.num(Radians)} default");
}

for (-2/2, -1/2, 1/2, 2/2) -> $desired_result
{
    # atan2(Rat) tests
    is_approx(tan(atan2($desired_result)), $desired_result, 
              "atan2(Rat) - $desired_result default");
    
    # Rat.atan2 tests
    is_approx($desired_result.atan2.tan, $desired_result, 
              "atan2(Rat) - $desired_result default");
    
    next unless $desired_result.denominator == 1;
    
    # atan2(Int) tests
    is_approx(tan(atan2($desired_result.numerator)), $desired_result, 
              "atan2(Int) - $desired_result default");
    
    # Int.atan2 tests
    is_approx($desired_result.numerator.atan2.tan, $desired_result, 
              "atan2(Int) - $desired_result default");
}

# Now test the full atan2 interface

for @sines -> $angle
{
    next if abs(cos($angle.num(Radians))) < 1e-6;     
	my $desired_result = sin($angle.num(Radians)) / cos($angle.num(Radians));

    # atan2(Num) tests
    is_approx(tan(atan2($desired_result, 1)), $desired_result, 
              "atan2(Num, 1) - {$angle.num(Radians)} default");
    given $base_list.shift {
        is_approx(tan(atan2($desired_result, 1, $_), $_), $desired_result, 
                  "atan2(Num, 1) - {$angle.num($_)} $_");
    }
    
    # atan2(:x(Num))
    is_approx(tan(atan2(:y($desired_result), :x(1))), $desired_result, 
              "atan2(:x(Num), :y(1)) - {$angle.num(Radians)} default");
    given $base_list.shift {
        is_approx(tan(atan2(:y($desired_result), :x(1), :base($_)), 
                                  $_), $desired_result, 
                  "atan2(:x(Num), :y(1)) - {$angle.num($_)} $_");
    }
    
    # # Num.atan2 tests
    # is_approx($desired_result.Num.atan2.tan, $desired_result, 
    #           "atan2(Num) - {$angle.num(Radians)} default");
    # given $base_list.shift {
    #     is_approx($desired_result.Num.atan2($_).tan($_), $desired_result,
    #               "atan2(Num) - {$angle.num($_)} $_");
    # }
}

for (-2/2, -1/2, 1/2, 2/2) -> $desired_result
{
    # atan2(Rat) tests
    is_approx(tan(atan2($desired_result, 1/1)), $desired_result, 
              "atan2(Rat) - $desired_result default");
    given $base_list.shift {
        is_approx(tan(atan2($desired_result, 1/1, $_), $_), $desired_result, 
                  "atan2(Rat) - $desired_result $_");
    }
    
    # # Rat.atan2 tests
    # is_approx($desired_result.atan2.tan, $desired_result, 
    #           "atan2(Rat) - $desired_result default");
    # given $base_list.shift {
    #     is_approx($desired_result.atan2($_).tan($_), $desired_result,
    #               "atan2(Rat) - $desired_result $_");
    # }
    
    next unless $desired_result.denominator == 1;
    
    # atan2(Int) tests
    is_approx(tan(atan2($desired_result.numerator, 1)), $desired_result, 
              "atan2(Int) - $desired_result default");
    given $base_list.shift {
        is_approx(tan(atan2($desired_result.numerator, 1, $_), $_), $desired_result, 
                  "atan2(Int) - $desired_result $_");
    }
    
    # # Int.atan2 tests
    # is_approx($desired_result.numerator.atan2.tan, $desired_result, 
    #           "atan2(Int) - $desired_result default");
    # given $base_list.shift {
    #     is_approx($desired_result.numerator.atan2($_).tan($_), $desired_result,
    #               "atan2(Int) - $desired_result $_");
    # }
}

# check that the proper quadrant is returned

is_approx(atan2(4, 4, Degrees), 45, "atan2(4, 4) is 45 degrees");
is_approx(atan2(-4, 4, Degrees), -45, "atan2(-4, 4) is -45 degrees");
is_approx(atan2(4, -4, Degrees), 135, "atan2(4, -4) is 135 degrees");
is_approx(atan2(-4, -4, Degrees), -135, "atan2(-4, -4) is -135 degrees");
];
CloseOutputFile($file);

# vim: ft=perl6
