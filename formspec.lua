-- Custom tabheader type function
local function tabheader(x, y, w, h, tabnames, button_image, button_depressed, button_selected, selected_tab)
  local listadd =
  "style_type[image_button;bgimg="..button_image..";bgimg_pressed="..button_depressed..";border=false]"..
  "style_type[label;textcolor=white]"

  local i = 0
  for ind,tabname in pairs(tabnames) do
    if selected_tab == ind then
      listadd = listadd.."image["..(x+(i*3))..","..y..";"..w..","..(h*1.33)..";"..button_selected.."]"
    else -- notice change of image button index to add "tabs_" to beginning
      listadd = listadd.."image_button["..(x+(i*3))..","..y..";"..w..","..h..";"..button_image..";tabs_"..ind..";;;;"..button_depressed.."]"
    end
    listadd = listadd.."label["..(x+(i*3)+(w/3))..","..(y+(h/2))..";"..tabname.."]"
    i = i + 1
  end
  return listadd
end


function vl_cosmetics.show_cozform(name, selected_tab)
  local formspec =
    "formspec_version[4]"..
    "size[18,9]"..

    "background[-1,-0.5;20,10;vlc_bg.png]"..
    "style_type[image_button;bgimg=vlc_button_blank.png;bgimg_pressed=vlc_button_blank.png;border=false]"..
    "image[0,7.899;16,1;vlc_button_blank.png]"..
    "image[0,1.5;0.9,1.5;vlc_bodyp_"..selected_tab..".png]"..
    "image_button[0,7.899;2,1;vlc_button_left_p.png;page_left;;;;vlc_button_left.png]"..
    "image_button[16,7.899;2,1;vlc_button_right_p.png;page_right;;;;vlc_button_right.png]"..
    tabheader(0, 0, 3, 1, {["head"] = "Head", ["body"] = "Body",  ["arm_left"] = "Left Arm", ["arm_right"] = "Right Arm", ["leg_left"] = "Left Leg", ["leg_right"] = "Right Leg"}, "vlc_button_tabheader.png", "vlc_button_tabheader_p.png", "vlc_button_tabheader_selected.png", selected_tab)
    --"tabheader[0,0.3;15,0.5;Tabs;Head,Body,Right Arm,Left Arm,Right Leg,Left Leg;Head;true;true]"


	minetest.show_formspec(name, "vlc:main", formspec)
end


core.register_on_player_receive_fields(function(player, formname, fields)
  if formname ~= "vlc:main" then return end


  local active_tab
  for fieldname,fieldvalue in pairs(fields) do
    if string.find(fieldname, "tabs_") then
      active_tab = fieldname:gsub("tabs_", "")
      break
    end
  end

  if active_tab then
    vl_cosmetics.show_cozform(player:get_player_name(), active_tab)
  end
end)


core.register_chatcommand("vlcoz", {
	description = "Open the cosmetic interface",
	privs = {interact=true},
	func = function(name)
    vl_cosmetics.show_cozform(name, "head")
	end,
})
