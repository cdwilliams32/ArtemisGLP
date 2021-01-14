-- Name: King of the Hill
-- Description: Every two minutes points are rewarded to the ships in the middle rings. 1 point for the outer, 2 for the middle and 3 for the inner. Ships are respawned every two minutes as long as their team base is intact.
-- Type: Basic

--- Scenario
-- @script scenario_101_KOH

--run at start
function init()
    --generate tables and set time
    playerShips = {}
    spaceStations = {}
    teamPoints = {0,0,0,0}
    time = 0
    
    --spawn artifacts
    spawnArtifacts()
    --spawn zones
    spawnZones()
    --spawn ships
    spawnShips()
    --spawn stations
    spawnStations()
end

--updates every 1 millisecond
function update(delta)
    --check boundry
    checkBond()

    checkVictory()

    --checks points
    if (time == 3600 or time == 7200 or time == 100)
    then
        checkPoints()
        annoucePoints()
    end

    --respawn ships
    if (time == 200) -- will be set to 7200 to respawn ships every two minutes
    then
        respawn()
    end

    --reset clock
    if (time == 201) -- will be set to 7201 for reset every two minutes
    then
        time = 1
    end
    time = time + 1
end

function annoucePoints()
    local announce = "Alpha: " .. teamPoints[1] .. " Bravo: " .. teamPoints[2] .. " Charlie: " .. teamPoints[3] .. " Delta: " .. teamPoints[4]
    print(announce)
    globalMessage(announce)

end

function checkVictory()
    local victory = ""
    if teamPoints[1] == 20
    then
    end
end

function checkPoints()
    for i=1,8,1
    do
        if innerZone:isInside(playerShips[i])
        then
            if (i == 1 or i == 2)
            then
                teamPoints[1] = teamPoints[1] + 1
            end
            if (i == 3 or i == 4)
            then
                teamPoints[2] = teamPoints[2] + 1
            end
            if (i == 5 or i == 6)
            then
                teamPoints[3] = teamPoints[3] + 1
            end
            if (i == 7 or i == 8)
            then
                teamPoints[4] = teamPoints[4] + 1
            end
        end
        if middleZone:isInside(playerShips[i])
        then
            if (i == 1 or i == 2)
            then
                teamPoints[1] = teamPoints[1] + 1
            end
            if (i == 3 or i == 4)
            then
                teamPoints[2] = teamPoints[2] + 1
            end
            if (i == 5 or i == 6)
            then
                teamPoints[3] = teamPoints[3] + 1
            end
            if (i == 7 or i == 8)
            then
                teamPoints[4] = teamPoints[4] + 1
            end
        end
    end
end

function checkBond()
    for i=1,8,1
    do
        if not bondZone:isInside(playerShips[i])
        then
            playerShips[i]:destroy()
        end
    end
end

function respawn()
    print("Respawning Ships!")
    if spaceStations[1]:isValid()
    then
        for i=1,2,1
        do
            if not playerShips[i]:isValid()
            then
                table.remove(playerShips,i)
                table.insert(playerShips,i,respawnShips(i))
            end
        end    
    end
    if spaceStations[2]:isValid()
    then
        for i=3,4,1
        do
            if not playerShips[i]:isValid()
            then
                table.remove(playerShips,i)
                table.insert(playerShips,i,respawnShips(i))
            end
        end
    end
    if spaceStations[3]:isValid()
    then
        for i=5,6,1
        do
            if not playerShips[i]:isValid()
            then
                table.remove(playerShips,i)
                table.insert(playerShips,i,respawnShips(i))
            end
        end
    end
    if spaceStations[4]:isValid()
    then
        for i=7,8,1
        do
            if not playerShips[i]:isValid()
            then
                table.remove(playerShips,i)
                table.insert(playerShips,i,respawnShips(i))
            end
        end
    end

end

