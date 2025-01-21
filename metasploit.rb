require "formula"

class MetasploitFramework < Formula
  homepage "https://github.com/rapid7/metasploit-framework"
  url "https://github.com/rapid7/metasploit-framework", :using => :git, :tag => '0e72da6'
  version "6-0e72da6"

  depends_on "ruby"
  depends_on "openssl"
  depends_on "libxml2"
  depends_on "libxslt"
  depends_on "sqlite"
  depends_on "postgresql"

  resource "bundler" do
    url "https://rubygems.org/gems/rubygems-update-3.6.3.gem"
    sha256 "6a46f9876e0ed8b5d9d1bd789b0c3308490eb5e7d21d0571ab4ef2d64211bb4f"
  end

  def install
    (buildpath/"vendor/bundle").mkpath
    resources.each do |r|
      r.verify_download_integrity(r.fetch)
      system("gem", "install", r.cached_download, "--no-document",
             "--install-dir", "vendor/bundle")
    end

    ENV["GEM_HOME"] = "#{buildpath}/vendor/bundle"
    system "ruby", "#{buildpath}/vendor/bundle/bin/bundle", "install",
           "--no-cache", "--path", "vendor/bundle"

    (bin/"msfconsole").write <<~EOS
      #!/usr/bin/env bash
      export GEM_HOME="#{pkgshare}/vendor/bundle"
      export BUNDLE_GEMFILE="#{pkgshare}/Gemfile"
      #{pkgshare}/vendor/bundle/bin/bundle exec ruby #{pkgshare}/msfconsole "$@"
    EOS
    (bin/"msfd").write <<~EOS
      #!/usr/bin/env bash
      export GEM_HOME="#{pkgshare}/vendor/bundle"
      export BUNDLE_GEMFILE="#{pkgshare}/Gemfile"
      #{pkgshare}/vendor/bundle/bin/bundle exec ruby #{pkgshare}/msfd "$@"
    EOS
    (bin/"msfdb").write <<~EOS
      #!/usr/bin/env bash
      export GEM_HOME="#{pkgshare}/vendor/bundle"
      export BUNDLE_GEMFILE="#{pkgshare}/Gemfile"
      #{pkgshare}/vendor/bundle/bin/bundle exec ruby #{pkgshare}/msfdb "$@"
    EOS
    (bin/"msfrpc").write <<~EOS
      #!/usr/bin/env bash
      export GEM_HOME="#{pkgshare}/vendor/bundle"
      export BUNDLE_GEMFILE="#{pkgshare}/Gemfile"
      #{pkgshare}/vendor/bundle/bin/bundle exec ruby #{pkgshare}/msfrpc "$@"
    EOS
    (bin/"msfrpcd").write <<~EOS
      #!/usr/bin/env bash
      export GEM_HOME="#{pkgshare}/vendor/bundle"
      export BUNDLE_GEMFILE="#{pkgshare}/Gemfile"
      #{pkgshare}/vendor/bundle/bin/bundle exec ruby #{pkgshare}/msfrpcd "$@"
    EOS
    (bin/"msfupdate").write <<~EOS
      #!/usr/bin/env bash
      export GEM_HOME="#{pkgshare}/vendor/bundle"
      export BUNDLE_GEMFILE="#{pkgshare}/Gemfile"
      #{pkgshare}/vendor/bundle/bin/bundle exec ruby #{pkgshare}/msfupdate "$@"
    EOS
    (bin/"msfvenom").write <<~EOS
      #!/usr/bin/env bash
      export GEM_HOME="#{pkgshare}/vendor/bundle"
      export BUNDLE_GEMFILE="#{pkgshare}/Gemfile"
      #{pkgshare}/vendor/bundle/bin/bundle exec ruby #{pkgshare}/msfvenom "$@"
    EOS

    pkgshare.install Dir['*']
    pkgshare.install ".git"
    pkgshare.install ".bundle"
  end
end
