local Helper = {}
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function getGameSeed()
	local gameData = ReplicatedStorage:FindFirstChild("GameData")
	if gameData then
		local seedObj = gameData:FindFirstChild("Seed")
		if seedObj then
			local seedNum = tonumber(seedObj.Value)
			if seedNum then
				return seedNum
			end
			
			local hash = 0
			local seedStr = tostring(seedObj.Value)
			for i = 1, #seedStr do
				hash = hash + string.byte(seedStr, i)
			end
			return hash
		end
	end
	return os.time()
end

function Helper:deltaWait(seconds)
	local elapsed = 0
	while elapsed < seconds do
		elapsed = elapsed + RunService.Heartbeat:Wait()
	end
end

function Helper:generateRandom(min, max, modifier)
	local seed = getGameSeed() + (modifier or 0)
	local rng = Random.new(seed)
	return rng:NextNumber(min, max)
end

function Helper:generateFullRandom(min, max, modifier)
	local seed = getGameSeed() + (modifier or 0)
	local rng = Random.new(seed)
	return rng:NextInteger(min, max)
end

return Helper
