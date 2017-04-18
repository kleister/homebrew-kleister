require "formula"
require "language/node"
require "language/go"

class KleisterUi < Formula
  desc "Manage mod packs for Minecraft - UI"
  homepage "https://github.com/kleister/kleister-ui"

  stable do
    url "https://dl.webhippie.de/kleister/ui/0.1.0/kleister-ui-0.1.0-darwin-10.6-amd64"
    sha256 `curl -Ls https://dl.webhippie.de/kleister/ui/0.1.0/kleister-ui-0.1.0-darwin-10.6-amd64.sha256`.split(" ").first
    version "0.1.0"
  end

  devel do
    url "https://dl.webhippie.de/kleister/ui/master/kleister-ui-master-darwin-10.6-amd64"
    sha256 `curl -Ls https://dl.webhippie.de/kleister/ui/master/kleister-ui-master-darwin-10.6-amd64.sha256`.split(" ").first
    version "master"
  end

  head do
    url "https://github.com/kleister/kleister-ui.git", :branch => "master"
    depends_on "go" => :build
    depends_on "node" => :build
  end

  go_resource "github.com/UnnoTed/fileb0x" do
    url "https://github.com/UnnoTed/fileb0x.git",
      :revision => "c1bd5476f1cb44cdc21780d954cefb2155e8a325"
  end

  test do
    system "#{bin}/kleister-ui", "--version"
  end

  def install
    case
    when build.head?
      ENV["GOPATH"] = buildpath
      ENV["GOHOME"] = buildpath
      ENV["CGO_ENABLED"] = 0
      ENV["TAGS"] = ""

      ENV.prepend_create_path "PATH", buildpath/"bin"

      currentpath = buildpath/"src/github.com/kleister/kleister-ui"
      currentpath.install Dir["*"]
      Language::Go.stage_deps resources, buildpath/"src"

      %w[src/github.com/UnnoTed/fileb0x].each do |path|
        cd(path) { system "go", "install" }
      end

      cd currentpath do
        system "npm", "install", *Language::Node.std_npm_install_args(libexec)
        system "npm", "run", "build"

        system "make", "generate", "test", "build"

        bin.install "kleister-ui"
        # bash_completion.install "contrib/bash-completion/_kleister-ui"
        # zsh_completion.install "contrib/zsh-completion/_kleister-ui"
        prefix.install_metafiles
      end
    when build.devel?
      bin.install "#{buildpath}/kleister-ui-master-darwin-10.6-amd64" => "kleister-ui"
    else
      bin.install "#{buildpath}/kleister-ui-0.1.0-darwin-10.6-amd64" => "kleister-ui"
    end
  end
end
