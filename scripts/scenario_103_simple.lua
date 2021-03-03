-- Name: Simple
-- Description: Help understand how Empty Epsilon works.
-- Type: Basic

--- Scenario
-- @script scenario_103_simple
require("utils.lua")

function init()
    
    gameState = 0
    spawnWorld()

    player = PlayerSpaceship():setTemplate("Atlantis"):setPosition(115, 70):setFaction("Human Navy"):setCallSign("primus")
    gStation = SpaceStation():setTemplate("Large Station"):setFaction("Human Navy"):setCallSign("DS9428"):setPosition(17506, 172)
    bStation = SpaceStation():setTemplate("Small Station"):setFaction("Exuari"):setCallSign("DS9431"):setPosition(24513, -11338)
    en1 = CpuShip():setFaction("Exuari"):setTemplate("Adder MK3"):setCallSign("UTI3"):setPosition(11009, -8):setWeaponStorage("HVLI", 1):orderIdle()

    en2 = CpuShip():setFaction("Exuari"):setTemplate("Atlantis X23"):setCallSign("SS6"):setPosition(-271325, -334973):orderIdle():setWeaponStorage("Homing", 0):setWeaponStorage("HVLI", 16)
    en3 = CpuShip():setFaction("Exuari"):setTemplate("Atlantis X23"):setCallSign("BR7"):setPosition(-277237, -326680):orderIdle():setWeaponStorage("Homing", 0):setWeaponStorage("HVLI", 16)
    en4 = CpuShip():setFaction("Exuari"):setTemplate("Atlantis X23"):setCallSign("VS5"):setPosition(-281502, -334234):orderIdle():setWeaponStorage("Homing", 0):setWeaponStorage("HVLI", 16)


end

function update(delta)
    if gameState == 0
    then
        if distance(en1,player) < 7000
        then
            print("Attack!")
            en1:orderAttack(player)
            gameState = 1
        end
    end
    if gameState == 1
    then
        if not bStation:isValid()
        then
            en2:setPosition(30332, -14223):setWeaponStorage("Homing", 0):orderAttack(player)
            en3:setPosition(19972, -13638):setWeaponStorage("Homing", 0):orderAttack(player)
            en4:setPosition(24326, -5862):setWeaponStorage("Homing", 0):orderAttack(player)
            gameState = 2
        end
    end
    if not player:isValid()
    then
        victory("Exuari")
    end
    if player:isValid() and not en2:isValid() and not en3:isValid() and not en4:isValid()
    then
        victory("Human Navy")
    end
end

function spawnWorld()
    Mine():setPosition(57, 3317)
    Mine():setPosition(-1195, 3317)
    Mine():setPosition(-2478, 3308)
    Mine():setPosition(-3762, 1910)
    Mine():setPosition(-3715, -748)
    Mine():setPosition(-3697, -2015)
    Mine():setPosition(-3714, 600)
    Mine():setPosition(1328, 3339)
    Mine():setPosition(-3781, 3207)
    Mine():setPosition(23129, -6608)
    Mine():setPosition(23091, -5366)
    Mine():setPosition(1439, -3221)
    Mine():setPosition(3856, 3459)
    Mine():setPosition(2585, 3351)
    Mine():setPosition(3945, -3183)
    Mine():setPosition(2667, -3231)
    Mine():setPosition(147, -3224)
    Mine():setPosition(-1117, -3259)
    Mine():setPosition(-2404, -3229)
    Mine():setPosition(-3673, -3267)
    Mine():setPosition(27929, -7096)
    Mine():setPosition(27919, -5814)
    Mine():setPosition(28012, -4555)
    Mine():setPosition(7761, 3574)
    Mine():setPosition(6468, 3566)
    Mine():setPosition(5167, 3529)
    Mine():setPosition(5250, -3165)
    Mine():setPosition(4571, -2095)
    Mine():setPosition(9089, -3101)
    Mine():setPosition(6518, -3125)
    Mine():setPosition(4521, 1170)
    Mine():setPosition(4493, 2425)
    Mine():setPosition(4558, -851)
    Mine():setPosition(21794, -3217)
    Mine():setPosition(22614, -4226)
    Mine():setPosition(27713, -948)
    Mine():setPosition(28088, -3312)
    Mine():setPosition(28158, -2103)
    Mine():setPosition(26932, 124)
    Mine():setPosition(26203, 1255)
    Mine():setPosition(25258, 2220)
    Mine():setPosition(22994, 3452)
    Mine():setPosition(24190, 2936)
    Mine():setPosition(21727, 3777)
    Mine():setPosition(19249, 3844)
    Mine():setPosition(20418, 3835)
    Mine():setPosition(14092, 3697)
    Mine():setPosition(13491, 1263)
    Mine():setPosition(17946, 3802)
    Mine():setPosition(16678, 3782)
    Mine():setPosition(15394, 3791)
    Mine():setPosition(20565, -2884)
    Mine():setPosition(18021, -2873)
    Mine():setPosition(19293, -2952)
    Mine():setPosition(16736, -2927)
    Mine():setPosition(14205, -2927)
    Mine():setPosition(15464, -2993)
    Mine():setPosition(13510, -1794)
    Mine():setPosition(12898, -2969)
    Mine():setPosition(11615, -2995)
    Mine():setPosition(10362, -3046)
    Mine():setPosition(7814, -3088)
    Mine():setPosition(10279, 3638)
    Mine():setPosition(9003, 3594)
    Mine():setPosition(11547, 3660)
    Mine():setPosition(13445, 2563)
    Mine():setPosition(12809, 3702)
end