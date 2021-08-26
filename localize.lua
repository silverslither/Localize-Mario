marioBool = false
file = io.open("MARIO-LOCALIZED.txt", "a")

function updateMario()
	marioBool = false
	smallMario = memory.readbyte(1876)
	
	if (memory.readbyte(181) == 1 and memory.readbyte(14) == 8) then
		marioBool = true
		return
	end
	
	if (memory.readbyte(14) ~= 0) then
		for x = 0, 255 do
			for y = 0, 239 do
				temp1, temp2, temp3, temp4 = emu.getscreenpixel(x, y, true)
				if (temp4 == 24) then
					marioBool = true
				end
			end
		end
	end
end

while (true) do
	if taseditor.engaged() then
		updateMario()
		if marioBool then
			file:write(emu.framecount() .. ":1," .. memory.readbyte(941) .. "," .. ((256 * (memory.readbyte(181) - 1)) + memory.readbyte(206) + (smallMario * 16)), "\n")
		else
			file:write(emu.framecount() .. ":0", "\n")
		end
	end
	emu.frameadvance()
end
