-- Custom tabheader type function
local function tabheader(x, y, w, h, space, tabnames, button_image, button_depressed, button_selected, selected_tab)
  local listadd =
  "style_type[image_button;bgimg="..button_image..";bgimg_pressed="..button_depressed..";border=false]"..
  "style_type[label;textcolor=white]"

  local i = 0
  for ind,tabname in pairs(tabnames) do
    if selected_tab == ind then
      listadd = listadd.."image["..(x+(i*3*space))..","..y..";"..w..","..(h*1.33)..";"..button_selected.."]"
    else -- notice change of image button index to add "tabs_" to beginning
      listadd = listadd.."image_button["..(x+(i*3*space))..","..y..";"..w..","..h..";"..button_image..";tabs_"..ind..";;;;"..button_depressed.."]"
    end
    listadd = listadd.."label["..(x+(i*3*space)+(w/3))..","..(y+(h/2))..";"..tabname.."]"
    i = i + 1
  end
  return listadd
end




function vl_cosmetics.show_cozform(name, selected_tab)

  vl_cosmetics.scroll[name] = vl_cosmetics.scroll[name] or -2

  local models = ""

  local inter = 1

  for cozname,def in pairs(vl_cosmetics.registered_cosmetics) do -- find out which models to display

    local coztype = def.cosmetic_type

    if selected_tab == coztype and not def.do_not_list then

      local def = vl_cosmetics.registered_cosmetics[cozname]

      local textures = table.copy(def.textures)
      textures[1] = "vl_cosmetics_character.png" -- add preview texture where normally blank.png


      local xpos = (vl_cosmetics.scroll[name]+inter*4)

      local button = ""

      if vl_cosmetics.has_coz(minetest.get_player_by_name(name), cozname) then
        models = models..
        "image["..(xpos+0.9)..",1.8;2.2,1;vlc_button_blank.png]"..
        "label["..(xpos+1.1)..",2.1;You already\nhave this one.]"
        button = ""..
        "image_button["..(xpos+0.75)..",2.899;2.5,5;vlc_model_border_selected.png;remove_"..cozname..";;;;vlc_model_border_p.png]"
      else
        button = ""..
        "image_button["..(xpos+0.75)..",2.899;2.5,5;vlc_model_border.png;select_"..cozname..";;;;vlc_model_border_p.png]"
      end
      -- models



      models = models..
      "style_type[image_button;bgimg=vlc_model_border.png;bgimg_pressed=vlc_model_border.png;border=false]"..
      button..
      "image["..(xpos+0.9)..",3;2.2,1;vlc_button_blank.png]"..
      "label["..(xpos+1.1)..",3.5;"..def.usename.."]"..
      "model["..xpos..",4;4,4;"..cozname..";"..def.mesh..";"..table.concat(textures, ",")..";-20,39;false;true]"

      inter = inter + 1
    end
  end

  if selected_tab == "collections" then

    local long_inter = 0


    for colname,def in pairs(vl_cosmetics.registered_collections) do -- find out which models to display for collections
      local xpos = (vl_cosmetics.scroll[name]+long_inter+5)

      local inter = 0

      models = models..
      "image["..(xpos)..",1.7;3.5,6.5;vlc_model_border.png]"..
      "image_button["..(xpos+0.2)..",2;3.1,1.5;vlc_button_select.png;selectcol_"..colname..";;;;vlc_button_select_p.png]"


      for ind,cozname in pairs(def) do -- find out which models to display for collections
        local def = vl_cosmetics.registered_cosmetics[cozname]

        local textures = table.copy(def.textures)
        textures[1] = "vl_cosmetics_character.png" -- add preview texture where normally blank.png

        local button = ""

        if vl_cosmetics.has_coz(minetest.get_player_by_name(name), cozname) then
          button = ""..
          "image["..(xpos+(inter/3)+0.17)..","..(((inter%3)+2.889)*1.2)..";0.66,1.2;vlc_model_underline_selected.png]"
        else
          button = ""..
          "image["..(xpos+(inter/3)+0.17)..","..(((inter%3)+2.889)*1.2)..";0.66,1.2;vlc_model_underline.png]"
        end




        models = models..
        button..
        "model["..(xpos+(inter/3))..","..(((inter%3)+3)*1.2)..";1,1;"..cozname..";"..def.mesh..";"..table.concat(textures, ",")..";-20,39;false;true]"

        inter = inter+1
      end



      long_inter = long_inter + 4
    end
  end


  local formspec =
    "formspec_version[8]"..
    "size[18,9]"..

    "background[-1,-0.5;20,10;vlc_bg.png]"..
    "style_type[image_button;bgimg=vlc_button_blank.png;bgimg_pressed=vlc_button_blank.png;border=false]"..

    models..
    "image[-2,0.5;4,8;vlc_bg_border.png]"..

    "image[0,7.899;16,1;vlc_button_blank.png]"..
    "image[0,1.5;0.9,1.5;vlc_bodyp_"..selected_tab..".png]"..
    "image_button[0,7.899;2,1;vlc_button_left_p.png;page_left;;;;vlc_button_left.png]"..
    "image_button[16,7.899;2,1;vlc_button_right_p.png;page_right;;;;vlc_button_right.png]"..
    tabheader(0, 0, 2.5, 1, 0.8, {["head"] = "Head", ["body"] = "Body",  ["arm_left"] = "Left Arm", ["arm_right"] = "Right Arm", ["leg_left"] = "Left Leg", ["leg_right"] = "Right Leg", ["collections"] = "Collections"}, "vlc_button_tabheader.png", "vlc_button_tabheader_p.png", "vlc_button_tabheader_selected.png", selected_tab)
    --"tabheader[0,0.3;15,0.5;Tabs;Head,Body,Right Arm,Left Arm,Right Leg,Left Leg;Head;true;true]"


	core.show_formspec(name, "vlc:main", formspec)
