file = io.open("CAMERA-LOCALIZED.txt", "a")

while (true) do
	if (taseditor.engaged() and memory.readbyte(14) ~= 0) then
		file:write(emu.framecount() .. ":" .. (memory.readbyte(1887) + 1) .. "-" .. (memory.readbyte(1888) + 1) .. "," .. (256*memory.readbyte(109) + memory.readbyte(134) - memory.readbyte(941)), "\n")
	end
	emu.frameadvance()
end
