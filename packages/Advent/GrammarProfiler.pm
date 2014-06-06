use v6;

our %timing;

my class ProfiledGrammarHOW is Metamodel::GrammarHOW is Mu {

    method find_method($obj, $name) {
        my $meth := callsame;
        substr($name, 0, 1) eq '!' || $name eq any(<parse CREATE Bool defined MATCH perl>) ??
            $meth !!
            -> $c, |args {
                my $grammar = $obj.WHAT.perl;
                %timing{$grammar} //= {};                   # Vivify grammar hash
                %timing{$grammar}{$meth.name} //= {};       # Vivify method hash
                my %t := %timing{$grammar}{$meth.name};
                my $start = now;                            # get start time
                my $result := $meth($obj, |args);           # Call original method
                %t<time> += now - $start;                   # accumulate execution time
                %t<calls>++;
                $result
            }
    }

    method publish_method_cache($obj) {
        # no caching, so we always hit find_method
    }

}

sub get-timing is export { %timing }
sub reset-timing is export { %timing = {} }

my module EXPORTHOW { }
EXPORTHOW.WHO.<grammar> = ProfiledGrammarHOW;
