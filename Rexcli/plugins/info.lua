--Begin info.lua By @MrRex
--Edited Info.lua By @Rex_Developer
local MrRex = 468354860
local function setrank(msg, user_id, value,chat_id)
  local hash = nil

    hash = 'rank:'..msg.to.id..':variables'

  if hash then
    redis:hset(hash, user_id, value)
  return tdbot.sendMessage(chat_id, '', 0, '_set_ *Rank* _for_ *[ '..user_id..' ]* _To :_ *'..value..'*', 0, "md")
  end
end
local function info_by_reply(arg, data)
    if tonumber(data.sender_user_id) then
local function info_cb(arg, data)
    if data.username then
  username = "@"..check_markdown(data.username)
    else
  username = ""
  end
    if data.first_name then
  firstname = check_markdown(data.first_name)
    else
  firstname = ""
  end
    if data.last_name then
  lastname = check_markdown(data.last_name)
    else
  lastname = ""
  end
	local hash = 'rank:'..arg.chat_id..':variables'
   local text = "₪ First name ➲ *"..firstname.."*\n₪ Last name ➲ *"..lastname.."*\n₪ Username ➲ "..username.."\n₪ ID : *"..data.id.."*\n\n"
		    if data.id == tonumber(MrRex) then
		       text = text..'₪ Rank ➲ *Executive Admin*\n\n'
			   elseif is_sudo1(data.id) then
	           text = text..'₪ Rank ➲ *Full Access Admin*\n\n'
		     elseif is_admin1(data.id) then
		       text = text..'₪ Rank ➲ *Bot Admin*\n\n'
		     elseif is_owner1(arg.chat_id, data.id) then
		       text = text..'₪ Rank ➲ *Group Owner*\n\n'
		     elseif is_mod1(arg.chat_id, data.id) then
		       text = text..'₪ Rank ➲ *Group Moderator*\n\n'
		 else
		       text = text..'₪ Rank ➲ *Group Member*\n\n'
			end
         local user_info = {} 
  local uhash = 'user:'..data.id
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..data.id..':'..arg.chat_id
  user_info_msgs = tonumber(redis:get(um_hash) or 0)
  text = text..'₪ Total messages ➲ '..user_info_msgs..'\n\n'
  text = text..'@RexCompany'
  tdbot.sendMessage(arg.chat_id, arg.msgid, 0, text, 0, "md")
end
assert (tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, info_cb, {chat_id=data.chat_id,user_id=data.sender_user_id,msgid=data.id}))
    else
tdbot.sendMessage(data.chat_id, "", 0, "*User not found*", 0, "md")
   end
end

local function info_by_username(arg, data)
    if tonumber(data.id) then
local function info_cb(arg, data)
    if data.username then
  username = "@"..check_markdown(data.username)
    else
  username = ""
  end
    if data.first_name then
  firstname = check_markdown(data.first_name)
    else
  firstname = ""
  end
    if data.last_name then
  lastname = check_markdown(data.last_name)
    else
  lastname = ""
  end
	local hash = 'rank:'..arg.chat_id..':variables'
   local text = "₪ First name ➲ *"..firstname.."*\n₪ Last name ➲ *"..lastname.."*\n₪ Username ➲ "..username.."\n₪ ID : *"..data.id.."*\n\n"
		    if data.id == tonumber(MrRex) then
		       text = text..'₪ Rank ➲ *Executive Admin*\n\n'
			   elseif is_sudo1(data.id) then
	           text = text..'₪ Rank ➲ *Full Access Admin*\n\n'
		     elseif is_admin1(data.id) then
		       text = text..'₪ Rank ➲ *Bot Admin*\n\n'
		     elseif is_owner1(arg.chat_id, data.id) then
		       text = text..'₪ Rank ➲ *Group Owner*\n\n'
		     elseif is_mod1(arg.chat_id, data.id) then
		       text = text..'₪ Rank ➲ *Group Moderator*\n\n'
		 else
		       text = text..'₪ Rank ➲ *Group Member*\n\n'
			end
         local user_info = {} 
  local uhash = 'user:'..data.id
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..data.id..':'..arg.chat_id
  user_info_msgs = tonumber(redis:get(um_hash) or 0)
  text = text..'₪ Total messages ➲ '..user_info_msgs..'\n\n'
  text = text..'@RexCompany'
  tdbot.sendMessage(arg.chat_id, arg.msgid, 0, text, 0, "md")
end
assert (tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, info_cb, {chat_id=arg.chat_id,user_id=data.id,msgid=msgid}))
    else
tdbot.sendMessage(arg.chat_id, "", 0, "*User not found*", 0, "md")
   end
end

