### **math.round** ( `n`: number )
Rounds a number to the nearest integer. For numbers with decimal digit under 0.5, it will floor that number, and for numbers over 0.5 it will ceil that number.


**Parameters:**
- **n** (`Number`) : The number to round


**Returns:**
- `Number` The number rounded.

---

### **math.restrict** ( `number`: number, `lower`: number, `higher`: number )
Restrict the given input between two limits. 


**Parameters:**
- **number** (`Number`) : The number to restrict
- **lower** (`Number`) : The lower limit
- **higher** (`Number`) : The higher limit


**Returns:**
- `Number` The number between the specified range.

---

### **math.pythag** ( `ax`: number, `ay`: number, `bx`: number, `by`: number )
Returns the distance between two points on a cartesian plane. 


**Parameters:**
- **ax** (`Number`) : The horizontal coordinate of the first point
- **ay** (`Number`) : The vertical coordinate of the first point
- **bx** (`Number`) : The horizontal coordinate of the second point
- **by** (`Number`) : The vertical coordinate of the second point


**Returns:**
- `Number` The distance between both points.

---

### **math.udist** ( `a`: number, `b`: number )
Returns the absolute difference between two numbers. 


**Parameters:**
- **a** (`Number`) : The first number
- **b** (`Number`) : The second number


**Returns:**
- `Number` The absolute difference.

---

### **math.precision** ( `number`: number, `precision`: int )
Rounds a number to the specified level of precision. The precision is the amount of decimal points after the integer part.


**Parameters:**
- **number** (`Number`) : The number to correct precision
- **precision** (`Int`) : The decimal digits of precision that this number will have


**Returns:**
- `Number` The number with the corrected precision.

---

### **math.tobase** ( `number`: number, `base`: int )
Converts a number to a string representation in another base. The base can be as lower as 2 or as higher as 64, otherwise it returns nil.


**Parameters:**
- **number** (`Number`) : The number to convert
- **base** (`Int`) : The base to convert this number to


**Returns:**
- `String` The number converted to the specified base.

---

### **math.tonumber** ( `str`: string, `base`: int )
Converts a string to a number, if possible. The base can be as lower as 2 or as higher as 64, otherwise it returns nil. When bases are equal or lower than 36, it uses the native Lua `tonumber` method.


**Parameters:**
- **str** (`String`) : The string to convert
- **base** (`Int`) : The base to convert this string to number


**Returns:**
- `String` The string converted to number from the specified base.

---

### **math.cosint** ( `a`: number, `b`: number, `s`: number )
Interpolates two points with a cosine curve. 


**Parameters:**
- **a** (`Number`) : First Point
- **b** (`Number`) : Second point
- **s** (`Number`) : Curve size


**Returns:**
- `Number` Resultant point with value interpolated through cosine function.

---

### **math.heightMap** ( `amplitude`: number, `waveLenght`: number, `width`: int, `offset`: number, `lower`: number, `higher`: number )
Generates a Height Map based on the current `randomseed`. 


**Parameters:**
- **amplitude** (`Number`) : How tall can a wave be
- **waveLenght** (`Number`) : How wide will a wave be
- **width** (`Int`) : How large should the height map be
- **offset** (`Number`) : Overall height for which map will be increased
- **lower** (`Number`) : The lower limit of height
- **higher** (`Number`) : The higher limit of height


**Returns:**
- `Table` An array that contains each point of the height map.

---

### **math.stretchMap** ( `ls`: table, `mul`: int )
Stretches a height map, or array with numerical values. 


**Parameters:**
- **ls** (`Table`) : The array to stretch.
- **mul** (`Int`) : How much should it be stretched


**Returns:**
- `Table` The array stretched

---

### **nil** ( `nil`:  )
Copies a table and all its values recursively. It avoids keeping references over values.


**Parameters:**
- **nil** (`nil`) : nil


**Returns:**
- `Table` The table copied.

---

### **nil** ( `nil`:  )
Inhertis all values to a table, from the specified one. It does not modify the original tables, but copies them, to avoid inconsistencies. All values to inherit will overwrite values on the target table.


**Parameters:**
- **nil** (`nil`) : nil


**Returns:**
- `Table` The new child table, product of the tables provided.

---

### **nil** ( `nil`: , `nil`:  )
Searches for a value across a table. Will return the first index of where it was found, otherwise returns nil.


**Parameters:**
- **nil** (`nil`) : nil
- **nil** (`nil`) : nil


**Returns:**
- `Any` The key or index where the element was found.
- `Any` The element specified.

---

### **nil** (  )
Searches for a value, but in a depth of 1 index. Refer to table.find for more information.

---

### **nil** ( `nil`: , `nil`:  )
Gives the specific data of a module from an encoded string. 


**Parameters:**
- **nil** (`nil`) : nil
- **nil** (`nil`) : nil


**Returns:**
- `String` The raw data for this module, otherwise an empty string.

---

### **nil** ( `nil`: , `nil`: , `nil`:  )
Sets the data to the specified module on an encoded string 


**Parameters:**
- **nil** (`nil`) : nil
- **nil** (`nil`) : nil
- **nil** (`nil`) : nil


**Returns:**
- `String` The new encoded data
- `String` The new raw data for the module
- `String` The old encoded data
- `String` The old raw data for the module

---

### **nil** ( `nil`: , `nil`:  )
Decodes a piece of raw data. 


**Parameters:**
- **nil** (`nil`) : nil
- **nil** (`nil`) : nil


**Returns:**
- `Table` The table with the data.

---

### **nil** ( `nil`: , `nil`:  )
Parses a value encoded or compressed. 


**Parameters:**
- **nil** (`nil`) : nil
- **nil** (`nil`) : nil


**Returns:**
- `Any` The value decoded.

---

### **nil** ( `nil`: , `nil`:  )
Encondes a value into a reasonable format. 


**Parameters:**
- **nil** (`nil`) : nil
- **nil** (`nil`) : nil


**Returns:**
- `String` The value encoded.

---

### **nil** ( `nil`: , `nil`:  )
Encodes a table into a reasonable format. 


**Parameters:**
- **nil** (`nil`) : nil
- **nil** (`nil`) : nil


**Returns:**
- `String` The encoded table