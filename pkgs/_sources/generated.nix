# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  fcitx5-pinyin-moegirl = {
    pname = "fcitx5-pinyin-moegirl";
    version = "20231114";
    src = fetchurl {
      url = "https://github.com/outloudvi/mw2fcitx/releases/download/20231114/moegirl.dict";
      sha256 = "sha256-x+XkATiNMNbcSiN87MkRRvKiNuzvpmkDrtGkwdnIsYM=";
    };
  };
  fcitx5-pinyin-zhwiki = {
    pname = "fcitx5-pinyin-zhwiki";
    version = "20231205";
    src = fetchurl {
      url = "https://github.com/felixonmars/fcitx5-pinyin-zhwiki/releases/download/0.2.4/zhwiki-20231205.dict";
      sha256 = "sha256-crMmSqQ7QgmjgEG8QpvBgQYfvttCUsKYo8gHZGXIZmc=";
    };
  };
  rime-ice = {
    pname = "rime-ice";
    version = "8f98f0d1c9176ce005ad76043db7f55096583675";
    src = fetchFromGitHub {
      owner = "iDvel";
      repo = "rime-ice";
      rev = "8f98f0d1c9176ce005ad76043db7f55096583675";
      fetchSubmodules = false;
      sha256 = "sha256-ye4neNSmar42XYMKqZ9vqOR8hZjXYR/eSUkwQ7eScR4=";
    };
    date = "2023-12-03";
  };
}