end


core.register_on_player_receive_fields(function(player, formname, fields)
  if formname ~= "vlc:main" then return end

  local change

  local name = player:get_player_name()


  local scroll = vl_cosmetics.scroll[name]
  if fields.page_left then
    vl_cosmetics.scroll[name] = scroll + 4
    if scroll >= -2 then vl_cosmetics.scroll[name] = -2 end
    change = true
  elseif fields.page_right then
    change = true
    vl_cosmetics.scroll[name] = scroll - 4
  end



  local active_tab = vl_cosmetics.active_tab[name] or "head"
  for fieldname,fieldvalue in pairs(fields) do
    if string.find(fieldname, "tabs_") then
      active_tab = fieldname:gsub("tabs_", "")
      vl_cosmetics.scroll[name] = nil
      change = true
      break
    elseif string.find(fieldname, "select_") then
      vl_cosmetics.equip_coz(player, fieldname:gsub("select_", ""))
      change = true
      break
    elseif string.find(fieldname, "remove_") then
      vl_cosmetics.remove_coz(player, fieldname:gsub("remove_", ""), false)
      change = true
      break
    elseif string.find(fieldname, "selectcol_") then

      uneqip_all = true

      for ind,cozname in pairs(vl_cosmetics.registered_collections[fieldname:gsub("selectcol_", "")]) do
        if not vl_cosmetics.has_coz(player, cozname) then
          uneqip_all = false
          vl_cosmetics.equip_coz(player, cozname)
        end
      end

      if uneqip_all then
        for ind,cozname in pairs(vl_cosmetics.registered_collections[fieldname:gsub("selectcol_", "")]) do
          vl_cosmetics.remove_coz(player, cozname)
        end
      end

      change = true
      break
    end
  end
  vl_cosmetics.active_tab[name] = active_tab

  if change then
    vl_cosmetics.show_cozform(player:get_player_name(), vl_cosmetics.active_tab[name])
  end
end)


core.register_chatcommand("vlcoz", {
	description = "Open the cosmetic interface",
	privs = {interact=true},
	func = function(name)
    vl_cosmetics.active_tab[name] = vl_cosmetics.active_tab[name] or "head"
    vl_cosmetics.show_cozform(name, vl_cosmetics.active_tab[name])
	end,
})
