{ pkgs, ... }: {
  # https://github.com/NixOS/nixpkgs/issues/216361
  # Packages here can break if nixpkgs-unstable goes out of sync with home manager master
  home.packages = with pkgs; [
    eza
    bat


    kitty
    blackbox-terminal

    reflex
    insomnia    # REST API client

    ##### Applications: Communication Utilities
    telegram-desktop # Telegram client
    webcord # Alternative Discord client
    whatsapp-for-linux # unofficial client
    # zoom             # Zoom client
    teams-for-linux



    pdfsam-basic           # PDF editing
    xournalpp        # tablet notetaking software
    stable.joplin-desktop


    # [Specialised CTF Tools]
    thc-hydra        # online password-cracking tool
    john             # John the Ripper, an offline password-cracker
    nmap             # port scanner
    # TODO: Fix privilege issues so that wireshark CLI is user but wireshark-cli is root
    # wireshark-qt     # network analyzer


    # texlive.combined.scheme-full
    tectonic


    dbeaver
    nix-output-monitor

    (openfortivpn.overrideAttrs(old: {
      src = builtins.fetchTarball
      {
        url = "https://github.com/adrienverge/openfortivpn/archive/refs/tags/v1.20.4.tar.gz";
        sha256 = "1dzw16ndvghkkhq8z5w6vyxblrjkmns0mfh8r6z8q4r95dal59i4";
      };
    }))

    flavours

    waypaper killall

    ticktick
    linux-wifi-hotspot
    bottles
  ];
}

