LibraryOptions = {FileManip = {}}
Control = {}
local keyboard = require"keyboard"
local component = require "component"
local modem = component.modem
local serialization = require"serialization"
local thread = require"thread"
local computer = require"computer"
local filesystem = require"filesystem"
local event = require "event"
local debugmode = false

function sendFileToServer(dataString, pathToSave)
 --local filePath,dataString = read(file)
modem.send(variableCurrentAddress, port, "receiveFile")--begin
modem.send(variableCurrentAddress, port, pathToSave) --path
os.sleep(0.5)
modem.send(variableCurrentAddress, port, dataString) --data
end

function connect()
	addresses = {}
	local addressesCount = 1
	modem.broadcast(port, "connect")
	for i = 0, 10,1 do 
		local _, _, from, _, _, _ = event.pull(1, "modem_message") 
	
	if from ~= nil then
	print(from)

	addresses[addressesCount] = from
	print(addressesCount)
	addressesCount = addressesCount+1
	return addresses[1]
else 
	break
	print("nil address")
end end end

function currentAddress()
	local counter = 1
		for addressesCount = 0, 10, 1 do
			if addresses[addressesCount] ~=nil then
				print(counter..'.'..addresses[addressesCount])
				counter = counter +1
 			else
 			break 
 		end
 	end
 print ("choose address")
 	while true do
		local e = {event.pull()}
 			if e[1] == "key_down" then
			local currentPosition = tonumber((e[4]-1))
				if(keyboard.isControlDown()) then

					print("entering in debug")
					local debugCode = io.read()
 	 					if(debugCode ~= nil ) then
							debugmode = true
							CA = "debug"
							
						return CA
						end 
					end
							if (debugmode ~= true)then CA = addresses[currentPosition]
								print(currentPosition)
								if (CA ~= nil) then
									print("your chose: "..currentPosition..'.'..CA)
								break
									print (CA)
								else print("wrong position")
     						end
						end
				 	end
				end
return CA
end 

function LibraryOptions.communicateWithServer()

	modem.send(variableCurrentAddress, port, (io.read()))
	repeat
	local _, _, from, port, _, message = event.pull("modem_message")
	print("Got a message from " .. from .. " on port " .. port .. ": " .. tostring(message))
until message == "end" 
print ("end of cicle")
end 

function LibraryOptions.FileManip.read(filePath)
local fileRead = {"data"}
local Path = ""
local data = ""
table.insert(fileRead,(io.open(filePath, "rb")))
--fileRead[Path] = io.open(filePath, "rb")
fileRead[data] = fileRead[2]:read("*a")
print(fileRead[data])
local fileString = serialization.serialize(fileRead[data])	
return {filePath,fileString}
end

function LibraryOptions.FileManip.SendOnServer(command, file, pathToSave)
local tempBuf = {}
local command = "receiveFile"
local arg = {command, file, pathToSave}
local argCounts = 3
	while (arg ~= nil) do
		table.insert(tempBuf, arg[argCounts])
		arg[argCounts] = nil
		argCounts = argCounts- 1
	end
	for i = 1, #tempBuf, 1 do
		modem.send(variableCurrentAddress, port,tempBuf[i])
	end
end

--[[function LibraryOptions.FileManip.WriteInFile(file, pathToSave)
local tempBuf = {}
local arg = {file, pathToSave}
	
end
]]-- так блядь, эта хуита в разработке епта, доделаю потом