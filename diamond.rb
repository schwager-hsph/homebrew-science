class Diamond < Formula
  desc "Accelerated BLAST compatible local sequence aligner"
  homepage "http://ab.inf.uni-tuebingen.de/software/diamond/"
  # doi "10.1038/nmeth.3176"
  # tag "bioinformatics"

  url "https://github.com/bbuchfink/diamond/archive/v0.7.9.tar.gz"
  sha256 "25dc43e41768f7a41c98b8b1dcf5aa2c51c0eaf62e71bff22ad01c97b663d341"

  depends_on "wget" => :build

  def install
    Dir.chdir("src") do
      system "./install-boost"
      system "make"
    end
    bin.install "bin/diamond"
    doc.install "README.rst"
  end

  test do
    assert_match "gapextend", shell_output("diamond -h 2>&1", 0)
  end
end
