class Pocl < Formula
  homepage "http://pocl.sourceforge.net"
  url "https://downloads.sourceforge.net/project/pocl/pocl-0.10.tar.gz"
  sha256 "e9c38f774a77e61f66d850b705a5ba42d49356c40e75733db4c4811e091e5088"

  bottle do
    sha256 "b79e64fe8bfeb42cc7a931fb67f6f02976f6d30798f4af928a32ee35eaa527d2" => :yosemite
    sha256 "121b57ea1adeedc3c4523750ed9def5be63a54d147b8d30c85d612e2213224c3" => :mavericks
  end

  option "without-check", "Skip build-time tests (not recommended)"

  depends_on "pkg-config" => :build
  depends_on "hwloc"

  if OS.linux? || MacOS.version > :mountain_lion
    depends_on "llvm" => ["with-clang", "with-rtti"]
  else
    depends_on "homebrew/versions/llvm34"
  end

  depends_on "libtool" => :run
  depends_on "autoconf" => :build if build.with? "check"

  # Check if ndebug flag is required for compiling pocl didn"t work on osx.
  # https://github.com/pocl/pocl/pull/65
  patch do
    url "https://github.com/pocl/pocl/commit/fa86bf.diff"
    sha256 "243f07ebe1200cf0b2cc99c0519572be5bdb8f7104e657fbecf3433e0ac3150a"
  end

  def install
    ENV.j1
    system "./configure", "--disable-debug",
                          "--enable-direct-linkage",
                          "--disable-icd",
                          "--enable-testsuites=",
                          "--prefix=#{prefix}"
    system "make", "prepare-examples" if build.with? "check"
    system "make", "check" if build.with? "check"
    system "make", "install"
  end
end
