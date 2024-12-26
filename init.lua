vl_cosmetics = {
  coz_names = {},
  coz_collections = {}
}

function vl_cosmetics.register_cosmetic(name, def)
  local models = {
    ["Head"] = "vl_cosmetics_head.obj",
    ["Body"] = "vl_cosmetics_body.obj",
    ["Arm_Right"] = "vl_cosmetics_arm_right.obj",
    ["Arm_Left"] = "vl_cosmetics_arm_left.obj",
    ["Leg_Right"] = "vl_cosmetics_leg_right.obj",
    ["Leg_Left"] = "vl_cosmetics_leg_left.obj",
  }


  core.register_entity("vl_cosmetics:"..name, {
    visual = "mesh",
    mesh = def.mesh or models[def.cosmetic_type],
    textures = def.textures,
    glow = def.glow,
    cosmetic_type = def.cosmetic_type,
    on_detach = function(self)
      self.object:remove()
    end,
    on_activate = function(self)
      minetest.after(0.05, function()
        if self and self.object:get_pos() and not self.object:get_attach() then
          self.object:remove()
        end
      end)
    end
  })

  vl_cosmetics.coz_names[name] = 1
end

function vl_cosmetics.register_cosmetic_collection(name, def)
  vl_cosmetics.coz_collections[name] = def
end

local function equip_coz(player, coz_name)
  local coz = core.add_entity(player:get_pos(), "vl_cosmetics:"..coz_name)
  coz:set_attach(player, coz:get_luaentity().cosmetic_type, vector.new(0,0,0), vector.new(0,0,0))
end

local function add_cosmetic(player, coz_name)
  if vl_cosmetics.coz_names[coz_name] then
    equip_coz(player, coz_name)
    core.chat_send_player(player:get_player_name(), "Cosmetic added: '"..coz_name.."'")
    return
  elseif vl_cosmetics.coz_collections[coz_name] then
    for _,cozlistname in pairs(vl_cosmetics.coz_collections[coz_name]) do
      equip_coz(player, cozlistname)
    end
  else
    core.chat_send_player(player:get_player_name(), "That is not the name of any cosmetic!")
    return
  end
end

core.register_chatcommand("vlc", {
	params = "[<cosmetic_name>]",
	description = "Add a cosmetic to yourself",
	privs = {interact=true},
	func = function(name, param)
		if(param == "") then
			-- Selfkill
      core.chat_send_player(name, "No cosmetic specified")
			return
		else
			return add_cosmetic(core.get_player_by_name(name), param)
		end
	end,
})

core.register_chatcommand("vlc_remove", {
	params = "[<cosmetic_name>]",
	description = "Remove a cosmetic (or all cosmetics if left blank)",
	privs = {interact=true},
	func = function(name, param)
    local player = core.get_player_by_name(name)
    local children = player:get_children()
		if(param == "") then
      for _,obj in pairs(children) do
        if not obj:is_player() and obj:get_luaentity().cosmetic_type then
          obj:remove()
        end
      end
      core.chat_send_player(name, "All cosmetics removed!")
		else
      for _,obj in pairs(children) do
        if not obj:is_player() and obj:get_luaentity().name == "vl_cosmetics:"..param then
          obj:remove()
          core.chat_send_player(name, param.." removed!")
        end
      end
		end
	end,
})







vl_cosmetics.register_cosmetic("glow_eyes", {
  cosmetic_type = "Head",
  textures = {"vl_cosmetics_eyes.png"},
  glow = 14,
})

vl_cosmetics.register_cosmetic("mushroom", {
  cosmetic_type = "Head",
  mesh = "vl_cosmetics_plantlike_on_head.obj",
  textures = {"farming_mushroom_red.png"},
})

--[[
vl_cosmetics.register_cosmetic_collection("fullbody", {
  Head = "glow_eyes",
  Body = "body",
  Arm_right = "right"
})]]
