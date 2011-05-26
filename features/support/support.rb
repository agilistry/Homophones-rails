Dir['spec/support/**/*.rb'].each {|f| require f }
World(UserSpecHelpers)

Cucumber::Rails::World.use_transactional_fixtures = false
