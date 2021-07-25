### Requirements
- Debian bullseye Linux host requires the following 
  - docker.io
  - docker-compose
  - `sudo adduser $USER docker`
  - the certabo serial device is hot swappable and may change simple names; the by-id name should be static:
    - ie `/dev/serial/by-id/usb-Silicon_Labs_CP2103_USB_to_UART_Bridge_Controller_0001-if00-port`

