do
-- #Begin plugins.lua by @BeyondTeam
-- #Edited Plugins.lua By @RexCompany
-- #Special Thx To @Sudo_Hack
-- Returns the key (index) in the config.enabled_plugins table
local function plugin_enabled( name )
  for k,v in pairs(_config.enabled_plugins) do
    if name == v then
      return k
    end
  end
  -- If not found
  return false
end

-- Returns true if file exists in plugins folder
local function plugin_exists( name )
  for k,v in pairs(plugins_names()) do
    if name..'.lua' == v then
      return true
    end
  end
  return false
end

local function list_all_plugins(only_enabled, msg)
  local tmp = '\n'..msg_caption
  local text = ''
  local nsum = 0
  for k, v in pairs( plugins_names( )) do
    --  ✔ enabled, ❌ disabled
    local status = '|👎|>'
    nsum = nsum+1
    nact = 0
    -- Check if is enabled
    for k2, v2 in pairs(_config.enabled_plugins) do
      if v == v2..'.lua' then 
        status = '|👍|>'
      end
      nact = nact+1
    end
    if not only_enabled or status == '|👍|>'then
      -- get the name
      v = string.match (v, "(.*)%.lua")
      text = text..nsum..'.'..status..' '..v..' \n'
    end
  end
  text = '<code>'..text..'</code>\n\n'..nsum..' <b>↯ᴘʟᴜɢɪɴs ɪɴsᴛᴀʟʟᴇᴅ</b>\n\n'..nact..' <i>👍ᴘʟᴜɢɪɴs ᴇɴᴀʙʟᴇᴅ</i>\n\n'..nsum-nact..' <i>👎ᴘʟᴜɢɪɴs ᴅɪsᴀʙʟᴇᴅ</i>'..tmp
  tdbot.sendMessage(msg.to.id, msg.id, 1, text, 1, 'html')
end

local function list_plugins(only_enabled, msg)
  local text = ''
  local nsum = 0
  for k, v in pairs( plugins_names( )) do
    --  ✔ enabled, ❌ disabled
    local status = '*|👎|>*'
    nsum = nsum+1
    nact = 0
    -- Check if is enabled
    for k2, v2 in pairs(_config.enabled_plugins) do
      if v == v2..'.lua' then 
        status = '*|👍|>*'
      end
      nact = nact+1
    end
    if not only_enabled or status == '*|👍|>*'then
      -- get the name
      v = string.match (v, "(.*)%.lua")
     -- text = text..v..'  '..status..'\n'
    end
  end
  text = "\n`↻ All Plugins ➲ Reloaded`\n\n"..nact.." *👍ᴘʟᴜɢɪɴs ᴇɴᴀʙʟᴇᴅ*\n"..nsum.." *↯ᴘʟᴜɢɪɴs ɪɴsᴛᴀʟʟᴇᴅ*\n"..msg_caption
  tdbot.sendMessage(msg.to.id, msg.id, 1, text, 1, 'md')
end

local function reload_plugins(checks, msg)
  plugins = {}
  load_plugins()
  return list_plugins(true, msg)
end


local function enable_plugin( plugin_name, msg )
  print('checking if '..plugin_name..' exists')
  -- Check if plugin is enabled
  if plugin_enabled(plugin_name) then
    local text = '<b>'..plugin_name..'</b> <i>is ➲ enabled.</i>'
	tdbot.sendMessage(msg.to.id, msg.id, 1, text, 1, 'html')
	return
  end
  -- Checks if plugin exists
  if plugin_exists(plugin_name) then
    -- Add to the config table
    table.insert(_config.enabled_plugins, plugin_name)
    print(plugin_name..' added to _config table')
    save_config()
    -- Reload the plugins
    return reload_plugins(true, msg)
  else
    local text = '<b>'..plugin_name..'</b> <i>ᴅᴏᴇs ɴᴏᴛ ➲ ᴇxɪsᴛs.</i>'
	tdbot.sendMessage(msg.to.id, msg.id, 1, text, 1, 'html')
  end
end

local function disable_plugin( name, msg )
  local k = plugin_enabled(name)
  -- Check if plugin is enabled
  if not k then
    local text = '<b>'..name..'</b> <i>not ➲ enabled.</i>'
	tdbot.sendMessage(msg.to.id, msg.id, 1, text, 1, 'html')
	return
  end
  -- Check if plugins exists
  if not plugin_exists(name) then
    local text = '<b>'..name..'</b> <i>ᴅᴏᴇs ɴᴏᴛ ➲ ᴇxɪsᴛs.</i>'
	tdbot.sendMessage(msg.to.id, msg.id, 1, text, 1, 'html')
  else
  -- Disable and reload
  table.remove(_config.enabled_plugins, k)
  save_config( )
  return reload_plugins(true, msg)
end  
end

