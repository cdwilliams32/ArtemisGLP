-- Name: Quiz
-- Description: After investigating a point of interest, Atlantis needs to return back to base for its next mission. Be careful, there is sightings of enemy ships.
-- Type: Basic

--- Scenario
-- @script scenario_102_quiz
require("utils.lua")

--run at start
function init()

    gameState = 0
    timer = 0
    supportComing = 0

    spawnWorld()

    player = PlayerSpaceship():setTemplate("Atlantis"):setPosition(17571, 3998):setFaction("USN")
    firstCPU = CpuShip():setFaction("Exuari"):setTemplate("Adder MK3"):setCallSign("BR3"):setPosition(-1699, -3808):setWeaponStorage("HVLI", 0)


    poseidon1 = CpuShip():setFaction("USN"):setTemplate("Starhammer II"):setCallSign("PoseidonSpear1"):setPosition(-19015, 20474):orderIdle():setWeaponStorage("Homing", 3):setWeaponStorage("EMP", 1)
    poseidon2 = CpuShip():setFaction("USN"):setTemplate("Starhammer II"):setCallSign("PoseidonSpear2"):setPosition(-25747, 25130):orderIdle():setWeaponStorage("Homing", 3):setWeaponStorage("EMP", 1)
    poseidon3 = CpuShip():setFaction("USN"):setTemplate("Starhammer II"):setCallSign("PoseidonSpear3"):setPosition(-26483, 18603):orderIdle():setWeaponStorage("Homing", 3):setWeaponStorage("EMP", 1)

    DS449 = SpaceStation():setTemplate("Large Station"):setFaction("USN"):setCallSign("DS449"):setPosition(-7795, 24427)
    B9 = SpaceStation():setTemplate("Huge Station"):setFaction("USN"):setCallSign("B9"):setPosition(-23806, 21502)
    DS450 = SpaceStation():setTemplate("Large Station"):setFaction("USN"):setCallSign("DS450"):setPosition(-32090, 11834)


    patrol1 = CpuShip():setFaction("USN"):setTemplate("Adder MK4"):setCallSign("CV11"):setPosition(-10341, 21550):orderFlyTowards(DS449:getPosition()):setWeaponStorage("HVLI", 1)
    patrol2 = CpuShip():setFaction("USN"):setTemplate("Adder MK4"):setCallSign("NC12"):setPosition(-11898, 22393):orderFlyTowards(DS449:getPosition()):setWeaponStorage("HVLI", 1)
    patrol3 = CpuShip():setFaction("USN"):setTemplate("Adder MK4"):setCallSign("CV10"):setPosition(-11042, 22893):orderFlyTowards(DS449:getPosition()):setWeaponStorage("HVLI", 1)

    ES = SpaceStation():setTemplate("Medium Station"):setFaction("Exuari"):setCallSign("DS458"):setPosition(-39840, -10264)
    EDP1 = CpuShip():setFaction("Exuari"):setTemplate("Defense platform"):setCallSign("CCN14"):setPosition(-44263, -9579):orderRoaming()
    EDP2 = CpuShip():setFaction("Exuari"):setTemplate("Defense platform"):setCallSign("CV15"):setPosition(-37602, -13842):orderRoaming()
    EDP3 = CpuShip():setFaction("Exuari"):setTemplate("Defense platform"):setCallSign("SS13"):setPosition(-37141, -6246):orderRoaming()
    

end

