begin
  require 'rubygems'
  require 'test/unit'
  require 'active_support'
  require 'active_support/core_ext/string/inflections.rb'
  require File.expand_path(File.join(File.dirname(__FILE__), '/../lib/to_csv.rb'))
rescue LoadError
  puts 'to_csv tests rely on fastercsv, and active_support'
  puts 'error loading one or more files'
  raise
end

class User
  COLUMNS = %w(id name age)
  
  attr_accessor *COLUMNS

  def self.human_attribute_name(attribute)
    attribute.to_s.humanize
  end

  def initialize(params={})
    params.each { |key, value| self.send("#{key}=", value); }
    self
  end

  def attributes
    COLUMNS.inject({}) { |attributes, attribute| attributes.merge(attribute => send(attribute)) }
  end

  def is_old?
    age > 40
  end
  
  @dogs = []
  
  def dogs
    @dogs
  end
  
  def set_dogs(dogs)
    @dogs=dogs
  end
    
end
class RemoteControl
  COLUMNS = %w(id name age)
  
  attr_accessor *COLUMNS

  def self.human_attribute_name(attribute)
    attribute.to_s.humanize
  end

  def initialize(params={})
    params.each { |key, value| self.send("#{key}=", value); }
    self
  end

  def attributes
    COLUMNS.inject({}) { |attributes, attribute| attributes.merge(attribute => send(attribute)) }
  end

  def has_buttons?
    true
  end
      
end
class Dog
  COLUMNS = %w(id name)
  
  attr_accessor *COLUMNS

  def self.human_attribute_name(attribute)
    attribute.to_s.humanize
  end

  def initialize(params={})
    params.each { |key, value| self.send("#{key}=", value); }
    self
  end

  def attributes
    COLUMNS.inject({}) { |attributes, attribute| attributes.merge(attribute => send(attribute)) }
  end
  
  
  
  def bark?
    true
  end
end
class Toy
  COLUMNS = %w(id name)
  
  attr_accessor *COLUMNS

  def self.human_attribute_name(attribute)
    attribute.to_s.humanize
  end

  def initialize(params={})
    params.each { |key, value| self.send("#{key}=", value); }
    self
  end

  def attributes
    COLUMNS.inject({}) { |attributes, attribute| attributes.merge(attribute => send(attribute)) }
  end

  def is_wrecked?
    true
  end
end