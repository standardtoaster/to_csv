begin
  require 'rubygems'
  require 'test/unit'
  require 'active_record'
  require 'logger'
  require 'sqlite3'
  require 'active_support'
  require 'active_support/core_ext/string/inflections.rb'
  require File.expand_path(File.join(File.dirname(__FILE__), '/../lib/to_csv.rb'))
rescue LoadError
  puts 'to_csv tests rely on fastercsv, and active_support'
  puts 'error loading one or more files'
  raise
end
 
ENV['DB'] ||= 'in_memory' 
 
def load_schema
  config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
  ActiveRecord::Base.logger = Logger.new(STDOUT)

  ActiveRecord::Base.establish_connection(config[ENV['DB']])
  load(File.dirname(__FILE__) + "/schema.rb")
end

def load_test_data
  #has no remote, but a couple dogs
  ary = User.create(:name => 'Ary', :age => 25)
  ary.dogs << Dog.create(:name => 'Rufus', :toy => Toy.create(:name => 'Bone'))
  ary.dogs << Dog.create(:name => 'Scruffy')

  #has a remote but no dogs
  nati = User.create(:name => 'Nati', :age => 22, :remote => Remote.create(:name => 'universal'))

end

class User < ActiveRecord::Base
  belongs_to :remote
  has_many :dogs
  def is_old?
    self.age > 40
  end
end

class Remote < ActiveRecord::Base
  def button_count
    5
  end
end

class Dog < ActiveRecord::Base
  has_one :toy
  def barks?
    true
  end
end

class Toy < ActiveRecord::Base
  def is_wrecked?
    false
  end
end

