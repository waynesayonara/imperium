require 'rspec'
require_relative '../lib/imperium'
require_relative 'spec_helper'

describe 'All scenes implementations common behaviour' do

  # all classes in the specified folder should include module 'Scene'
  it 'should include Scene module' do
    # load all classes from the specified folder in project
    Dir['lib/imperium/ui/scenes/implementations/*.rb'].each do |file_path|
      # load ruby class from file_path
      load file_path
      # parse class_name from full path
      file_name = File.basename(file_path, '.*' )
      # class_name => ClassName
      impl_class_name = file_name.split('_').collect(&:capitalize).join
      # get class object
      impl_class = Engine.const_get(impl_class_name);
      # create derived class with default constructor
      impl_derived_class =
          Class.new impl_class do
            def initialize
            end
          end
      # instantiate derived class
      impl_derived_instance = impl_derived_class.new
      # check whether derived class instance includes module 'Scene'
      expect(impl_derived_instance.class.ancestors).to include(Engine::Scene)
    end
  end
end