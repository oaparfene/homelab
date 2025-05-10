{ config, pkgs, ... }:
{
  # Install wayvnc
  environment.systemPackages = with pkgs; [
    wayvnc
  ];

  # Systemd service to start wayvnc
  systemd.user.services.wayvnc = {
    description = "WayVNC Server";
    after = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.wayvnc}/bin/wayvnc -o HEADLESS-1 0.0.0.0 5901";
    };
  };
}