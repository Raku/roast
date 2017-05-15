use Test;

plan 7;

my $prog = Proc::Async.new(:w, 'does-not-exist-cabbage-mooncake-unicycle');
my $stdout = $prog.stdout;
my $stderr = $prog.stderr;
my $promise = $prog.start;
dies-ok { await $prog.write(Buf.new(12, 42)) },
    'Writing to an async process that does not exist breaks the retunred Promise';
dies-ok { react { whenever $stdout { } } },
    'Trying to tap STDOUT of an async process that does not exist signals failure';
dies-ok { react { whenever $stderr { } } },
    'Trying to tap STDERR of an async process that does not exist signals failure';
lives-ok { $prog.close-stdin },
    'Closing stdin of an async process that does not exist is harmless';
dies-ok { await $prog.ready },
    'Ready promise for a process that does not exist is broken';
dies-ok { await $promise },
    'Promise for a process that does not exist is broken';

does-ok $prog.ready.cause, X::OS;
