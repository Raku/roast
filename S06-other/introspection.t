use v6;

use Test;

plan 12;

# L<S06/Other matters/Introspection>

# introspecting only subs
only sub only-sub($a, $b) { "only" };   #OK not used

# .candidates
is(&only-sub.candidates.elems,1,"an only subs lists itself in the .candidates");
is(&only-sub.candidates[0].(1,2),"only","an only subs lists itself in the .candidates");

# .cando
is(&only-sub.cando(\(1,2)).elems,1,"an only sub implements .cando");
is(&only-sub.cando(\(1,2)).[0].(1,2),"only","an only sub implements .cando");

# .signature
ok(\(1,2) ~~ &only-sub.signature,"an only sub implements .signature");

# introspecting multi subs
multi sub multi-sub(1,2) { "m1" };
multi sub multi-sub(1)   { "m2" };
multi sub multi-sub()    { "m3" };

# .candidates
is(&multi-sub.candidates.elems,3,"a multi sub returns all its candidates");

# .cando
is(&multi-sub.cando(\(1,2)).[0].(1,2),"m1","you can invoke through introspection");
is(&multi-sub.cando(\(1)).[0].(1),"m2","you can invoke through introspection");
is(&multi-sub.cando(\()).[0].(),"m3","you can invoke through introspection");

# .signature
{
    my $sig = &multi-sub.signature;
    ok(\(1,2) ~~ $sig,"junction sig matches first candidate");
    ok(\(1)   ~~ $sig,"junction sig matches second candidate");
    ok(\()    ~~ $sig, "junction sig matches third candidate");
}
