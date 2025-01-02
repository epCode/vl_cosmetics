
vl_cosmetics = {
  registered_cosmetics = {},
  registered_collections = {},
  scroll = {},
  active_tab = {}
}

--[[
function vl_cosmetics.preview_model_version(def, replacement_tex)
  local textures = {replacement_tex, def.textures[1], def.textures[2]}

  if string.find(def.cosmetic_type, "leg") or string.find(def.cosmetic_type, "arm") then
    textures = {[1] = def.textures[1], [2] = replacement_tex}
  end
  return textures
end]]


function vl_cosmetics.register_cosmetic(name, def)

  def.usename = name

  name = name:gsub(" ", "_")
  name = name:gsub("#", "")

  local models = {
    ["head"] = "vl_cosmetics_head.obj",
    ["body"] = "vl_cosmetics_body.obj",
    ["arm_right"] = "vl_cosmetics_arm_right.obj",
    ["arm_left"] = "vl_cosmetics_arm_left.obj",
    ["leg_right"] = "vl_cosmetics_leg_right.obj",
    ["leg_left"] = "vl_cosmetics_leg_left.obj",
  }

  local cap = {
    ["head"] = "Head",
    ["body"] = "Body",
    ["arm_right"] = "Arm_Right",
    ["arm_left"] = "Arm_Left",
    ["leg_right"] = "Leg_Right",
    ["leg_left"] = "Leg_Left"
  }

  local textures = {"blank.png", def.textures[1], def.textures[2]}

  if string.find(def.cosmetic_type, "leg") or string.find(def.cosmetic_type, "arm") then
    textures = {[1] = def.textures[1], [2] = "blank.png"}
  end

  local final_def = {
    visual = "mesh",
    mesh = def.mesh or models[def.cosmetic_type],
    textures = textures,
    glow = def.glow,
    cosmetic_type = def.cosmetic_type,
    cosmetic_type_cap = cap[def.cosmetic_type] or "",
    pointable = false,
    do_not_list = def.do_not_list,
    usename = def.usename,
    on_step = def.on_step,
    _timer = 0,
    on_detach = function(self)
      self.object:remove()
    end,
    on_activate = function(self)
      core.after(0.05, function()
        if self and self.object:get_pos() and not self.object:get_attach() then
          self.object:remove()
        end
      end)
    end
  }

  core.register_entity("vl_cosmetics:"..name, final_def)

  vl_cosmetics.registered_cosmetics[name] = final_def
end

function vl_cosmetics.register_cosmetic_collection(name, def)
  vl_cosmetics.registered_collections[name] = def
end

local function force_equip_coz(player, cozname)
  if not vl_cosmetics.registered_cosmetics[cozname] then
    core.log("warning", "Cosmetic: "..cozname.." nonexistent, removing from player "..player:get_player_name().."...")

    local meta = player:get_meta()
    local local_player_coz = core.deserialize(meta:get_string("vl_cosmetics")) or {}
    local_player_coz[cozname] = nil
    meta:set_string("vl_cosmetics", core.serialize(local_player_coz))


    return
  end
  local coz = core.add_entity(player:get_pos(), "vl_cosmetics:"..cozname)
  coz:set_attach(player, coz:get_luaentity().cosmetic_type_cap, vector.new(0,0,0), vector.new(0,0,0))
end


function vl_cosmetics.has_coz(player, cozname)
  local meta = player:get_meta()
  local local_player_coz = core.deserialize(meta:get_string("vl_cosmetics")) or {}

  if local_player_coz[cozname] then return true end
end


function vl_cosmetics.equip_coz(player, cozname)
  local meta = player:get_meta()
  local local_player_coz = core.deserialize(meta:get_string("vl_cosmetics")) or {}

  if local_player_coz[cozname] then return "You already have that one!" end

  local_player_coz[cozname] = true

  meta:set_string("vl_cosmetics", core.serialize(local_player_coz))

  force_equip_coz(player, cozname)

  return "Cosmetic added: '"..cozname.."'"
end

