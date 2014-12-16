# -*- ruby -*-

require 'rake/clean'

require 'rubygems'

CLEAN.concat Dir["**/*.a"]
CLEAN.concat Dir["**/*.so"]
CLEAN.concat Dir["**/*.bundle"]
CLEAN.concat Dir["**/*.dylib"]
CLEAN.concat Dir["**/*.pyc"]
CLEAN.concat Dir["lib/zxing/Makefile"]
CLEAN.concat Dir["lib/zxing/zxing.o"]
CLEAN.concat Dir["**/build"]

shared_ext = ".so"
Dir["lib/zxing/zxing.*"].each do |file|
  case file
  when %r{\.so$}; shared_ext = ".so"
  when %r{\.dylib$}; shared_ext = ".dylib"
  when %r{\.bundle$}; shared_ext = ".bundle"
  end
end

file "vendor/zxing-cpp" do
  sh "git submodule update --init --recursive"
end

task :compile => "vendor/zxing-cpp"

CPP_BUILD_DIR = "vendor/zxing-cpp/build"
ZXING_CPP_LIB = "#{CPP_BUILD_DIR}/libzxing.a"
SHARED_LIB = "lib/zxing/zxing#{shared_ext}"

task :clean do
  rm_rf CPP_BUILD_DIR if File.exist? CPP_BUILD_DIR
end

# ZXing C++ static library

file "#{CPP_BUILD_DIR}/Makefile" => "vendor/zxing-cpp/CMakeLists.txt" do
  Dir.mkdir CPP_BUILD_DIR unless File.exist? CPP_BUILD_DIR
  Dir.chdir CPP_BUILD_DIR do
    sh "cmake -DBUILD_SHARED_LIBS:BOOL=OFF .."
  end
end

file ZXING_CPP_LIB => Dir["vendor/zxing-cpp/core/src/**/*.{h,cpp}"] + ["#{CPP_BUILD_DIR}/Makefile"] do
  Dir.chdir CPP_BUILD_DIR do
    sh "make"
  end
end

# FFI friendly C shared library

file "lib/zxing/Makefile" => [ "lib/zxing/extconf.rb", ZXING_CPP_LIB ] do
  Dir.chdir "lib/zxing" do
    ruby "extconf.rb"
  end
end

file SHARED_LIB => [ "lib/zxing/Makefile", "lib/zxing/zxing.cc", ZXING_CPP_LIB ] do
  Dir.chdir "lib/zxing" do
    sh "make"
  end
end

task :recompile do
  Rake::Task["clean"].invoke
  Rake::Task["compile"].invoke
end

desc "compile zxing shared library"
task :compile => SHARED_LIB

task(:default).clear
task :default => :compile
