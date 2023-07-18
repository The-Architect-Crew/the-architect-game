### winv API
#### `winv:register_inventory(inv_name, def)`
Adds a new winventory.
- `inv_name` : winventory name
- `def` : table of definitions
    - `button` : table containing button definitions for button accessing said winventory
        - `texture` : button icon image
        - `pressed_texture` : optional, button icon image when pressed
        - `label` : optional, button label (defaults to `""`)
        - `tooltip` : optional, tooltip (when mouse hovers over button) (defaults to `inv_name`)
    - `lists` : table containing a list of inventory lists that the winventory contains, in the format of `"<list_name>"`, `<size>` (i.e. `{"main", 36}`)
    - `button_function(player, formname, fields)` : optional, triggers specified function when button is pressed
    - `requirement(player)` : function to be called when checking if the winventory should show for referenced player, return true to show, return nil to hide
    - `formspec` : string containing winventory formspec
        Formspec initalizers like `formspec_version` and `size` are already pre-provided, so no need to redefine!
        Provide the size of `7.75 x 10.5` for a window, but `noclip` elements are enabled by default, so larger sizes are possible, but at risk of being shown outside of the player's screen. Suggested size would be a square window of `7.75 x 7.75`
        Add an image background with `"image[0,0;7.75,7.75;winv_bg.png]"`
    - `formspec_function(player)` : function to return a string containing winventory formspec, overwrites `formspec`, same comments about formspec contents as above
    - `on_player_receive_fields(player, formname, fields)` : handles formspec input and fields, functions similar to normal minetest function, but add specifically to winv fields
    - `hide_in_node` : optional, boolean as to whether to hide in node inventories (if utilized) (nil (false) by default)

#### `winv:register_listring(inv1, inv2, listring)`
Appends listrings between two specified winventories.
Can technically be used to appends such similar elements that is shared between both winventories as well, but not suggested.
- `inv1` : name of first specified winventory
- `inv2` : name of second specified winventory
- `listring` : string containing formspec list with listrings

#### `winv.get_inventory(player, side)`
Returns the winventory name of the current winventory present on specified `side`
- `player` : player object
- `side` : string of either `left` or `right`, specifying the left and right side respectively

#### `winv.hide_inventory(player, side)`
Hides the specified side completely from view, this is a permanent trigger, unless reversed with `winv.unhide_inventory` (see below).
- `player` : player object
- `side` : string of winventory side to hide, supports the following
    1. `left` - hides left side winventory but leaves left side navigation header
    2. `right` - hides right side winventory but leaves right side navigation header
    3. `left_header` - hides left side navigation header but leaves left side winventory
    4. `right_header` - hides right side navigation header but leaves right side winventory
    5. `left_all` - hides both left side winventory and left side navigation header
    6. `right_all` - hides both right side winventory and right side navigation header
    7. `all` - hides everything

#### `winv.inventory_shown(player, inv_name)`
Returns true if a specified winventory is not hidden (regardless of side and navigation headers visiblity are not considered), else nil
- `player` : player object
- `inv_name` : winventory name

#### `winv.unhide_inventory(player, side)`
Show/unhide the specified side, reverses the hide decision from `winv.hide_inventory`
- `player` : player object
- `side` : string of winventory side to unhide, supports the same as `winv.hide_inventory` (see above) but in reverse.

#### `winv.reset_inventory(player)`
Resets winventories to default state (`winv.default.left` & `winv.default.right`)
- `player` : player object

#### `winv.init_inventory(player, nodeform)`
Returns a formspec string with the current winventories, `nodeform` field allows additional formspec list to be appended to it (for the purpose of building a node inventory formspec)
When using `nodeform`, the left side is always reserved for winventories, while the right side is reserved for custom node formspec sent with the second argument.
Same comments about formspec contents for `nodeform` as stated in `winv:register_inventory` `formspec` section above.
- `player` : player object
- `nodeform` : string containing formspec list that is appended, meant for node inventory usage

#### `winv.refresh(player, show_formspec)`
Updates winventory (required for any field changes)
- `player` : player object
- `show_formspec` : boolean as to whether trigger `minetest.show_formspec` to enforce inventory (when winv is not utilized in a player inventory context, should be unnecessary for most usage)

#### `winv.node_refresh(player)`
Returns true if a formspec update is required (for node inventories whereby changes from to player inventories aren't detected), else nil

#### `winv.node_receive_fields(player, formname, fields)`
Duplicated receive_fields for winv fields, meant to be called for node inventories (whereby their receive fields are local and hence doesn't access winv's player global receive fields) - does provide special handling as well, unique to node inventories only usage of the right side, so use exclusively for node inventories!
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