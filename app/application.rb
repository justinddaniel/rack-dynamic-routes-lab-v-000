class Application

  @@items = [Item.new("Apples",5.23), Item.new("Oranges",2.43)]

  def call(env)
  resp = Rack::Response.new
  req = Rack::Request.new(env)
  item_name_array = []  #The .find method on lines 18-21 could have accomplished this 
  @@items.each do |i|   #much more efficiently. 
    item_name_array << i.name
  end

  #      if item =@@items.find{|i| i.name == item_name}
  #      resp.write item.price   <= use this insead of lines 18-21 

    if req.path.match(/items/)
      search_term = req.path.split("/items/").last
      if item_name_array.include?(search_term)
        search_item = @@items.select{ |i| i.name == "#{search_term}" }
        item_price = search_item[0].price
        resp.write "#{item_price}"
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end


end
