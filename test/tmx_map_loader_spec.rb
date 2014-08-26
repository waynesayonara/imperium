require 'rspec'
require_relative '../lib/imperium'

describe Imperium::Map do

  let(:target_module) { Imperium::Map }
  let(:correct_path) { '../resources/maps/map.tmx' }
  let(:incorrect_path) { 'wrong_path' }

  describe '#load_map' do
    it 'loads maps' do
      expect { target_module.load_map(incorrect_path) }.to raise_error
      expect { target_module.load_map(correct_path) }.to_not raise_error
    end
  end

end

