my class MethodBoundaryAspect is export {
}

multi trait_mod:<is>(Mu:U $type, MethodBoundaryAspect:U $aspect) is export {
    $aspect === MethodBoundaryAspect ??
        $type.HOW.add_parent($type, $aspect) !!
        $type.HOW.add_aspect($type, $aspect);
}

my class ClassWithAspectsHOW
    is Metamodel::ClassHOW
{
    has @!aspects;
    method add_aspect(Mu $obj, MethodBoundaryAspect:U $aspect) {
        @!aspects.push($aspect);
    }
    method compose(Mu $obj) {
        for @!aspects -> $a {
	    for self.methods($obj, :local) -> $m {
		$m.wrap(-> $obj, |args {
		    $a.?entry($m.name, $obj, args);
		    my $result := callsame;
		    $a.?exit($m.name, $obj, args, $result);
                $result
			});
	    }
        }
        callsame;
    }
}
my module EXPORTHOW { }
EXPORTHOW.WHO.<class> = ClassWithAspectsHOW;

