require 'rails_helper'

describe DeliveryInfo do
  before do
    @delivery_info = FactoryGirl.create(:delivery)
  end

  describe 'filled #name, #address' do
    it 'is required' do
      expect(@delivery_info).to be_valid
    end
  end
  describe '#name' do
    it 'is required' do
      @delivery_info.name = nil
      expect(@delivery_info).to_not be_valid
    end
    it 'filled over 120 chars is invalid' do
      @delivery_info.name = "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901"
      expect(@delivery_info).to_not be_valid
    end
  end

  describe '#address' do
    it 'is required' do
      @delivery_info.address = nil
      expect(@delivery_info).to_not be_valid
    end
    it 'filled over 120 chars is invalid' do
      @delivery_info.name = "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901"
      expect(@delivery_info).to_not be_valid
    end
  end
end