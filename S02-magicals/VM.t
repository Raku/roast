use Test;

plan 3;

ok $*VM, '$*VM exists';
ok $*VM.perl, '$*VM.perl works';
ok $*VM.gist, '$*VM.gist works';
