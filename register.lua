-- Misc
vl_cosmetics.register_cosmetic("Glow Eyes", {
  cosmetic_type = "head",
  textures = {"vl_cosmetics_eyes.png"},
  glow = 14,
})
vl_cosmetics.register_cosmetic("Mushroom", {
  cosmetic_type = "head",
  mesh = "vl_cosmetics_plantlike_on_head.obj",
  textures = {"farming_mushroom_red.png"},
})

-- Hair --
--facial hair
vl_cosmetics.register_cosmetic("Brown Beard", {
  cosmetic_type = "head",
  mesh = "vl_cosmetics_beard.obj",
  textures = {"vl_cosmetics_beard_brown.png"},
})
vl_cosmetics.register_cosmetic("Red Beard", {
  cosmetic_type = "head",
  mesh = "vl_cosmetics_beard.obj",
  textures = {"vl_cosmetics_beard_red.png"},
})
vl_cosmetics.register_cosmetic("Red Mustache", {
  cosmetic_type = "head",
  mesh = "vl_cosmetics_beard.obj",
  textures = {"vl_cosmetics_mustache_red.png"},
})

--head hair
vl_cosmetics.register_cosmetic("Elf Helmet", {
  cosmetic_type = "head",
  mesh = "vl_cosmetics_head_extruded.obj",
  textures = {"vl_cosmetics_elf_helmet.png"},
})


vl_cosmetics.register_cosmetic("beh_H", {
  cosmetic_type = "head",
  mesh = "vl_cosmetics_head_slightly_extruded.obj",
  textures = {"vl_cosmetics_brown_elf_hair.png"},
  do_not_list = true,
})
vl_cosmetics.register_cosmetic("beh_B", {
  cosmetic_type = "body",
  textures = {"vl_cosmetics_brown_elf_hair.png"},
  do_not_list = true,
})
-- ps. Keys in this collection are only code documentation purposes,
-- no actual hardcoded function. eg Head = "beh_H" is just using "beh_H"
vl_cosmetics.register_cosmetic_collection("Brown Elf Hair", {
  Head = "beh_H",
  Body = "beh_B",
})

vl_cosmetics.register_cosmetic("beh2_H", {
  cosmetic_type = "head",
  mesh = "vl_cosmetics_head_slightly_extruded.obj",
  textures = {"vl_cosmetics_brown_elf_hair_2.png"},
  do_not_list = true,
})
vl_cosmetics.register_cosmetic("beh2_B", {
  cosmetic_type = "body",
  textures = {"vl_cosmetics_brown_elf_hair_2.png"},
  do_not_list = true,
})
vl_cosmetics.register_cosmetic_collection("Brown Elf Hair #2", {
  Head = "beh2_H",
  Body = "beh2_B",
})

vl_cosmetics.register_cosmetic("reh_H", {
  cosmetic_type = "head",
  mesh = "vl_cosmetics_head_slightly_extruded.obj",
  textures = {"vl_cosmetics_red_elf_hair.png"},
  do_not_list = true,
})
vl_cosmetics.register_cosmetic("reh_B", {
  cosmetic_type = "body",
  textures = {"vl_cosmetics_red_elf_hair.png"},
  do_not_list = true,
})
vl_cosmetics.register_cosmetic_collection("Red Elf Hair", {
  Head = "reh_H",
  Body = "reh_B",
})

-- Body Parts --
vl_cosmetics.register_cosmetic("Elf Ears", {
  cosmetic_type = "head",
  mesh = "vl_cosmetics_head_slightly_extruded.obj",
  textures = {"vl_cosmetics_elf_ears_1.png"},
})


