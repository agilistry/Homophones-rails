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

  define_builder(Question) do |klass, overrides|
    klass.new :ask => "What is an uninterested 2x4?", :response_size => 2,
              :responses => 'bored, board'
  end
end

include Fixjour
