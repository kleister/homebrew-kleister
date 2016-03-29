require "securerandom"

class SolderCli < Formula
  homepage "https://github.com/solderapp/solder-cli"
  url "http://dl.webhippie.de/solder-cli/v0.0.1/solder-cli-0.0.1-darwin-amd64"
  sha256 `curl -s http://dl.webhippie.de/solder-cli/v0.0.1/solder-cli-0.0.1-darwin-amd64.sha256`.split(" ").first

  head do
    url "https://github.com/solderapp/solder-cli.git", :branch => "master"

    depends_on "go" => :build
    depends_on "mercurial" => :build
    depends_on "bzr" => :build
    depends_on "git" => :build
  end

  test do
    system "#{bin}/solder-cli", "version"
  end

  def install
    if build.head?
      solder_build_home = "/tmp/#{SecureRandom.hex}"
      solder_build_path = File.join(solder_build_home, "src", "github.com", "solderapp", "solder-cli")

      ENV["GOPATH"] = solder_build_home
      ENV["GOHOME"] = solder_build_home

      mkdir_p solder_build_path

      system("cp -R #{buildpath}/* #{solder_build_path}")
      ln_s File.join(cached_download, ".git"), File.join(solder_build_path, ".git")

      Dir.chdir solder_build_path

      system "make", "deps"
      system "make", "build"

      bin.install "#{solder_build_path}/bin/drone-cli" => "drone-cli"
      Dir.chdir buildpath
    else 
      bin.install "#{buildpath}/drone-cli" => "drone-cli"
    end
  ensure
    rm_rf solder_build_home if build.head?
  end
end
