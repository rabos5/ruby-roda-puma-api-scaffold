### Purpose

#### Examples

### Run Application Locally
##### Setup
```
$ bundle install
```
##### Run
```
$ RACK_ENV=dev bundle exec puma -C config/puma.rb
```
  * Open up a browser and go to https://localhost:5555/api/status

OR (for just http / local testing)
```
$ RACK_ENV=dev bundle exec puma -b 'tcp://127.0.0.1:5555'
```
  * Open up a browser and go to http://localhost:5555/api/status

### Docker
#### Build
```
$ docker build --no-cache=true -t sample_docker_name .
```

#### Run
```
$ docker run -it -p 5555:5555 --env RACK_ENV=dev sample_docker_name
```

#### Push / Publish
```
$ docker push sample_docker_name
```

#### Pull
```
$ docker pull sample_docker_name
```

### Generate Self-Signed localhost Certificates (make sure config/certs directory exists)
```
$ openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout config/certs/pkey.pem -out config/certs/cert.crt -subj "/C=US/O=sample_org/OU=sample_org_unit/CN=localhost"
```

### References
* RODA:
  * https://roda.jeremyevans.net/rdoc
  * https://roda.jeremyevans.net/documentation.html

* PUMA:
  * https://puma.io/
  * https://github.com/puma/puma
