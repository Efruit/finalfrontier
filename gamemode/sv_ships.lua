ships = {}

ships._dict = {}
ships._nwdata = {}

function ships.Add(ship)
    local name = ship:GetName()
    if not name or ships._dict[name] then return end
    
    ships._dict[name] = ship
    table.insert(ships._nwdata, name)
    ships._UpdateNWData()

    local x, y = ship:GetCoordinates()
    local sector = universe:GetSector(x, y)
    MsgN("Ship added in sector " .. sector:GetSectorName()
        .. " : [" .. x .. ", " .. y .. "] (" .. name .. ")")
end

function ships.GetAll()
    return ships._dict
end

function ships.GetByName(name)
    return ships._dict[name]
end

function ships.GetRoomByName(name)
    for _, ship in pairs(ships._dict) do
        local room = ship:GetRoomByName(name)
        if room then return room end
    end
    
    return nil
end

function ships.InitPostEntity()
    local classOrder = {
        "info_ff_universe",
        "info_ff_ship",
        "info_ff_room",
        "info_ff_roomcorner",
        "info_ff_roomdetail",
        "info_ff_transtarget",
        "info_ff_damageeffect",
        "info_ff_door",
        "info_ff_screen",
        "info_ff_moduleslot"
    }

    for _1, class in ipairs(classOrder) do
        for _2, ent in ipairs(ents.FindByClass(class)) do
            ent:InitPostEntity()
        end
    end
end

function ships.FindCurrentShip(ply)
    local pos = ply:GetPos()
    for _, ship in pairs(ships._dict) do
        if ship:IsPointInside(pos.x, pos.y) then return ship end
    end
    return nil
end

function ships._UpdateNWData()
    SetGlobalTable("ships", ships._nwdata)
end
