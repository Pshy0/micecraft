local logpath = ("./build/log/%s.lua"):format(os.date("%Y%m%d%H%M%S"))
local buildpath = './build/micecraft.lua'

local shouldLog = false
local releaseBuild = false

local fileList = {
    [1] = {
        __name = "Init",
        __directory = "source/init",
        "init",
    },
	[2] = {
		__name = "Utilities",
		__directory = "source/utils",
		"math",
		"table",
		"data"
	},
	[3] = {
		__name = "Head",
		__directory = "source/init",
		"module",
		"room",
		"env",
		"enum",
		"prestart"
	},
	[4] = {
		__name = "Interface",
		__directory = "source/interface",
		"element",
		"template",
		"ui"
	},
	[5] = {
		__name = "World",
		__directory = "source/world",
		"init",
		"interaction",
		"generation",
		"encoding"
	},
	[6] = {
		__name = "Block",
		__directory = "source/block",
		"init",
		"graphics"
	},
	[7] = {
		__name = "Chunk",
		__directory = "source/chunk",
		"init"
	},
	[8] = {
		__name = "Player",
		__directory = "source/player",
		"init",
		"data"
	},
	[9] = {
		__name = "Events",
		__directory = "source/events",
		"NewGame",
		"NewPlayer",
		"PlayerDataLoaded",
		"PlayerLeft"
	},
	[10] = {
		__name = "Launch",
		__directory = "source/launch",
		"launch"
	}
}

os.readFile = function(fileName)
    local File, result = io.open(fileName, "r")
    local raw

    if File then
        raw = File:read("*all")
        File:close()
    end

    return raw, result
end

local buildModule = function(modulo, log)
    local arrayFiles = {}
    local path
    local fileContent, result

    for index, fileName in ipairs(modulo) do
        path = ("%s/%s.lua"):format(modulo.__directory, fileName)
        fileContent, result = os.readFile(path)
        if log then
            if fileContent then
                print(("[success] %s (%d)"):format(path, #fileContent))

                if releaseBuild then
                    if modulo.__name ~= "Libraries" then
                        fileContent = fileContent:gsub("%l-print", "--%1")
                        fileContent = fileContent:gsub("%-%-%[%[.-%]%]", "")
                        fileContent = fileContent:gsub("%-%-.-\n", "\n")
                        fileContent = fileContent:gsub("\n%s-\n", "\n")
                    end
                end
            else
                print(("[failure] %s: %s"):format(path, result))
            end
        end
        if releaseBuild then
            arrayFiles[index] = fileContent or ""
        else
            arrayFiles[index] = ("-- >> %s\n%s\n-- %s <<"):format(path, fileContent or "", path)
        end
    end

    local filesComp = table.concat(arrayFiles, "\n") or ""

    if log then
        print(("[MODULE] '%s' has been built (%d characters).\n"):format(modulo.__name, #filesComp))
    end
	
    local Module

    if releaseBuild then
        Module = filesComp
    else
        Module = ("-- %s\t%s\t%s --\n\n %s"):format(("="):rep(7), modulo.__name, ("="):rep(7), filesComp)
    end

    return Module
end

do
	local build
    local arrayModules = {}
    for index, modulo in ipairs(fileList) do
        arrayModules[index] = buildModule(modulo, true)
    end

    local compModules = table.concat(arrayModules, "\n")
    do
		local licenseFile = io.open("./LICENSE", "r")
        if licenseFile then
            local license = licenseFile:read("*all")
            
            build = ("--[[\n\n%s\n]]--\n%s"):format(license, compModules)
            licenseFile:close()
        end
	end
    
    local File, result = io.open(buildpath, "w")

    if File then
        File:write(build)
        File:close()

        print("SUCCESS! Module succesfully written at " .. buildpath .. ". (" .. build:len() .. " characters)")

        -- Assert

        load = loadstring or load

        local success, code = load('package.path = "build/?.lua;" .. package.path; require("tfmenv");' .. build, "micecraft")
        if success then
            print("[TEST] File syntax is correct. Testing execution...")
            local assertion, result = pcall(success)
            if assertion then
                print("[TEST] Module executes correctly !")
            else
                print("[FAILURE] " .. result)
            end
        else
            print("[TEST] File fails at executing: " .. code)
        end
    else
        print("Failure on writing the final file on " .. buildpath ..  ": " ..  result)
    end
	
	if shouldLog then
		File, result = io.open(logpath, "w")
        if File then
            File:write(arrayModules)
            File:close()
        end
	end
end