# Docker

The files in this directory provides the user with a method to quickly run the
Arduino IDE with the ESP32 tools.  The ESP32 tools need Python 2 and specific versions of some Python libraries that are a pain to set up.

The script `~/code/docker/build.bash` creates the docker image.  Do this just once!

To start the container, use `~/code/docker/start.bash` which script starts the container and leaves it running until `~/code/docker/stop.bash` is called.  It also copies any scripts from the `~/setup` directory into the workspace directory to allow the user to setup the workspace.

To start the Arduino IDE, use `./arduino.bash`.

After starting the container, you can get a Bash user prompt attached to the container using `~/code/docker/attach.bash`.  The command `source /opt/ros/foxy/setup.bash` is run for each new terminal.

To stop the container, use `./stop.bash`.

I is also  possible to make changes to the container and commit it using `./commit.bash`.
