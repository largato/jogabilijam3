local vertical_lanes = 8;
local upmost_unit = 50
local vertical_increment = CONF_SCREEN_HEIGHT / vertical_lanes;
local horizontal_increment = 150

local melee_life = 300;
local melee_damage = 30;

local medic_life = 200;
local medic_damage = -20;

local gunner_life = 100;
local gunner_damage = 70;

local tank_life = 1500;
local tank_damage = 200;

return {
    { unit=Melee, x=10, y=upmost_unit,                      life=melee_life, damage=melee_damage, time=0 },
    -- { unit=Melee, x=0, y=upmost_unit + vertical_increment,     life=melee_life, damage=melee_damage, time=0 },
    { unit=Melee, x=10, y=upmost_unit + vertical_increment * 2, life=melee_life, damage=melee_damage, time=0 },
    -- { unit=Melee, x=0, y=upmost_unit + vertical_increment * 3, life=melee_life, damage=melee_damage, time=0 },
    { unit=Melee, x=10, y=upmost_unit + vertical_increment * 4, life=melee_life, damage=melee_damage, time=0 },
    -- { unit=Melee, x=0, y=upmost_unit + vertical_increment * 5, life=melee_life, damage=melee_damage, time=0 },
    { unit=Melee, x=10, y=upmost_unit + vertical_increment * 6, life=melee_life, damage=melee_damage, time=0 },
    -- { unit=Melee, x=0, y=upmost_unit + vertical_increment * 7, life=melee_life, damage=melee_damage, time=0 },

    { unit=Gunner, x=-20, y=upmost_unit,                      life=gunner_life, damage=gunner_damage, time=10 },
    { unit=Gunner, x=-20, y=upmost_unit + vertical_increment * 7, life=gunner_life, damage=gunner_damage, time=10 },


    { unit=Medic, x=0, y=upmost_unit + vertical_increment * 3, life=100, damage=medic_damage, time=20 },
    { unit=Medic, x=0, y=upmost_unit + vertical_increment * 6, life=100, damage=medic_damage, time=20 },

    { unit=Melee, x=0, y=upmost_unit,                      life=melee_life, damage=melee_damage, time=25 },
    { unit=Melee, x=0, y=upmost_unit + vertical_increment * 2, life=melee_life, damage=melee_damage, time=25 },
    { unit=Melee, x=0, y=upmost_unit + vertical_increment * 4, life=melee_life, damage=melee_damage, time=25 },
    { unit=Melee, x=0, y=upmost_unit + vertical_increment * 6, life=melee_life, damage=melee_damage, time=25 },


    { unit=Gunner, x=0, y=upmost_unit + vertical_increment * 2, life=gunner_life, damage=melee_damage, time=30 },
    { unit=Gunner, x=0, y=upmost_unit + vertical_increment * 6, life=gunner_life, damage=melee_damage, time=30 },

    { unit=Gunner, x=0, y=upmost_unit,                      life=gunner_life, damage=gunner_damage, time=35 },
    { unit=Gunner, x=0, y=upmost_unit + vertical_increment * 7, life=gunner_life, damage=gunner_damage, time=35 },

    { unit=Tank, x=0, y=upmost_unit + vertical_increment * 2, life=tank_life, damage=tank_damage, time=35 },

    { unit=Melee, x=0, y=upmost_unit,                      life=melee_life, damage=melee_damage, time=40 },
    -- { unit=Melee, x=0, y=upmost_unit + vertical_increment,     life=melee_life, damage=melee_damage, time=40 },
    { unit=Melee, x=0, y=upmost_unit + vertical_increment * 2, life=melee_life, damage=melee_damage, time=40 },
    -- { unit=Melee, x=0, y=upmost_unit + vertical_increment * 3, life=melee_life, damage=melee_damage, time=40 },
    { unit=Melee, x=0, y=upmost_unit + vertical_increment * 4, life=melee_life, damage=melee_damage, time=40 },
    -- { unit=Melee, x=0, y=upmost_unit + vertical_increment * 5, life=melee_life, damage=melee_damage, time=40 },
    { unit=Melee, x=0, y=upmost_unit + vertical_increment * 6, life=melee_life, damage=melee_damage, time=40 },
    -- { unit=Melee, x=0, y=upmost_unit + vertical_increment * 7, life=melee_life, damage=melee_damage, time=40 },

    { unit=Gunner, x=0, y=upmost_unit,                      life=gunner_life, damage=gunner_damage, time=42 },
    { unit=Gunner, x=0, y=upmost_unit + vertical_increment * 7, life=gunner_life, damage=gunner_damage, time=42 },


    { unit=Gunner, x=0, y=upmost_unit + vertical_increment * 3, life=gunner_life, damage=gunner_damage, time=45 },
    { unit=Gunner, x=0, y=upmost_unit + vertical_increment * 6, life=gunner_life, damage=gunner_damage, time=45 },

    { unit=Melee, x=0, y=upmost_unit,                      life=melee_life, damage=melee_damage, time=50 },
    { unit=Melee, x=0, y=upmost_unit + vertical_increment,     life=melee_life, damage=melee_damage, time=50 },
    { unit=Melee, x=0, y=upmost_unit + vertical_increment * 2, life=melee_life, damage=melee_damage, time=50 },
    { unit=Melee, x=0, y=upmost_unit + vertical_increment * 3, life=melee_life, damage=melee_damage, time=50 },
    { unit=Melee, x=0, y=upmost_unit + vertical_increment * 4, life=melee_life, damage=melee_damage, time=50 },
    { unit=Melee, x=0, y=upmost_unit + vertical_increment * 5, life=melee_life, damage=melee_damage, time=50 },
    { unit=Melee, x=0, y=upmost_unit + vertical_increment * 6, life=melee_life, damage=melee_damage, time=50 },
    { unit=Melee, x=0, y=upmost_unit + vertical_increment * 7, life=melee_life, damage=melee_damage, time=50 },

    { unit=Tank, x=0, y=upmost_unit + vertical_increment * 2, life=tank_life, damage=tank_damage, time=55 },
    { unit=Tank, x=0, y=upmost_unit + vertical_increment * 5, life=tank_life, damage=tank_damage, time=55 },

    -- Final wave
    
    { unit=Tank, x=0, y=0, life=tank_life, damage=tank_damage, time=160 },
    { unit=Tank, x=0, y=vertical_increment, life=tank_life, damage=tank_damage, time=160 },
    { unit=Tank, x=0, y=vertical_increment*2, life=tank_life, damage=tank_damage, time=160 },
    { unit=Tank, x=0, y=vertical_increment*3, life=tank_life, damage=tank_damage, time=160 },
    { unit=Tank, x=0, y=vertical_increment*4, life=tank_life, damage=tank_damage, time=160 },
    { unit=Tank, x=0, y=vertical_increment*5, life=tank_life, damage=tank_damage, time=160 },
    { unit=Tank, x=0, y=vertical_increment*6, life=tank_life, damage=tank_damage, time=160 },
    { unit=Tank, x=0, y=vertical_increment*7, life=tank_life, damage=tank_damage, time=160 },

    { unit=Tank, x=horizontal_increment, y=vertical_increment*10, life=tank_life, damage=tank_damage, time=160 },
    { unit=Tank, x=horizontal_increment*2, y=vertical_increment*10, life=tank_life, damage=tank_damage, time=160 },
    { unit=Tank, x=horizontal_increment*3, y=vertical_increment*10, life=tank_life, damage=tank_damage, time=160 },
    { unit=Tank, x=horizontal_increment*4, y=vertical_increment*10, life=tank_life, damage=tank_damage, time=160 },
    { unit=Tank, x=horizontal_increment*5, y=vertical_increment*10, life=tank_life, damage=tank_damage, time=160 },
    { unit=Tank, x=horizontal_increment*6, y=vertical_increment*10, life=tank_life, damage=tank_damage, time=160 },
    { unit=Tank, x=horizontal_increment*7, y=vertical_increment*10, life=tank_life, damage=tank_damage, time=160 },
    { unit=Tank, x=horizontal_increment*8, y=vertical_increment*10, life=tank_life, damage=tank_damage, time=160 },
    { unit=Tank, x=horizontal_increment*9, y=vertical_increment*10, life=tank_life, damage=tank_damage, time=160 },

    { unit=Tank, x=horizontal_increment, y=0, life=tank_life, damage=tank_damage, time=160 },
    { unit=Tank, x=horizontal_increment*2, y=0, life=tank_life, damage=tank_damage, time=160 },
    { unit=Tank, x=horizontal_increment*3, y=0, life=tank_life, damage=tank_damage, time=160 },
    { unit=Tank, x=horizontal_increment*4, y=0, life=tank_life, damage=tank_damage, time=160 },
    { unit=Tank, x=horizontal_increment*5, y=0, life=tank_life, damage=tank_damage, time=160 },
    { unit=Tank, x=horizontal_increment*6, y=0, life=tank_life, damage=tank_damage, time=160 },
    { unit=Tank, x=horizontal_increment*7, y=0, life=tank_life, damage=tank_damage, time=160 },
    { unit=Tank, x=horizontal_increment*8, y=0, life=tank_life, damage=tank_damage, time=160 },
    { unit=Tank, x=horizontal_increment*9, y=0, life=tank_life, damage=tank_damage, time=160 },
}
