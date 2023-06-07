use Test;

# $failed is set to 0 (actually to Mu) at compiletime.
my $failed;
# At run time, if we ever reach runtime, $failed is set to 1.
$failed = 1;

# When we end, we check if $failed is still 0. If yes, we've never reached runtime.
END {
  nok $failed.defined,
      'exit() works in CHECK {} - $fail not yet initialized at END time';
}

CHECK {
  # Output the TAP header...
  plan 2;
  nok $failed.defined, '$failed not yet initialized in CHECK {}';
  # ...and exit, implicitly calling END.
  exit;
}
