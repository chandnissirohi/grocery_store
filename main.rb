require 'terminal-table/import'


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

# get discounted price
def get_discounted_price(groceryItemsColl)
    return 0 if groceryItemsColl.empty?

    item = groceryItemsColl[0]
    count = groceryItemsColl.size

    if (item.sale_price.nil?)
        return count * item.unit_price
    end

    quotient = count / item.sale_qty
    remainder = count % item.sale_qty

    return (quotient * item.sale_price) + (remainder * item.unit_price)
end

def get_discounted_bill(groceryItems)
    groupHash = groceryItems.group_by { |item| item.name }
    result = groupHash.reduce(0) { |acc, (name, list)|
        acc + get_discounted_price(list)
    }
    return result
end

def pricing_table(items)

    return [] if items.empty?

    result = []
    items_group = items.group_by{ |item| item.name }
    items_group.each { |name, list|
    result << [ name, list.size, "$#{get_discounted_price(list)}"]    
    }
    result
end

total_bill = items.reduce(0) { |acc, item| 
    acc + item.unit_price
}
discounted_bill = get_discounted_bill(items)
savings = total_bill - discounted_bill

puts "\n"
items_breakup = pricing_table(items)
items_table = table { |t| 
    t.headings = "Item", "Quantity", "Price"
    items_breakup.each { |row| t << row}
}
puts items_table
puts "\n"

puts "Total price:  $#{discounted_bill.round(2)}"
puts "You saved $#{savings.round(2)} today"