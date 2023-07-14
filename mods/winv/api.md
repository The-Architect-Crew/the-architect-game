### winv API
#### `winv:register_inventory(inv_name, def)`
Adds a new winventory.
- `inv_name` : winventory name
- `def` : table of definitions

#### `winv:register_listring(inv1, inv2, listring)`
Appends listrings between two specified winventories.
Can technically be used to appends such similar elements that is shared between both winventories as well, but not suggested.
- `inv1` : name of first specified winventory
- `inv2` : name of second specified winventory
- `listring` : string containing formspec list with listrings

#### `winv.reset_inventory(player)`
Resets winventories to default state (`winv.default.left` & `winv.default.right`)
- `player` : player object

#### `winv.init_inventory(player, nodeform)`
Returns a string with the current winventories, nodeform field allows additional formspec list to be appended to it (for the purpose of a node inventory formspec)
When using nodeform, the left side is always reserved for winventories, while the right side is reserved for custom node formspec sent with the second argument.
- `player` : player object
- `nodeform` : string containing formspec list that is appended, meant for node inventory usage

#### `winv.refresh(player, show_formspec)`
Updates winventory (required for any field changes)
- `player` : player object
- `show_formspec` : boolean as to whether trigger `minetest.show_formspec` to enforce inventory (when winv is not utilized in a player inventory context, should be unnecessary for most usage)

#### `winv.node_refresh(player)`
Returns true if a formspec update is required (for node inventories whereby changes from to player inventories aren't detected), else nil

#### `winv.node_receive_fields(player, formname, fields)`
Duplicated receive_fields for winv fields, meant to be called for node inventories (whereby their receive fields are local and hence doesn't access winv's player global receive fields)
- `player` : player object
- `formname` : node formspec name
- `fields` : node formspec fields

### Other helpers
#### `winv.is_group(itemname)`
Check is an itemname is a groupname instead (i.e. `group:groupname`)
Returns true if groupname, else nil
- `itemname` : item name in the format of `modname:itemname`

#### `winv.group_match(groupname, itemname)`
Check if a item is in a given group.
Return true if it is in the group, else nil.
- `groupname` : group name in the format of `group:groupname`
- `itemname` : item name in the format of `modname:itemname`

#### `winv.find_first_in_group(groupname)`
Find the first item in a group.
Returns the string of the item name, if the group contains no items, returns the groupname in the format as given
- `groupname` : group name in the format of `group:groupname`

#### `winv.mod_match(itemname, modname)`
Checks if an item is from specified mod.
Does a simple string cut of everything before `:`
- `itemname` : item name in the format of `modname:itemname`
- `modname` : name of the mod

#### `winv.get_nonempty_modnames(exclude_creative)`
Functions like minetest.get_modnames(), however only return mods that actually contain nodes/items.
Can exclude `not_in_creative_inventory` items if `exclude_creative` is set to true
- `exclude_creative` : boolean as to whether exclude items from `not_in_creative_inventory` (said items will not count as items)

#### `winv.in_invalid_mod(itemname)`
Check whether an item is in invalid mod.
Returns true if item is in invalid mod (mod doesn't exists), else nil.
Situation usually occurs due to alias renaming an node's modname from an existant mod to something else
- `itemname` : item name in the format of `modname:itemname`