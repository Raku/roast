use v6;

my $forward_functions_file = "forward.functions";
my $prelude_file = "TrigTestSupport";
my $output_file = "new_trig.t";

class TrigFunction
{
    has $.function_name;
    has $.angle_and_results_name;
    has $.setup_block;
    
    multi method new(Str $function_name is copy, 
                     Str $angle_and_results_name is copy,
                     Str $setup_block is copy) {
        self.bless(*, :$function_name, :$angle_and_results_name, :$setup_block);
    }
    
    
    method dump_tests($file)
    {
        my $code = qq[
            # {$.function_name} tests

            for $.angle_and_results_name -> \$angle
            \{
                $.setup_block

                # {$.function_name}(Num)
                is_approx({$.function_name}(\$angle.num("radians")), \$desired_result, 
                          "{$.function_name}(Num) - \{\$angle.num('radians')\} default");
                for %official_base.keys -> \$base \{
                    is_approx({$.function_name}(\$angle.num(\$base), %official_base\{\$base\}), \$desired_result, 
                              "{$.function_name}(Num) - \{\$angle.num(\$base)\} \$base");
                \}

                # Num.{$.function_name} tests
                is_approx(\$angle.num("radians").{$.function_name}, \$desired_result, 
                          "Num.{$.function_name} - \{\$angle.num('radians')\} default");
                for %official_base.keys -> \$base \{
                    is_approx(\$angle.num(\$base).{$.function_name}(%official_base\{\$base\}), \$desired_result, 
                              "Num.{$.function_name} - \{\$angle.num(\$base)\} \$base");
                \}

                # {$.function_name}(Rat)
                is_approx({$.function_name}(\$angle.rat("radians")), \$desired_result, 
                          "{$.function_name}(Rat) - \{\$angle.rat('radians')\} default");
                for %official_base.keys -> \$base \{
                    is_approx({$.function_name}(\$angle.rat(\$base), %official_base\{\$base\}), \$desired_result, 
                              "{$.function_name}(Rat) - \{\$angle.rat(\$base)\} \$base");
                \}

                # Rat.{$.function_name} tests
                is_approx(\$angle.rat("radians").{$.function_name}, \$desired_result, 
                          "Rat.{$.function_name} - \{\$angle.rat('radians')\} default");
                for %official_base.keys -> \$base \{
                    is_approx(\$angle.rat(\$base).{$.function_name}(%official_base\{\$base\}), \$desired_result, 
                              "Rat.{$.function_name} - \{\$angle.rat(\$base)\} \$base");
                \}

                # {$.function_name}(Int)
                is_approx({$.function_name}(\$angle.int("degrees"), %official_base\{"degrees"\}), \$desired_result, 
                          "{$.function_name}(Int) - \{\$angle.int('degrees')\} degrees");
                is_approx(\$angle.int('degrees').{$.function_name}(%official_base\{'degrees'\}), \$desired_result, 
                          "Int.{$.function_name} - \{\$angle.int('degrees')\} degrees");

                # # Complex tests
                # my Complex \$zp0 = \$angle.complex(0.0, "radians");
                # my Complex \$sz0 = \$desired_result + 0i;
                # my Complex \$zp1 = \$angle.complex(1.0, "radians");
                # my Complex \$sz1 = (exp(\$zp1 * 1i) - exp(-\$zp1 * 1i)) / 2i;
                # my Complex \$zp2 = \$angle.complex(2.0, "radians");
                # my Complex \$sz2 = (exp(\$zp2 * 1i) - exp(-\$zp2 * 1i)) / 2i;
                # 
                # # {$.function_name}(Complex) tests
                # is_approx({$.function_name}(\$zp0), \$sz0, "{$.function_name}(Complex) - \$zp0 default");
                # is_approx({$.function_name}(\$zp1), \$sz1, "{$.function_name}(Complex) - \$zp1 default");
                # is_approx({$.function_name}(\$zp2), \$sz2, "{$.function_name}(Complex) - \$zp2 default");
                # 
                # for %official_base.keys -> \$base \{
                #     my Complex \$z = \$angle.complex(0.0, \$base);
                #     is_approx({$.function_name}(\$z, %official_base\{\$base\}), \$sz0, "{$.function_name}(Complex) - \$z \$base");
                # 
                #     \$z = \$angle.complex(1.0, \$base);
                #     is_approx({$.function_name}(\$z, %official_base\{\$base\}), \$sz1, "{$.function_name}(Complex) - \$z \$base");
                # 
                #     \$z = \$angle.complex(2.0, \$base);
                #     is_approx({$.function_name}(\$z, %official_base\{\$base\}), \$sz2, "{$.function_name}(Complex) - \$z \$base");
                # \}
                # 
                # # Complex.{$.function_name} tests
                # is_approx(\$zp0.{$.function_name}, \$sz0, "Complex.{$.function_name} - \$zp0 default");
                # is_approx(\$zp1.{$.function_name}, \$sz1, "Complex.{$.function_name} - \$zp1 default");
                # is_approx(\$zp2.{$.function_name}, \$sz2, "Complex.{$.function_name} - \$zp2 default");
                # 
                # for %official_base.keys -> \$base \{
                #     my Complex \$z = \$angle.complex(0.0, \$base);
                #     #?rakudo skip "Complex.{$.function_name} plus base doesn't work yet"
                #     is_approx(\$z.{$.function_name}(%official_base\{\$base\}), \$sz0, "Complex.{$.function_name} - \$z \$base");
                # 
                #     \$z = \$angle.complex(1.0, \$base);
                #     #?rakudo skip "Complex.{$.function_name} plus base doesn't work yet"
                #     is_approx(\$z.{$.function_name}(%official_base\{\$base\}), \$sz1, "Complex.{$.function_name} - \$z \$base");
                # 
                #     \$z = \$angle.complex(2.0, \$base);
                #     #?rakudo skip "Complex.{$.function_name} plus base doesn't work yet"
                #     is_approx(\$z.{$.function_name}(%official_base\{\$base\}), \$sz2, "Complex.{$.function_name} - \$z \$base");
                # \}
            \}
        ];
        $file.say: $code;
    }
}

