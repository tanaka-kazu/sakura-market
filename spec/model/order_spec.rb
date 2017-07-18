require 'rails_helper'

describe Order do

  context "test create select date datas" do
    it "created date lists" do
      expect( Order.delivery_dates.size ).to eq(12) 
    end
  end

  context "test private method holiday?" do
    it "Saturday is holiday" do 
      expect( Order.send(:holiday?, Date.new(2017,7,1)) ).to eq(true)
    end
    it "Sunday is holiday" do
      expect( Order.send(:holiday?, Date.new(2017,7,2)) ).to eq(true)
    end
    it "Japanese sea day is holiday" do
      expect( Order.send(:holiday?, Date.new(2017,7,17)) ).to eq(true)
    end
    it "Monday is not holiday" do
      expect( Order.send(:holiday?, Date.new(2017,7,3)) ).to eq(false)
    end
    it "Friday is not holiday" do
      expect( Order.send(:holiday?, Date.new(2017,7,7)) ).to eq(false)
    end
  end

end