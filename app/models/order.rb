class Order < ApplicationRecord
  require 'holiday_japan'

  belongs_to :user
  has_many :order_items
  enum time_range_id: { free: 0, am: 1, pm1: 2, pm2: 3, pm4: 4, pm5: 5 }

  def self.delivery_dates
    dates = Hash.new
    today = Date.current
    elapsed_date = 3
    until dates.size == 12
      unless holiday?(today.since(elapsed_date.days))
        dates.store(today.since(elapsed_date.days).strftime("%Y年 %m月 %d日"), today.since(elapsed_date.days))
      end
      elapsed_date += 1
    end
    dates
  end

  def self.localed_time_ranges
    time_range_ids.keys.map do |k|
      [ApplicationController.helpers.t("enums.order.time_range_id.#{k}"), k]
    end
  end

  private
  def self.holiday?(date)
    if !HolidayJapan.check(date)
      if date.saturday? || date.sunday?
        return true
      end
      return false
    end
    return true
  end
end
