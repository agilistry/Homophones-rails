require 'rspec/core/rake_task'
 
namespace :spec do
  desc "Run headless JavaScript tests with node.js"
  task :jasmine do |t|
    sh("jasmine-node spec/javascripts")
  end
end