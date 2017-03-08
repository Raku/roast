use Test;

plan 3;

my $prog = Proc::Async.new(:w, 'does-not-exist-cabbage-mooncake-unicycle');
my $promise = $prog.start;
dies-ok { await $prog.write(Buf.new(12, 42)) },
    'Writing to an async process that does not exist breaks the retunred Promise';
lives-ok { $prog.close-stdin },
    'Closing stdin of an async process that does not exist is harmless';
dies-ok { await $promise },
    'Promise for a process that does not exist is broken';
