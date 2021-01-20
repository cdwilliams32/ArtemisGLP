-- Name: Quiz
-- Description: Help understand how Empty Epsilon works.

--- Scenario
-- @script scenario_102_quiz

--run at start
function init()

    gameState = 0

    spawnWorld()

    player = PlayerSpaceship():setTemplate("Atlantis"):setPosition(24843, 9638):setFaction("USN")
    firstCPU = CpuShip():setFaction("Exuari"):setTemplate("Adder MK3"):setCallSign("BR3"):setPosition(-7703, 788):orderIdle():setWeaponStorage("HVLI", 1)
    firstTriggerZone = Zone():setPoints(9515,-2180,8231,-3062,5343,2754,6787,3235)

    ambush1 = CpuShip():setFaction("Exuari"):setTemplate("Dreadnought"):setCallSign("VK7"):setPosition(940, -16751):orderIdle()
    ambush2 = CpuShip():setFaction("Exuari"):setTemplate("Dreadnought"):setCallSign("S6"):setPosition(-1107, -17714):orderIdle()
    ambush3 = CpuShip():setFaction("Exuari"):setTemplate("Dreadnought"):setCallSign("CCN5"):setPosition(-4960, -17594):orderIdle()
    ambush4 = CpuShip():setFaction("Exuari"):setTemplate("Dreadnought"):setCallSign("CV4"):setPosition(-9235, -17835):orderIdle()

    poseidon1 = CpuShip():setFaction("USN"):setTemplate("Starhammer II"):setCallSign("PoseidonSpear1"):setPosition(-3956, 15426):orderIdle():setWeaponStorage("Homing", 3):setWeaponStorage("EMP", 1)
    poseidon2 = CpuShip():setFaction("USN"):setTemplate("Starhammer II"):setCallSign("PoseidonSpear2"):setPosition(-3248, 16921):orderIdle():setWeaponStorage("Homing", 3):setWeaponStorage("EMP", 1)
    poseidon3 = CpuShip():setFaction("USN"):setTemplate("Starhammer II"):setCallSign("PoseidonSpear3"):setPosition(-1114, 17226):orderIdle():setWeaponStorage("Homing", 3):setWeaponStorage("EMP", 1)




end

function update(delta)
    if firstTriggerZone:isInside(player)
    then
        firstCPU:orderAttack(player)
        gameState = 1
    end
    if (gameState == 1 && not firstCPU.isValid())
    then
        ambush1:orderAttack(player)
        ambush2:orderAttack(player)
        ambush3:orderAttack(player)
        ambush4:orderAttack(player)
        gameState = 2
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