function update(delta)
    patrolUpdate()
    if gameState == 0
    then
        if distance(firstCPU,player) < 15000
        then
            print("Attack!")
            firstCPU:orderAttack(player)
            gameState = 1
        end
    end
    if (gameState == 1 and not firstCPU:isValid())
    then
        ambush1 = CpuShip():setFaction("Exuari"):setTemplate("Dreadnought"):setCallSign("CCN5"):setPosition(-1723, -2476):orderIdle()
        ambush2 = CpuShip():setFaction("Exuari"):setTemplate("Dreadnought"):setCallSign("VK7"):setPosition(4900, 4650):orderIdle()
        ambush3 = CpuShip():setFaction("Exuari"):setTemplate("Dreadnought"):setCallSign("S6"):setPosition(9175, -5262):orderIdle()
        print("Ambush!")
        local x,y = player:getPosition()
        x = x - 2500
        y = y + 1500
        ambush1:setPosition(x,y)
        x = x + 2500
        y = y - 4500
        ambush2:setPosition(x,y)
        x = x + 2500
        y = y + 4500
        ambush3:setPosition(x,y)
        ambush1:orderAttack(player)
        ambush2:orderAttack(player)
        ambush3:orderAttack(player)
        gameState = 2
    end
    if (gameState == 2)
    then
        if (timer < 2400)
        then
            timer = timer + 1
        end
        if (timer == 1200)
        then
            print("Poseidon's Spear, dropping out of wrap.")
            poseidon1:sendCommsMessage(player,"Poseidon's Spear, dropping out of wrap.")
        end
        if (timer == 1600)
        then
            local x,y = player:getPosition()
            x = x - 3500
            y = y + 2500
            poseidon1:setPosition(x,y)
            x = x + 3500
            y = y - 5500
            poseidon2:setPosition(x,y)
            x = x + 3500
            y = y + 5500
            poseidon3:setPosition(x,y)
        end
        if (timer == 2000)
        then
            print("Excuse the close wrap. We got these guys, report and dock to Station B9 in quadrant G3")
            poseidon1:sendCommsMessage(player,"Excuse the close wrap. We got these guys, report and dock to Station B9 in quadrant G3")
            poseidon1:orderAttack(ambush1)
            poseidon2:orderAttack(ambush2)
            poseidon3:orderAttack(ambush3)
            ambush1:orderAttack(poseidon1)
            ambush2:orderAttack(poseidon2)
            ambush3:orderAttack(poseidon3)
            ambush1:setHull(10)
            ambush2:setHull(10)
            ambush3:setHull(10)
            gameState = 3
            timer = 0
        end
    end
    if (gameState == 3 and player:isDocked(B9))
    then
        if (timer == 0)
        then
            print("Welcome to Station B9. Please stand by for next assignment.")
            B9:sendCommsMessage(player,"Welcome to Station B9. Please stand by for next assignment.")
        end
        if (timer < 1800)
        then
            timer = timer + 1
        end
        if (timer == 1800)
        then
            print("--New Orders--")
            B9:sendCommsMessage(player,"--New Orders--")
            print("Engage and destroy the Exuari Station in quadrant D3")
            B9:sendCommsMessage(player,"Engage and destroy the Exuari Station in quadrant D3")
            B9:sendCommsMessage(player,"If needed, suppot may be requested from Posedion's Spear")
            print("If needed, suppot may be requested from Posedion's Spear")
            timer = 0
            gameState = 4
        end
    end
    if not ambush1:isValid() and not ambush2:isValid() and not ambush3:isValid() and gameState < 4
    then
        poseidon3:orderIdle()
        poseidon2:orderIdle()
        poseidon1:orderIdle()
    end
    if not ES:isValid()
    then
        victory("USN")
    end
    if not player:isValid()
    then
        victory("Exuari")
    end
    if supportComing == 1
    then
        local x,y = player:getPosition()
            x = x - 3500
            y = y + 2500
            poseidon1:setPosition(x,y)
            x = x + 3500
            y = y - 5500
            poseidon2:setPosition(x,y)
            x = x + 3500
            y = y + 5500
            poseidon3:setPosition(x,y)
        if EDP1:isValid()
        then
            poseidon3:orderAttack(EDP1)
            poseidon2:orderAttack(EDP1)
            poseidon1:orderAttack(EDP1)
        end
        if EDP2:isValid() and not EDP1:isValid()
        then
            poseidon3:orderAttack(EDP2)
            poseidon2:orderAttack(EDP2)
            poseidon1:orderAttack(EDP2)
        end
        if EDP3:isValid() and not EDP1:isValid() and not EDP2:isValid()
        then
            poseidon3:orderAttack(EDP3)
            poseidon2:orderAttack(EDP3)
            poseidon1:orderAttack(EDP3)
        end
        if ES:isValid() and not EDP3:isValid() and not EDP1:isValid() and not EDP2:isValid()
        then
            poseidon3:orderAttack(ES)
            poseidon2:orderAttack(ES)
            poseidon1:orderAttack(ES)
        end
    end
