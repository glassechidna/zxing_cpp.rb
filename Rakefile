require 'rake/clean'
require 'rake/extensiontask'
require 'rake/testtask'

spec = Gem::Specification.load('zxing_cpp.gemspec')

desc 'Regenerate Manifest.txt'
task :manifest do
  File.open('Manifest.txt', 'w') do |f|
    f.puts(spec.files)
  end
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/test*.rb', 'test/zxing/test*.rb']
  t.verbose = true
end

Gem::PackageTask.new(spec) do |pkg|
  Rake::Task[:manifest].invoke
end

task :package => :manifest

Rake::ExtensionTask.new('zxing', spec) do |ext|
  ext.lib_dir = 'lib/zxing'
end