function respawnShips(index)
    if (index==1)
    then
        Alpha1 = PlayerSpaceship():setFaction("Alpha"):setCallSign("Alpha1"):setTemplate("Atlantis"):setPosition(-2491.26,-5595.47):setRotation(66)
        return Alpha1
    end
    if (index==2)
    then
        Alpha2 = PlayerSpaceship():setFaction("Alpha"):setCallSign("Alpha2"):setTemplate("Atlantis"):setPosition(-5595.47,-2491.26):setRotation(33)
        return Alpha2
    end
    if (index==3)
    then
        Bravo1 = PlayerSpaceship():setFaction("Bravo"):setCallSign("Bravo1"):setTemplate("Atlantis"):setPosition(2491.26,-5595.47):setRotation(123)
        return Bravo1
    end
    if (index==4)
    then
        Bravo2 = PlayerSpaceship():setFaction("Bravo"):setCallSign("Bravo2"):setTemplate("Atlantis"):setPosition(5595.47,-2491.26):setRotation(156)
        return Bravo2
    end
    if (index==5)
    then
        Charlie1 = PlayerSpaceship():setFaction("Charlie"):setCallSign("Charlie1"):setTemplate("Atlantis"):setPosition(-5595.47,2491.26):setRotation(336)
        return Charlie1
    end
    if (index==6)
    then
        Charlie2 = PlayerSpaceship():setFaction("Charlie"):setCallSign("Charlie2"):setTemplate("Atlantis"):setPosition(-2491.26,5595.47):setRotation(303)
        return Charlie2
    end
    if (index==7)
    then
        Delta1 = PlayerSpaceship():setFaction("Delta"):setCallSign("Delta1"):setTemplate("Atlantis"):setPosition(5595.47,2491.26):setRotation(204)
        return Delta1
    end
    if (index==8)
    then
        Delta2 = PlayerSpaceship():setFaction("Delta"):setCallSign("Delta2"):setTemplate("Atlantis"):setPosition(2491.26,5595.47):setRotation(237)
        return Delta2
    end
end

--spawns the spacestations and artifacts
function spawnArtifacts()
    --create the artifacts to visualize the bounderies

    --inner ring
    Artifact():setModel("artifact8"):setPosition(0,1750)
    Artifact():setModel("artifact8"):setPosition(0,-1750)
    Artifact():setModel("artifact8"):setPosition(1750,0)
    Artifact():setModel("artifact8"):setPosition(-1750,0)

    Artifact():setModel("artifact8"):setPosition(-1237.44,1237.44)
    Artifact():setModel("artifact8"):setPosition(1237.44,1237.44)
    Artifact():setModel("artifact8"):setPosition(1237.44,-1237.44)
    Artifact():setModel("artifact8"):setPosition(-1237.44,-1237.44)
    

    --middle ring
    Artifact():setModel("artifact8"):setPosition(0,3500)
    Artifact():setModel("artifact8"):setPosition(0,-3500)
    Artifact():setModel("artifact8"):setPosition(3500,0)
    Artifact():setModel("artifact8"):setPosition(-3500,0)

    Artifact():setModel("artifact8"):setPosition(-2474.87,2474.87)
    Artifact():setModel("artifact8"):setPosition(2474.87,2474.87)
    Artifact():setModel("artifact8"):setPosition(2474.87,-2474.87)
    Artifact():setModel("artifact8"):setPosition(-2474.87,-2474.87)

    Artifact():setModel("artifact8"):setPosition(-3197.41,1423.58)
    Artifact():setModel("artifact8"):setPosition(3197.41,1423.58)
    Artifact():setModel("artifact8"):setPosition(3197.41,-1423.58)
    Artifact():setModel("artifact8"):setPosition(-3197.41,-1423.58)

    Artifact():setModel("artifact8"):setPosition(-1423.58,3197.41)
    Artifact():setModel("artifact8"):setPosition(1423.58,3197.41)
    Artifact():setModel("artifact8"):setPosition(1423.58,-3197.41)
    Artifact():setModel("artifact8"):setPosition(-1423.58,-3197.41)

    --boundries
    Artifact():setModel("artifact8"):setPosition(0,8750)
    Artifact():setModel("artifact8"):setPosition(0,-8750)
    Artifact():setModel("artifact8"):setPosition(8750,0)
    Artifact():setModel("artifact8"):setPosition(-8750,0)

    Artifact():setModel("artifact8"):setPosition(-6187.18,6187.18)
    Artifact():setModel("artifact8"):setPosition(6187.18,6187.18)
    Artifact():setModel("artifact8"):setPosition(6187.18,-6187.18)
    Artifact():setModel("artifact8"):setPosition(-6187.18,-6187.18)

    Artifact():setModel("artifact8"):setPosition(-3558.95,7993.52)
    Artifact():setModel("artifact8"):setPosition(3558.95,7993.52)
    Artifact():setModel("artifact8"):setPosition(3558.95,-7993.52)
    Artifact():setModel("artifact8"):setPosition(-3558.95,-7993.52)

    Artifact():setModel("artifact8"):setPosition(-7993.52,3558.95)
    Artifact():setModel("artifact8"):setPosition(7993.52,3558.95)
    Artifact():setModel("artifact8"):setPosition(7993.52,-3558.95)
    Artifact():setModel("artifact8"):setPosition(-7993.52,-3558.95)


