-- Name: Quiz
-- Description: Help understand how Empty Epsilon works.

--- Scenario
-- @script scenario_102_quiz

--run at start
function init()

    gameState = 0
    timer = 0
    supportComing = 0

    spawnWorld()

    player = PlayerSpaceship():setTemplate("Atlantis"):setPosition(24843, 9638):setFaction("USN")
    firstCPU =     CpuShip():setFaction("Exuari"):setTemplate("Adder MK3"):setCallSign("BR3"):setPosition(-16603, 778):setWeaponStorage("HVLI", 0):orderIdle()
    firstTriggerZone = Zone():setPoints(9515,-2180,8231,-3062,5343,2754,6787,3235)

    ambush1 = CpuShip():setFaction("Exuari"):setTemplate("Dreadnought"):setCallSign("VK7"):setPosition(940, -16751):orderIdle()
    ambush2 = CpuShip():setFaction("Exuari"):setTemplate("Dreadnought"):setCallSign("S6"):setPosition(-1107, -17714):orderIdle()
    ambush3 = CpuShip():setFaction("Exuari"):setTemplate("Dreadnought"):setCallSign("CCN5"):setPosition(-4960, -17594):orderIdle()

    poseidon1 = CpuShip():setFaction("USN"):setTemplate("Starhammer II"):setCallSign("PoseidonSpear1"):setPosition(-3956, 15426):orderIdle():setWeaponStorage("Homing", 3):setWeaponStorage("EMP", 1)
    poseidon2 = CpuShip():setFaction("USN"):setTemplate("Starhammer II"):setCallSign("PoseidonSpear2"):setPosition(-3248, 16921):orderIdle():setWeaponStorage("Homing", 3):setWeaponStorage("EMP", 1)
    poseidon3 = CpuShip():setFaction("USN"):setTemplate("Starhammer II"):setCallSign("PoseidonSpear3"):setPosition(-1114, 17226):orderIdle():setWeaponStorage("Homing", 3):setWeaponStorage("EMP", 1)

    DS449 = SpaceStation():setTemplate("Large Station"):setFaction("USN"):setCallSign("DS449"):setPosition(9408, 41938)
    2B9 = SpaceStation():setTemplate("Huge Station"):setFaction("USN"):setCallSign("2B9"):setPosition(-36111, 29775)
    DS450 = SpaceStation():setTemplate("Large Station"):setFaction("USN"):setCallSign("DS450"):setPosition(-61796, 2873)


    patrol1 = CpuShip():setFaction("USN"):setTemplate("Adder MK4"):setCallSign("CV11"):setPosition(5243, 40755):orderFlyTowards(DS449:getPosition()):setWeaponStorage("HVLI", 1)
    patrol2 = CpuShip():setFaction("USN"):setTemplate("Adder MK4"):setCallSign("NC12"):setPosition(1928, 43543):orderFlyTowards(DS449:getPosition()):setWeaponStorage("HVLI", 1)
    patrol3 = CpuShip():setFaction("USN"):setTemplate("Adder MK4"):setCallSign("CV10"):setPosition(722, 41132):orderFlyTowards(DS449:getPosition()):setWeaponStorage("HVLI", 1)

    EDP1 = CpuShip():setFaction("Exuari"):setTemplate("Defense platform"):setCallSign("CCN14"):setPosition(-28008, -24655):orderStandGround()
    EDP2 = CpuShip():setFaction("Exuari"):setTemplate("Defense platform"):setCallSign("CV15"):setPosition(-28469, -32251):orderStandGround()
    EDP3 = CpuShip():setFaction("Exuari"):setTemplate("Defense platform"):setCallSign("SS13"):setPosition(-35130, -27988):orderStandGround()
    ES = SpaceStation():setTemplate("Medium Station"):setFaction("Exuari"):setCallSign("DS458"):setPosition(-30707, -28673)


end

function update(delta)
    patrolUpdate()
    if firstTriggerZone:isInside(player)
    then
        firstCPU:orderAttack(player)
        gameState = 1
    end
    if (gameState == 1 and not firstCPU.isValid())
    then
        ambush1:orderAttack(player)
        ambush2:orderAttack(player)
        ambush3:orderAttack(player)
        ambush4:orderAttack(player)
        gameState = 2
    end
    if (gameState == 2)
    then
        if (timer < 240)
        then
            timer = timer + 1
        end
        if (timer = 120)
        then
            player:commandSendCommPlayer("Poseidon's Spear, dropping out of wrap.")
        end
        if (timer == 180)
        then
            local x,y = player:getPosition()
            x = x - 2500
            y = y + 1500
            poseidon1:setPosition(x,y)
            x = x + 2500
            y = y - 3000
            poseidon2:setPosition(x,y)
            x = x + 2500
            y = y + 3000
            poseidon3:setPosition(x,y)
        end
        if (timer == 240)
        then
            player:commandSendCommPlayer("Excuse the close wrap. We got these guys, report and dock to Station 2B9 in quadrant G3")
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
    if (gameState == 3 and player:isDocked(2B9))
    then
        if (timer == 0)
        then
            player:commandSendCommPlayer("Welcome to Station 2B9. Please stand by for next assignment.")
        end
        if (timer < 1800)
        then
            timer = timer + 1
        end
        if (timer == 1800)
        then
            player:commandSendCommPlayer("--New Orders--")
            player:commandSendCommPlayer("Engage and destroy the Exuari Station in quadrant D3")
            player:commandSendCommPlayer("If needed, suppot may be requested from Posedion's Spear")
            timer = 0
            gameState = 4
        end
    end
    if not ambush1.isValid() and not ambush2.isValid() and not ambush3.isValid() and gameState < 4
    then
        poseidon3:orderIdle()
        poseidon2:orderIdle()
        poseidon1:orderIdle()
    end
    if not ES.isValid()
    then
        victory("USN")
    end
    if not player.isValid()
    then
        victory("Exuari")
    end
    if supportComing == 1
    then
        if EDP1.isValid()
        then
            poseidon3:orderAttack(EDP1)
            poseidon2:orderAttack(EDP1)
            poseidon1:orderAttack(EDP1)
        end
        if EDP2.isValid() and not EDP1.isValid()
        then
            poseidon3:orderAttack(EDP2)
            poseidon2:orderAttack(EDP2)
            poseidon1:orderAttack(EDP2)
        end
        if EDP3.isValid() and not EDP1.isValid() and not EDP2.isValid()
        then
            poseidon3:orderAttack(EDP3)
            poseidon2:orderAttack(EDP3)
            poseidon1:orderAttack(EDP3)
        end
        if ES:isValid() and not EDP3.isValid() and not EDP1.isValid() and not EDP2.isValid()
        then
            poseidon3:orderAttack(ES)
            poseidon2:orderAttack(ES)
            poseidon1:orderAttack(ES)
        end
    end
end

function patrolUpdate()
    if (distance(patrol1,DS449) < 150 or distance(patrol2,DS449) < 150 or distance(patrol3,DS449) < 150)
    then
        patrol1:orderFlyTowards(DS450)
        patrol2:orderFlyTowards(DS450)
        patrol3:orderFlyTowards(DS450)
    end
    if (distance(patrol1,DS450) < 150 or distance(patrol2,DS450) < 150 or distance(patrol3,DS450) < 150)
    then
        patrol1:orderFlyTowards(DS449)
        patrol2:orderFlyTowards(DS449)
        patrol3:orderFlyTowards(DS449)
    end
end

function spawnWorld()
    Nebula():setPosition(-48313, 39166)
    Nebula():setPosition(27072, -6279)
    Nebula():setPosition(31658, 17497)
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
