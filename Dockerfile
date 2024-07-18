FROM python:3.7-slim

RUN apt-get update && apt-get install -y curl

RUN pip install --no-cache-dir pyyaml
COPY arduino-cli-compile-docker/compile.py /usr/src/app/

RUN pip3 install pyserial

RUN curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh

RUN arduino-cli core update-index && \
    arduino-cli core install arduino:avr

RUN arduino-cli core install esp32:esp32 --additional-urls https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json

RUN arduino-cli core install esp8266:esp8266 --additional-urls http://arduino.esp8266.com/stable/package_esp8266com_index.json

RUN arduino-cli core install Heltec-esp32:esp32 --additional-urls https://github.com/Heltec-Aaron-Lee/WiFi_Kit_series/releases/download/3.0.0-1.0.1/package_heltec_esp32_index.json

RUN arduino-cli core install jp112sdl:EFM32 --additional-urls https://raw.githubusercontent.com/mpovel/ARDUINO_EFM32/master/package/package_ARDUINO_EFM32_index.json

RUN curl -O https://raw.githubusercontent.com/espressif/esp-idf/8bc19ba893e5544d571a753d82b44a84799b94b1/components/spiffs/spiffsgen.py

WORKDIR /usr/src/sketch
CMD [ "python", "-u", "/usr/src/app/compile.py" ]
