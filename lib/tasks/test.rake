namespace :test do
  desc "Jasmine Javascript tests"
  task :jsunits => 'spec:jasmine'
  
  desc "Rspecs"
  task :units => :spec
  
  desc "Cucumber"
  task :cucumber => 'cucumber:ok'
  
  desc "Fast suite to run before checkin"
  task :all => [:jsunits, :units, :cucumber]
end