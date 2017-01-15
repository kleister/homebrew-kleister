require "formula"
require "language/go"

class KleisterCli < Formula
  desc "Manage mod packs for Minecraft - CLI"
  homepage "https://github.com/kleister/kleister-cli"

  stable do
    url "http://dl.webhippie.de/kleister-cli/0.1.0/kleister-cli-0.1.0-darwin-10.6-amd64"
    sha256 `curl -Ls http://dl.webhippie.de/kleister-cli/0.1.0/kleister-cli-0.1.0-darwin-10.6-amd64.sha256`.split(" ").first
    version "0.1.0"
  end

  devel do
    url "http://dl.webhippie.de/kleister-cli/master/kleister-cli-master-darwin-10.6-amd64"
    sha256 `curl -Ls http://dl.webhippie.de/kleister-cli/master/kleister-cli-master-darwin-10.6-amd64.sha256`.split(" ").first
    version "master"
  end

  head do
    url "https://github.com/kleister/kleister-cli.git", :branch => "master"
    depends_on "go" => :build
  end

  test do
    system "#{bin}/kleister-cli", "--version"
  end

  def install
    case
    when build.head?
      ENV["GOPATH"] = buildpath
      ENV["GOHOME"] = buildpath
      ENV["CGO_ENABLED"] = 0
      ENV["TAGS"] = ""

      ENV.append_path "PATH", buildpath/"bin"

      currentpath = buildpath/"src/github.com/kleister/kleister-cli"
      currentpath.install Dir["*"]
      Language::Go.stage_deps resources, buildpath/"src"

      cd currentpath do
        system "make", "test", "build"

        bin.install "kleister-cli"
        # bash_completion.install "contrib/bash-completion/_kleister-cli"
        # zsh_completion.install "contrib/zsh-completion/_kleister-cli"
      end
    when build.devel?
      bin.install "#{buildpath}/kleister-cli-master-darwin-10.6-amd64" => "kleister-cli"
    else
      bin.install "#{buildpath}/kleister-cli-0.1.0-darwin-10.6-amd64" => "kleister-cli"
    end
  end
end
