require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs = ["lib"]
  # t.warning = false # <-- Scarlet added this to eleminate our minitest circular warnings
  t.test_files = FileList["specs/*_spec.rb"]
end

task default: :test
