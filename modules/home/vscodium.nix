{ pkgs, ... }:

let
  cardinal90.multi-cursor-case-preserve = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "multi-cursor-case-preserve";
      publisher = "cardinal90";
      version = "1.0.5";
      hash = "sha256-eJafjYDydD8DW83VLH9MPFeDENXBx3el7XvjZqu88Jw=";
    };
  };
  circlecodesolution.ccs-flutter-color = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "ccs-flutter-color";
      publisher = "circlecodesolution";
      version = "2.0.0";
      hash = "sha256-SdWj/MS2g8ltidgYXoDzB1PyajuW5JXAaV5SaotC2hg=";
    };
  };
  lyzerk.linecounter = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "linecounter";
      publisher = "lyzerk";
      version = "0.2.7";
      hash = "sha256-cIWKjz/pjUOJDnhSAchEiVMJ8nb2HYf2VyZ6xzhZDlo=";
    };
  };
  steoates.autoimport = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "autoimport";
      publisher = "steoates";
      version = "1.5.4";
      hash = "sha256-7iIwJJsoNbtTopc+BQ+195aSCLqdNAaGtMoxShyhBWY=";
    };
  };
  stivo.tailwind-fold = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "tailwind-fold";
      publisher = "stivo";
      version = "0.2.0";
      hash = "sha256-yH3eA5jgBwxqnpFQkg91KQMkQps5iM1v783KQkQcWUU=";
    };
  };
  wayou.vscode-todo-highlight = pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = {
      name = "vscode-todo-highlight";
      publisher = "wayou";
      version = "1.0.5";
      hash = "sha256-CQVtMdt/fZcNIbH/KybJixnLqCsz5iF1U0k+GfL65Ok=";
    };
  };
in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # nix language
        jnoortheen.nix-ide
        # nix-shell suport
        arrterian.nix-env-selector
        # C/C++
        llvm-vs-code-extensions.vscode-clangd
        # OCaml
        # ocamllabs.ocaml-platform

        # Color theme
        jdinhlife.gruvbox
        # material icon theme
        pkief.material-icon-theme
        # comments highlighting
        aaron-bond.better-comments
        # indentation beautify
        oderwat.indent-rainbow
        # multiple cursor case preserve
        cardinal90.multi-cursor-case-preserve
        # console output color
        ibm.output-colorizer
        # code prettier
        esbenp.prettier-vscode
        # sort lines
        tyriar.sort-lines
        # highlight todo
        wayou.vscode-todo-highlight
        # visualize colors
        circlecodesolution.ccs-flutter-color
        # line counter
        lyzerk.linecounter

        # markdown preview
        shd101wyy.markdown-preview-enhanced

        # intellicode
        visualstudioexptteam.vscodeintellicode
        visualstudioexptteam.intellicode-api-usage-examples

        # python
        ms-python.python
        # import sorting for python
        ms-python.isort
        # language server
        ms-python.vscode-pylance
        # auto docstring
        njpwerner.autodocstring

        # java
        redhat.java

        # javascript/typescript
        # eslint
        dbaeumer.vscode-eslint
        # auto import
        steoates.autoimport
        # import cost
        wix.vscode-import-cost
        # pretty ts errors
        yoavbls.pretty-ts-errors
        # html tags
        formulahendry.auto-close-tag
        formulahendry.auto-rename-tag

        # tailwindcss
        bradlc.vscode-tailwindcss
        # tailwind fold
        stivo.tailwind-fold
      ];
      userSettings = {
        "update.mode" = "none";
        "extensions.autoUpdate" = false; # This stuff fixes vscode freaking out when theres an update
        "window.titleBarStyle" = "custom"; # needed otherwise vscode crashes, see https://github.com/NixOS/nixpkgs/issues/246509
        "window.menuBarVisibility" = "toggle";
        "editor.fontFamily" = "'Maple Mono', 'SymbolsNerdFont', 'monospace', monospace";
        "terminal.integrated.fontFamily" = "'Maple Mono', 'SymbolsNerdFont'";
        "editor.fontSize" = 18;
        "workbench.colorTheme" = "Gruvbox Dark Hard";
        "workbench.iconTheme" = "material-icon-theme";
        "material-icon-theme.folders.theme" = "classic";
        "vsicons.dontShowNewVersionMessage" = true;
        "explorer.confirmDragAndDrop" = false;
        "editor.fontLigatures" = true;
        "editor.minimap.enabled" = true;
        "workbench.startupEditor" = "none";
        "editor.formatOnSave" = true;
        "editor.formatOnType" = true;
        "editor.formatOnPaste" = true;
        "editor.inlayHints.enabled" = "off";
        "editor.codeActionsOnSave" = {
          "source.fixAll.eslint" = true;
        };
        "editor.suggestSelection" = "first";
        "workbench.layoutControl.type" = "menu";
        "workbench.editor.limit.enabled" = true;
        "workbench.editor.limit.value" = 10;
        "workbench.editor.limit.perEditorGroup" = true;
        "workbench.editor.showTabs" = "none";
        "files.autoSave" = "afterDelay";
        "explorer.openEditors.visible" = 0;
        "breadcrumbs.enabled" = true;
        "editor.renderControlCharacters" = false;
        "workbench.activityBar.location" = "hidden";
        "workbench.statusBar.visible" = true;
        "editor.scrollbar.verticalScrollbarSize" = 2;
        "editor.scrollbar.horizontalScrollbarSize" = 2;
        "editor.scrollbar.vertical" = "hidden";
        "editor.scrollbar.horizontal" = "hidden";
        "workbench.layoutControl.enabled" = true;
        "editor.mouseWheelZoom" = true;
        "security.workspace.trust.untrustedFiles" = "open";
        "javascript.updateImportsOnFileMove.enabled" = true;
        "typescript.updateImportsOnFileMove.enabled" = true;

        "[typescript]" = {
          "editor.defaultFormatter" = "esbnp.prettier-vscode";
        };
        "[typescriptreact]" = {
          "editor.defaultFormatter" = "esbnp.prettier-vscode";
        };
        "[javascript]" = {
          "editor.defaultFormatter" = "esbnp.prettier-vscode";
        };
        "[html]" = {
          "editor.defaultFormatter" = "esbnp.prettier-vscode";
        };

        # C/C++
        "clangd.arguments" = [
          "--clang-tidy"
          "--inlay-hints=false"
        ];

        "nix.serverPath" = "nixd";
        "nix.enableLanguageServer" = true;
        # "nix.serverSettings" = {
        #   "nixd" = {
        #     "formatting" = {
        #       "command" = [ "nixfmt" ];
        #     };
        #   };
        # };
      };
      # Keybindings
      keybindings = [
        {
          key = "ctrl+q";
          command = "editor.action.commentLine";
          when = "editorTextFocus && !editorReadonly";
        }
        {
          key = "ctrl+s";
          command = "workbench.action.files.saveFiles";
        }
      ];
    };
  };
}
