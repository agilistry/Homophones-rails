require 'fixjour'

Fixjour do
  define_builder(HomophoneSet) do |klass, overrides|
    klass.new :homophones => [
      Homophone.new(:name => 'a'), Homophone.new(:name => 'eh')
    ]
  end

  define_builder(Homophone) do |klass, overrides|
    klass.new :name => "a", :definition => "short little word"
  end
end

include Fixjour
