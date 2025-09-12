{ config, lib, pkgs, ...}:
{

  config = {
    hostConfig = {
      dataDir = "/data";
    };
  };

  imports = [
    ./hardware-configuration.nix
  ];

  environment.etc."ser2net.yaml" = {
    mode = "0755";
    text = ''
connection: &con01
  enable: on
  accepter: tcp,20108
  connector: serialdev,/dev/serial/by-id/usb-ITead_Sonoff_Zigbee_3.0_USB_Dongle_Plus_da3c386a8212ec11915520c7bd930c07-if00-port0,115200n81,local,dtr=off,rts=off
  options:
    kickolduser: true

connection: &con02
  accepter: tcp,20208
  connector: serialdev,/dev/serial/by-id/usb-FTDI_FT232R_USB_UART_AB4HWRSK-if00-port0,115200n81,local
  options:
    kickolduser: true
    banner: *banner
    telnet-brk-on-sync: true

connection: &con03
  accepter: tcp,20308
  connector: serialdev,/dev/serial/by-id/usb-RFXCOM_RFXtrx433XL_DO7372CL-if00-port0,38400n81,local
  options:
    kickolduser: true
    telnet-brk-on-sync: true

connection: &con04
  accepter: tcp,20408
  connector: serialdev,/dev/serial/by-id/usb-Silicon_Labs_CP2102_USB_to_UART_Bridge_Controller_0001-if00-port0,1200n81,local
  options:
    kickolduser: true
    '';
  };

  systemd.services.ser2net = {
    wantedBy = [ "multi-user.target" ];
    description = "Serial to network proxy";
    after = [ "network.target" "dev-ttyUSB0.device" "dev-ttyUSB1.device" "dev-ttyUSB2.device" "dev-ttyUSB3.device" ];
    serviceConfig = {
        Type = "simple";
        User = "root"; # todo user with only dialout group?
        ExecStart = ''${pkgs.ser2net}/bin/ser2net -n -c /etc/ser2net.yaml'';
        ExecReload = ''kill -HUP $MAINPID'';
        Restart = "on-failure";
      };
  };

}