local function disable_plugin_on_chat(receiver, plugin, msg)
  if not plugin_exists(plugin) then
    return "`⇋ Plugin doesn't exists`"
  end

  if not _config.disabled_plugin_on_chat then
    _config.disabled_plugin_on_chat = {}
  end

  if not _config.disabled_plugin_on_chat[receiver] then
    _config.disabled_plugin_on_chat[receiver] = {}
  end

  _config.disabled_plugin_on_chat[receiver][plugin] = true

  save_config()
  local text = '<b>'..plugin..'</b> <i>disabled on this chat.</i>'
  tdbot.sendMessage(msg.to.id, msg.id, 1, text, 1, 'html')
end

local function reenable_plugin_on_chat(receiver, plugin, msg)
  if not _config.disabled_plugin_on_chat then
    return 'There aren\'t any disabled plugins'
  end

  if not _config.disabled_plugin_on_chat[receiver] then
    return 'There aren\'t any disabled plugins for this chat'
  end

  if not _config.disabled_plugin_on_chat[receiver][plugin] then
    return '_This plugin is not disabled_'
  end

  _config.disabled_plugin_on_chat[receiver][plugin] = false
  save_config()
  local text = '<b>'..plugin..'</b> <i>is enabled again.</i>'
  tdbot.sendMessage(msg.to.id, msg.id, 1, text, 1, 'html')
end

local function run(msg, matches)
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
  -- Show the available plugins 
  if is_sudo(msg) then
  if (matches[1]:lower() == 'plist' and not Clang) or (matches[1]:lower() == 'لیست پلاگین' and Clang) then --after changed to moderator mode, set only sudo
    return list_all_plugins(false, msg)
  end
end
  -- Re-enable a plugin for this chat
  if (matches[1]:lower() == 'pl' and not Clang) or (matches[1]:lower() == 'پلاگین' and Clang) then
  if matches[2] == '+' and ((matches[4] == 'chat' and not Clang) or (matches[4] == 'گروه' and not Clang)) then
      if is_mod(msg) then
    local receiver = msg.chat_id_
    local plugin = matches[3]
    print("enable "..plugin..' on this chat')
    return reenable_plugin_on_chat(receiver, plugin, msg)
  end
    end

  -- Enable a plugin
  if matches[2] == '+' and is_sudo(msg) then --after changed to moderator mode, set only sudo
    local plugin_name = matches[3]
    print("enable: "..matches[3])
    return enable_plugin(plugin_name, msg)
  end
  -- Disable a plugin on a chat
  if matches[2] == '-' and ((matches[4] == 'chat' and not Clang) or (matches[4] == 'گروه' and not Clang)) then
      if is_mod(msg) then
    local plugin = matches[3]
    local receiver = msg.chat_id_
    print("disable "..plugin..' on this chat')
    return disable_plugin_on_chat(receiver, plugin, msg)
  end
    end
  -- Disable a plugin
  if matches[2] == '-' and is_sudo(msg) then --after changed to moderator mode, set only sudo
    if matches[3] == 'plugins' then
		return 'This plugin can\'t be disabled'
    end
    print("disable: "..matches[3])
    return disable_plugin(matches[3], msg)
  end

  -- Reload all the plugins!
  if matches[2] == '*' and is_sudo(msg) then --after changed to moderator mode, set only sudo
    return reload_plugins(true, msg)
  end
  end
  if (matches[1]:lower() == 'reload' and not Clang) or (matches[1]:lower() == 'ریلود' and Clang) and is_sudo(msg) then --after changed to moderator mode, set only sudo
    return reload_plugins(true, msg)
  end
end

return {
  description = "Plugin to manage other plugins. Enable, disable or reload.", 
  usage = {
      moderator = {
          "!pl - [plugin] chat : disable plugin only this chat.",
          "!pl + [plugin] chat : enable plugin only this chat.",
          },
      sudo = {
          "!plist : list all plugins.",
          "!pl + [plugin] : enable plugin.",
          "!pl - [plugin] : disable plugin.",
          "!pl * : reloads all plugins." },
          },
  patterns = {
    "^([Pp]list)$",
    "^([Pp]l) (+) ([%w_%.%-]+)$",
    "^([Pp]l) (-) ([%w_%.%-]+)$",
    "^([Pp]l) (+) ([%w_%.%-]+) (chat)",
    "^([Pp]l) (-) ([%w_%.%-]+) (chat)",
    "^([Pp]l) (*)$",
    "^([Rr]eload)$",
    "^(لیست پلاگین)$",
    "^(پلاگین) (+) ([%w_%.%-]+)$",
    "^(پلاگین) (-) ([%w_%.%-]+)$",
    "^(پلاگین) (+) ([%w_%.%-]+) (گروه)",
    "^(پلاگین) (-) ([%w_%.%-]+) (گروه)",
    "^(پلاگین) (*)$",
    "^(ریلود)$",
    },
  run = run,
  moderated = true, -- set to moderator mode
  privileged = true
}

end

