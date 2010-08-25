framework 'AppKit'
framework 'QTKit'
framework 'QuartzCore'
framework 'CoreVideo'

class AppDelegate
  def initialize options
    @options = options
  end
  def applicationDidFinishLaunching(notification)
    trap "INT" do
      NSApplication.sharedApplication.
        performSelectorOnMainThread :"terminate:", withObject:self, waitUntilDone:false
    end

    @mask = NSTitledWindowMask|
      NSClosableWindowMask|
      NSMiniaturizableWindowMask|
      NSResizableWindowMask
    frame = NSWindow.frameRectForContentRect [0, 0, 640, 480 ], styleMask:@mask
    @window = NSWindow.alloc.initWithContentRect(frame,
                                                 styleMask:@mask,
                                                 backing:NSBackingStoreBuffered,
                                                 defer:false)

    
    @window.center


    @window.setFrameAutosaveName "SomeWindow"
    @window.setFrameUsingName "SomeWindow"

    @capture = capture = ::ZXCapture.alloc.init

    if @options[:preview]
      @window.title = 'ZXing'
      @window.level = NSNormalWindowLevel
      @window.delegate = self

      @window.display
      @window.orderFrontRegardless
      @window.makeMainWindow
      @window.makeKeyWindow

      capture.layer.frame = NSWindow.contentRectForFrameRect @window.contentView.frame, styleMask:@mask

      if @options[:show_luminance]
        capture.showLuminance = true
      end

      if @options[:show_binary]
        capture.showBinary = true
      end

      # main.addSublayer capture.layer
      @window.contentView.layer = capture.layer
      @window.contentView.wantsLayer = true
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
      # capture.delegate = nil
      # capture.layer.removeFromSuperlayer
      capture.stop
      NSApplication.sharedApplication.
        performSelectorOnMainThread :"terminate:", withObject:self, waitUntilDone:false
    end
  end

  def size_window
    frame = NSWindow.frameRectForContentRect @new_frame, styleMask:@mask
    @window.setFrame frame, display:true
    @window.setContentAspectRatio [@new_frame.size.width, @new_frame.size.height]
  end

  def captureSize capture, width:width, height:height
    # p "CS", width, height
    video_ar = 1.0*width/height
    window_ar = @window.frame.size.width/@window.frame.size.height
    if (video_ar-window_ar).abs > 0.001
      @new_frame = @window.frame
      if video_ar > window_ar
        @new_frame.size.height = @new_frame.size.width/video_ar
      else
        @new_frame.size.width = @new_frame.size.height*video_ar
      end
      performSelectorOnMainThread :size_window, withObject:self, waitUntilDone:false
    end
  end

  def applicationShouldTerminateAfterLastWindowClosed app
    true
  end

  def windowWillResize window, toSize:size
    frame = [0, 0, size.width, size.height]
    NSWindow.contentRectForFrameRect frame, styleMask:@mask
    @capture.layer.frame = frame
    size
  end

  # esc %f %w %q

end
