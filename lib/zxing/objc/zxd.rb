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

    return

    @session  =  QTCaptureSession.alloc.init

    device = QTCaptureDevice.defaultInputDeviceWithMediaType QTMediaTypeVideo
    device.open nil
    input = QTCaptureDeviceInput.deviceInputWithDevice device
    @session.addInput input, error:nil

    output = QTCaptureDecompressedVideoOutput.alloc.init
    output.automaticallyDropsLateVideoFrames = true
    output.delegate = self

    key = KCVPixelBufferPixelFormatTypeKey
    value = NSNumber.numberWithUnsignedInt KCVPixelFormatType_32BGRA
    pixelBufferAttributes = NSDictionary.dictionaryWithObject value, forKey:key
    pixelBufferAttributes = {KCVPixelBufferPixelFormatTypeKey:KCVPixelFormatType_32BGRA}
    output.pixelBufferAttributes = pixelBufferAttributes
    @session.addOutput output, error:nil
    
    capture = QTCaptureLayer.alloc.initWithSession @session
    capture.frame = @window.contentView.frame
    mirror = CGAffineTransformMakeScale -1, 1
    capture.affineTransform = mirror
    main.addSublayer capture

    frame = @window.contentView.frame
    frame.origin.x = frame.size.width - frame.size.width*0.2;
    frame.origin.y = 0;
    frame.size.width = frame.size.width*0.2;
    frame.size.height = frame.size.height*0.2;

    @luminanceView = NSImageView.alloc.initWithFrame frame
    @luminanceView.autoresizingMask = NSViewWidthSizable|NSViewHeightSizable
    @window.contentView.addSubview @luminanceView

    frame.origin.y += frame.size.height;
    @binarizedView = NSImageView.alloc.initWithFrame frame

    @binarizedView.autoresizingMask = NSViewWidthSizable|NSViewHeightSizable
    @window.contentView.addSubview @binarizedView

    @session.startRunning
  end

  def captureResult capture, result:result
    p "capture result", capture, result
    return !!@options[:continuous]
  end

end