local function info_by_id(arg, data)
      if tonumber(data.id) then
    if data.username then
  username = "@"..check_markdown(data.username)
    else
  username = ""
  end
    if data.first_name then
  firstname = check_markdown(data.first_name)
    else
  firstname = ""
  end
    if data.last_name then
  lastname = check_markdown(data.last_name)
    else
  lastname = ""
  end
	local hash = 'rank:'..arg.chat_id..':variables'
   local text = "₪ First name ➲ *"..firstname.."*\n₪ Last name ➲ *"..lastname.."*\n₪ Username ➲ "..username.."\n₪ ID ➲ *"..data.id.."*\n\n"
		    if data.id == tonumber(MrRex) then
		       text = text..'₪ Rank ➲ *Executive Admin*\n\n'
			   elseif is_sudo1(data.id) then
	           text = text..'₪ Rank ➲ *Full Access Admin*\n\n'
		     elseif is_admin1(data.id) then
		       text = text..'₪ Rank ➲ *Bot Admin*\n\n'
		     elseif is_owner1(arg.chat_id, data.id) then
		       text = text..'₪ Rank ➲ *Group Owner*\n\n'
		     elseif is_mod1(arg.chat_id, data.id) then
		       text = text..'₪ Rank ➲ *Group Moderator*\n\n'
		 else
		       text = text..'₪ Rank ➲ *Group Member*\n\n'
			end
         local user_info = {} 
  local uhash = 'user:'..data.id
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..data.id..':'..arg.chat_id
  user_info_msgs = tonumber(redis:get(um_hash) or 0)
  text = text..'₪ Total messages ➲ '..user_info_msgs..'\n\n'
  text = text..'@RexCompany'
  tdbot.sendMessage(arg.chat_id, arg.msgid, 0, text, 0, "md")
   else
   tdbot.sendMessage(arg.chat_id, "", 0, "*User not found*", 0, "md")
   end
end

local function run(msg, matches)
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
	if (matches[1]:lower() == 'info' and not Clang) or (matches[1]:lower() == 'اطلاعات فرد' and Clang) then 
if not matches[2] and tonumber(msg.reply_to_message_id) ~= 0 then
    assert (tdbot_function ({
      _ = "getMessage",
      chat_id = msg.chat_id,
      message_id = msg.reply_to_message_id
    }, info_by_reply, {chat_id=msg.chat_id}))
  end
  if matches[2] and string.match(matches[2], '^%d+$') and tonumber(msg.reply_to_message_id) == 0 then
assert (tdbot_function ({
    _ = "getUser",
    user_id = matches[2],
  }, info_by_id, {chat_id=msg.chat_id,user_id=matches[2],msgid=msg.id}))
    end
  if matches[2] and not string.match(matches[2], '^%d+$') and tonumber(msg.reply_to_message_id) == 0 then
   assert (tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, info_by_username, {chat_id=msg.chat_id,username=matches[2],msgid=msg.id}))
      end
  if not matches[2] and tonumber(msg.reply_to_message_id) == 0 then
local function info2_cb(arg, data)
      if tonumber(data.id) then
    if data.username then
  username = "@"..check_markdown(data.username)
    else
  username = ""
  end
    if data.first_name then
  firstname = check_markdown(data.first_name)
    else
  firstname = ""
  end
    if data.last_name then
  lastname = check_markdown(data.last_name)
    else
  lastname = ""
  end
	local hash = 'rank:'..arg.chat_id..':variables'
   local text = "₪ First name ➲ *"..firstname.."*\n₪ Last name ➲ *"..lastname.."*\n₪ Username ➲ "..username.."\n₪ ID ➲ *"..data.id.."*\n\n"
		    if data.id == tonumber(MrRex) then
		       text = text..'₪ Rank ➲ *Executive Admin*\n\n'
			   elseif is_sudo1(data.id) then
	           text = text..'₪ Rank ➲ *Full Access Admin*\n\n'
		     elseif is_admin1(data.id) then
		       text = text..'₪ Rank ➲ *Bot Admin*\n\n'
		     elseif is_owner1(arg.chat_id, data.id) then
		       text = text..'₪ Rank ➲ *Group Owner*\n\n'
		     elseif is_mod1(arg.chat_id, data.id) then
		       text = text..'₪ Rank ➲ *Group Moderator*\n\n'
		 else
		       text = text..'₪ Rank ➲ *Group Member*\n\n'
			end
         local user_info = {} 
  local uhash = 'user:'..data.id
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..data.id..':'..arg.chat_id
  user_info_msgs = tonumber(redis:get(um_hash) or 0)
  text = text..'₪ Total messages ➲ '..user_info_msgs..'\n\n'
  text = text..'@RexCompany'
  tdbot.sendMessage(arg.chat_id, arg.msgid, 0, text, 0, "md")
   end
end
assert (tdbot_function ({
    _ = "getUser",
    user_id = msg.sender_user_id,
  }, info_by_id, {chat_id=msg.chat_id,user_id=msg.sender_user_id,msgid=msg.id}))
      end
   end
end
return {
	patterns = {
"^(info)$",
"^(info) (.*)$",
"^(info)$",
"^(اطلاعات فرد)$",
"^(اطلاعات فرد) (.*)$",

},
	run = run
}
--This Is info.lua for BDReborn Source :)
