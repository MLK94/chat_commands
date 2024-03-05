minetest.register_chatcommand("userinfo", {
	params = "[<name>]",
  privs = {server=true},
	description = "Show a user's connection details. Leave name blank for your own connection details.",
	func = function(caller, param)
		param = param:trim()
		local pname = (param ~= "" and param or caller)
		if not minetest.get_player_by_name(pname) then 
			return false, pname.." is not online."
		end
		local usertable = {"-----"}
		local userinfo = minetest.get_player_information(pname)
		if userinfo then
			for key, value in pairs(userinfo) do
				if value == nil or value == "" then value = "unknown" end
				usertable[#usertable+1] = key.." : "..value
			end
			local form_name="userinformer"
		  	--table.sort(usertable)
			usertable = table.concat(usertable,",")
			local sizex = 8
			local sizey = 12
			local titlezy = "USERNAME: "..pname
		  	local fsver = tostring(userinfo["formspec_version"]) or 4
		  	if not fsver then fsver = 4 end -- Is this line redundant?
			local gui = (
				"formspec_version["..fsver.."]"..
				"size["..sizex..","..sizey.."]"..
				"no_prepend[]"..
				"bgcolor[#770000EE;false]"..
				"table[0.5,0.5;"..(sizex-1)..","..(sizey-1)..";tablezy;"..titlezy..","..usertable..";1]"
			)
			minetest.show_formspec(caller, form_name, gui)
		end -- userinfo
	end -- func
})
