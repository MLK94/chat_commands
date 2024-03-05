minetest.register_chatcommand("nodecount", {
  description = "Admin tool for checking the registered node total in this world. Can also be used from the server console.",
  privs={server=true},
  func=function(name)
    local itemstring
    local item = 0
    for itemstring,_ in pairs(minetest.registered_items) do
      if itemstring ~= "" and itemstring ~= "unknown" and itemstring ~= "ignore" then
        item = item + 1
      end
    end
    local qname = minetest.get_player_by_name(name) or nil 	-- check to see if command being called from console, not in-game.
    local pname
    if qname then       					                          -- is the caller in-game?      
      local pname = qname:get_player_name()
      minetest.chat_send_player(pname,"Total number of nodes in this modpack: "..dump(item))
    else
      minetest.log("Total number of nodes in this modpack: "..dump(item))
    end
  end,
})
