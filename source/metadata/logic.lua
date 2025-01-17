--- Creates a new Meta Data handler.
-- A handler can automatically fill void properties, return defaults
-- or function as Class inheritor, by supporting Templates.
-- @param default The default object for this Meta Data handler.
-- @return `MetaData` The Meta Data handler for this object
function MetaData:newMetaData(default)
	local this = setmetatable({}, self)
	this.__index = self
	
	this.__templates = {}
	this.__default = default or {}
	
	return this
end

do
	local type = type
	local copy = table.copy
	local inherit = table.inherit
	
	--- Creates a new Template for the specified Meta Data handler.
	-- A template can serve to apply specific properties automatically
	-- to new objects created under it. Templates can be derivated from
	-- other templates to support higher abstraction.
	-- @param identifier The identifier for this template
	-- @param definition The definition for this template. In case aux is present, this can be another identifier for a template to inherit
	-- @param aux In case it's present, it will perform a double inheritance, serving as main definition
	-- @return `Template` The new template.
	function MetaData:newTemplate(identifier, definition, aux)
		if aux then
			definition = inherit(self.__default, type(definition) == "table" and definition or self.__templates[definition])
			definition = inherit(definition, aux)
		end
		self.__templates[identifier] = inherit(self.__default, definition)
		
		return self.__templates[identifier]
	end
	
	--- Gets a template, if it exists.
	-- @param identifier The identifier of the desired template
	-- @return `Template` The template object, if it exists, otherwise the default Meta Data value.
	function MetaData:getTemplate(identifier)
		return self.__templates[identifier] or self.__default
	end
	
	--- Sets a new object under the Meta Data storage.
	-- An object can inherit properties from a template or from another object.
	-- @param index The index to storage this object into
	-- @param template If definition is not defined, this will be the object to set, which will inherit default object
	-- @param definition If present, it will inherit, first from template, and second from default
	-- @return `Object` The new object.
	function MetaData:set(index, template, definition)
		if not definition then
			definition = type(template) == "string" and self:getTemplate(template) or template
			template = nil
		end
		
		local object = copy(definition)
		
		if template then
			if type(template) == "table" then
				object = inherit(template, object)
			else
				template = self.__templates[template]
				
				if template then
					object = inherit(template, definition)
				end
			end
		end
		
		if object.name == "Null" then
			object.name = "null_" .. index
		end
		object.fixedId = index
		
		self[index] = inherit(self.__default, object)
	end
	
	--- Gets an object, if it exists.
	-- @param index The identifier of the desired object
	-- @return `Object` The object, if it exists, otherwise the default Meta Data value.
	function MetaData:get(index)
		return self[index] or self.__default
	end
end

-- The precedence, when setting, is this
-- SET > TEMPLATE > DEFAULT
-- Usage:
--[[
	local BlockMetadata = MetaData:newMetaData({
		a = 1,
		b = 2,
		c = 3
	})
	
	BlockMetadata:newTemplate("Water", {
		b = 4,
		d = 6
	})
	
	BlockMetadata:set(1, "Water", {
		e = 10
	})
	
	BlockMetadata:set(2, {
		a = 1,
		d = 3,
	})
	
	BlockMetadata[1] will be equal to {
		a = 1, -- Default value
		b = 4, -- Inherited from "Water"
		c = 3, -- Default value
		d = 6, -- Inherited from "Water"
		e = 10 -- Defined on :set
	}
	
	BlockMetadata[2] will be equal to {
		a = 1, -- Defined on :set
		b = 2, -- Default value
		c = 3, -- Default value
		d = 3 -- Defined on :set
	}
	
]]