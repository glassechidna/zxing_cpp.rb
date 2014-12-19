= zxing_cpp

* https://github.com/glassechidna/zxing_cpp.rb

== DESCRIPTION:

zxing_cpp is a Ruby interface for the ZXing C++ barcode and QR code library.

It is a light-weight fork of zxing.rb (https://github.com/smparkes/zxing.rb).

== FEATURES:

* Wraps the ZXing C++ library (https://github.com/glassechidna/zxing-cpp)

== SUPPORT:

The {bug tracker}[https://github.com/glassechidna/zxing_cpp.rb/issues] is available here:

   https://github.com/glassechidna/zxing_cpp.rb/issues

== SYNOPSIS:

  require 'zxing'
  result = ZXing.decode "myimage.png"

zxing_cpp also comes with a command that decodes images: zxd:

  $ zxd filename.png
  <decoded contents>

+zxd+ can take multiple arguments and the arguments can be URLs.

zxing_cpp provides access to many of the classes of ZXing classes like
readers, luminance sources, binarizers, so you can mix and match your
own applications much as you would with a native Java or C++ app. See
+zxd+ and +test/vendor.rb+ for examples.

NOTE: There is a proto-encoder (zxe) in the works but the C wrapper code
is yet to be written.

=== Using the ZXing module

    require 'zxing'

    # You can decode a URL...
    ZXing.decode 'http://2d-code.co.uk/images/bbc-logo-in-qr-code.gif'

    # ... or a file path...
    ZXing.decode '/Users/ecin/qrcode.png'

    # ... or a File object...
    ZXing.decode File.open('qrcode.png')

    # ... or anything that returns a URL or file path when #path or #to_s 
    # is called on it.
    class Image
      attr_reader :path
      def initialize(path); @path = path end
    end

    image = Image.new('qrcode.png')
    ZXing.decode image
      
    # #decode returns nil if it can't decode the image.
    ZXing.decode 'image_without_a_code.png'
    # => nil

    # #decode! will raise an error if it can't decode the image.
    ZXing.decode! 'image_without_a_code.png'
    # => NativeException

    # Feel free to include ZXing to shorten the call.
    include ZXing

    decode 'qrcode.png'

=== Including the Decodable module

     require 'zxing/decodable'

     class File
       include Decodable
     end

     file = File.open('qrcode.png')
     file.decode

== REQUIREMENTS:

* Ruby (>= 1.9)
* CMake (>= 2.8.0)

zxing_cpp bundles a version of the ZXing C++ library (zxing-cpp).

== INSTALL:

If you're using RubyGems (probably), then simply add the following to your <tt>Gemfile</tt>:

    gem 'zxing_cpp'

Alternatively, you could clone the {zxing_cpp repo}[https://github.com/glassechidna/zxing_cpp.rb] and execute:

  rake gem
  gem install pkg/zxing_cpp-0.1.0.gem

== DEVELOPMENT:

  rake test

<tt>rake test</tt> runs the zxing_cpp unit tests.

== LICENSE:

(The MIT License)

Copyright (c) 2011 {Steven Parkes}[http://github.com/smparkes]

Copyright (c) 2014 {Benjamin Dobell}[http://github.com/Benjamin-Dobell], {Glass Echidna Pty Ltd}[http://github.com/glassechidna]

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
