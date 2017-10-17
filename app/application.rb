class Application
  def call(env)
  resp = Rack::Response.new
  req = Rack::Request.new(env)
  item_name_array = []
  item_name_array = Item.all.collect {|i| i.name}

    if req.path.match(/items/)
      search_term = req.params["item"]
      if item_name_array.include?(search_term)
        search_item = Item.all.select{ |i| i.name == "#{search_term}" }
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
