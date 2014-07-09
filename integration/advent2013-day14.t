use v6;
use Test;
plan 10;

# Promises

{
    my $p1000 = start {
	(1..Inf).grep(*.is-prime)[999]
    }

    is $p1000.result, 7919, 'simple promise';
}

class CurrencyExchange {
    has Int $.delay;
    has Str $.id;

    method get_quote($val) {
	sleep( $.delay );
	return $val * $.delay;
    }
}

my @currency_exchanges = (CurrencyExchange.new( :id<fast>, :delay(1) ),
			  CurrencyExchange.new( :id<med>,  :delay(3) ),
			  CurrencyExchange.new( :id<slow>, :delay(7) ), # wont finish in 5 sec
                         );

#?rakudo.moar skip 'Promise.in'
{
    my $val = 42;
    my @getting = @currency_exchanges.map(-> $ex { start { $ex.get_quote($val) } });
    await Promise.anyof(Promise.allof(@getting), Promise.in(5));
    my @quotes = @getting.grep(*.status == Kept).map(*.result);

    is_deeply @quotes, [42, 42*3], 'quotes example';
}

{
    my $p1000 = start {
	(1..Inf).grep(*.is-prime)[999]
    }
    my $base16 = $p1000.then(sub ($res) {
	$res.result.base(16)
    });
    my $pwrite = $base16.then(sub ($res) {
	return 'p1000.txt';
    });
    is $base16.result, '1EEF', '.then chaining';
    is $pwrite.result, 'p1000.txt', '.then chaining';
}

{
    # Create the promise.
    my $p = Promise.new;

    # Take the "vow" object, used to keep/break it.
    my $v = $p.vow;

    # keep this promise
    my $result = 42;
    $v.keep($result);
    is $p.status, 'Kept', 'kept promise';
}

{
    # Create the promise.
    my $p = Promise.new;

    # Take the "vow" object, used to keep/break it.
    my $v = $p.vow;

    my $exception_or_message = 'broken promise';
    $v.break($exception_or_message);
    is $p.status, 'Broken', 'broken promise';
}

# Channels

#?rakudo.moar skip 'combined config example'
{
    {
	my @files = qw<config1.ini config2.ini>;
	my %config = read_all(@files);
	is %config<font><size>, '10', 'combined config (font/size)';
	is %config<font><style>, 'italic', 'combined config (font/style)';
	is %config<font><color>, 'red', 'combined config (font/color)';
	is %config<line><style>, 'dashed', 'combined config (line/style)';
    }

    sub read_all(@files) {
	my $read = Channel.new;
	my $parsed = Channel.new;
	read_worker(@files, $read);
	parse_worker($read, $parsed);
	my %all_config = await config_combiner($parsed);
	$read.close; $parsed.close;
	return %all_config;
    }

    sub read_worker(@files, $dest) {

	# simulated slurp()
	sub Slurp($name) {
	    my %files = (
	     'config1.ini' => q:to"END1",
	     [font]
	     size = 10
	     style = italic
	     [line]
	     style = dashed
	     END1
	     'config2.ini' => q:to"END2",
	     [font]
	     color = red
	     [line]
	     height = 0.5
	     END2
	   );
	   return %files{$name}
	}

	start {
	    for @files -> $file {
		$dest.send( Slurp($file) );
	    }
	    $dest.close();
	    CATCH { diag 'read_worker failure:' ~ $_; $dest.fail($_) }
	}
    }

    sub parse_worker($source, $dest) {
	my grammar INIFile {
	    token TOP {
		^
		<entries>
		<section>+
		$
	    }

	    token section {
		'[' ~ ']' <key> \n
		<entries>
	    }

	    token entries {
		[
		| <entry> \n
		| \n
		]*
	    }

	    rule entry { <key> '=' <value> }

	    token key   { \w+ }
	    token value { \N+ }

	    token ws { \h* }
	 }

	my class INIFileActions {
	    method TOP($/) {
		my %result;
		%result<_> = $<entries>.ast;
		for @<section> -> $sec {
		    %result{$sec<key>} = $sec<entries>.ast;
		}
		make %result;
	    }

	    method entries($/) {
		my %entries;
		for @<entry> -> $e {
		    %entries{$e<key>} = ~$e<value>;
		}
		make %entries;
	    }
	}

	start {
	    loop {
		winner $source {
		    more $source {
			if INIFile.parse($_, :actions(INIFileActions)) -> $parsed {
			    $dest.send($parsed.ast);
			}
			else {
			    $dest.fail("Could not parse INI file");
			    last;
			}
		    }
		    done $source { last }
		}
	    }
	    $dest.close();
	    CATCH { diag 'parse worker failure:' ~ $_; $dest.fail($_) }
	}
    }

    sub config_combiner($source) {
	my $p = Promise.new;
	my $v = $p.vow;
	start {
	    my %result;
	    loop {
		winner $source {
		    more $source {
			for %^content.kv -> $sec, %kvs {
			    for %kvs.kv -> $k, $v {
				%result{$sec}{$k} = $v;
			    }
			}
		    }
		    done $source { last }
		}
	    }
	    $v.keep(%result);
	    CATCH { diag "combiner failure:" ~ $_; $v.break($_) }
	}
	return $p;
    }
}
