/usr/bin/supervisord
sleep 10
socat tcp-listen:4455,fork tcp:localhost:4444 &
tail -f /var/log/rsk/rsk.log
