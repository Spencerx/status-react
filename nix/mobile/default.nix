{ config, stdenv, pkgs, target-os ? "all" }:

with pkgs;
with stdenv;

let
  gradle = gradle_4_10;
  platform = pkgs.callPackage ../platform.nix { inherit target-os; };
  xcodewrapperArgs = {
    version = "10.1";
  };
  android = callPackage ./android.nix { inherit config; };

in
  {
    inherit (android) androidComposition;
    inherit xcodewrapperArgs;

    buildInputs = lib.optional platform.targetAndroid android.buildInputs;
    shellHook = lib.optionalString platform.targetAndroid android.shellHook;
  }