--Test
vl_cosmetics.register_cosmetic("ElfHead", {
  cosmetic_type = "head",
  do_not_list = true,
  textures = {"vl_cosmetics_test.png"},
})
vl_cosmetics.register_cosmetic("ElfBody", {
  cosmetic_type = "body",
  do_not_list = true,
  textures = {"vl_cosmetics_test.png"},
})
vl_cosmetics.register_cosmetic("ElfArmRight", {
  cosmetic_type = "arm_right",
  do_not_list = true,
  textures = {"vl_cosmetics_test.png"},
})
vl_cosmetics.register_cosmetic("ElfArmLeft", {
  cosmetic_type = "arm_left",
  do_not_list = true,
  textures = {"vl_cosmetics_test.png"},
})
vl_cosmetics.register_cosmetic("ElfLegRight", {
  cosmetic_type = "leg_left",
  do_not_list = true,
  textures = {"vl_cosmetics_test.png"},
})
vl_cosmetics.register_cosmetic("ElfLegLeft", {
  cosmetic_type = "leg_right",
  do_not_list = true,
  textures = {"vl_cosmetics_test.png"},
})
--[[
vl_cosmetics.register_cosmetic_collection("Elf", {
  Head = "ElfHead",
  Body = "ElfBody",
  Arm_Right = "ElfArmRight",
  Arm_Left = "ElfArmLeft",
  Leg_Right = "ElfLegRight",
  Leg_Left = "ElfLegLeft",
})]]


vl_cosmetics.register_cosmetic("Blink", {
  cosmetic_type = "head",
  textures = {
    "vlc_blink_15.png",
  },
  value_slider = true,
  texture_animation = {
    display_index = 0, -- index of frame that is displayed in ui_model
    index = 2, -- texture index
    delay = 0.2, -- how long each frame is displayed
    random = true, -- random choice of frames
    frame_count = 15, -- vertical frame count
  }
})


vl_cosmetics.register_cosmetic("Yawn", {
  cosmetic_type = "head",
  textures = {
    "vlc_yawn_5.png",
  },
  texture_animation = { -- similar to a vertical_frames animation (uses the texture modifier)
    index = 2, -- texture index
    delay = 0.2, -- how long each frame is displayed
    frame_count = 5, -- vertical frame count
    pause = {0, 200}, -- for how many seconds a pause is each frame.png playthrough, can be int or min, max
  }
})

vl_cosmetics.register_cosmetic("Sparkleh", {
  cosmetic_type = "head",
  glow = 14,
  textures = {
    "vlc_sparkle_5.png",
  },
  texture_animation = {
    index = 2, -- texture index
    delay = 0.2, -- how long each frame is displayed
    frame_count = 5, -- vertical frame count
  }
})
vl_cosmetics.register_cosmetic("Sparkleb", {
  cosmetic_type = "body",
  glow = 14,
  textures = {
    "vlc_sparkle_5.png",
  },
  texture_animation = {
    index = 2, -- texture index
    delay = 0.2, -- how long each frame is displayed
    frame_count = 5, -- vertical frame count
  }
})
vl_cosmetics.register_cosmetic("Sparklear", {
  cosmetic_type = "arm_right",
  glow = 14,
  textures = {
    "vlc_sparkle_5.png",
  },
  texture_animation = {
    index = 1, -- texture index
    delay = 0.2, -- how long each frame is displayed
    frame_count = 5, -- vertical frame count
  }
})
vl_cosmetics.register_cosmetic("Sparkleal", {
  cosmetic_type = "arm_left",
  glow = 14,
  textures = {
    "vlc_sparkle_5.png",
  },
  texture_animation = {
    index = 1, -- texture index
    delay = 0.2, -- how long each frame is displayed
    frame_count = 5, -- vertical frame count
  }
})
vl_cosmetics.register_cosmetic("Sparklelr", {
  cosmetic_type = "leg_right",
  glow = 14,
  textures = {
    "vlc_sparkle_5.png",
  },
  texture_animation = {
    index = 1, -- texture index
    delay = 0.2, -- how long each frame is displayed
    frame_count = 5, -- vertical frame count
  }
})
vl_cosmetics.register_cosmetic("Sparklell", {
  cosmetic_type = "leg_left",
  glow = 14,
  textures = {
    "vlc_sparkle_5.png",
  },
  texture_animation = {
    index = 1, -- texture index
    delay = 0.2, -- how long each frame is displayed
    frame_count = 5, -- vertical frame count
  }
})


vl_cosmetics.register_cosmetic_collection("Sparkle", {
  Head = "Sparkleh",
  Body = "Sparkleb",
  Arm_Right = "Sparklear",
  Arm_Left = "Sparkleal",
  Leg_Right = "Sparklelr",
  Leg_Left = "Sparklell",
})
