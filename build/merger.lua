local logpath = ("./build/log/%s.lua"):format(os.date("%Y%m%d%H%M%S"))
local buildpath = './micecraft.lua'

local shouldLog = false
local releaseBuild = false

local fileList = {
    [1] = {
        __name = "Head",
        __directory = "source/init",
        "init",
		"module",
		"room",
		"env",
    },
	[2] = {
		__name = "Utilities",
		__directory = "source/utils",
		"math",
		"table",
		"data"
	},
	[3] = {
		__name = "Interface",
		__directory = "source/interface",
		"element",
		"template",
		"ui"
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

    arrayFiles = table.concat(arrayFiles, "\n") or ""

    if log then
        print(("[MODULE] '%s' has been built (%d characters).\n"):format(modulo.__name, #arrayFiles))
    end
	
    local Module

    if releaseBuild then
        Module = arrayFiles
    else
        Module = ("-- %s\t%s\t%s --\n\n %s"):format(("="):rep(7), modulo.__name, ("="):rep(7), arrayFiles)
    end

    return Module
end

do
	local build
    local arrayModules = {}
    for index, modulo in ipairs(fileList) do
        arrayModules[index] = buildModule(modulo, true)
    end

    arrayModules = table.concat(arrayModules, "\n")
    do
		local licenseFile = io.open("./LICENSE", "r")
		local license = licenseFile:read("*all")
		
		build = ("--[[\n%s]]--\n%s"):format(license, arrayModules)
		licenseFile:close()
	end
    
    local File, result = io.open(buildpath, "w")

    if File then
        File:write(build)
        File:close()

        print("SUCCESS! Module succesfully written at " .. buildpath .. ". (" .. arrayModules:len() .. " characters)")

        -- Assert

        load = loadstring or load

        local success, code = load('package.path = "build/?.lua;" .. package.path\nrequire("tfmenv")\n\n' .. arrayModules, "micecraft")
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
		File:write(arrayModules)
		File:close()
	end
end