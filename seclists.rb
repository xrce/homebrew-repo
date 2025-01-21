require "formula"

class SecLists < Formula
  homepage "https://github.com/danielmiessler/SecLists"
  url "https://github.com/danielmiessler/SecLists", :using => :git, :revision => "288328a"
  head "https://github.com/danielmiessler/SecLists", :using => :git, :branch => "master"
  version "2024.4-288328a"

  def install
    pkgshare.install Dir["*"]
  end

  def caveats; <<~EOS
    The SecLists lists can be found in #{HOMEBREW_PREFIX}/share/seclists
    EOS
  end
end
