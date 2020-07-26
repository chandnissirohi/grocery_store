# Declaring constants
GROCERY_ITEMS = ['milk', 'bread', 'apple', 'banana']

# prompt: Add items to the cart
puts "Please enter all the items purchased separated by a comma"

inputs = gets.chomp

# Converting items string to an array
items = inputs.split(',')

# condition if no items are added to the cart
if items.empty?
    puts 'Please add items to the cart'
    exit
end

# remove unwanted spaces in the items
items.map! { |item| item.strip }

# initialize items with price and quantity, add to the cart with the total billed amount
class GroceryItem

    attr_reader :name, :unit_price, :sale_price, :sale_qty

    def initialize(name, unit_price, sale_price=nil, sale_qty=nil)
        @name = name
        @unit_price = unit_price
        @sale_price = sale_price
        @sale_qty = sale_qty
    end
end

items.map! { |item|
case item
    when 'milk' then GroceryItem.new('Milk', 3.97, 5.00, 2)
    when 'bread' then GroceryItem.new('Bread', 2.17, 6.00, 3)
    when 'apple' then GroceryItem.new('Apple', 0.89)
    when 'banana' then GroceryItem.new('Banana', 0.99)
end
}

# condition if unavailable items are added
if items.include? nil
    puts "Kindly add only available items"
    exit
end


p items

total_bill = items.reduce(0) { |acc, item| 
    acc + item.unit_price
}

puts "Total price:  $#{total_bill}"