function vl_cosmetics.add_cosmetic(player, cozname)
  if vl_cosmetics.registered_cosmetics[cozname] then
    --core.chat_send_player(player:get_player_name(), vl_cosmetics.equip_coz(player, cozname))
    return
  elseif vl_cosmetics.registered_collections[cozname] then
    for _,cozlistname in pairs(vl_cosmetics.registered_collections[cozname]) do
      vl_cosmetics.equip_coz(player, cozlistname)
    end
  else
    --core.chat_send_player(player:get_player_name(), "That is not the name of any cosmetic!")
    return
  end
end

function vl_cosmetics.remove_coz(player, cozname, all)
  local meta = player:get_meta()
  local local_player_coz = core.deserialize(meta:get_string("vl_cosmetics")) or {}

  local name = player:get_player_name()
  local children = player:get_children()
  if all then
    local_player_coz = {}
    for _,obj in pairs(children) do
      if not obj:is_player() and obj:get_luaentity().cosmetic_type then
        obj:remove()
      end
    end
    --core.chat_send_player(name, "All cosmetics removed!")
  else
    for _,obj in pairs(children) do
      if not obj:is_player() and obj:get_luaentity() then
        local luaname = obj:get_luaentity().name
        if vl_cosmetics.registered_collections[cozname] then
          print(luaname)
          -- if a cosmetic happens to have the same name as a collection, it will silently fail to remove.
          for _,cozlistname in pairs(vl_cosmetics.registered_collections[cozname]) do
            if luaname == "vl_cosmetics:"..cozlistname then
              obj:remove()
              local_player_coz[cozname] = nil
              --core.chat_send_player(name, cozlistname.." removed!")
            end
          end
        elseif luaname == "vl_cosmetics:"..cozname then
          obj:remove()
          local_player_coz[cozname] = nil
          --core.chat_send_player(name, cozname.." removed!")
        end
      end
    end
  end

  meta:set_string("vl_cosmetics", core.serialize(local_player_coz))
end


core.register_chatcommand("vlc", {
	params = "[<cosmetic_name>]",
	description = "Add a cosmetic to yourself",
	privs = {interact=true},
	func = function(name, param)
		if(param == "") then
			-- Selfkill
      --core.chat_send_player(name, "No cosmetic specified")
			return
		else
			return vl_cosmetics.add_cosmetic(core.get_player_by_name(name), param)
		end
	end,
})


core.register_chatcommand("vlc_remove", {
	params = "[<cosmetic_name>]",
	description = "Remove a cosmetic (or all cosmetics if left blank)",
	privs = {interact=true},
	func = function(name, param)
    if(param == "") then
      vl_cosmetics.remove_coz(core.get_player_by_name(name), param, true)
    else
      vl_cosmetics.remove_coz(core.get_player_by_name(name), param)
    end
	end,
})


core.register_on_joinplayer(function(player)
  local meta = player:get_meta()
  local local_player_coz = core.deserialize(meta:get_string("vl_cosmetics")) or {}
  for coz,value in pairs(local_player_coz) do
    force_equip_coz(player, coz)
  end
end)



--[[
core.register_chatcommand("vlc_on_head", {
	params = "[<drawtype>][<cosmetic_texture>][<cosmetic_name>]",
	description = "Add a cosmetic to the top of your head on plantlike/node/wielditem form based on a texture",
	privs = {interact=true},
	func = function(name, params)
    local P = {}
		local i = 0
		for str in string.gmatch(params, "([^ ]+)") do
			i = i + 1
			P[i] = str
		end
    local drawtype, texture, cozname = P[1], P[2], P[3]

    if not drawtype or not texture or not cozname then return end


    vl_cosmetics.register_cosmetic(cozname, {
      cosmetic_type = "Head",
      mesh = "vl_cosmetics_"..drawtype.."_on_head.obj",
      textures = {texture},
    })

	end,
})]]




dofile(core.get_modpath("vl_cosmetics").."/register.lua")
dofile(core.get_modpath("vl_cosmetics").."/formspec.lua")
