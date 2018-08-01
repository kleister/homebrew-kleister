require "formula"
require "language/go"
require "fileutils"
require "open-uri"

class KleisterApi < Formula
  desc "Manage mod packs for Minecraft - API"
  homepage "https://github.com/kleister/kleister-api"

  head do
    url "https://github.com/kleister/kleister-api.git", :branch => "master"
    depends_on "go" => :build
  end

  stable do
    url "https://dl.webhippie.de/kleister/api/0.1.0/kleister-api-0.1.0-darwin-10.6-amd64"
    sha256 begin
      open("https://dl.webhippie.de/kleister/api/0.1.0/kleister-api-0.1.0-darwin-10.6-amd64.sha256").read.split(" ").first
    rescue
      nil
    end
    version "0.1.0"
  end

  devel do
    url "https://dl.webhippie.de/kleister/api/master/kleister-api-master-darwin-10.6-amd64"
    sha256 begin
      open("https://dl.webhippie.de/kleister/api/master/kleister-api-master-darwin-10.6-amd64.sha256").read.split(" ").first
    rescue
      nil
    end
    version "master"
  end

  test do
    system "#{bin}/kleister-api", "--version"
  end

  def install
    case
    when build.head?
      ENV["GOPATH"] = buildpath
      ENV["GOHOME"] = buildpath
      ENV["CGO_ENABLED"] = 1
      ENV["TAGS"] = ""

      ENV.prepend_create_path "PATH", buildpath/"bin"

      currentpath = buildpath/"src/github.com/kleister/kleister-api"
      currentpath.install Dir["*"]
      Language::Go.stage_deps resources, buildpath/"src"

      cd currentpath do
        system "make", "test", "build"

        bin.install "kleister-api"
        # bash_completion.install "contrib/bash-completion/_kleister-api"
        # zsh_completion.install "contrib/zsh-completion/_kleister-api"
        prefix.install_metafiles
      end
    when build.devel?
      bin.install "#{buildpath}/kleister-api-master-darwin-10.6-amd64" => "kleister-api"
    else
      bin.install "#{buildpath}/kleister-api-0.1.0-darwin-10.6-amd64" => "kleister-api"
    end

    FileUtils.touch("kleister-api.conf")
    etc.install "kleister-api.conf" => "kleister-api.conf"
  end

  plist_options :startup => true

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>EnvironmentVariables</key>
          <dict>
            <key>KLEISTER_ENV_FILE</key>
            <string>#{etc}/kleister-api.conf</string>
          </dict>
          <key>ProgramArguments</key>
          <array>
            <string>#{opt_bin}/kleister-api</string>
            <string>server</string>
          </array>
          <key>RunAtLoad</key>
          <true/>
          <key>KeepAlive</key>
          <true/>
        </dict>
      </plist>
    EOS
  end
end
