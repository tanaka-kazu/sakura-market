class ShoppingCart < ActiveRecord::Base
  acts_as_shopping_cart

  def tax_pct
    8.0
  end

  def shipping_charge
    settlement_charge.to_i + packing_charge.to_i
  end

  def total_taxes
    (subtotal.to_i + shipping_charge.to_i) * tax_pct.to_i / 100
  end

  def total_price
    subtotal.to_i + shipping_charge.to_i + total_taxes.to_i
  end

  private
    def settlement_charge
      if subtotal.to_i < 10000
        300
      elsif subtotal.to_i < 30000
        400
      elsif subtotal.to_i < 100000
        600
      else
        1000
      end
    end

    def packing_charge
      (total_unique_items / 5.to_f).ceil * 600
    end
end