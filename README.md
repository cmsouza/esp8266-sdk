# ESP8266 - Docker Image

+ A docker image built to use the ESP8266 SDK provided by phalcon (https://github.com/pfalcon/esp-open-sdk)
+ Also includes esp-open-rtos (https://github.com/SuperHouse/esp-open-rtos)

## Build
+ ```$ docker build . -t cmsouza/esp8266-sdk```

## Run
+ ```$ docker run -it --device=/dev/ttyUSB0 cmsouza/esp8266-sdk /bin/bash```
