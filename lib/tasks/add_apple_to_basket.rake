# See README for test run

# Return basket having space
def find_basket_with_space
  basket_with_space = Basket.all.select { |b| b.apples.length < b.capacity }
end

# Return basket having space and same variety
# Or just empty basket
def get_basket(variety)
  basket_with_space = find_basket_with_space()
  basket_with_same_variety = basket_with_space.find { |b| b.apples.first.variety == variety && b.apples.size > 0 }
  if basket_with_same_variety.nil?
    # return some other completely empty basket
    basket_with_space.find { |b| b.apples.size == 0 }
  else
    # return basket with same variety of apples
    basket_with_same_variety
  end
end

# Add apples of the given variety to given basket
def apples_to_basket(variety, basket)
  basket.apples.create!(variety: variety)

  # update fill_rate
  basket.fill_rate = ((basket.apples.size.to_f / basket.capacity.to_f) * 100).round
  basket.save
end

# Standard output for remaining apples when run out of baskets
def baskets_full(apple_count)
  puts "All baskets are full. We couldn't find the place for #{apple_count} apples"
end

desc "Add same variety apple to a basket based on conditions"
task :add_apple_to_basket, [:variety, :apple_count] => :environment do |task, args|

  # Get arguments first and fix their type
  variety = args.variety.to_s
  apple_count = args.apple_count.to_i

  basket = get_basket(variety)

  if basket.nil?
    baskets_full(apple_count)
  else
    1.upto(apple_count) do |i|

      # if basket has some space, add apples
      # else find new basket until all done
      if basket.apples.size < basket.capacity
        # put apples to basket
        apples_to_basket(variety, basket)
      else
        basket = get_basket(variety)
        if basket.nil?
          # calculate apples which are left
          apples_left = apple_count - i
          baskets_full(apples_left)
          break
        else
          apples_to_basket(variety, basket)
        end
      end
    end
  end

end