# my $fff = open $forward_functions_file, :r or die "Unable to open $forward_functions_file: $!\n";

my $file = open $output_file, :w or die "Unable to open $output_file $!\n";

my $prelude = open $prelude_file, :r or die "Unable to open $prelude_file: $!\n";
for $prelude.lines -> $line {
    $file.say: $line;
}

my $tf = TrigFunction.new("sin", "@sines", "my \$desired_result = \$angle.result;");
$tf.dump_tests($file);
$tf = TrigFunction.new("cos", "@cosines", "my \$desired_result = \$angle.result;");
$tf.dump_tests($file);
$tf = TrigFunction.new("tan", "@sines", 
                       "next if abs(cos(\$angle.num('radians'))) < 1e-6; 
                       my \$desired_result = sin(\$angle.num('radians')) / cos(\$angle.num('radians'));");
$tf.dump_tests($file);
$tf = TrigFunction.new("sec", "@cosines", 
                       "next if abs(cos(\$angle.num('radians'))) < 1e-6; 
                       my \$desired_result = 1.0 / cos(\$angle.num('radians'));");
$tf.dump_tests($file);
$tf = TrigFunction.new("cosec", "@sines", 
                       "next if abs(sin(\$angle.num('radians'))) < 1e-6; 
                       my \$desired_result = 1.0 / sin(\$angle.num('radians'));");
$tf.dump_tests($file);
$tf = TrigFunction.new("cotan", "@sines", 
                       "next if abs(sin(\$angle.num('radians'))) < 1e-6; 
                       my \$desired_result = cos(\$angle.num('radians')) / sin(\$angle.num('radians'));");
$tf.dump_tests($file);

$tf = TrigFunction.new("sinh", "@sinhes", "my \$desired_result = \$angle.result;");
$tf.dump_tests($file);
$tf = TrigFunction.new("cosh", "@coshes", 
                       "my \$desired_result = \$angle.result;");
$tf.dump_tests($file);
$tf = TrigFunction.new("tanh", "@sines", 
                       "next if abs(cosh(\$angle.num('radians'))) < 1e-6; 
                       my \$desired_result = sinh(\$angle.num('radians')) / cosh(\$angle.num('radians'));");
$tf.dump_tests($file);
$tf = TrigFunction.new("sech", "@cosines", 
                       "next if abs(cosh(\$angle.num('radians'))) < 1e-6; 
                       my \$desired_result = 1.0 / cosh(\$angle.num('radians'));");
$tf.dump_tests($file);
$tf = TrigFunction.new("cosech", "@sines", 
                       "next if abs(sinh(\$angle.num('radians'))) < 1e-6; 
                       my \$desired_result = 1.0 / sinh(\$angle.num('radians'));");
$tf.dump_tests($file);
$tf = TrigFunction.new("cotanh", "@sines", 
                       "next if abs(sinh(\$angle.num('radians'))) < 1e-6; 
                       my \$desired_result = cosh(\$angle.num('radians')) / sinh(\$angle.num('radians'));");
$tf.dump_tests($file);

$file.say: "done_testing;

# vim: ft=perl6";
