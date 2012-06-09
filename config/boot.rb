LP_ENV = LP_ENV ||= :production

puts "LP_ENV = #{LP_ENV}"

APP_ROOT = File.dirname(__FILE__) + '/..'

module LonelyPlanet
  class << self
    def root(*args)
      File.expand_path(File.join(APP_ROOT, *args))
    end
  end
end

require 'bundler/setup'
Bundler.require(:default, LP_ENV)

Dir.glob(File.dirname(__FILE__) + '/../lib/*') {|file| require file}
Dir.glob(File.dirname(__FILE__) + '/../models/*') {|file| require file}

require File.expand_path(File.dirname(__FILE__) + '/database')

DataMapper.finalize
#DataMapper::Model.raise_on_save_failure = true
#DataMapper.auto_migrate!

#puts DataMapper.repository.adapter.options

#hash
#name
#to_sym
#adapter
#identity_map
#scope
#new_query
#create
#read
#update
#delete
#inspect
#assert_kind_of
#psych_to_yaml
#to_yaml_properties
#to_yaml
#must_be_empty
#must_equal
#must_be_close_to
#must_be_within_delta
#must_be_within_epsilon
#must_include
#must_be_instance_of
#must_be_kind_of
#must_match
#must_be_nil
#must_be
#must_output
#must_raise
#must_respond_to
#must_be_same_as
#must_send
#must_be_silent
#must_throw
#wont_be_empty
#wont_equal
#wont_be_within_delta
#wont_be_close_to
#wont_be_within_epsilon
#wont_include
#wont_be_instance_of
#wont_be_kind_of
#wont_match
#wont_be_nil
#wont_be
#wont_respond_to
#wont_be_same_as
#nil?
#===
#    =~
#    !~
#    <=>
#    class
#    singleton_class
#      clone
#      dup
#      initialize_dup
#      initialize_clone
#      taint
#      tainted?
#      untaint
#      untrust
#      untrusted?
#      trust
#      freeze
#      frozen?
#      to_s
#      methods
#      singleton_methods
#      protected_methods
#      private_methods
#      public_methods
#      instance_variables
#      instance_variable_get
#      instance_variable_set
#      instance_variable_defined?
#      instance_of?
#      kind_of?
#      is_a?
#      tap
#      send
#      public_send
#      respond_to?
#      respond_to_missing?
#      extend
#      display
#      method
#      public_method
#      define_singleton_method
#      object_id
#      to_enum
#      enum_for
#      gem
#      psych_y
#      equal?
#      !
#      !=
#          instance_eval
#      instance_exec
#      __send__