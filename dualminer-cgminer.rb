require 'formula'

class Cgminer < Formula
  homepage 'https://github.com/baseboxorg/dualminer-cgminer'
  head 'https://github.com/baseboxorg/dualminer-cgminer.git', :branch => 'master'
  url 'https://github.com/baseboxorg/dualminer-cgminer/archive/1.0.0.tar.gz'
  sha256 '3cea48e26bab0ae99976818cbb9812692cb4030db8307cdc9f13505f094a39c5'

  depends_on 'autoconf' => :build
  depends_on 'automake' => :build
  depends_on 'libtool' => :build
  depends_on 'pkg-config' => :build
  depends_on 'coreutils' => :build
  depends_on 'curl'

  def install
    inreplace "autogen.sh", "libtoolize", "glibtoolize"
    system "autoreconf -fvi"
    system "./autogen.sh", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "PKG_CONFIG_PATH=#{HOMEBREW_PREFIX}/opt/curl/lib/pkgconfig:#{HOMEBREW_PREFIX}/opt/jansson/lib/pkgconfig:#{HOMEBREW_PREFIX}/opt/libusb/lib/pkgconfig",
                          "--enable-dualminer",
                          "--enable-scrypt",
                          "--disable-opencl"
                      
    system "make", "install"
  end

  test do
    system "dualminer-cgminer"
  end
end
