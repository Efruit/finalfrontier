universe = {}

universe._nwdata = GetGlobalTable("universe")

function universe:GetHorizontalSectors()
    return self._nwdata.horzSectors
end

function universe:GetVerticalSectors()
    return self._nwdata.vertSectors
end

function universe:GetWorldWidth()
    return self._nwdata.width
end

function universe:GetWorldHeight()
    return self._nwdata.height
end

function universe:WrapCoordinates(x, y)
    return x - math.floor(x / self:GetHorizontalSectors()) * self:GetHorizontalSectors(),
        y - math.floor(y / self:GetVerticalSectors()) * self:GetVerticalSectors()
end

function universe:GetWorldPos(x, y)
    x, y = ((x / self:GetHorizontalSectors()) - 0.5) * self:GetWorldWidth(),
        ((y / self:GetVerticalSectors()) - 0.5) * self:GetWorldHeight()
    return Vector(x, y, 0) + self:GetPos()
end

function universe:GetUniversePos(vec)
    local diff = (vec - self:GetPos())
    return ((diff.x / self:GetWorldWidth()) + 0.5) * self:GetHorizontalSectors(),
        ((diff.y / self:GetWorldHeight()) + 0.5) * self:GetVerticalSectors()
end

function universe:GetSectorPos(vec)
    local x, y = self:GetUniversePos(vec)
    return math.floor(x) + 0.5, math.floor(y) + 0.5
end

function universe:GetSectorIndex(x, y)
    local xi, yi = self:WrapCoordinates(math.floor(x), math.floor(y))
    return xi + yi * self:GetHorizontalSectors() + 1, xi, yi
end
