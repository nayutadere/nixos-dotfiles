{ pkgs, ... }: {
    programs.mango.enable = true;

    environment.systemPackages = with pkgs; [
        foot
        wl-clipboard
        swww
        fuzzel
        waybar
    ];

}
