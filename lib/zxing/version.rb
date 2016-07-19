module ZXing
  VERSION = "0.1.1" unless defined?(::ZXing::VERSION)

  VERSION_INFO = {}
  VERSION_INFO['warnings']              = []
  VERSION_INFO['ruby']                  = {}
  VERSION_INFO['ruby']['version']       = ::RUBY_VERSION
  VERSION_INFO['ruby']['platform']      = ::RUBY_PLATFORM
  VERSION_INFO['ruby']['engine']        = defined?(RUBY_ENGINE) ? RUBY_ENGINE : 'mri'

  if defined?(LIBZXING_VERSION)
    VERSION_INFO['libzxing']              = {}
    VERSION_INFO['libzxing']['binding']   = 'extension'
    VERSION_INFO['libzxing']['compiled']  = LIBZXING_VERSION
    VERSION_INFO['libzxing']['loaded']    = LIBZXING_PARSER_VERSION.scan(/^(.*)(..)(..)$/).first.collect{|j|j.to_i}.join(".")

    if VERSION_INFO['libzxing']['compiled'] != VERSION_INFO['libzxing']['loaded']
      warning = "ZXing was built against Libzxing version #{VERSION_INFO['libzxing']['compiled']}, but has dynamically loaded #{VERSION_INFO['libzxing']['loaded']}"
      VERSION_INFO['warnings'] << warning
      warn "WARNING: #{warning}"
    end
  end

  def self.uses_libzxing? # :nodoc:
    !ZXing::VERSION_INFO['libzxing'].nil?
  end

  def self.jruby?
    !ZXing::VERSION_INFO['ruby']['jruby'].nil?
  end


end
