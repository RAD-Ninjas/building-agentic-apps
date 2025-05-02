# To learn more about how to use Nix to configure your environment
# see: https://firebase.google.com/docs/studio/customize-workspace
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-24.05"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.jdk17
    pkgs.unzip
  ];
  # Sets environment variables in the workspace
  env = {
    GEMINI_API_KEY = "";
    OPEN_WEATHER_API_KEY = "";
    UNSPLASH_ACCESS_KEY = "";
    PORT = "8080";
  };
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      "Dart-Code.flutter"
      "Dart-Code.dart-code"
    ];
    workspace = {
      # Runs when a workspace is first created with this `dev.nix` file
      onCreate = {
        install-genkit-dependencies = ''
          cd genkit_flutter_agentic_app/genkit_backend
          npm install
        '';
      };

      # onStart = {
      #   start-genkit = ''
      #     cd genkit_flutter_agentic_app/genkit_backend

      #     npx genkit start -o -- node src/app.js
      #   '';
      # };
      
      # To run something each time the workspace is (re)started, use the `onStart` hook
    };
    # Enable previews and customize configuration
    previews = {
      enable = true;
      previews = {
        # web = {
        #   command = ["flutter" "run" "--machine" "-d" "web-server" "--web-hostname" "0.0.0.0" "--web-port" "$PORT"];
        #   manager = "flutter";
        # };
        android = {
          command = [
            "bash" "-c"
            "cd genkit_flutter_agentic_app/flutter_frontend && flutter run --machine -d android -d localhost:5555"
          ];
          manager = "flutter";
        };
      };
    };
  };
}
