-- Name: Simple
-- Description: Help understand how Empty Epsilon works.
-- Type: Basic

--- Scenario
-- @script scenario_103_simple
require("utils.lua")

function init()
    
    gameState = 0
    spawnWorld()

    player = PlayerSpaceship():setTemplate("Atlantis"):setPosition(115, 70):setFaction("Human Navy")
    gStation = SpaceStation():setTemplate("Large Station"):setFaction("Human Navy"):setCallSign("DS9428"):setPosition(17506, 172)
    bStation = SpaceStation():setTemplate("Small Station"):setFaction("Exuari"):setCallSign("DS9431"):setPosition(24513, -11338)
    en1 = CpuShip():setFaction("Exuari"):setTemplate("Adder MK3"):setCallSign("UTI3"):setPosition(11009, -8):setWeaponStorage("HVLI", 1):orderIdle()

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
            en2 = CpuShip():setFaction("Exuari"):setTemplate("Atlantis X23"):setCallSign("SS6"):setPosition(30332, -14223):setWeaponStorage("Homing", 0):orderAttack(player)
            en3 = CpuShip():setFaction("Exuari"):setTemplate("Atlantis X23"):setCallSign("BR7"):setPosition(19972, -13638):setWeaponStorage("Homing", 0):orderAttack(player)
            en4 = CpuShip():setFaction("Exuari"):setTemplate("Atlantis X23"):setCallSign("VS5"):setPosition(24326, -5862):setWeaponStorage("Homing", 0):orderAttack(player)
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
    Mine():setPosition(21849, -6000)
    Mine():setPosition(4599, 3059)
    Mine():setPosition(4495, 2016)
    Mine():setPosition(28025, -4595)
    Mine():setPosition(28158, -3190)
    Mine():setPosition(28158, -2103)
    Mine():setPosition(21213, -5894)
    Mine():setPosition(21160, -5125)
    Mine():setPosition(26726, -5973)
    Mine():setPosition(27919, -5814)
    Mine():setPosition(26064, 2509)
    Mine():setPosition(25136, 3039)
    Mine():setPosition(23493, 3145)
    Mine():setPosition(28131, -460)
    Mine():setPosition(27601, 1104)
    Mine():setPosition(27071, 1953)
    Mine():setPosition(21133, -3561)
    Mine():setPosition(19092, -3455)
    Mine():setPosition(17820, -3535)
    Mine():setPosition(21239, 2324)
    Mine():setPosition(21213, -2474)
    Mine():setPosition(19861, -3296)
    Mine():setPosition(13116, -2051)
    Mine():setPosition(13255, 1912)
    Mine():setPosition(13081, 2850)
    Mine():setPosition(16680, -3508)
    Mine():setPosition(15408, -3482)
    Mine():setPosition(13791, -3588)
    Mine():setPosition(6650, -3059)
    Mine():setPosition(7867, -3233)
    Mine():setPosition(9327, -3233)
    Mine():setPosition(5607, -3059)
    Mine():setPosition(12038, -2955)
    Mine():setPosition(12977, -3233)
    Mine():setPosition(10891, -3059)
    Mine():setPosition(22141, 3278)
    Mine():setPosition(3418, 3615)
    Mine():setPosition(19092, 3914)
    Mine():setPosition(18085, 3994)
    Mine():setPosition(21239, 3464)
    Mine():setPosition(20418, 3835)
    Mine():setPosition(14003, 3755)
    Mine():setPosition(13116, 3615)
    Mine():setPosition(16521, 3782)
    Mine():setPosition(15063, 3808)
    Mine():setPosition(11656, 3824)
    Mine():setPosition(10613, 3789)
    Mine():setPosition(8041, 3824)
    Mine():setPosition(9396, 3754)
    Mine():setPosition(5156, 3754)
    Mine():setPosition(4530, 3406)
    Mine():setPosition(8875, 3650)
    Mine():setPosition(6198, 3580)
    Mine():setPosition(6998, 3685)
    Mine():setPosition(-997, 3476)
    Mine():setPosition(150, 3476)
    Mine():setPosition(1645, 3511)
    Mine():setPosition(-2214, 3546)
    Mine():setPosition(-4264, 2016)
    Mine():setPosition(-4125, 3511)
    Mine():setPosition(-3952, 904)
    Mine():setPosition(-3847, -973)
    Mine():setPosition(-3604, -2398)
    Mine():setPosition(-3673, -3267)
    Mine():setPosition(1228, -3128)
    Mine():setPosition(-1553, -3233)
    Mine():setPosition(-2457, -3163)
    Mine():setPosition(-580, -3198)
    Mine():setPosition(2931, -3337)
    Mine():setPosition(4426, -1738)
    Mine():setPosition(4460, -3024)
end




