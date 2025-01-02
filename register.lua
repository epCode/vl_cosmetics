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

vl_cosmetics.register_cosmetic_collection("Elf", {
  Head = "ElfHead",
  Body = "ElfBody",
  Arm_Right = "ElfArmRight",
  Arm_Left = "ElfArmLeft",
  Leg_Right = "ElfLegRight",
  Leg_Left = "ElfLegLeft",
})


vl_cosmetics.register_cosmetic("AnimTest", {
  cosmetic_type = "head",
  textures = {
    "vlc_anim_test.png^[verticalframe:2:1",
  },
  glow = 14,
  on_step = function(self, dtime)
    self._timer = self._timer + dtime

    if self._timer > 0.3 then
      self._timer = 0
      local tex = self.object:get_properties().textures
      tex[2] = "vlc_anim_test.png^[verticalframe:30:"..(math.random(30)-1)

      self.object:set_properties({textures = tex})
    end
  end
})
