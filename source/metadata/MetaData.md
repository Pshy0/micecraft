# MetaData

---

### **nil** ( `nil`:  )
Creates a new Meta Data handler. A handler can automatically fill void properties, return defaults or function as Class inheritor, by supporting Templates.


**Parameters:**
- **nil** (`nil`) : nil


**Returns:**
- `MetaData` The Meta Data handler for this object

---

### **nil** ( `nil`: , `nil`: , `nil`:  )
Creates a new Template for the specified Meta Data handler. A template can serve to apply specific properties automatically to new objects created under it. Templates can be derivated from other templates to support higher abstraction.


**Parameters:**
- **nil** (`nil`) : nil
- **nil** (`nil`) : nil
- **nil** (`nil`) : nil


**Returns:**
- `Template` The new template.

---

### **nil** ( `nil`:  )
Gets a template, if it exists. 


**Parameters:**
- **nil** (`nil`) : nil


**Returns:**
- `Template` The template object, if it exists, otherwise the default Meta Data value.

---

### **nil** ( `nil`: , `nil`: , `nil`:  )
Sets a new object under the Meta Data storage. An object can inherit properties from a template or from another object.


**Parameters:**
- **nil** (`nil`) : nil
- **nil** (`nil`) : nil
- **nil** (`nil`) : nil


**Returns:**
- `Object` The new object.

---

### **nil** ( `nil`:  )
Gets an object, if it exists. 


**Parameters:**
- **nil** (`nil`) : nil


**Returns:**
- `Object` The object, if it exists, otherwise the default Meta Data value.