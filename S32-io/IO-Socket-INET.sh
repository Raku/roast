# shell script (unix style) to supply a fork() for Rakudo
TEST="$1"
PORT="$2"
# commented out echo lines are diagnostics used during development.
# echo IO-Socket-INET.sh TEST=$TEST PORT=$PORT

# clear a file that acts as a status message from server to client
rm t/spec/S32-io/server-ready-flag 2>/dev/null

# use & to run the server as a background process
./perl6 t/spec/S32-io/IO-Socket-INET.pl $TEST $PORT server & SERVER=$!

# use & to run the client as a background process
./perl6 t/spec/S32-io/IO-Socket-INET.pl $TEST $PORT client & CLIENT=$!

# make a watchdog to kill a hanging client (occurs only if a test fails)
( sleep 20; kill $CLIENT 2>/dev/null && echo '(timeout)' ) &

# the client should exit after about 3 seconds. The watchdog would kill
# it after 10 sec. Hang around here until the client ends, either way.
# echo BEFORE CLIENT ENDS
wait $CLIENT 2>/dev/null
# echo AFTER CLIENT ENDED
# now that the client is finished either way, stop the server
kill $SERVER 2>/dev/null
# echo SHELL COMPLETED
