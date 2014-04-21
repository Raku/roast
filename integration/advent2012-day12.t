# http://perl6advent.wordpress.com/2012/12/12/exceptions/

use v6;
use Test;

plan 5;

class X::HTTP is Exception {
    has $.request-method;
    has $.url;
    has $.status;
    has $.error-string;

    method message() {
	"Error during $.request-method request"
	    ~ " to $.url: $.status $.error-string";
    }
 }

sub do-operation-that-will-die() {
    die X::HTTP.new(
	request-method  => 'GET',
	url             => 'http://example.com/no-such-file',
	status          => 404,
	error-string    => 'Not found',
	);
}

{
    my $result = try do-operation-that-will-die();
    ok $!, 'try error';
    is "$!", "Error during GET request to http://example.com/no-such-file: 404 Not found", 'error interpolated';
}

{
    my $result =  do-operation-that-will-die();
    CATCH {
	when X::HTTP {
	    is "$_.url()", 'http://example.com/no-such-file', 'CATCH error access';
	    # do some proper error handling
	}
	# exceptions not of type X::HTTP are rethrown
    }
}

sub I-am-fatal() {
    die "Neat error message";
}
try I-am-fatal();
is $!, 'Neat error message', 'adhoc error';
is $!.perl, 'X::AdHoc.new(payload => "Neat error message")', 'adhoc error';

