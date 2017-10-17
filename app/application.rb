class Application

  @@items = [Item.new("Apples",5.23), Item.new("Oranges",2.43)]

  def call(env)
  resp = Rack::Response.new
  req = Rack::Request.new(env)
  item_name_array = []
  @@items.each do |i|
    item_name_array << i.name
  end

    if req.path.match(/items/)
      search_term = req.params["item"]
      if item_name_array.include?(search_term)
        search_item = @@items.select{ |i| i.name == "#{search_term}" }
        item_price = search_item.price
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
