# http://rosettacode.org/wiki/Sierpinski_triangle#Perl_6

use v6;
use Test;

plan 1;

my $rosetta-code = {

#### RC-begin
sub sierpinski ($n) {
    my @down  = '*';
    my $space = ' ';
    for ^$n {
        @down = @down.map({"$space$_$space"}), @down.map({"$_ $_"});
        $space ~= $space;
    }
    return @down;
}
 
.say for sierpinski 4;
#### RC-end

}

my $oldOUT = $*OUT;
my $output;
$*OUT = class {
    method print(*@args) {
        $output ~= @args.join;
    }
}

$rosetta-code.();

my $expected = "               *               
              * *              
             *   *             
            * * * *            
           *       *           
          * *     * *          
         *   *   *   *         
        * * * * * * * *        
       *               *       
      * *             * *      
     *   *           *   *     
    * * * *         * * * *    
   *       *       *       *   
  * *     * *     * *     * *  
 *   *   *   *   *   *   *   * 
* * * * * * * * * * * * * * * *
";

$*OUT = $oldOUT;
is($output.subst("\r", '', :g), $expected.subst("\r", '', :g), "Sierpinski Triangle");
