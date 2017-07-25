constant $constant-regex is export =  /fo*/;
constant &constant-sub   is export  = sub { "win" };
constant &constant-sub-with-call is export = sub { uc "win" };
constant @const-map      is export  = map { uc $_ }, <foo bar baz>;
constant $const-regex-block  is export  = /{ uc "win"} ./;
