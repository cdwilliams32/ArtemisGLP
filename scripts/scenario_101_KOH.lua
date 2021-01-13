-- Name: King of the Hill
-- Description: Every two minutes points are rewarded to the ships in the middle rings. 1 point for the outer, 2 for the middle and 3 for the inner. Ships are respawned every two minutes as long as their team base is intact.
-- Type: Basic

--- Scenario
-- @script scenario_101_KOH

--run at start
function init()
    --generate tables
    playerShips = {}
    spaceStations = {}

    --spawn world
    spawnWorld()
    --spawn zones
    spawnZones()
    --spawn ships
    spawnShips()
end

--updates every 1 millisecond
function update(delta)
end

--spawns the spacestations and artifacts
function spawnWorld()
    --inner ring
    Artifact():setModel("artifact8"):setPosition(0,1750)
    Artifact():setModel("artifact8"):setPosition(0,-1750)
    Artifact():setModel("artifact8"):setPosition(1750,0)
    Artifact():setModel("artifact8"):setPosition(-1750,0)

    Artifact():setModel("artifact8"):setPosition(-1237.44,1237.44)
    Artifact():setModel("artifact8"):setPosition(1237.44,1237.44)
    Artifact():setModel("artifact8"):setPosition(1237.44,-1237.44)
    Artifact():setModel("artifact8"):setPosition(-1237.44,1237.44)

    --middle ring
end

--spawn the zones for play area and point rewarding
function spawnZones()
end

--spawn player ships
function spawnShips()
    Alpha1 = PlayerSpaceShip():setFaction("Alpha"):setCallsign("Alpha1"):setTemplate("Atlantis")
    Alpha2

    Bravo1
    Bravo2

    Charlie1
    Charlie2

    Delta1
    Delta2
end