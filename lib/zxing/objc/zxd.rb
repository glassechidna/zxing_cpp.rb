framework 'AppKit'
framework 'QTKit'
framework 'QuartzCore'
framework 'CoreVideo'

class AppDelegate
  def initialize options
    @options = options
  end
  def applicationDidFinishLaunching(notification)
    @window = NSWindow.alloc.initWithContentRect([200, 300, 640, 480],
                                                 styleMask:
                                                 NSTitledWindowMask|
                                                 NSClosableWindowMask|
                                                 NSMiniaturizableWindowMask,
                                                 backing:NSBackingStoreBuffered,
                                                 defer:false)
    capture = ::ZXCapture.alloc.init

    if @options[:preview]
      @window.title = 'ZXing'
      @window.level = NSNormalWindowLevel
      @window.delegate = self

      @window.display
      @window.orderFrontRegardless
      @window.makeMainWindow
      @window.makeKeyWindow

      main = CALayer.layer
      main.position = [0, 0]
      main.bounds = @window.contentView.bounds
      @window.contentView.layer = main
      @window.contentView.wantsLayer = true

      capture.layer.frame = @window.contentView.bounds

      if @options[:show_luminance]
        capture.showLuminance = true
      end

      if @options[:show_binary]
        capture.showBinary = true
      end

      main.addSublayer capture.layer
    end

    capture.delegate = self
  end

  def captureResult capture, result:result
    if @options[:continuous]
      @count ||= 0
      print "#{@count+=1} "
    end
    puts result.text
    if !@options[:continuous]
      capture.delegate = nil
      capture.layer.removeFromSuperlayer
      exit
    end
  end

end