end

function patrolUpdate()
    if (distance(patrol1,DS449) < 1500 or distance(patrol2,DS449) < 1500 or distance(patrol3,DS449) < 1500)
    then
        patrol1:orderFlyTowards(DS450:getPosition())
        patrol2:orderFlyTowards(DS450:getPosition())
        patrol3:orderFlyTowards(DS450:getPosition())
    end
    if (distance(patrol1,DS450) < 1500 or distance(patrol2,DS450) < 1500 or distance(patrol3,DS450) < 1500)
    then
        patrol1:orderFlyTowards(DS449:getPosition())
        patrol2:orderFlyTowards(DS449:getPosition())
        patrol3:orderFlyTowards(DS449:getPosition())
    end
end

function spawnWorld()
    Nebula():setPosition(-48313, 39166)
    Nebula():setPosition(22233, 12896)
    Nebula():setPosition(28285, 7257)
    Nebula():setPosition(26518, -31)
    Nebula():setPosition(27072, -6279)
    Nebula():setPosition(31658, 17497)
    Nebula():setPosition(-5748, -17210)
    Nebula():setPosition(-5756, -3031)
    Nebula():setPosition(-40823, 1760)
    Nebula():setPosition(-13490, -8684)
    Nebula():setPosition(-13473, 1405)
    Nebula():setPosition(35943, 4570)
    Nebula():setPosition(36602, 31095)
    Nebula():setPosition(-20652, -12624)
    Nebula():setPosition(32784, 44490)
    Nebula():setPosition(34622, -24229)
    Nebula():setPosition(15971, -19962)
    Nebula():setPosition(8424, -13978)
    Nebula():setPosition(5295, -48993)
    Nebula():setPosition(13254, 14222)
    Nebula():setPosition(-20503, -45035)
    Nebula():setPosition(-3204, 15503)
    Nebula():setPosition(36142, -19320)
    Nebula():setPosition(13124, -5645)
    Nebula():setPosition(46306, -31904)
    Nebula():setPosition(11847, -30580)
    Nebula():setPosition(45118, -34190)
    Nebula():setPosition(-28377, 5991)
    Nebula():setPosition(26245, -32603)
    Nebula():setPosition(-38712, -45330)
    Nebula():setPosition(-12185, -23710)
    Nebula():setPosition(-387, -19025)
    Nebula():setPosition(29319, 40987)
    Nebula():setPosition(-30073, -17985)
    Nebula():setPosition(-43223, -20866)
    Nebula():setPosition(7486, 28855)
    Nebula():setPosition(29225, 36944)
    Nebula():setPosition(-3240, -28476)
    Nebula():setPosition(11057, -26513)
    Nebula():setPosition(-28394, -4098)
    Nebula():setPosition(-21398, -36221)
    Nebula():setPosition(7941, 7454)
    Nebula():setPosition(-8409, -20597)
    Nebula():setPosition(10777, 19587)
    Nebula():setPosition(-39275, -35610)
    Nebula():setPosition(8039, -25789)
    Nebula():setPosition(36379, 26386)
    Nebula():setPosition(35429, -9796)
    Nebula():setPosition(37710, 11858)
    Nebula():setPosition(-19980, -32712)
    Nebula():setPosition(3648, 13920)
    Nebula():setPosition(22604, -8170)
    Nebula():setPosition(14770, -27236)
    Nebula():setPosition(-49165, -4784)
    Nebula():setPosition(-20660, 1555)
    Nebula():setPosition(17693, 30443)
    Nebula():setPosition(48160, 41465)
    Nebula():setPosition(-12253, -20557)
    Nebula():setPosition(23779, 23076)
    Nebula():setPosition(35720, 36548)
    Nebula():setPosition(-47216, 47725)
    Nebula():setPosition(17058, 17845)
    Nebula():setPosition(31702, 347)
end

function sendPoseidonSpear()
    supportComing = 1
end
