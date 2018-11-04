unit module RT129215;

sub array_str ($data) is export { $data ~~ Array[Str]; };
sub hash_str ($data) is export { $data ~~ Hash[Str]; };
sub hash_hash_str ($data) is export { $data ~~ Hash[Hash[Str]]; };

sub str_d ($data) is export { $data ~~ Str:D; };
sub array_str_d ($data) is export { $data ~~ Array[Str:D]; };
sub hash_str_d ($data) is export { $data ~~ Hash[Str:D]; };
sub hash_hash_str_d ($data) is export { $data ~~ Hash[Hash[Str:D]]; };

sub str_u ($data) is export { $data ~~ Str:U; };
sub array_str_u ($data) is export { $data ~~ Array[Str:U]; };
sub hash_str_u ($data) is export { $data ~~ Hash[Str:U]; };
sub hash_hash_str_u ($data) is export { $data ~~ Hash[Hash[Str:U]]; };
