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
    has $.plus_inf;
    has $.minus_inf;
    
    multi method new(Str $function_name is copy, 
                     Str $inverted_function_name is copy;
                     Str $angle_and_results_name is copy,
                     Str $rational_inverse_tests is copy;
                     Str $setup_block is copy,
                     Str $plus_inf is copy,
                     Str $minus_inf is copy) {
        self.bless(*, 
                   :$function_name, 
                   :$inverted_function_name, 
                   :$angle_and_results_name, 
                   :$rational_inverse_tests,
                   :$setup_block,
                   :$plus_inf,
                   :$minus_inf);
    }
        
    method dump_forward_tests($file) {
        my $code = q[
            # $.function_name tests

            for $.angle_and_results_name -> $angle
            {
                $.setup_block

                # $.function_name(Num)
                is_approx($.function_name($angle.num("radians")), $desired_result, 
                          "$.function_name(Num) - {$angle.num('radians')} default");
                for %official_base.keys -> $base {
                    is_approx($.function_name($angle.num($base), %official_base{$base}), $desired_result, 
                              "$.function_name(Num) - {$angle.num($base)} $base");
                }

                # Num.$.function_name tests
                is_approx($angle.num("radians").$.function_name, $desired_result, 
                          "Num.$.function_name - {$angle.num('radians')} default");
                for %official_base.keys -> $base {
                    is_approx($angle.num($base).$.function_name(%official_base{$base}), $desired_result, 
                              "Num.$.function_name - {$angle.num($base)} $base");
                }

                # $.function_name(Rat)
                is_approx($.function_name($angle.rat("radians")), $desired_result, 
                          "$.function_name(Rat) - {$angle.rat('radians')} default");
                for %official_base.keys -> $base {
                    is_approx($.function_name($angle.rat($base), %official_base{$base}), $desired_result, 
                              "$.function_name(Rat) - {$angle.rat($base)} $base");
                }

                # Rat.$.function_name tests
                is_approx($angle.rat("radians").$.function_name, $desired_result, 
                          "Rat.$.function_name - {$angle.rat('radians')} default");
                for %official_base.keys -> $base {
                    is_approx($angle.rat($base).$.function_name(%official_base{$base}), $desired_result, 
                              "Rat.$.function_name - {$angle.rat($base)} $base");
                }

                # $.function_name(Int)
                is_approx($.function_name($angle.int("degrees"), %official_base{"degrees"}), $desired_result, 
                          "$.function_name(Int) - {$angle.int('degrees')} degrees");
                is_approx($angle.int('degrees').$.function_name(%official_base{'degrees'}), $desired_result, 
                          "Int.$.function_name - {$angle.int('degrees')} degrees");

                # # Complex tests
                # my Complex $zp0 = $angle.complex(0.0, "radians");
                # my Complex $sz0 = $desired_result + 0i;
                # my Complex $zp1 = $angle.complex(1.0, "radians");
                # my Complex $sz1 = (exp($zp1 * 1i) - exp(-$zp1 * 1i)) / 2i;
                # my Complex $zp2 = $angle.complex(2.0, "radians");
                # my Complex $sz2 = (exp($zp2 * 1i) - exp(-$zp2 * 1i)) / 2i;
                # 
                # # $.function_name(Complex) tests
                # is_approx($.function_name($zp0), $sz0, "$.function_name(Complex) - $zp0 default");
                # is_approx($.function_name($zp1), $sz1, "$.function_name(Complex) - $zp1 default");
                # is_approx($.function_name($zp2), $sz2, "$.function_name(Complex) - $zp2 default");
                # 
                # for %official_base.keys -> $base {
                #     my Complex $z = $angle.complex(0.0, $base);
                #     is_approx($.function_name($z, %official_base{$base}), $sz0, "$.function_name(Complex) - $z $base");
                # 
                #     $z = $angle.complex(1.0, $base);
                #     is_approx($.function_name($z, %official_base{$base}), $sz1, "$.function_name(Complex) - $z $base");
                # 
                #     $z = $angle.complex(2.0, $base);
                #     is_approx($.function_name($z, %official_base{$base}), $sz2, "$.function_name(Complex) - $z $base");
                # }
                # 
                # # Complex.$.function_name tests
                # is_approx($zp0.$.function_name, $sz0, "Complex.$.function_name - $zp0 default");
                # is_approx($zp1.$.function_name, $sz1, "Complex.$.function_name - $zp1 default");
                # is_approx($zp2.$.function_name, $sz2, "Complex.$.function_name - $zp2 default");
                # 
                # for %official_base.keys -> $base {
                #     my Complex $z = $angle.complex(0.0, $base);
                #     #?rakudo skip "Complex.$.function_name plus base doesn't work yet"
                #     is_approx($z.$.function_name(%official_base{$base}), $sz0, "Complex.$.function_name - $z $base");
                # 
                #     $z = $angle.complex(1.0, $base);
                #     #?rakudo skip "Complex.$.function_name plus base doesn't work yet"
                #     is_approx($z.$.function_name(%official_base{$base}), $sz1, "Complex.$.function_name - $z $base");
                # 
                #     $z = $angle.complex(2.0, $base);
                #     #?rakudo skip "Complex.$.function_name plus base doesn't work yet"
                #     is_approx($z.$.function_name(%official_base{$base}), $sz2, "Complex.$.function_name - $z $base");
                # }
            }
            
            is($.function_name(Inf), $.plus_inf, "$.function_name(Inf) - default");
            is($.function_name(-Inf), $.minus_inf, "$.function_name(-Inf) - default");
            for %official_base.keys -> $base
            {
                is($.function_name(Inf,  %official_base{$base}), $.plus_inf, "$.function_name(Inf) - $base");
                is($.function_name(-Inf, %official_base{$base}), $.minus_inf, "$.function_name(-Inf) - $base");
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
    
    method dump_inverse_tests($file) {
        my $code = q[
            # $.inverted_function_name tests

            for $.angle_and_results_name -> $angle
            {
                $.setup_block

                # $.inverted_function_name(Num) tests
                is_approx($.function_name($.inverted_function_name($desired_result)), $desired_result, 
                          "$.inverted_function_name(Num) - {$angle.num('radians')} default");
                for %official_base.keys -> $base {
                    is_approx($.function_name($.inverted_function_name($desired_result, %official_base{$base}), %official_base{$base}), $desired_result, 
                              "$.inverted_function_name(Num) - {$angle.num($base)} $base");
                }
                
                # Num.$.inverted_function_name tests
                is_approx($desired_result.Num.$.inverted_function_name.$.function_name, $desired_result, 
                          "$.inverted_function_name(Num) - {$angle.num('radians')} default");
                for %official_base.keys -> $base {
                    is_approx($desired_result.Num.$.inverted_function_name(%official_base{$base}).$.function_name(%official_base{$base}), $desired_result,
                              "$.inverted_function_name(Num) - {$angle.num($base)} $base");
                }
            }
            
            for $.rational_inverse_tests -> $desired_result
            {
                # $.inverted_function_name(Rat) tests
                is_approx($.function_name($.inverted_function_name($desired_result)), $desired_result, 
                          "$.inverted_function_name(Rat) - $desired_result default");
                for %official_base.keys -> $base {
                    is_approx($.function_name($.inverted_function_name($desired_result, %official_base{$base}), %official_base{$base}), $desired_result, 
                              "$.inverted_function_name(Rat) - $desired_result $base");
                }
                
                # Rat.$.inverted_function_name tests
                is_approx($desired_result.$.inverted_function_name.$.function_name, $desired_result, 
                          "$.inverted_function_name(Rat) - $desired_result default");
                for %official_base.keys -> $base {
                    is_approx($desired_result.$.inverted_function_name(%official_base{$base}).$.function_name(%official_base{$base}), $desired_result,
                              "$.inverted_function_name(Rat) - $desired_result $base");
                }
                
                next unless $desired_result.denominator == 1;
                
                # $.inverted_function_name(Int) tests
                is_approx($.function_name($.inverted_function_name($desired_result.numerator)), $desired_result, 
                          "$.inverted_function_name(Int) - $desired_result default");
                for %official_base.keys -> $base {
                    is_approx($.function_name($.inverted_function_name($desired_result.numerator, %official_base{$base}), %official_base{$base}), $desired_result, 
                              "$.inverted_function_name(Int) - $desired_result $base");
                }
                
                # Int.$.inverted_function_name tests
                is_approx($desired_result.numerator.$.inverted_function_name.$.function_name, $desired_result, 
                          "$.inverted_function_name(Int) - $desired_result default");
                for %official_base.keys -> $base {
                    is_approx($desired_result.numerator.$.inverted_function_name(%official_base{$base}).$.function_name(%official_base{$base}), $desired_result,
                              "$.inverted_function_name(Int) - $desired_result $base");
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

my $file = open $output_file, :w or die "Unable to open $output_file $!\n";

$file.say: '# WARNING:
# This is a generated file and should not be edited directly.
# look into generate-tests.pl instead';

my $prelude = open $prelude_file, :r or die "Unable to open $prelude_file: $!\n";
for $prelude.lines -> $line {
    $file.say: $line;
}

my $functions = open $functions_file, :r or die "Unable to open $functions_file: $!\n";

my $in_setup = Bool::False;
my Str $function_name;
my Str $inverted_function_name;
my Str $angle_and_results_name;
my Str $rational_inverse_tests;
my Str $setup_block;
my Str $plus_inf;
my Str $minus_inf;
for $functions.lines {
    when $in_setup && /end\-setup/ { $in_setup = Bool::False; }
    when $in_setup { $setup_block ~= $_; }
    when /Function\:\s+(.*)/ { 
        $function_name = ~$0; 
        $inverted_function_name = "a$0";
        $angle_and_results_name = "";
        $rational_inverse_tests = "(-2/2, -1/2, 1/2, 2/2)";
        $setup_block = "";
        $plus_inf = "NaN";
        $minus_inf = "NaN";
    }
    when /setup:/ { $in_setup = Bool::True; }
    when /loop_over\:\s+(.*)/ { $angle_and_results_name = ~$0; }
    when /inverted_function\:\s+(.*)/ { $inverted_function_name = ~$0; }
    when /rational_inverse_tests\:\s+(.*)/ { $rational_inverse_tests = ~$0; }
    when /plus_inf\:\s+(.*)/ { $plus_inf = ~$0; }
    when /minus_inf\:\s+(.*)/ { $minus_inf = ~$0; }
    when /End/ {
        my $tf = TrigFunction.new($function_name, $inverted_function_name, $angle_and_results_name, 
                                  $rational_inverse_tests, $setup_block, $plus_inf, $minus_inf);
        $tf.dump_forward_tests($file);
        $tf.dump_inverse_tests($file);
    }
}

# $tf = TrigFunction.new("cosech", "acosech", "@sines", 
#                        "next if abs(sinh(\$angle.num('radians'))) < 1e-6; 
#                        my \$desired_result = 1.0 / sinh(\$angle.num('radians'));",
#                        "0", '"-0"');
# $tf.dump_forward_tests($file);
# $tf.dump_inverse_tests($file);
# $tf = TrigFunction.new("cotanh", "acotanh", "@sines", 
#                        "next if abs(sinh(\$angle.num('radians'))) < 1e-6; 
#                        my \$desired_result = cosh(\$angle.num('radians')) / sinh(\$angle.num('radians'));",
#                        "1", "-1");
# $tf.dump_forward_tests($file);
# $tf.dump_inverse_tests($file);

# the {} afer 'vim' just generate an empty string.
# this is to avoid the string constant being interpreted as a modeline
# here in generate-tests.pl
$file.say: "done_testing;

# vim{}: ft=perl6 nomodifiable";

# vim: ft=perl6
