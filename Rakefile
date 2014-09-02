require 'rake/testtask'

Rake::TestTask.new(:default) do |t|
  t.test_files = FileList['test/test_*.rb']
end

desc "Run all tests"
task :default => :test