end

--spawn the zones for play area and point rewarding
function spawnZones()
    innerZone = Zone():setColor(0,0,0):setPoints(0,1750,-1237.44,1237.44,-1750,0,-1237.44,-1237.44,0,-1750,1237.44,-1237.44,1750,0,1237.44,1237.44)
    middleZone = Zone():setColor(255,255,255):setPoints(0,3500,-1423.58,3197.41,-2474.87,2474.87,-3197.41,1423.58,-3500,0,-3197.41,-1423.58,-2474.87,-2474.87,-1423.58,-3197.41,0,-3500,1423.58,-3197.41,2474.87,-2474.87,3197.41,-1423.58,3500,0,3197.41,1423.58,2474.87,2474.87,1423.58,3197.41)
    bondZone = Zone():setColor(0,0,0):setPoints(0,8750,-3558.95,7993.52,-6187.18,6187.18,-7993.52,3558.95,-8750,0,-7993.52,-3558.95,-6187.18,-6187.18,-3558.95,-7993.52,0,-8750,3558.95,-7993.52,6187.18,-6187.18,7993.52,-3558.95,8750,0,7993.52,3558.95,6187.18,6187.18,3558.95,7993.52)
end

--spawn player ships
function spawnShips()
    Alpha1 = PlayerSpaceship():setFaction("Alpha"):setCallSign("Alpha1"):setTemplate("Atlantis"):setPosition(-2491.26,-5595.47):setRotation(66)
    table.insert(playerShips, Alpha1)
    Alpha2 = PlayerSpaceship():setFaction("Alpha"):setCallSign("Alpha2"):setTemplate("Atlantis"):setPosition(-5595.47,-2491.26):setRotation(33)
    table.insert(playerShips, Alpha2)

    Bravo1 = PlayerSpaceship():setFaction("Bravo"):setCallSign("Bravo1"):setTemplate("Atlantis"):setPosition(2491.26,-5595.47):setRotation(123)
    table.insert(playerShips,Bravo1)
    Bravo2 = PlayerSpaceship():setFaction("Bravo"):setCallSign("Bravo2"):setTemplate("Atlantis"):setPosition(5595.47,-2491.26):setRotation(156)
    table.insert(playerShips,Bravo2)

    Charlie1 = PlayerSpaceship():setFaction("Charlie"):setCallSign("Charlie1"):setTemplate("Atlantis"):setPosition(-5595.47,2491.26):setRotation(336)
    table.insert(playerShips, Charlie1)
    Charlie2 = PlayerSpaceship():setFaction("Charlie"):setCallSign("Charlie2"):setTemplate("Atlantis"):setPosition(-2491.26,5595.47):setRotation(303)
    table.insert(playerShips, Charlie2)

    Delta1 = PlayerSpaceship():setFaction("Delta"):setCallSign("Delta1"):setTemplate("Atlantis"):setPosition(5595.47,2491.26):setRotation(204)
    table.insert(playerShips, Delta1)
    Delta2 = PlayerSpaceship():setFaction("Delta"):setCallSign("Delta2"):setTemplate("Atlantis"):setPosition(2491.26,5595.47):setRotation(237)
    table.insert(playerShips, Delta2)
end

--spawn space stations
function spawnStations()
    alphaStation = SpaceStation():setTemplate("Huge Station"):setCallSign("AlphaStation"):setFaction("Alpha"):setPosition(-4949.75,-4949.75)
    table.insert(spaceStations, alphaStation)
    bravoStation = SpaceStation():setTemplate("Huge Station"):setCallSign("BravoStation"):setFaction("Bravo"):setPosition(4949.75,-4949.75)
    table.insert(spaceStations, bravoStation)
    charlieStation = SpaceStation():setTemplate("Huge Station"):setCallSign("CharlieStation"):setFaction("Charlie"):setPosition(-4949.75,4949.75)
    table.insert(spaceStations, charlieStation)
    deltaStation = SpaceStation():setTemplate("Huge Station"):setCallSign("DeltaStation"):setFaction("Delta"):setPosition(4949.75,4949.75)
    table.insert(spaceStations, deltaStation)
end