{ stdenv, pkgs, fetchFromGitHub, buildHomeAssistantComponent, pyelectroluxconnect }:

buildHomeAssistantComponent rec {

  owner = "mauro-modolo";
  domain = "samsungtv-tizen";
  version = "1.6.1";

  src = fetchFromGitHub {
    owner = "jaruba";
    repo = "ha-samsungtv-tizen";
    rev = "v${version}";
    sha256 = "sha256-85p4eG0ePW2EI6vzksSbWLhNfkdrzCiu1KChuPwSobU=";
  };

}

