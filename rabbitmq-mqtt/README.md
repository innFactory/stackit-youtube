

## Test MQTT

### Download and install mosquitto client
https://mosquitto.org/download/

### send messages
```bash
mosquitto_pub \
  -h rad29556e-2.data.eu01.onstackit.cloud \
  -p 51351 \
  -u "a9s-brk-usr-ad6acbbb6595712dbce08c8efd5225beb534e136" \
  -P "a9scd0797a8ef256e5c5e3faa7c8365c887bc5eacd4" \
  --tls-use-os-certs \
  -V mqttv311 \
  -d \
  -t "my/topic" \
  -m "Hello"
```

or

```bash
mosquitto_pub \
  -L "mqtts://a9s-brk-usr-ad6acbbb6595712dbce08c8efd5225beb534e136:a9scd0797a8ef256e5c5e3faa7c8365c887bc5eacd4@rad29556e-2.data.eu01.onstackit.cloud:51351/my/topic" \
  -d \
  -m "Hello"
```

### subscribe to messages
```bash
mosquitto_sub \
  -h rad29556e-2.data.eu01.onstackit.cloud \
  -p 51351 \
  -u "a9s-brk-usr-ad6acbbb6595712dbce08c8efd5225beb534e136" \
  -P "a9scd0797a8ef256e5c5e3faa7c8365c887bc5eacd4" \
  --tls-use-os-certs \
  -V mqttv311 \
  -t "my/topic"
```