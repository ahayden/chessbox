### Requirements
- Using Debian bullseye as a docker host requires the following 
  - Packages
    - docker.io
    - docker-compose
  - Local user able to run docker
    - `sudo adduser $USER docker`
  - Passing the Certabo serial device to the container
    - The certabo serial device is hot swappable and may change simple names; 
    the by-id name should be static:
      - ie `/dev/serial/by-id/usb-Silicon_Labs_CP2103_USB_to_UART_Bridge_Controller_0001-if00-port`
    - Make the serial devices writeable outside of the root owner and dialout user groups
      - ie `echo 'KERNEL=="ttyUSB[0-9]*",MODE="0666" >> /etc/udev/rules.d/99-serial.rules'`
- Add a lichess.token file to the same directory as the `docker-compose.yaml` file
- Run `docker-compose run chessbox /tmp/certabo-lichess/certabo-lichess.py 
  --port /dev/certabo --calibrate` to generate a calibration file. It will be 
  stored persistently. Run it again with the second set of queens.

### Running
- Run `docker-compose up` to start the container. It will run at boot and will restart 
after errors.
- Challenge someone to a correspondence game using the web client

