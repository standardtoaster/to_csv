#load core requirements
require 'active_support'
require 'active_support/core_ext/string/inflections.rb'


#figure out which CSV lib to use, and load the appropriate file. 
require "csv"
if CSV.const_defined? :Reader
  require 'fastercsv'
  require File.expand_path(File.join(File.dirname(__FILE__), 'to_csv_fastercsv'))
else
  require File.expand_path(File.join(File.dirname(__FILE__), 'to_csv_csv'))
end
