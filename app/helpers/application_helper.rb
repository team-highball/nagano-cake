module ApplicationHelper

  def price_include_tax(price)
    price = price * 1.1
    price.floor
  end

  def simple_time(time)
    time.strftime("%Y-%m-%d　%H:%M　")
  end

end
