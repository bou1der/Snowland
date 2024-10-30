{ pkgs, ... }:

let
  walls = pkgs.lib.importJSON "/home/boulder/.cache/wal/colors.json";
in
{
  imports = [
    ./proxy.nix
    ./ssh.nix
  ];

  home.packages = with pkgs ; [
    rofi-wayland
  ];

  home.file.".config/rofi/config.rasi".text = ''
    configuration {
      show-icons:true;
      display-drun:"🐢";
      font:"JetBrainsMono Nerd Font 14";
      drun-display-format:"{name}";
    }

    window {
     width:740px; 
     height:550px;
     padding:30px 30px 40px 32px;

     border:1px;
     border-color:${walls.special.foreground};
     border-radius:10px;

     transparency: "real";
     background-color: ${walls.special.background}80;
    }

    mainbox{
        background-color:transparent;
    }

    inputbar{
        children:                    ["dummy"];
        border-radius:               9px;
        spacing:                     0px;
        padding:                     64px 72px;
        background-image:            url("~/.config/backimg.png",width);
    }

    dummy {
        children: ["prompt","entry"];
        orientation:horizontal;
        border-radius:9px;
        background-color: ${walls.colors.color4};
    }

    prompt{
        padding:7px 0px 5px 20px;
        font:"JetBrainsMono Nerd Font 20";
        margin-right:-10px;
        background-color: ${walls.colors.color4};
    }
    entry{
        font:"JetBrainsMono Nerd Font BOLD 13";
        placeholder:"Search...";
        placeholder-color:${walls.special.cursor};
        text-color:${walls.special.cursor};
        width:424px;  
        padding:13px 70px 11px 7px;
        background-color: ${walls.colors.color4};
    }



    /* Elements ----------------------------------------------------- */
    element {
        children:["element-icon","element-text"]; 
        padding:4px 0px 4px 30px;
        border-radius:15px;
    }

    element normal.normal,
    element alternate.normal {
        
        background-color:transparent;
    }

    element selected.normal {
        background-color: ${walls.colors.color3};
    }


    element-text {
        background-color: transparent ;
        text-color:${walls.colors.color15} ;
        padding:3px 0px 0px 0px;
        horizontal-align: 0.5;
    }
    element-icon {
        background-color:transparent;
        size:32px;
    }

    element selected{
        background-color:${walls.special.cursor};
        text-color:${walls.special.background};
    }

    /* Listview ---------------------------------------------------- */

    listview {
        border:                      none;
        cursor:                      "default";
        columns:                     2;
        cycle:                       true;
        dynamic:                     true;
        scrollbar:                   false;
        layout:                      vertical;
        reverse:                     false;
        fixed-height:                true;
        fixed-columns:               true;
        
        background-color:            transparent;
        text-color:                  ${walls.special.cursor};

        spacing:                     4px;
        margin:                      0px;
        padding:                     30px 0px 0px 0px;
    }

    /* Scrollbar ---------------------------------------------------- */
    scrollbar {

    }

    /* Message ------------------------------------------------------ */
    message {
    }
    error-message {

    }
    textbox {

    }
    /*@media(max-aspect-ratio: 1.8) {
        element {
            orientation:             vertical;
        }
    }*/
  '';


}
