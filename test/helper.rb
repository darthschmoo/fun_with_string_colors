require "fun_with_testing"
# require 'simplecov'
# 
# module SimpleCov::Configuration
#   def clean_filters
#     @filters = []
#   end
# end
# 
# SimpleCov.configure do
#   clean_filters
#   load_adapter 'test_frameworks'
# end
# 
# ENV["COVERAGE"] && SimpleCov.start do
#   add_filter "/.rvm/"
# end
# 
# require 'rubygems'
# require 'bundler'

# begin
#   Bundler.setup(:default, :development)
# rescue Bundler::BundlerError => e
#   $stderr.puts e.message
#   $stderr.puts "Run `bundle install` to install missing gems"
#   exit e.status_code
# end
# 
# require 'minitest'
# require 'shoulda'

# $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
# $LOAD_PATH.unshift(File.dirname(__FILE__))

require_relative( File.join( "..", "lib", "fun_with_string_colors" ) )

FunWith::StringColors.activate
String.colorize( true )

# class Test::Unit::TestCase
# end
# 
class FunWith::StringColors::TestCase < FunWith::Testing::TestCase
end
