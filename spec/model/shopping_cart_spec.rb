require 'rails_helper'

describe ShoppingCart do

  before do
    @cart = ShoppingCart.create
  end

  context "test private method settlement_charge" do
    it "subsubtotal price lt 10000 is 300" do
      @cart.add(Item.new(name: "test"), 9999)
      expect( @cart.send(:settlement_charge) ).to eq(300)
    end
    it "subtotal price eq 10000 is 400" do
      @cart.add(Item.new(name: "test"), 10000)
      expect( @cart.send(:settlement_charge) ).to eq(400)
    end
    it "subtotal price lt 30000 is 400" do
      @cart.add(Item.new(name: "test"), 29999)
      expect( @cart.send(:settlement_charge) ).to eq(400)
    end
    it "subtotal price eq 30000 is 600" do
      @cart.add(Item.new(name: "test"), 30000)
      expect( @cart.send(:settlement_charge) ).to eq(600)
    end
    it "subtotal price lt 100000 is 600" do
      @cart.add(Item.new(name: "test"), 99999)
      expect( @cart.send(:settlement_charge) ).to eq(600)
    end
    it "subtotal price eq 100000 is 1000" do
      @cart.add(Item.new(name: "test"), 100000)
      expect( @cart.send(:settlement_charge) ).to eq(1000)
    end
  end

  context "test private method packing_charge" do
    it "items count eq 5 is 600" do
      5.times {
        @cart.add(Item.new(name: "test"), 100)
      }
      expect( @cart.send(:packing_charge) ).to eq(600)
    end
    it "items count eq 6 is 1200" do
      6.times {
        @cart.add(Item.new(name: "test"), 100)
      }
      expect( @cart.send(:packing_charge) ).to eq(1200)
    end
    it "items count eq 10 is 1200" do
      10.times {
        @cart.add(Item.new(name: "test"), 100)
      }
      expect( @cart.send(:packing_charge) ).to eq(1200)
    end
    it "items count eq 11 is 1800" do
      11.times {
        @cart.add(Item.new(name: "test"), 100)
      }
      expect( @cart.send(:packing_charge) ).to eq(1800)
    end
  end

  context "test shipping_charge calculate" do
    it "subtotal price lt 10000 5items is 900" do
      5.times {
          @cart.add(Item.new(name: "test"), 1999)
      }
      expect( @cart.shipping_charge ).to eq(900)
    end
    it "subtotal price eq 10000 5items is 1000" do
      5.times {
          @cart.add(Item.new(name: "test"), 2000)
      }
      expect( @cart.shipping_charge ).to eq(1000)
    end
    it "subtotal price lt 10000 6items is 1500" do
      6.times {
          @cart.add(Item.new(name: "test"), 1666)
      }
      expect( @cart.shipping_charge ).to eq(1500)
    end
    it "subtotal price lt 30000 10items is 1600" do
      10.times {
          @cart.add(Item.new(name: "test"), 2999)
      }
      expect( @cart.shipping_charge ).to eq(1600)
    end
    it "subtotal price eq 30000 10items is 1800" do
      10.times {
          @cart.add(Item.new(name: "test"), 3000)
      }
      expect( @cart.shipping_charge ).to eq(1800)
    end
    it "subtotal price lt 100000 15items is 3000" do
      15.times {
          @cart.add(Item.new(name: "test"), 6666)
      }
      expect( @cart.shipping_charge ).to eq(2400)
    end
    it "subtotal price eq 100000 16items is 2800" do
      16.times {
          @cart.add(Item.new(name: "test"), 6250)
      }
      expect( @cart.shipping_charge ).to eq(3400)
    end
  end

  context "test total_tax calculate" do
    it "should be 8 percents tax charge" do
      @cart.add(Item.new(name: "test"), 10000)
      expect( @cart.total_taxes ).to eq(880)
    end
  end

  context "test total_price calculate" do
    it "should be addition value subtotal, shipping_charge and tax" do
      @cart.add(Item.new(name: "test"), 10000)
      expect( @cart.total_price ).to eq(11880)
    end
  end
end