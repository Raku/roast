use v6;
use Test;
my $r;

# more failing tables under original but patched code

# plan 42;

=begin table
        The Shoveller   Eddie Stevens     King Arthur's singing shovel
        Blue Raja       Geoffrey Smith    Master of cutlery
        Mr Furious      Roy Orson         Ticking time bomb of fury
        The Bowler      Carol Pinnsler    Haunted bowling ball
=end table

=table
    Constants           1
    Variables           10
    Subroutines         33
    Everything else     57

=for table
    mouse    | mice
    horse    | horses
    elephant | elephants

=table
    Animal | Legs |    Eats
    =======================
    Zebra  +   4  + Cookies
    Human  +   2  +   Pizza
    Shark  +   0  +    Fish

=table
        Superhero     | Secret          |
                      | Identity        | Superpower
        ==============|=================|================================
        The Shoveller | Eddie Stevens   | King Arthur's singing shovel

=begin table

                        Secret
        Superhero       Identity          Superpower
        =============   ===============   ===================
        The Shoveller   Eddie Stevens     King Arthur's
                                          singing shovel

        Blue Raja       Geoffrey Smith    Master of cutlery

        Mr Furious      Roy Orson         Ticking time bomb
                                          of fury

        The Bowler      Carol Pinnsler    Haunted bowling ball

=end table

=table
    X | O |    
   ---+---+--- 
      | X | O  
   ---+---+--- 
      |   | X  

=table
    X   O     
   ===========
        X   O 
   ===========
            X 

=begin table

foo
bar

=end table

=begin table
a | b | c
l | m | n
x | y
=end table

