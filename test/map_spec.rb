require 'rspec'
require_relative '../lib/imperium'
require_relative 'spec_helper'

describe Imperium::Map::GameMap do

  let(:target_class) { Imperium::Map::GameMap }
  let(:tmx_map) { Imperium::Map.load_map('../resources/maps/map.tmx') }

  subject(:map) { target_class.new(tmx_map) }

  describe '#initialize' do
    it 'initializes with map path' do
      expect { map }.to_not raise_error
    end
  end

  describe '#tilesets' do
    it 'returns instance of TileSets' do
      expect(map.tilesets).to be_a Imperium::Map::TileSets
    end
  end

  describe '#layers' do
    it 'returns array of Layer' do
      expect(map.layers).to all(be_an(Imperium::Map::Layer))
    end
  end

  describe '#width' do
    it "show map's width" do
      expect(map.width).to be 50 * 32
    end
  end

  describe '#height' do
    it "show map's  height" do
      expect(map.height).to be 50 * 32
    end
  end

  describe '#draw' do
    it 'draws map on game window at point (0, 0)' do
      expect { map.draw(0, 0) }.not_to raise_error
    end

    it 'draws shifted map on game window at point (10, 10)' do
      expect { map.draw(10, 10) }.not_to raise_error
    end
  end
end

