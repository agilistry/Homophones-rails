require 'fixjour'

Fixjour do
  define_builder(HomophoneSet) do |klass, overrides|
    klass.new :homophones => [
      Homophone.new(:name => 'a'), Homophone.new(:name => 'eh')
    ]
  end
end

include Fixjour