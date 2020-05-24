{ config, pkgs, ... }:

{
  config = rec {
    fonts.fontconfig.enable = true;

    conf = pkgs.writeText "fonts.conf" ''
      <?xml version="1.0" encoding="utf-8"?>
      <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
      <fontconfig>
        <include ignore_missing="yes">${config.home.path}/etc/fonts/conf.d</include>
        <include ignore_missing="yes">${config.home.path}/etc/fonts/fonts.conf</include>
        <dir>${config.home.path}/lib/X11/fonts</dir>
        <dir>${config.home.path}/share/fonts</dir>
        <dir>${config.home.profileDirectory}/lib/X11/fonts</dir>
        <dir>${config.home.profileDirectory}/share/fonts</dir>
        <cachedir>${config.home.path}/lib/fontconfig/cache</cachedir>
      </fontconfig>
    '';

    nmt.script = ''
      assertFileExists home-files/.config/fontconfig/conf.d/10-hm-fonts.conf
      assertFileContent home-files/.config/fontconfig/conf.d/10-hm-fonts.conf \
          ${conf}
    '';
  };
}
