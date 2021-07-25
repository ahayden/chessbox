### Requirements
- Debian bullseye Linux host requires the following 
  - docker.io
  - docker-compose
  - `sudo adduser $USER docker`
  - the certabo serial device is hot swappable and may change simple names; the by-id name should be static:
    - ie `/dev/serial/by-id/usb-Silicon_Labs_CP2103_USB_to_UART_Bridge_Controller_0001-if00-port`
    - write `KERNEL=="ttyUSB[0-9]*",MODE="0666"` to `/etc/udev/rules.d/99-serial.rules`

### Running
Run `docker-compose up` to start the container. It will run at boot and will restart after errors.

