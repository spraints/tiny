# [My Tag Data](https://github.com/spraints/mytagdata)

This app receives data from my [wireless tag router](https://mytagdata.com) and pushes it into [influxdb](../influxdb).

See https://tfoel.medium.com/monitoring-temperature-other-parameters-with-wireless-sensor-tags-influxdb-and-grafana-451a97e38945 for the inspiration.

## Usage

    ./start

Visit the tag manager site and set up URL Calling.
- URL: `http://<IP-ADDRESS>:8900/wirelesstags/updates`
- HTTP Verb: POST
- Content: `{"tag_name":"{0}","tag_id":"{1}","degrees_c":{2},"humidity":{3},"now":"{5}","battery":{6}}`
- Check "This URL uses private IP address."
