{
  config,
  pkgs,
  lib,
  utils,
  inputs,
  ...
}:
with lib;
  mkIf config.normal.terminal.llm.ollama.enable {
    allow-unfree = [
      # AI
      "lib.*"
      "cuda.*"
      # Nvidia
      "nvidia.*"
    ];

    # openblasSupport = false;
    environment.systemPackages = with pkgs; [
      # pkgs-unstable.ollama
      cudatoolkit
      freeglut
      # Python dependencies managment
      poetry

      # Add cuda binary cache
      cachix
    ];

    services.ollama = {
      package = pkgs.ollama;
      enable = true;
      host = "[::1]"; #ipv6
      port = 11434; #default
      acceleration = "cuda";
      # loadModels = ["mistral"];
      environmentVariables = {
        OLLAMA_LLM_LIBRARY = "cuda_v12";
      };
    };

    environment.sessionVariables = {
      # cli compat
      OLLAMA_API_KEY = "";
      OLLAMA_HOST = "http://[::1]:11434";
    };
    environment.variables = {
      OLLAMA_LLM_LIBRARY = "cuda_v12";
    };

    # Add cuda binary cache
    nix = {
      settings = {
        substituters = [
          "https://cuda-maintainers.cachix.org"
        ];
        trusted-public-keys = [
          "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        ];
      };
    };
  }
