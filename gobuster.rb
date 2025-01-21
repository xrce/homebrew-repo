require "language/go"

class Gobuster < Formula
  homepage "https://github.com/OJ/gobuster"
  url "https://github.com/OJ/gobuster", :using => :git, :revision => "308cf9f"
  version "3.6.0-308cf9f"

  depends_on "go" => :build

  go_resource "github.com/satori/go.uuid" do
    url "https://github.com/satori/go.uuid.git", :revision => "b2ce238"
  end

  go_resource "golang.org/x/crypto" do
    url "https://go.googlesource.com/crypto.git", :revision => "a8ea4be"
  end

  def install
    ENV["GOPATH"] = buildpath
    Language::Go.stage_deps resources, buildpath/"src"

    system "go", "build", "-o", bin/"gobuster"
  end
end
