# Hardware

The hardware for this robot is based on a RasPiRobot kit I bought years ago.

![RasPiRobot Rover Robot](RasPiRobot.jpg "RasPiRobot Rover Robot")

Instead of the Raspberry Pi 2 shown in the picture, I'm using an ESP32-CAM module using the same RasPiRobot RRBv3 board to drive the motors.  The camera will be used instead of the ultrasonic sensor.

## The ESP32-CAM

The ESP32-CAM board I'm using was bought from [AliExpress](https://www.aliexpress.com/item/1005001597435442.html) and is fitted with:

* RAM
* ...

Other ESP32-CAM modules are available but the pins used may vary so check carefully before

Minimal connections for testing are:

| ESP32-CAM Pin | USB serial cable |
|-|-|
| 5V | Red |
| GND | Black |
|


## Programming the ESP32-CAM

Use the docker in this directory as the ESP32 tools need Python 2 and specific versions of python libraries.

1. Start Arduino IDE using `docker/arduino.sh`.
1. [Set up the Arduino IDE to use the  ESP32](https://randomnerdtutorials.com/installing-the-esp32-board-in-arduino-ide-mac-and-linux-instructions/) that boils down to
   1. Add the URL <https://dl.espressif.com/dl/package_esp32_index.json> to the `File > Preferences` > `Settings` for additional boards.
   2. Then go to `Tools > Boards Manager`.  Search for ESP32.  Install latest version.  I'm using v1.0.5.
1. Select the board using `Tools > ESP32 Arduino`.  I used the `AI Thinker ESP32-CAM" as it was the closest I could find.
1. Select port `/dev/ttyUSB0`.
1. Verify the connection by runnig the
1. Open `File > Examples > ESP32 > Camera > CameraWebServer`.

### Troubleshooting

#### ESP32 serial error

```code
Traceback (most recent call last):
  File "/home/andy/.arduino15/packages/esp32/tools/esptool_py/3.0.0/esptool.py", line 38, in <module>
    import serial
ImportError: No module named serial
Multiple libraries were found for "WiFi.h"
 Used: /home/andy/.arduino15/packages/esp32/hardware/esp32/1.0.5/libraries/WiFi
 Not used: /home/andy/software/arduino-1.8.13/libraries/WiFi
exit status 1
Error compiling for board AI Thinker ESP32-CAM.
```

Caused by missing python library.  Proved this by running the executable from the command line using:

```bash
/home/andy/.arduino15/packages/esp32/tools/esptool_py/3.0.0/esptool.py
```

[This blog](https://koen.vervloesem.eu/blog/fixing-the-arduino-ide-for-the-esp32esp8266-on-ubuntu-2004/) was helpful is finding the fix which was:

```bash
curl https://bootstrap.pypa.io/2.7/get-pip.py --output get-pip.py
python2 get-pip.py
pip2 install pyserial
/home/andy/.arduino15/packages/esp32/tools/esptool_py/3.0.0/esptool.py
```

## Connecting the ESP32-CAM

