local storage = minetest.get_mod_storage()
if not storage:get_string('luahist') then storage:set_string('luahist','') end
local function genfs()
    local fspec =
    "size[16,9]"..
    "field[0.2,0.3;16,1;code;Code:;]"..
    "field_close_on_enter[code;false]"..
    "button[14.5,1;1.4,1;run;Run!]"..
    "textarea[0.2,2;16,8.5;hist;Notes & History:;"..storage:get_string('luahist').."]"..
    "button[12.5,1;2,1;save;Save notes]"
    return fspec
end
minetest.register_chatcommand("lua", {
    description = "Open luagui",
    func = function(param)
core.show_formspec('luagui',genfs())
end})
core.register_on_formspec_input(function(formname, fields)
	if formname == "luagui" then
	if fields.run then
		core.run_server_chatcommand('/lua',fields.code)
		storage:set_string('luahist',storage:get_string('luahist')..core.formspec_escape(fields.code)..'\n')
		core.show_formspec('luagui',genfs())
        elseif fields.save then
		storage:set_string('luahist',fields.hist)
	end
	end
end)
