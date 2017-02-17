local textures = love.image.newImageData("wolftextures.png")
local texWidth = 64
local texHeight = 64
local map = {
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,2,2,2,2,2,0,0,0,0,3,0,3,0,3,0,0,0,1},
	{1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,3,0,0,0,3,0,0,0,1},
	{1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,2,2,0,2,2,0,0,0,0,3,0,3,0,3,0,0,0,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,4,0,4,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,4,0,0,0,0,4,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,4,0,4,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,4,0,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
}

local buffer = {}
for y = 1, love.graphics.getHeight() do
	local temp = {}
	for x = 1, love.graphics.getWidth() do
		temp[#temp+1] = 0
	end
	buffer[#buffer+1] = temp
end

local texture = {}
for i = 1, 8 do
	local temp = {}
	for j = 1, texWidth * texHeight do
		temp[#temp+1] = 0
	end
	texture[#texture+1] = temp
end

for x = 1, texWidth do
	for y = 1, texHeight do
		local xorcolor = (x * 256 / texWidth) ^ (y * 256 / texHeight)
		local ycolor = y * 256 / texHeight
		local xycolor = y * 128 / texHiehgt + x * 128 / texWidth
		texture[1][texWidth * y + x] = 65536 * 254 * (x ~= y and x ~= texWidth - y)
		
	end
end

local posX, posY = 22, 12
local dirX, dirY = -1, 0
local planeX, planeY = 0, 0.66
local moveSpeed = .1
local rotSpeed = .04

function love.update(dt)
	if love.keyboard.isDown("up") then
		if map[math.floor(posY)][math.floor(posX + dirX * moveSpeed)] == 0 then posX = posX + dirX * moveSpeed end
		if map[math.floor(posY + dirY * moveSpeed)][math.floor(posX)] == 0 then posY = posY + dirY * moveSpeed end
	elseif love.keyboard.isDown("down") then
		if map[math.floor(posY - dirY * moveSpeed)][math.floor(posX)] == 0 then posY = posY - dirY * moveSpeed end
		if map[math.floor(posY)][math.floor(posX - dirX * moveSpeed)] == 0 then posX = posX - dirX * moveSpeed end
	end
	if love.keyboard.isDown("right") then
		local oldDirX = dirX
		dirX = dirX * math.cos(-rotSpeed) - dirY * math.sin(-rotSpeed)
		dirY = oldDirX * math.sin(-rotSpeed) + dirY * math.cos(-rotSpeed)
		local oldPlaneX = planeX
		planeX = planeX * math.cos(-rotSpeed) - planeY * math.sin(-rotSpeed)
		planeY = oldPlaneX * math.sin(-rotSpeed) + planeY * math.cos(-rotSpeed)
	elseif love.keyboard.isDown("left") then
		local oldDirX = dirX
		dirX = dirX * math.cos(rotSpeed) - dirY * math.sin(rotSpeed)
		dirY = oldDirX * math.sin(rotSpeed) + dirY * math.cos(rotSpeed)
		local oldPlaneX = planeX
		planeX = planeX * math.cos(rotSpeed) - planeY * math.sin(rotSpeed)
		planeY = oldPlaneX * math.sin(rotSpeed) + planeY * math.cos(rotSpeed)
	end
end

function love.draw()
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight()
	for x = 0, w do
		local cameraX = 2 * x / w - 1
		local rayPosX = posX
		local rayPosY = posY
		local rayDirX = dirX + planeX * cameraX
		local rayDirY = dirY + planeY * cameraX

		local mapX = math.floor(rayPosX)
		local mapY = math.floor(rayPosY)

		local sideDistX, sideDistY
		local deltaDistX = math.sqrt(1 + (rayDirY * rayDirY) / (rayDirX * rayDirX))
		local deltaDistY = math.sqrt(1 + (rayDirX * rayDirX) / (rayDirY * rayDirY))
		local perpWallDist

		local stepX, stepY
		local hit = 0
		local side

		if rayDirX < 0 then
			stepX = -1
			sideDistX = (rayPosX - mapX) * deltaDistX
		else
			stepX = 1
			sideDistX = (mapX + 1 - rayPosX) * deltaDistX
		end
		if rayDirY < 0 then
			stepY = -1
			sideDistY = (rayPosY - mapY) * deltaDistY
		else
			stepY = 1
			sideDistY = (mapY + 1 - rayPosY) * deltaDistY
		end

		while hit == 0 do
			if sideDistX < sideDistY then
				sideDistX = sideDistX + deltaDistX
				mapX = mapX + stepX
				side = 0
			else
				sideDistY = sideDistY + deltaDistY
				mapY = mapY + stepY
				side = 1
			end

			if map[mapY][mapX] > 0 then hit = 1 end
		end

		if side == 0 then perpWallDist = (mapX - rayPosX + (1 - stepX) / 2) / rayDirX
		else 			  perpWallDist = (mapY - rayPosY + (1 - stepY) / 2) / rayDirY end

		lineHeight = h / perpWallDist
		drawStart = -lineHeight / 2 + h / 2
		if drawStart < 0 then drawStart = 0 end
		drawEnd = lineHeight / 2 + h / 2
		if drawEnd >= h then drawEnd = h - 1 end

		value = 255
		if side == 1 then value = 150 end
		local n = map[mapY][mapX]
		if n == 1 then
			love.graphics.setColor(value, 0, 0)
		elseif n == 2 then
			love.graphics.setColor(0, value, 0)
		elseif n == 3 then
			love.graphics.setColor(0, 0, value)
		elseif n == 4 then
			love.graphics.setColor(value, value, value)
		end
		love.graphics.line(x, drawStart, x, drawEnd)
	end

	love.graphics.setColor(textures:getPixel(1,1))
	love.graphics.rectangle("fill", 0, 0, 32, 32)
end
