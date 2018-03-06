local function modadd(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)

    -- superuser and admins only (because sudo are always has privilege)
    if not is_admin(msg) then
   if not lang then
       return "⇋ You're No مدیر😐"
else
return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
    end
end
    local data = load_data(_config.moderation.data)
  if data[tostring(msg.to.id)] then
if not lang then
   return '`⇋ Group is Already ➲ added`'
else
return '`⇋ گروه از قبل ⇜ نصب شده است.`'
  end
end
        -- create data array in moderation.json
      data[tostring(msg.to.id)] = {
              owners = {},
      mods ={},
      banned ={},
      is_silent_users ={},
      filterlist ={},
      whitelist ={},
      settings = {
          set_name = msg.to.title,
          lock_link = 'yes',
          lock_tag = 'yes',
          lock_spam = 'yes',
          lock_webpage = 'no',
          lock_markdown = 'no',
          flood = 'yes',
          lock_bots = 'yes',
          lock_pin = 'no',
          welcome = 'no',
		  lock_join = 'no',
		  lock_edit = 'no',
		  lock_arabic = 'no',
		  lock_mention = 'no',
		  lock_all = 'no',
		  num_msg_max = '5',
		  set_char = '40',
		  time_check = '2',
          },
   mutes = {
                  mute_forward = 'no',
                  mute_audio = 'no',
                  mute_video = 'no',
                  mute_contact = 'no',
                  mute_text = 'no',
                  mute_photo = 'no',
                  mute_gif = 'no',
                  mute_location = 'no',
                  mute_document = 'no',
                  mute_sticker = 'no',
                  mute_voice = 'no',
                  mute_all = 'no',
				  mute_keyboard = 'no',
				  mute_game = 'no',
				  mute_inline = 'no',
				  mute_tgservice = 'no',
          }
      }
  save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
    if not lang then
  return '`⇋ Group ➲ added`\n\n₪ Group charged 3 minutes  for ➲ settings.\n'..msg_caption
else
  return '`↜ گروه ⇜ نصب شد`\n\n₪ گروه به مدت 3 دقیقه برای اجرای تنظیمات شارژ میباشد.\n'..msg_caption
end
end

local function modrem(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
      if not is_admin(msg) then
     if not lang then
        return "⇋ You're No مدیر😐"
else
return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
    end
   end
    local data = load_data(_config.moderation.data)
    local receiver = msg.to.id
  if not data[tostring(msg.to.id)] then
  if not lang then
    return '`⇋ Group is ➲ not added`'
else
    return '`↜ گروه ⇜ نصب نشده.`'
   end
  end

  data[tostring(msg.to.id)] = nil
  save_data(_config.moderation.data, data)
     local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
 if not lang then
  return '`⇋ Group ➲ removed`'
 else
  return '`↜ گروه ⇜ حذف شد.`'
end
end

local function filter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
if data[tostring(msg.to.id)]['filterlist'][(word)] then
   if not lang then
         return "⇋ Word *"..word.."* is Already ➲ filtered"
            else
         return "↜ کلمه * "..word.."* ⇜ از قبل فیلتر بود"
    end
end
   data[tostring(msg.to.id)]['filterlist'][(word)] = true
     save_data(_config.moderation.data, data)
   if not lang then
         return "⇋ Word *"..word.."* ➲ Filtered"
            else
         return "↜ کلمه *"..word.."* ⇜ فیلتر شد"
    end
end

local function unfilter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
      if data[tostring(msg.to.id)]['filterlist'][word] then
      data[tostring(msg.to.id)]['filterlist'][(word)] = nil
       save_data(_config.moderation.data, data)
       if not lang then
         return "⇋ Word *"..word.."* ➲ unfiltered"
       elseif lang then
         return "↜ کلمه *"..word.."* ⇜ رفع فیلتر شد"
     end
      else
       if not lang then
         return "⇋ Word *"..word.."* ➲ Not filtered"
       elseif lang then
         return "↜ کلمه *"..word.."* از قبل ⇜ فیلتر نبود"
      end
   end
end

local function modlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.chat_id)] then
  if not lang then
    return "⇋ Group ➲ Not added"
 else
    return "↜ گروه به لیست گروه های مدیریتی ربات اضافه نشده است"
  end
 end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['mods']) == nil then --fix way
  if not lang then
    return "⇋ No *moderator* in this group"
else
   return " ↜ در حال حاضر هیچ مدیری برای گروه انتخاب نشده است"
  end
end
if not lang then
   message = '⇋ *List of moderators :*\n'
else
   message = '↜ *لیست مدیران گروه :*\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['mods'])
do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function ownerlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.to.id)] then
if not lang then
    return "⇋ Group ➲ Not added"..msg_caption
else
return "↜ گروه به لیست گروه های مدیریتی ربات اضافه نشده است"
  end
end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['owners']) == nil then --fix way
 if not lang then
    return "⇋ No *owner* in this group"
else
    return "↜ در حال حاضر هیچ مالکی برای گروه انتخاب نشده است"
  end
end
if not lang then
   message = '⇋ *List of moderators :*\n'
else
   message = '↜ *لیست مالکین گروه :*\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['owners']) do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function action_by_reply(arg, data)
local hash = "gp_lang:"..data.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
if not tonumber(data.sender_user_id) then return false end
    if data.sender_user_id then
  if not administration[tostring(data.chat_id)] then
  if not lang then
    return tdbot.sendMessage(data.chat_id, "", 0, "⇋ Group ➲ Not added", 0, "md")
else
    return tdbot.sendMessage(data.chat_id, "", 0, "↜ گروه به لیست گروه های مدیریتی ربات اضافه نشده است", 0, "md")
     end
  end
    if cmd == "setwhitelist" then
local function setwhitelist_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* is Already in ➲ *white list*", 0, "md")
else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از قبل در لیست سفید بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* has been added to ➲ *white list*", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *به لیست سفید اضافه شد*", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, setwhitelist_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
    if cmd == "remwhitelist" then
local function remwhitelist_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* Not in ➲ *white list*", 0, "md")
    else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از قبل در لیست سفید نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* has been removed from ➲ *white list*", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از لیست سفید حذف شد*", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, remwhitelist_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
if cmd == "setowner" then
local function owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* is Already a ➲ *group owner*", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از قبل صاحب گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* is Now the ➲ *group owner*", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *به مقام صاحب گروه منتصب شد*", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, owner_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
    if cmd == "promote" then
local function promote_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* is Already a ➲ *moderator*", 0, "md")
else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از قبل مدیر گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* ➲ *promoted*", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *به مقام مدیر گروه منتصب شد*", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, promote_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
     if cmd == "remowner" then
local function rem_owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] then
   if not lang then
return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* Not a ➲ *group owner*", 0, "md")
   else
return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از قبل صاحب گروه نبود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* is no longer a ➲ *group owner*", 0, "md")
    else
return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از مقام صاحب گروه برکنار شد*", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, rem_owner_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
    if cmd == "demote" then
local function demote_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* Not a ➲ *moderator*", 0, "md")
    else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از قبل مدیر گروه نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* ➲ *demoted*", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از مقام مدیر گروه برکنار شد*", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, demote_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
    if cmd == "id" then
local function id_cb(arg, data)
    return tdbot.sendMessage(arg.chat_id, "", 0, "*"..data.id.."*", 0, "md")
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, id_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
else
    if lang then
  return tdbot.sendMessage(data.chat_id, "", 0, "کاربر یافت نشد", 0, "md")
   else
  return tdbot.sendMessage(data.chat_id, "", 0, "⇋ *User Not Found*", 0, "md")
      end
   end
end

local function action_by_username(arg, data)
    --return tdbot.sendMessage(arg.chat_id, "", 0, serpent.block(data), 0, "html")
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ Group ➲ Not added", 0, "md")
else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜گروه به لیست گروه های مدیریتی ربات اضافه نشده است ", 0, "md")
     end
  end
if not arg.username then return false end
   if data.id then
    if cmd == "setwhitelist" then
local function setwhitelist_cb(arg, data)
    --return tdbot.sendMessage(arg.chat_id, "", 0, serpent.block(data), 0, "html")
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* is Already ➲ in *white list*", 0, "md")
else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از قبل در لیست سفید بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* has been added to ➲ *white list*", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *به لیست سفید اضافه شد*", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, setwhitelist_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
    if cmd == "remwhitelist" then
local function remwhitelist_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* Not in ➲ *white list*", 0, "md")
    else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از قبل در لیست سفید نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* has been removed from ➲ *white list*", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از لیست سفید حذف شد*", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, remwhitelist_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
if cmd == "setowner" then
local function owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* is Already ➲ a *group owner*", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از قبل صاحب گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* is Now the ➲ *group owner*", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *به مقام صاحب گروه منتصب شد*", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, owner_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
    if cmd == "promote" then
local function promote_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* is Already ➲ a *moderator*", 0, "md")
else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از قبل مدیر گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* ➲ *promoted*", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *به مقام مدیر گروه منتصب شد*", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, promote_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
     if cmd == "remowner" then
local function rem_owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] then
   if not lang then
return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* ➲ Not a ➲ *group owner*", 0, "md")
   else
return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* *از قبل صاحب گروه نبود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* is no longer a ➲ *group owner*", 0, "md")
    else
return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از مقام صاحب گروه برکنار شد*", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, rem_owner_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
    if cmd == "demote" then
local function demote_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* ➲ Not a *moderator*", 0, "md")
    else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از قبل مدیر گروه نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* ➲ *demoted*", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از مقام مدیر گروه برکنار شد*", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, demote_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
    if cmd == "res" then
local function res_cb(arg, data)
if data.last_name then
user_name = check_markdown(data.first_name).." "..check_markdown(data.last_name)
else
user_name = check_markdown(data.first_name)
end
    if not lang then
     text = "⇋ Result For : @"..check_markdown(data.username).."\n Name : "..user_name.."\n ID : `"..data.id.."`"
      else
     text = "↜ اطلاعات برای : @"..check_markdown(data.username).."\n نام : "..user_name.."\n ایدی : `"..data.id.."`"
  end
    return tdbot.sendMessage(arg.chat_id, "", 0, text, 0, "md")
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, res_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
else
    if lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر یافت نشد", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ *User Not Found*", 0, "md")
      end
   end
end

local function action_by_id(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdbot.sendMessage(data.chat_id, "", 0, "⇋ Group ➲ Not added", 0, "md")
else
    return tdbot.sendMessage(data.chat_id, "", 0, "↜ گروه به لیست گروه های مدیریتی ربات اضافه نشده است", 0, "md")
     end
  end
if not tonumber(arg.user_id) then return false end
   if data.id then
if data.first_name then
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
    if cmd == "setwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* is Already ➲ in *white list*", 0, "md")
else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از قبل در لیست سفید بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* has been added to ➲ *white list*", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *به لیست سفید اضافه شد*", 0, "md")
   end
end
    if cmd == "remwhitelist" then
  if not administration[tostring(arg.chat_id)]['whitelist'] then
    administration[tostring(arg.chat_id)]['whitelist'] = {}
    save_data(_config.moderation.data, administration)
    end
if not administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* ➲ Not in *white list*", 0, "md")
    else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از قبل در لیست سفید نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['whitelist'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* has been removed from ➲ *white list*", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از لیست سفید حذف شد*", 0, "md")
   end
end
  if cmd == "setowner" then
  if administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* is Already ➲ a *group owner*", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از قبل صاحب گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* is Now the ➲ *group owner*", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *به مقام صاحب گروه منتصب شد*", 0, "md")
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* is Already ➲ a *moderator*", 0, "md")
else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از قبل مدیر گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* ➲ *promoted*", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *به مقام مدیر گروه منتصب شد*", 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] then
   if not lang then
return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* ➲ Not a ➲ *group owner*", 0, "md")
   else
return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* *از قبل صاحب گروه نبود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* is no longer a *group owner*", 0, "md")
    else
return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از مقام صاحب گروه برکنار شد*", 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] then
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* ➲ Not a *moderator*", 0, "md")
    else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از قبل مدیر گروه نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User "..user_name.." *"..data.id.."* ➲ *demoted*", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر "..user_name.." *"..data.id.."* *از مقام مدیر گروه برکنار شد*", 0, "md")
   end
end
    if cmd == "whois" then
if data.username then
username = '@'..check_markdown(data.username)
else
if not lang then
username = '⇋ not found'
 else
username = 'ندارد'
  end
end
     if not lang then
       return tdbot.sendMessage(arg.chat_id, "", 0, '⇋ Info for [ '..data.id..' ] :\nUserName : '..username..'\nName : '..check_markdown(data.first_name), 0, "md")
   else
       return tdbot.sendMessage(arg.chat_id, "", 0, '↜ اطلاعات برای [ '..data.id..' ] :\nیوزرنیم : '..username..'\nنام : '..check_markdown(data.first_name), 0, "md")
      end
   end
 else
    if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ User not founded", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر یافت نشد", 0, "md")
    end
  end
else
    if lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "↜ کاربر یافت نشد", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "⇋ *User Not Found*", 0, "md")
      end
   end
end


---------------Lock Link-------------------
local function lock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're No مدیر😐"
else
return "شما جایگاهی در مدیریت ربات ندارید😑💦"
end
end

local lock_link = data[tostring(target)]["settings"]["lock_link"] 
if lock_link == "yes" then
if not lang then
 return "⇋ *Link* Is Already ➲ Locked"
elseif lang then
 return "↜ ارسال *لینک* ⇜ ممنوع بود."
end
else
data[tostring(target)]["settings"]["lock_link"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
return "⇋ *Link* ➲ Locked"
else
 return "↜ ارسال *لینک* ⇜ ممنوع شد."
end
end
end

local function unlock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "⇋ You're No مدیر😐"
else
return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
end
end 

local lock_link = data[tostring(target)]["settings"]["lock_link"]
 if lock_link == "no" then
if not lang then
return "⇋ *Link*  Is Already ➲ Unlocked" 
elseif lang then
return "↜ ارسال *لینک* ⇜ ممنوع نیست"
end
else 
data[tostring(target)]["settings"]["lock_link"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "⇋ *Link* ➲ Unlocked" 
else
return "↜ ارسال *لینک* ⇜ آزاد شد."
end
end
end

---------------Lock Tag-------------------
local function lock_tag(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're No مدیر😐"
else
 return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
end
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"] 
if lock_tag == "yes" then
if not lang then
 return "⇋ *Tag* Is Already ➲ Locked"
elseif lang then
 return "↜ ارسال تگ ⇜ ممنوع بود"
end
else
 data[tostring(target)]["settings"]["lock_tag"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "⇋ *Tag* ➲ Locked"
else
 return "↜ ارسال تگ ⇜ ممنوع شد"
end
end
end

local function unlock_tag(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "⇋ You're No مدیر😐"
else
 return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
end 
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"]
 if lock_tag == "no" then
if not lang then
return "⇋ *Tag* ➲ Not Locked" 
elseif lang then
return "↜ ارسال تگ ⇜ ممنوع نیست"
end
else 
data[tostring(target)]["settings"]["lock_tag"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "⇋ *Tag* ➲ Unlocked" 
else
return "↜ ارسال تگ ⇜ آزاد شد"
end
end
end

---------------Lock Mention-------------------
local function lock_mention(msg, data, target)
 local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're No مدیر😐"
else
 return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
end
end

local lock_mention = data[tostring(target)]["settings"]["lock_mention"] 
if lock_mention == "yes" then
if not lang then
 return "⇋ *Mention* Is Already ➲ Locked"
elseif lang then
 return "↜ ارسال فراخوانی افراد ⇜ ممنوع بود"
end
else
 data[tostring(target)]["settings"]["lock_mention"] = "yes"
save_data(_config.moderation.data, data)
if not lang then 
 return "⇋ *Mention* ➲ Locked"
else 
 return "↜ ارسال فراخوانی افراد ⇜ ممنوع شد"
end
end
end

local function unlock_mention(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "⇋ You're No مدیر😐"
else
 return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
end
end 

local lock_mention = data[tostring(target)]["settings"]["lock_mention"]
 if lock_mention == "no" then
if not lang then
return "⇋ *Mention* ➲ Not Locked" 
elseif lang then
return "↜ ارسال فراخوانی افراد ⇜ ممنوع نیست"
end
else 
data[tostring(target)]["settings"]["lock_mention"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "⇋ *Mention* ➲ Unlocked" 
else
return "↜ ارسال فراخوانی افراد ⇜ آزاد شد"
end
end
end

---------------Lock Arabic--------------
local function lock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're No مدیر😐"
else
 return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
end
end

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"] 
if lock_arabic == "yes" then
if not lang then
 return "⇋ *Arabic/Persian*  Is Already ➲ Locked"
elseif lang then
 return "↜ ارسال کلمات عربی/فارسی ⇜ ممنوع بود"
end
else
data[tostring(target)]["settings"]["lock_arabic"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "⇋ *Arabic/Persian* ➲ Locked"
else
 return "↜ ارسال کلمات عربی/فارسی ⇜ ممنوع شد"
end
end
end

local function unlock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "⇋ You're No مدیر😐"
else
 return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
end
end 

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"]
 if lock_arabic == "no" then
if not lang then
return "⇋ *Arabic/Persian*  ➲ Not Locked" 
elseif lang then
return "↜ ارسال کلمات عربی/فارسی ⇜ ممنوع نیست"
end
else 
data[tostring(target)]["settings"]["lock_arabic"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "⇋ *Arabic/Persian* ➲ Unlocked" 
else
return "↜ ارسال کلمات عربی/فارسی ⇜ آزاد شد"
end
end
end

---------------Lock Edit-------------------
local function lock_edit(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're No مدیر😐"
else
 return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
end
end

local lock_edit = data[tostring(target)]["settings"]["lock_edit"] 
if lock_edit == "yes" then
if not lang then
 return "⇋ *Editing* Is Already ➲ Locked"
elseif lang then
 return "↜ ویرایش پیام ⇜ ممنوع بود"
end
else
 data[tostring(target)]["settings"]["lock_edit"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "⇋ *Editing* ➲ Locked"
else
 return "↜ ویرایش پیام ⇜ ممنوع شد"
end
end
end

local function unlock_edit(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "⇋ You're No مدیر😐"
else
 return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
end
end 

local lock_edit = data[tostring(target)]["settings"]["lock_edit"]
 if lock_edit == "no" then
if not lang then
return "⇋ *Editing* ➲ Not Locked" 
elseif lang then
return "↜ ویرایش پیام ⇜ ممنوع نیست"
end
else 
data[tostring(target)]["settings"]["lock_edit"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "⇋ *Editing* ➲ Unlocked" 
else
return "↜ ویرایش پیام ⇜ آزاد شد"
end
end
end

---------------Lock spam-------------------
local function lock_spam(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're No مدیر😐"
else
 return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
end
end

local lock_spam = data[tostring(target)]["settings"]["lock_spam"] 
if lock_spam == "yes" then
if not lang then
 return "⇋ *Spam* Is Already ➲ Locked"
elseif lang then
 return "↜ ارسال هرزنامه  ⇜ ممنوع بود"
end
else
 data[tostring(target)]["settings"]["lock_spam"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "⇋ *Spam* ➲ Locked"
else
 return "↜ ارسال هرزنامه ⇜ ممنوع شد"
end
end
end

local function unlock_spam(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "⇋ You're No مدیر😐"
else
 return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
end
end 

local lock_spam = data[tostring(target)]["settings"]["lock_spam"]
 if lock_spam == "no" then
if not lang then
return "⇋ *Spam* ➲ Not Locked" 
elseif lang then
 return "↜ ارسال هرزنامه ⇜ ممنوع نیست"
end
else 
data[tostring(target)]["settings"]["lock_spam"] = "no" 
save_data(_config.moderation.data, data)
if not lang then 
return "⇋ *Spam* ➲ Unlocked" 
else
 return "↜ ارسال هرزنامه ⇜ آزاد شد"
end
end
end

---------------Lock Flood-------------------
local function lock_flood(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're No مدیر😐"
else
 return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
end
end

local lock_flood = data[tostring(target)]["settings"]["flood"] 
if lock_flood == "yes" then
if not lang then
 return "⇋ *Flooding* Is Already ➲ Locked"
elseif lang then
 return "↜ ارسال پیام مکرر ⇜ ممنوع بود"
end
else
 data[tostring(target)]["settings"]["flood"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "⇋ *Flooding* ➲ Locked"
else
 return "↜ ارسال پیام مکرر ⇜ ممنوع شد"
end
end
end

local function unlock_flood(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "⇋ You're No مدیر😐"
else
 return "↜ شما جایگاهی در مدیریت ربات ندارید`😑💦"
end
end 

local lock_flood = data[tostring(target)]["settings"]["flood"]
 if lock_flood == "no" then
if not lang then
return "⇋ *Flooding* ➲ Not Locked" 
elseif lang then
return "↜ ارسال پیام مکرر ⇜ ممنوع نیست"
end
else 
data[tostring(target)]["settings"]["flood"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "⇋ *Flooding* ➲ Unlocked" 
else
return "↜ ارسال پیام مکرر ⇜ آزاد شد"
end
end
end

---------------Lock Bots-------------------
local function lock_bots(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're No مدیر😐"
else
 return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
end
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"] 
if lock_bots == "yes" then
if not lang then
 return "⇋ *Bots* Protection Is Already ➲ Enabled"
elseif lang then
 return "↜ محافظت از گروه در برابر ربات ها هم اکنون فعال است"
end
else
 data[tostring(target)]["settings"]["lock_bots"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "⇋ *Bots* Protection ➲ Enabled"
else
 return "↜ محافظت از گروه در برابر ربات ها فعال شد"
end
end
end

local function unlock_bots(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "⇋ You're No مدیر😐"
else
 return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
end 
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"]
 if lock_bots == "no" then
if not lang then
return "⇋ *Bots* Protection ➲ Not Enabled" 
elseif lang then
return "↜ محافظت از گروه در برابر ربات ها غیر فعال است"
end
else 
data[tostring(target)]["settings"]["lock_bots"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "⇋ *Bots* Protection ➲ Disabled" 
else
return "↜ محافظت از گروه در برابر ربات ها غیر فعال شد"
end
end
end

---------------Lock Join-------------------
local function lock_join(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're No مدیر😐"
else
 return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
end
end

local lock_join = data[tostring(target)]["settings"]["lock_join"] 
if lock_join == "yes" then
if not lang then
 return "⇋ *Join* Is Already ➲ Locked"
elseif lang then
 return "↜ ورود به گروه ⇜ ممنوع بود"
end
else
 data[tostring(target)]["settings"]["lock_join"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "⇋ *Join* ➲ Locked"
else
 return "↜ ورود به گروه ⇜ ممنوع شد"
end
end
end

local function unlock_join(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "⇋ You're No مدیر😐"
else
 return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
end 
end

local lock_join = data[tostring(target)]["settings"]["lock_join"]
 if lock_join == "no" then
if not lang then
return "⇋ *Join* ➲ Not Locked" 
elseif lang then
return "↜ ورود به گروه ⇜ ممنوع نیست"
end
else 
data[tostring(target)]["settings"]["lock_join"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
return "⇋ *Join* ➲ Unlocked" 
else
return "↜ ورود به گروه ⇜ آزاد شد"
end
end
end

---------------Lock Markdown-------------------
local function lock_markdown(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're No مدیر😐"
else
 return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
end
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"] 
if lock_markdown == "yes" then
if not lang then 
 return "⇋ *Markdown* Is Already ➲ Locked"
elseif lang then
 return "↜ ارسال پیام های دارای فونت در گروه ⇜ ممنوع بود"
end
else
 data[tostring(target)]["settings"]["lock_markdown"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "⇋ *Markdown* ➲ Locked"
else
 return "↜ ارسال پیام های دارای فونت ⇜ ممنوع شد"
end
end
end

local function unlock_markdown(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "⇋ You're No مدیر😐"
else
 return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
end 
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"]
 if lock_markdown == "no" then
if not lang then
return "⇋ *Markdown* ➲ Not Locked"
elseif lang then
return "↜ ارسال پیام های دارای فونت ⇜ ممنوع نیست"
end
else 
data[tostring(target)]["settings"]["lock_markdown"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "⇋ *Markdown* ➲ Unlocked"
else
return "↜ ارسال پیام های دارای فونت ⇜ آزاد شد"
end
end
end

---------------Lock Webpage-------------------
local function lock_webpage(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're No مدیر😐"
else
 return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
end
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"] 
if lock_webpage == "yes" then
if not lang then
 return "⇋ *Webpage* Is Already ➲ Locked"
elseif lang then
 return "↜ ارسال صفحات وب ⇜ ممنوع بود"
end
else
 data[tostring(target)]["settings"]["lock_webpage"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "⇋ *Webpage* ➲ Locked"
else
 return "↜ ارسال صفحات وب ⇜ ممنوع شد"
end
end
end

local function unlock_webpage(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "⇋ You're No مدیر😐"
else
 return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
end 
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"]
 if lock_webpage == "no" then
if not lang then
return "⇋ *Webpage* ➲ Not Locked" 
elseif lang then
return "↜ ارسال صفحات وب ⇜ ممنوع نیست"
end
else 
data[tostring(target)]["settings"]["lock_webpage"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
return "⇋ *Webpage* ➲ Unlocked" 
else
return "↜ ارسال صفحات وب ⇜ آزاد شد"
end
end
end

---------------Lock Pin-------------------
local function lock_pin(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're No مدیر😐"
else
 return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
end
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"] 
if lock_pin == "yes" then
if not lang then
 return "⇋ *Pinned Message* Is Already ➲ Locked"
elseif lang then
 return "↜ پین کردن پیام در گروه ⇜ ممنوع بود"
end
else
 data[tostring(target)]["settings"]["lock_pin"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "⇋ *Pinned Message* ➲ Locked"
else
 return "↜ پین کردن پیام در گروه ⇜ ممنوع شد"
end
end
end

local function unlock_pin(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
 return "⇋ You're No مدیر😐"
else
 return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
end 
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"]
 if lock_pin == "no" then
if not lang then
return "⇋ *Pinned Message* ➲ Not Locked" 
elseif lang then
return "↜ پین کردن پیام در گروه ⇜ ممنوع نیست"
end
else 
data[tostring(target)]["settings"]["lock_pin"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
return "⇋ *Pinned Message* ➲ Unlocked" 
else
return "↜ پین کردن پیام در گروه ⇜ آزاد شد"
end
end
end

function group_settings(msg, target) 	
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 	return "⇋ You're No مدیر😐"
else
 return "↜ شما جایگاهی در مدیریت ربات ندارید😑💦"
end
end
local data = load_data(_config.moderation.data)
local target = msg.to.id 
if data[tostring(target)] then 	
if data[tostring(target)]["settings"]["num_msg_max"] then 	
NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['num_msg_max'])
	print('custom'..NUM_MSG_MAX) 	
else 	
NUM_MSG_MAX = 5
end
if data[tostring(target)]["settings"]["set_char"] then 	
SETCHAR = tonumber(data[tostring(target)]['settings']['set_char'])
	print('custom'..SETCHAR) 	
else 	
SETCHAR = 40
end
if data[tostring(target)]["settings"]["time_check"] then 	
TIME_CHECK = tonumber(data[tostring(target)]['settings']['time_check'])
	print('custom'..TIME_CHECK) 	
else 	
TIME_CHECK = 2
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_link"] then			
data[tostring(target)]["settings"]["lock_link"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_tag"] then			
data[tostring(target)]["settings"]["lock_tag"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_mention"] then			
data[tostring(target)]["settings"]["lock_mention"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_arabic"] then			
data[tostring(target)]["settings"]["lock_arabic"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_edit"] then			
data[tostring(target)]["settings"]["lock_edit"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_spam"] then			
data[tostring(target)]["settings"]["lock_spam"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_flood"] then			
data[tostring(target)]["settings"]["lock_flood"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_bots"] then			
data[tostring(target)]["settings"]["lock_bots"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_markdown"] then			
data[tostring(target)]["settings"]["lock_markdown"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_webpage"] then			
data[tostring(target)]["settings"]["lock_webpage"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["welcome"] then			
data[tostring(target)]["settings"]["welcome"] = "no"		
end
end

 if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_pin"] then			
 data[tostring(target)]["settings"]["lock_pin"] = "no"		
 end
 end
 if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_join"] then			
 data[tostring(target)]["settings"]["lock_join"] = "no"		
 end
 end
 local expire_date = ''
local expi = redis:ttl('ExpireDate:'..msg.to.id)
if expi == -1 then
if lang then
	expire_date = '↜ نامحدود!'
else
	expire_date = '⇋ Unlimited!'
end
else
	local day = math.floor(expi / 86400) + 1
if lang then
	expire_date = day..' روز'
else
	expire_date = day..' Days'
end
end
if not lang then

local settings = data[tostring(target)]["settings"] 
 text = "❥ Group Settings:\n₪ Lock edit : *"..settings.lock_edit.."*\n₪ Lock links : *"..settings.lock_link.."*\n₪ Lock tags : *"..settings.lock_tag.."*\n₪ Lock Join : *"..settings.lock_join.."*\n₪ Lock flood : *"..settings.flood.."*\n₪ Lock spam : *"..settings.lock_spam.."*\n₪ Lock mention : *"..settings.lock_mention.."*\n₪ Lock arabic : *"..settings.lock_arabic.."*\n₪ Lock webpage : *"..settings.lock_webpage.."*\n₪ Lock markdown : *"..settings.lock_markdown.."*\n₪ Group welcome : *"..settings.welcome.."*\n₪ Lock pin message : *"..settings.lock_pin.."*\n₪ Bots protection : *"..settings.lock_bots.."*\n₪ Flood sensitivity : *"..NUM_MSG_MAX.."*\n₪ Character sensitivity : *"..SETCHAR.."*\n₪ Flood check time : *"..TIME_CHECK.."*\n*____________________*\n➢ Expire Date : *"..expire_date.."*\n✪ Bot channel: @RexCompany\n*🇬🇧 Group Language* : *EN*"
else
local settings = data[tostring(target)]["settings"] 
 text = "🐾 تنظیمات گروه:\n₪ قفل ویرایش پیام : *"..settings.lock_edit.."*\n₪ قفل لینک : *"..settings.lock_link.."*\n₪ قفل ورود : *"..settings.lock_join.."*\n₪ قفل تگ : *"..settings.lock_tag.."*\n₪ قفل پیام مکرر : *"..settings.flood.."*\n₪ قفل هرزنامه : *"..settings.lock_spam.."*\n₪ قفل فراخوانی : *"..settings.lock_mention.."*\n₪ قفل عربی : *"..settings.lock_arabic.."*\n₪ قفل صفحات وب : *"..settings.lock_webpage.."*\n₪ قفل فونت : *"..settings.lock_markdown.."*\n₪ پیام خوشآمد گویی : *"..settings.welcome.."*\n₪ قفل پین کردن : *"..settings.lock_pin.."*\n₪ محافظت در برابر ربات ها : *"..settings.lock_bots.."*\n₪ حداکثر پیام مکرر : *"..NUM_MSG_MAX.."*\n₪ حداکثر حروف مجاز : *"..SETCHAR.."*\n₪ زمان بررسی پیام های مکرر : *"..TIME_CHECK.."*\n*____________________*\n↫ تاریخ انقضا : *"..expire_date.."*\n✪ کانال ما: @RexCompany\n🇬🇧 زبان سوپرگروه : *FA*"
end
return text
end
--------Mutes---------
--------Mute all--------------------------
local function mute_all(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then 
if not lang then
return "⇋ You're Not *Moderator*" 
else
return "↜ شما مدیر گروه نمیباشید"
end
end

local mute_all = data[tostring(target)]["mutes"]["mute_all"] 
if mute_all == "yes" then 
if not lang then
return "⇋ *Mute All* Is Already ➲ Enabled" 
elseif lang then
return "↜ بیصدا کردن همه فعال ⇜ بود"
end
else 
data[tostring(target)]["mutes"]["mute_all"] = "yes"
 save_data(_config.moderation.data, data) 
if not lang then
return "⇋ *Mute All* ➲ Enabled" 
else
return "↜ بیصدا کردن همه فعال ⇜ شد"
end
end
end

local function unmute_all(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then 
if not lang then
return "⇋ You're Not *Moderator*" 
else
return "↜ شما مدیر گروه نمیباشید"
end
end

local mute_all = data[tostring(target)]["mutes"]["mute_all"] 
if mute_all == "no" then 
if not lang then
return "⇋ *Mute All* Is Already ➲ Disabled" 
elseif lang then
return "↜ بیصدا کردن همه غیر فعال ⇜ است"
end
else 
data[tostring(target)]["mutes"]["mute_all"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "⇋ *Mute All* ➲ Disabled" 
else
return "↜ بیصدا کردن همه غیر فعال ⇜ شد"
end 
end
end

---------------Mute Gif-------------------
local function mute_gif(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're Not *Moderator*"
else
 return "↜ شما مدیر گروه نمیباشید"
end
end

local mute_gif = data[tostring(target)]["mutes"]["mute_gif"] 
if mute_gif == "yes" then
if not lang then
 return "⇋ *Mute Gif* Is Already ➲ Enabled"
elseif lang then
 return "↜ بیصدا کردن گیف فعال  ⇜ بود"
end
else
 data[tostring(target)]["mutes"]["mute_gif"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then 
 return "⇋ *Mute Gif* ➲ Enabled"
else
 return "↜ بیصدا کردن گیف فعال  ⇜ شد"
end
end
end

local function unmute_gif(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "⇋ You're Not *Moderator*"
else
return "↜ شما مدیر گروه نمیباشید"
end
end 

local mute_gif = data[tostring(target)]["mutes"]["mute_gif"]
 if mute_gif == "no" then
if not lang then
return "⇋ *Mute Gif* Is Already ➲ Disabled" 
elseif lang then
return "↜ بیصدا کردن گیف غیر فعال  ⇜ بود"
end
else 
data[tostring(target)]["mutes"]["mute_gif"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "⇋ *Mute Gif* ➲ Disabled" 
else
return "↜ بیصدا کردن گیف غیر فعال  ⇜ شد"
end
end
end
---------------Mute Game-------------------
local function mute_game(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're Not *Moderator*"
else
 return "↜ شما مدیر گروه نمیباشید"
end
end

local mute_game = data[tostring(target)]["mutes"]["mute_game"] 
if mute_game == "yes" then
if not lang then
 return "⇋ *Mute Game* Is Already ➲ Enabled"
elseif lang then
 return "↜ بیصدا کردن بازی های تحت وب فعال  ⇜ بود"
end
else
 data[tostring(target)]["mutes"]["mute_game"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "⇋ *Mute Game* ➲ Enabled"
else
 return "↜ بیصدا کردن بازی های تحت وب فعال  ⇜ شد"
end
end
end

local function unmute_game(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "⇋ You're Not *Moderator*"
else
return "↜ شما مدیر گروه نمیباشید"
end 
end

local mute_game = data[tostring(target)]["mutes"]["mute_game"]
 if mute_game == "no" then
if not lang then
return "⇋ *Mute Game* Is Already ➲ Disabled" 
elseif lang then
return "↜ بیصدا کردن بازی های تحت وب غیر فعال  ⇜ بود"
end
else 
data[tostring(target)]["mutes"]["mute_game"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "⇋ *Mute Game* ➲ Disabled" 
else
return "↜ بیصدا کردن بازی های تحت وب غیر فعال  ⇜ شد"
end
end
end
---------------Mute Inline-------------------
local function mute_inline(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're Not *Moderator*"
else
 return "↜ شما مدیر گروه نمیباشید"
end
end

local mute_inline = data[tostring(target)]["mutes"]["mute_inline"] 
if mute_inline == "yes" then
if not lang then
 return "⇋ *Mute Inline* Is Already ➲ Enabled"
elseif lang then
 return "↜ بیصدا کردن اینلاین فعال  ⇜ بود"
end
else
 data[tostring(target)]["mutes"]["mute_inline"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "⇋ *Mute Inline* ➲ Enabled"
else
 return "↜ بیصدا کردن اینلاین فعال  ⇜ شد"
end
end
end

local function unmute_inline(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "⇋ You're Not *Moderator*"
else
return "↜ شما مدیر گروه نمیباشید"
end
end 

local mute_inline = data[tostring(target)]["mutes"]["mute_inline"]
 if mute_inline == "no" then
if not lang then
return "⇋ *Mute Inline* Is Already ➲ Disabled" 
elseif lang then
return "↜ بیصدا کردن اینلاین غیر فعال  ⇜ بود"
end
else 
data[tostring(target)]["mutes"]["mute_inline"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "⇋ *Mute Inline* ➲ Disabled" 
else
return "↜ بیصدا کردن اینلاین غیر فعال  ⇜ شد"
end
end
end
---------------Mute Text-------------------
local function mute_text(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're Not *Moderator*"
else
 return "↜ شما مدیر گروه نمیباشید"
end
end

local mute_text = data[tostring(target)]["mutes"]["mute_text"] 
if mute_text == "yes" then
if not lang then
 return "⇋ *Mute Text* Is Already ➲ Enabled"
elseif lang then
 return "↜ بیصدا کردن متن فعال ⇜ بود"
end
else
 data[tostring(target)]["mutes"]["mute_text"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "⇋ *Mute Text* ➲ Enabled"
else
 return "↜ بیصدا کردن متن فعال ⇜ شد"
end
end
end

local function unmute_text(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "⇋ You're Not *Moderator*"
else
return "↜ شما مدیر گروه نمیباشید"
end 
end

local mute_text = data[tostring(target)]["mutes"]["mute_text"]
 if mute_text == "no" then
if not lang then
return "⇋ *Mute Text* Is Already ➲ Disabled"
elseif lang then
return "↜ بیصدا کردن متن غیر فعال ⇜ بود" 
end
else 
data[tostring(target)]["mutes"]["mute_text"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "⇋ *Mute Text* ➲ Disabled" 
else
return "↜ بیصدا کردن متن غیر فعال ⇜ شد"
end
end
end
---------------Mute photo-------------------
local function mute_photo(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're Not *Moderator*"
else
 return "↜ شما مدیر گروه نمیباشید"
end
end

local mute_photo = data[tostring(target)]["mutes"]["mute_photo"] 
if mute_photo == "yes" then
if not lang then
 return "⇋ *Mute Photo* Is Already ➲ Enabled"
elseif lang then
 return "↜ بیصدا کردن عکس فعال ⇜ بود"
end
else
 data[tostring(target)]["mutes"]["mute_photo"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "⇋ *Mute Photo* ➲ Enabled"
else
 return "↜ بیصدا کردن عکس فعال ⇜ شد"
end
end
end

local function unmute_photo(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "⇋ You're Not *Moderator*"
else
return "↜ شما مدیر گروه نمیباشید"
end
end
 
local mute_photo = data[tostring(target)]["mutes"]["mute_photo"]
 if mute_photo == "no" then
if not lang then
return "⇋ *Mute Photo* Is Already ➲ Disabled" 
elseif lang then
return "↜ بیصدا کردن عکس غیر فعال ⇜ بود"
end
else 
data[tostring(target)]["mutes"]["mute_photo"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "⇋ *Mute Photo* ➲ Disabled" 
else
return "↜ بیصدا کردن عکس غیر فعال ⇜ شد"
end
end
end
---------------Mute Video-------------------
local function mute_video(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're Not *Moderator*"
else
 return "↜ شما مدیر گروه نمیباشید"
end
end

local mute_video = data[tostring(target)]["mutes"]["mute_video"] 
if mute_video == "yes" then
if not lang then
 return "⇋ *Mute Video* Is Already ➲ Enabled"
elseif lang then
 return "↜ بیصدا کردن فیلم فعال ⇜ بود"
end
else
 data[tostring(target)]["mutes"]["mute_video"] = "yes" 
save_data(_config.moderation.data, data)
if not lang then 
 return "⇋ *Mute Video* ➲ Enabled"
else
 return "↜ بیصدا کردن فیلم فعال ⇜ شد"
end
end
end

local function unmute_video(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "⇋ You're Not *Moderator*"
else
return "↜ شما مدیر گروه نمیباشید"
end
end 

local mute_video = data[tostring(target)]["mutes"]["mute_video"]
 if mute_video == "no" then
if not lang then
return "⇋ *Mute Video* Is Already ➲ Disabled" 
elseif lang then
return "↜ بیصدا کردن فیلم غیر فعال ⇜ بود"
end
else 
data[tostring(target)]["mutes"]["mute_video"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "⇋ *Mute Video* ➲ Disabled" 
else
return "↜ بیصدا کردن فیلم غیر فعال ⇜ شد"
end
end
end
---------------Mute Video_Note-------------------
local function mute_video_note(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're Not *Moderator*"
else
 return "↜ شما مدیر گروه نمیباشید"
end
end

local mute_video_note = data[tostring(target)]["mutes"]["mute_video_note"] 
if mute_video == "yes" then
if not lang then
 return "⇋ *Mute Video Note* Is Already ➲ Enabled"
elseif lang then
 return "↜ بیصدا کردن فیلم سلفی فعال ⇜ بود"
end
else
 data[tostring(target)]["mutes"]["mute_video_note"] = "yes" 
save_data(_config.moderation.data, data)
if not lang then 
 return "⇋ *Mute Video Note* ➲ Enabled"
else
 return "↜ بیصدا کردن فیلم سلفی فعال ⇜ شد"
end
end
end

local function unmute_video_note(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "⇋ You're Not *Moderator*"
else
return "↜ شما مدیر گروه نمیباشید"
end
end 

local mute_video_note = data[tostring(target)]["mutes"]["mute_video_note"]
 if mute_video == "no" then
if not lang then
return "⇋ *Mute Video Note* Is Already ➲ Disabled" 
elseif lang then
return "↜ بیصدا کردن فیلم سلفی غیر فعال ⇜ بود"
end
else 
data[tostring(target)]["mutes"]["mute_video_note"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "⇋ *Mute Video Note* ➲ Disabled" 
else
return "↜ بیصدا کردن فیلم سلفی غیر فعال ⇜ شد"
end
end
end
---------------Mute Audio-------------------
local function mute_audio(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're Not *Moderator*"
else
 return "↜ شما مدیر گروه نمیباشید"
end
end

local mute_audio = data[tostring(target)]["mutes"]["mute_audio"] 
if mute_audio == "yes" then
if not lang then
 return "⇋ *Mute Audio* Is Already ➲ Enabled"
elseif lang then
 return "↜ بیصدا کردن آهنگ فعال ⇜ بود"
end
else
 data[tostring(target)]["mutes"]["mute_audio"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "⇋ *Mute Audio* ➲ Enabled"
else 
return "↜بیصدا کردن آهنگ فعال ⇜ شد د"
end
end
end

local function unmute_audio(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "⇋ You're Not *Moderator*"
else
return "↜ شما مدیر گروه نمیباشید"
end
end 

local mute_audio = data[tostring(target)]["mutes"]["mute_audio"]
 if mute_audio == "no" then
if not lang then
return "⇋ *Mute Audio* Is Already ➲ Disabled" 
elseif lang then
return "↜ بیصدا کردن آهنک غیر فعال ⇜ بود"
end
else 
data[tostring(target)]["mutes"]["mute_audio"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "⇋ *Mute Audio* ➲ Disabled"
else
return "↜ بیصدا کردن آهنگ غیر فعال ⇜ شد" 
end
end
end
---------------Mute Voice-------------------
local function mute_voice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're Not *Moderator*"
else
 return "↜ شما مدیر گروه نمیباشید"
end
end

local mute_voice = data[tostring(target)]["mutes"]["mute_voice"] 
if mute_voice == "yes" then
if not lang then
 return "⇋ *Mute Voice* Is Already ➲ Enabled"
elseif lang then
 return "↜ بیصدا کردن صدا فعال ⇜ بود"
end
else
 data[tostring(target)]["mutes"]["mute_voice"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "⇋ *Mute Voice* ➲ Enabled"
else
 return "↜ بیصدا کردن صدا فعال ⇜ شد"
end
end
end

local function unmute_voice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "⇋ You're Not *Moderator*"
else
return "↜ شما مدیر گروه نمیباشید"
end
end 

local mute_voice = data[tostring(target)]["mutes"]["mute_voice"]
 if mute_voice == "no" then
if not lang then
return "⇋ *Mute Voice* Is Already ➲ Disabled" 
elseif lang then
return "↜ بیصدا کردن صدا غیر فعال ⇜ بود"
end
else 
data[tostring(target)]["mutes"]["mute_voice"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "⇋ *Mute Voice* ➲ Disabled" 
else
return "↜ بیصدا کردن صدا غیر فعال ⇜ شد"
end
end
end
---------------Mute Sticker-------------------
local function mute_sticker(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're Not *Moderator*"
else
 return "↜ شما مدیر گروه نمیباشید"
end
end

local mute_sticker = data[tostring(target)]["mutes"]["mute_sticker"] 
if mute_sticker == "yes" then
if not lang then
 return "⇋ *Mute Sticker* Is Already ➲ Enabled"
elseif lang then
 return "↜ بیصدا کردن استیکر فعال ⇜ بود"
end
else
 data[tostring(target)]["mutes"]["mute_sticker"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "⇋ *Mute Sticker* ➲ Enabled"
else
 return "↜ بیصدا کردن استیکر فعال ⇜ شد"
end
end
end

local function unmute_sticker(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "⇋ You're Not *Moderator*"
else
return "↜ شما مدیر گروه نمیباشید"
end 
end

local mute_sticker = data[tostring(target)]["mutes"]["mute_sticker"]
 if mute_sticker == "no" then
if not lang then
return "⇋ *Mute Sticker* Is Already ➲ Disabled" 
elseif lang then
return "↜ بیصدا کردن استیکر غیر فعال ⇜ بود"
end
else 
data[tostring(target)]["mutes"]["mute_sticker"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "⇋ *Mute Sticker* ➲ Disabled"
else
return "↜ بیصدا کردن استیکر غیر فعال ⇜ شد"
end 
end
end
---------------Mute Contact-------------------
local function mute_contact(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're Not *Moderator*"
else
 return "↜ شما مدیر گروه نمیباشید"
end
end

local mute_contact = data[tostring(target)]["mutes"]["mute_contact"] 
if mute_contact == "yes" then
if not lang then
 return "⇋ *Mute Contact* Is Already ➲ Enabled"
elseif lang then
 return "↜ بیصدا کردن مخاطب فعال ⇜ بود"
end
else
 data[tostring(target)]["mutes"]["mute_contact"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "⇋ *Mute Contact* ➲ Enabled"
else
 return "↜ بیصدا کردن مخاطب فعال ⇜ شد"
end
end
end

local function unmute_contact(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "⇋ You're Not *Moderator*"
else
return "↜ شما مدیر گروه نمیباشید"
end
end 

local mute_contact = data[tostring(target)]["mutes"]["mute_contact"]
 if mute_contact == "no" then
if not lang then
return "⇋ *Mute Contact* Is Already ➲ Disabled" 
elseif lang then
return "↜ بیصدا کردن مخاطب غیر فعال ⇜ بود"
end
else 
data[tostring(target)]["mutes"]["mute_contact"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "⇋ *Mute Contact* ➲ Disabled" 
else
return "↜ بیصدا کردن مخاطب غیر فعال ⇜ شد"
end
end
end
---------------Mute Forward-------------------
local function mute_forward(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're Not *Moderator*"
else
 return "↜ شما مدیر گروه نمیباشید"
end
end

local mute_forward = data[tostring(target)]["mutes"]["mute_forward"] 
if mute_forward == "yes" then
if not lang then
 return "⇋ *Mute Forward* Is Already ➲ Enabled"
elseif lang then
 return "↜ بیصدا کردن فروارد فعال ⇜ بود"
end
else
 data[tostring(target)]["mutes"]["mute_forward"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "⇋ *Mute Forward* ➲ Enabled"
else
 return "↜ بیصدا کردن فروارد فعال ⇜ شد"
end
end
end

local function unmute_forward(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "⇋ You're Not *Moderator*"
else
return "↜ شما مدیر گروه نمیباشید"
end
end 

local mute_forward = data[tostring(target)]["mutes"]["mute_forward"]
 if mute_forward == "no" then
if not lang then
return "⇋ *Mute Forward* Is Already ➲ Disabled"
elseif lang then
return "↜ بیصدا کردن فروارد غیر فعال ⇜ بود"
end 
else 
data[tostring(target)]["mutes"]["mute_forward"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "⇋ *Mute Forward* ➲ Disabled" 
else
return "↜ بیصدا کردن فروارد غیر فعال ⇜ شد"
end
end
end
---------------Mute Location-------------------
local function mute_location(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're Not *Moderator*"
else
 return "↜ شما مدیر گروه نمیباشید"
end
end

local mute_location = data[tostring(target)]["mutes"]["mute_location"] 
if mute_location == "yes" then
if not lang then
 return "⇋ *Mute Location* Is Already ➲ Enabled"
elseif lang then
 return "↜ بیصدا کردن موقعیت فعال ⇜ بود"
end
else
 data[tostring(target)]["mutes"]["mute_location"] = "yes" 
save_data(_config.moderation.data, data)
if not lang then
 return "⇋ *Mute Location* ➲ Enabled"
else
 return "↜ بیصدا کردن موقعیت فعال ⇜ شد"
end
end
end

local function unmute_location(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "⇋ You're Not *Moderator*"
else
return "↜ شما مدیر گروه نمیباشید"
end
end 

local mute_location = data[tostring(target)]["mutes"]["mute_location"]
 if mute_location == "no" then
if not lang then
return "⇋ *Mute Location* Is Already ➲ Disabled" 
elseif lang then
return "↜ بیصدا کردن موقعیت غیر فعال ⇜ بود"
end
else 
data[tostring(target)]["mutes"]["mute_location"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return " *Mute Location* ➲ Disabled" 
else
return "↜ بیصدا کردن موقعیت غیر فعال ⇜ شد"
end
end
end
---------------Mute Document-------------------
local function mute_document(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're Not *Moderator*"
else
return " شما مدیر گروه نمیباشید"
end
end

local mute_document = data[tostring(target)]["mutes"]["mute_document"] 
if mute_document == "yes" then
if not lang then
 return "⇋ *Mute Document* Is Already ➲ Enabled"
elseif lang then
 return "↜ بیدا کردن اسناد فعال ⇜ بود"
end
else
 data[tostring(target)]["mutes"]["mute_document"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "⇋ *Mute Document* ➲ Enabled"
else
 return "↜ بیصدا کردن اسناد فعال ⇜ شد"
end
end
end

local function unmute_document(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "⇋ You're Not *Moderator*"
else
return "↜ شما مدیر گروه نمیباشید"
end
end 

local mute_document = data[tostring(target)]["mutes"]["mute_document"]
 if mute_document == "no" then
if not lang then
return "⇋ *Mute Document* Is Already ➲ Disabled" 
elseif lang then
return "↜ بیصدا کردن اسناد غیر فعال ⇜ است"
end
else 
data[tostring(target)]["mutes"]["mute_document"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "⇋ *Mute Document* ➲ Disabled" 
else
return "↜ بیصدا کردن اسناد غیر فعال ⇜ شد"
end
end
end
---------------Mute TgService-------------------
local function mute_tgservice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're Not *Moderator*"
else
 return "↜ شما مدیر گروه نمیباشید"
end
end

local mute_tgservice = data[tostring(target)]["mutes"]["mute_tgservice"] 
if mute_tgservice == "yes" then
if not lang then
 return "⇋ *Mute TgService* Is Already ➲ Enabled"
elseif lang then
 return "↜ بیصدا کردن خدمات تلگرام فعال ⇜ بود"
end
else
 data[tostring(target)]["mutes"]["mute_tgservice"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "⇋ *Mute TgService* ➲ Enabled"
else
return "↜ بیصدا کردن خدمات تلگرام فعال ⇜ شد"
end
end
end

local function unmute_tgservice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "⇋ You're Not *Moderator*"
else
return "↜ شما مدیر گروه نیستید"
end 
end

local mute_tgservice = data[tostring(target)]["mutes"]["mute_tgservice"]
 if mute_tgservice == "no" then
if not lang then
return "⇋ *Mute TgService* Is Already ➲ Disabled"
elseif lang then
return "↜ بیصدا کردن خدمات تلگرام غیر فعال ⇜ بود"
end 
else 
data[tostring(target)]["mutes"]["mute_tgservice"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "⇋ *Mute TgService* ➲ Disabled"
else
return "↜ بیصدا کردن خدمات تلگرام غیر فعال ⇜ شد"
end 
end
end

---------------Mute Keyboard-------------------
local function mute_keyboard(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "⇋ You're Not *Moderator*"
else
 return "↜ شما مدیر گروه نمیباشید"
end
end

local mute_keyboard = data[tostring(target)]["mutes"]["mute_keyboard"] 
if mute_keyboard == "yes" then
if not lang then
 return "⇋ *Mute Keyboard* Is Already ➲ Enabled"
elseif lang then
 return "↜ بیصدا کردن کیبورد فعال ⇜ بود"
end
else
 data[tostring(target)]["mutes"]["mute_keyboard"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "⇋ *Mute Keyboard* ➲ Enabled"
else
return "↜ بیصدا کردن کیبورد فعال ⇜ شد"
end
end
end

local function unmute_keyboard(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "⇋ You're Not *Moderator*"
else
return "↜ شما مدیر گروه نیستید"
end 
end

local mute_keyboard = data[tostring(target)]["mutes"]["mute_keyboard"]
 if mute_keyboard == "no" then
if not lang then
return "⇋ *Mute Keyboard* Is Already ➲ Disabled"
elseif lang then
return "↜ بیصدا کردن کیبورد غیرفعال ⇜ بود"
end 
else 
data[tostring(target)]["mutes"]["mute_keyboard"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "⇋ *Mute Keyboard* ➲ Disabled"
else
return "↜ بیصدا کردن کیبورد غیرفعال ⇜ شد"
end 
end
end
----------MuteList---------
local function mutes(msg, target) 	
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 	return "⇋ You're Not *Moderator*"	
else
 return "↜ شما مدیر گروه نیستید"
end
end
local data = load_data(_config.moderation.data)
local target = msg.to.id 
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_all"] then			
data[tostring(target)]["mutes"]["mute_all"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_gif"] then			
data[tostring(target)]["mutes"]["mute_gif"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_text"] then			
data[tostring(target)]["mutes"]["mute_text"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_photo"] then			
data[tostring(target)]["mutes"]["mute_photo"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_video"] then			
data[tostring(target)]["mutes"]["mute_video"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_video_note"] then			
data[tostring(target)]["mutes"]["mute_video_note"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_audio"] then			
data[tostring(target)]["mutes"]["mute_audio"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_voice"] then			
data[tostring(target)]["mutes"]["mute_voice"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_sticker"] then			
data[tostring(target)]["mutes"]["mute_sticker"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_contact"] then			
data[tostring(target)]["mutes"]["mute_contact"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_forward"] then			
data[tostring(target)]["mutes"]["mute_forward"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_location"] then			
data[tostring(target)]["mutes"]["mute_location"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_document"] then			
data[tostring(target)]["mutes"]["mute_document"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_tgservice"] then			
data[tostring(target)]["mutes"]["mute_tgservice"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_inline"] then			
data[tostring(target)]["mutes"]["mute_inline"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_game"] then			
data[tostring(target)]["mutes"]["mute_game"] = "no"		
end
end
if data[tostring(target)]["mutes"] then		
if not data[tostring(target)]["mutes"]["mute_keyboard"] then			
data[tostring(target)]["mutes"]["mute_keyboard"] = "no"		
end
end
if not lang then
local mutes = data[tostring(target)]["mutes"] 
 text = "❥ *Group Mute List* : \n₪ Mute all : *"..mutes.mute_all.."*\n₪ Mute gif : *"..mutes.mute_gif.."*\n₪ Mute text : *"..mutes.mute_text.."*\n₪ Mute inline : *"..mutes.mute_inline.."*\n₪ Mute game : *"..mutes.mute_game.."*\n₪ Mute photo : *"..mutes.mute_photo.."*\n₪ Mute video : *"..mutes.mute_video.."*\n₪ Mute audio : *"..mutes.mute_audio.."*\n₪ Mute voice : *"..mutes.mute_voice.."*\n₪ Mute sticker : *"..mutes.mute_sticker.."*\n₪ Mute contact : *"..mutes.mute_contact.."*\n₪ Mute forward : *"..mutes.mute_forward.."*\n₪ Mute location : *"..mutes.mute_location.."*\n₪ Mute document : *"..mutes.mute_document.."*\n₪ Mute TgService : *"..mutes.mute_tgservice.."*\n₪ Mute keyboard : *"..mutes.mute_keyboard.."*\n₪ Mute video note : *"..mutes.mute_video_note.."*\n *____________________*\n*✪ Bot channel*: @RexCompany\n*🇬🇧 Group Language* : *EN*"
else
local mutes = data[tostring(target)]["mutes"] 
 text = "🐾 *لیست بیصدا ها* : \n₪ بیصدا همه : *"..mutes.mute_all.."*\n₪ بیصدا گیف : *"..mutes.mute_gif.."*\n₪ بیصدا متن : *"..mutes.mute_text.."*\n₪ بیصدا اینلاین : *"..mutes.mute_inline.."*\n₪ بیصدا بازی های تحت وب : *"..mutes.mute_game.."*\n₪ بیصدا عکس : *"..mutes.mute_photo.."*\n₪ بیصدا فیلم : *"..mutes.mute_video.."*\n₪ بیصدا آهنگ : *"..mutes.mute_audio.."*\n₪ بیصدا صدا : *"..mutes.mute_voice.."*\n₪ بیصدا استیکر : *"..mutes.mute_sticker.."*\n₪ بیصدا مخاطب : *"..mutes.mute_contact.."*\n₪ بیصدا فور : *"..mutes.mute_forward.."*\n₪ بیصدا موقعیت : *"..mutes.mute_location.."*\n₪ بیصدا اسناد : *"..mutes.mute_document.."*\n₪ بیصدا خدمات تلگرام : *"..mutes.mute_tgservice.."*\n₪ بیصدا کیبورد : *"..mutes.mute_keyboard.."*\n₪ بیصدا فیلم سلفی : *"..mutes.mute_video_note.."*\n*____________________*\n*✪ کانال ما*: @RexCompany\n🇬🇧 زبان سوپرگروه : *FA*"
end
return text
end

local function run(msg, matches)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
local data = load_data(_config.moderation.data)
local chat = msg.chat_id
local user = msg.sender_user_id
-- if msg.to.type ~= 'pv' then
if ((matches[1] == "add" and not Clang) or (matches[1] == "ادد" and Clang)) then
return modadd(msg)
end
if ((matches[1] == "rem" and not Clang) or (matches[1] == "ریم" and Clang)) then
return modrem(msg)
end
if not data[tostring(msg.chat_id)] then return end
if (matches[1] == "id" and not Clang) or (matches[1] == "ایدی" and Clang) then
print('OK')
if not matches[2] and not msg.reply_id then
local function getpro(arg, data)
-- vardump(data)
   if data.photos[0] then
       if not lang then
        tdbot.sendPhoto(msg.to.id, msg.id, data.photos[0].sizes[1].photo.persistent_id, 0, {}, 0, 0,'₪ Name ➲ '..(msg.from.first_name or "----")..'\n₪ Username ➲ @'..(msg.from.username or "----")..'\n₪ Chat ID ➲ '..msg.to.id..'\n₪ User ID ➲ '..msg.from.id, 0, 0, 1, nil, dl_cb, nil)
       elseif lang then
        tdbot.sendPhoto(msg.to.id, msg.id, data.photos[0].sizes[1].photo.persistent_id, 0, {}, 0, 0, '₪ نام ⇜ '..(msg.from.first_name or "----")..'\n₪ نام کاربری ⇜ @'..(msg.from.username or "----")..'\n₪ شناسه گروه ⇜ '..msg.to.id..'\n₪ شناسه شما ⇜ '..msg.from.id, 0, 0, 1, nil, dl_cb, nil)
     end
   else
       if not lang then
      tdbot.sendMessage(msg.to.id, msg.id, 1, "`❥ You Have Not Profile Photo...!`\n\n> *Chat ID :* `"..msg.to.id.."`\n*User ID :* `"..msg.from.id.."`", 1, 'md')
       elseif lang then
      tdbot.sendMessage(msg.to.id, msg.id, 1, "_شما هیچ عکسی ندارید...!_\n\n> _شناسه گروه :_ `"..msg.to.id.."`\n_شناسه شما :_ `"..msg.from.id.."`", 1, 'md')
            end
        end
   end
   assert(tdbot_function ({
    _ = "getUserProfilePhotos",
    user_id = msg.sender_user_id,
    offset = 0,
    limit = 1
  }, getpro, nil))
end
if tonumber(msg.reply_to_message_id) ~= 0 and not matches[2] and is_mod(msg) then
    assert(tdbot_function ({
      _ = "getMessage",
      chat_id = msg.chat_id,
      message_id = msg.reply_to_message_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="id"}))
  end
if matches[2] and is_mod(msg) then
   tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="id"})
      end
   end
if ((matches[1] == "pin" and not Clang) or (matches[1] == "پین" and Clang)) and is_mod(msg) and msg.reply_id then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == 'yes' then
if is_owner(msg) then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdbot.pinChannelMessage(msg.to.id, msg.reply_id, 1, dl_cb, nil)
if not lang then
return "⇋ *Message ➲ Pinned*"
elseif lang then
return "↜ پیام پین ⇜ شد"
end
elseif not is_owner(msg) then
   return
 end
 elseif lock_pin == 'no' then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdbot.pinChannelMessage(msg.to.id, msg.reply_id, 1, dl_cb, nil)
if not lang then
return "⇋ *Message ➲ Pinned*"
elseif lang then
return "↜ پیام پین ⇜ شد"
end
end
end
if ((matches[1] == 'unpin' and not Clang) or (matches[1] == "ان پین" and Clang)) and is_mod(msg) then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == 'yes' then
if is_owner(msg) then
tdbot.unpinChannelMessage(msg.to.id, dl_cb, nil)
if not lang then
return "⇋ *Pin message ➲ unpinned*"
elseif lang then
return "↜ پیام پین شده پاک ⇜ شد"
end
elseif not is_owner(msg) then
   return 
 end
 elseif lock_pin == 'no' then
tdbot.unpinChannelMessage(msg.to.id, dl_cb, nil)
if not lang then
return "⇋ *Pin message ➲ unpinned*"
elseif lang then
return "↜ پیام پین شده پاک ⇜ شد"
end
end
end
if ((matches[1]:lower() == "whitelist" and not Clang) or (matches[1] == "لیست سفید" and Clang)) and matches[2] == "+" and is_mod(msg) then
if not matches[3] and msg.reply_id then
    tdbot_function ({
      _ = "getMessage",
      chat_id = msg.to.id,
      message_id = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setwhitelist"})
  end
  if matches[3] and string.match(matches[3], '^%d+$') then
tdbot_function ({
    _ = "getUser",
    user_id = matches[3],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[3],cmd="setwhitelist"})
    end
  if matches[3] and not string.match(matches[3], '^%d+$') then
   tdbot_function ({
      _ = "searchPublicChat",
      username = matches[3]
    }, action_by_username, {chat_id=msg.to.id,username=matches[3],cmd="setwhitelist"})
      end
   end
if ((matches[1]:lower() == "whitelist" and not Clang) or (matches[1] == "لیست سفید" and Clang)) and matches[2] == "-" and is_mod(msg) then
if not matches[3] and msg.reply_id then
    tdbot_function ({
      _ = "getMessage",
      chat_id = msg.to.id,
      message_id = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remwhitelist"})
  end
  if matches[3] and string.match(matches[3], '^%d+$') then
tdbot_function ({
    _ = "getUser",
    user_id = matches[3],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[3],cmd="remwhitelist"})
    end
  if matches[3] and not string.match(matches[3], '^%d+$') then
   tdbot_function ({
      _ = "searchPublicChat",
      username = matches[3]
    }, action_by_username, {chat_id=msg.to.id,username=matches[3],cmd="remwhitelist"})
      end
   end
if ((matches[1] == "setowner" and not Clang) or (matches[1] == 'مالک' and Clang)) and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdbot_function ({
      _ = "getMessage",
      chat_id = msg.to.id,
      message_id = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdbot_function ({
    _ = "getUser",
    user_id = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="setowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="setowner"})
      end
   end
if ((matches[1] == "remowner" and not Clang) or (matches[1] == "حذف مالک" and Clang)) and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdbot_function ({
      _ = "getMessage",
      chat_id = msg.to.id,
      message_id = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdbot_function ({
    _ = "getUser",
    user_id = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="remowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="remowner"})
      end
   end
if ((matches[1] == "promote" and not Clang) or (matches[1] == "مدیر" and Clang)) and is_owner(msg) then
if not matches[2] and msg.reply_id then
    tdbot_function ({
      _ = "getMessage",
      chat_id = msg.to.id,
      message_id = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="promote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdbot_function ({
    _ = "getUser",
    user_id = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="promote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="promote"})
      end
   end
if ((matches[1] == "demote" and not Clang) or (matches[1] == "حذف مدیر" and Clang)) and is_owner(msg) then
if not matches[2] and msg.reply_id then
 tdbot_function ({
      _ = "getMessage",
      chat_id = msg.to.id,
      message_id = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="demote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdbot_function ({
    _ = "getUser",
    user_id = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="demote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="demote"})
      end
   end

if ((matches[1] == "lock" and not Clang) or (matches[1] == "قفل" and Clang)) and is_mod(msg) then
local target = msg.to.id
if ((matches[2] == "link" and not Clang) or (matches[2] == "لینک" and Clang)) then
return lock_link(msg, data, target)
end
if ((matches[2] == "tag" and not Clang) or (matches[2] == "تگ" and Clang)) then
return lock_tag(msg, data, target)
end
if ((matches[2] == "mention" and not Clang) or (matches[2] == "فراخوانی" and Clang)) then
return lock_mention(msg, data, target)
end
if ((matches[2] == "arabic" and not Clang) or (matches[2] == "عربی" and Clang)) then
return lock_arabic(msg, data, target)
end
if ((matches[2] == "edit" and not Clang) or (matches[2] == "ویرایش" and Clang)) then
return lock_edit(msg, data, target)
end
if ((matches[2] == "spam" and not Clang) or (matches[2] == "هرزنامه" and Clang)) then
return lock_spam(msg, data, target)
end
if ((matches[2] == "flood" and not Clang) or (matches[2] == "پیام مکرر" and Clang)) then
return lock_flood(msg, data, target)
end
if ((matches[2] == "bots" and not Clang) or (matches[2] == "ربات" and Clang)) then
return lock_bots(msg, data, target)
end
if ((matches[2] == "markdown" and not Clang) or (matches[2] == "فونت" and Clang)) then
return lock_markdown(msg, data, target)
end
if ((matches[2] == "webpage" and not Clang) or (matches[2] == "وب" and Clang)) then
return lock_webpage(msg, data, target)
end
if ((matches[2] == "pin" and not Clang) or (matches[2] == "پین" and Clang)) and is_owner(msg) then
return lock_pin(msg, data, target)
end
if ((matches[2] == "join" and not Clang) or (matches[2] == "ورود" and Clang)) then
return lock_join(msg, data, target)
end
end

if ((matches[1] == "unlock" and not Clang) or (matches[1] == "بازکردن" and Clang)) and is_mod(msg) then
local target = msg.to.id
if ((matches[2] == "link" and not Clang) or (matches[2] == "لینک" and Clang)) then
return unlock_link(msg, data, target)
end
if ((matches[2] == "tag" and not Clang) or (matches[2] == "تگ" and Clang)) then
return unlock_tag(msg, data, target)
end
if ((matches[2] == "mention" and not Clang) or (matches[2] == "فراخوانی" and Clang)) then
return unlock_mention(msg, data, target)
end
if ((matches[2] == "arabic" and not Clang) or (matches[2] == "عربی" and Clang)) then
return unlock_arabic(msg, data, target)
end
if ((matches[2] == "edit" and not Clang) or (matches[2] == "ویرایش" and Clang)) then
return unlock_edit(msg, data, target)
end
if ((matches[2] == "spam" and not Clang) or (matches[2] == "هرزنامه" and Clang)) then
return unlock_spam(msg, data, target)
end
if ((matches[2] == "flood" and not Clang) or (matches[2] == "پیام مکرر" and Clang)) then
return unlock_flood(msg, data, target)
end
if ((matches[2] == "bots" and not Clang) or (matches[2] == "ربات" and Clang)) then
return unlock_bots(msg, data, target)
end
if ((matches[2] == "markdown" and not Clang) or (matches[2] == "فونت" and Clang)) then
return unlock_markdown(msg, data, target)
end
if ((matches[2] == "webpage" and not Clang) or (matches[2] == "وب" and Clang)) then
return unlock_webpage(msg, data, target)
end
if ((matches[2] == "pin" and not Clang) or (matches[2] == "پین" and Clang)) and is_owner(msg) then
return unlock_pin(msg, data, target)
end
if ((matches[2] == "join" and not Clang) or (matches[2] == "ورود" and Clang)) then
return unlock_join(msg, data, target)
end
end
if ((matches[1] == "mute" and not Clang) or (matches[1] == "بیصدا" and Clang)) and is_mod(msg) then
local target = msg.to.id
if ((matches[2] == "all" and not Clang) or (matches[2] == "همه" and Clang)) then
return mute_all(msg, data, target)
end
if ((matches[2] == "gif" and not Clang) or (matches[2] == "گیف" and Clang)) then
return mute_gif(msg, data, target)
end
if ((matches[2] == "text" and not Clang) or (matches[2] == "متن" and Clang)) then
return mute_text(msg ,data, target)
end
if ((matches[2] == "photo" and not Clang) or (matches[2] == "عکس" and Clang)) then
return mute_photo(msg ,data, target)
end
if ((matches[2] == "video" and not Clang) or (matches[2] == "فیلم" and Clang)) then
return mute_video(msg ,data, target)
end
if ((matches[2] == "videonote" and not Clang) or (matches[2] == "فیلم سلفی" and Clang)) then
return mute_video_note(msg ,data, target)
end
if ((matches[2] == "audio" and not Clang) or (matches[2] == "اهنگ" and Clang)) then
return mute_audio(msg ,data, target)
end
if ((matches[2] == "voice" and not Clang) or (matches[2] == "صدا" and Clang)) then
return mute_voice(msg ,data, target)
end
if ((matches[2] == "sticker" and not Clang) or (matches[2] == "استیکر" and Clang)) then
return mute_sticker(msg ,data, target)
end
if ((matches[2] == "contact" and not Clang) or (matches[2] == "مخاطب" and Clang)) then
return mute_contact(msg ,data, target)
end
if ((matches[2] == "fwd" and not Clang) or (matches[2] == "فور" and Clang)) then
return mute_forward(msg ,data, target)
end
if ((matches[2] == "location" and not Clang) or (matches[2] == "موقعیت" and Clang)) then
return mute_location(msg ,data, target)
end
if ((matches[2] == "document" and not Clang) or (matches[2] == "اسناد" and Clang)) then
return mute_document(msg ,data, target)
end
if ((matches[2] == "tgservice" and not Clang) or (matches[2] == "خدمات تلگرام" and Clang)) then
return mute_tgservice(msg ,data, target)
end
if ((matches[2] == "inline" and not Clang) or (matches[2] == "اینلاین" and Clang)) then
return mute_inline(msg ,data, target)
end
if ((matches[2] == "game" and not Clang) or (matches[2] == "بازی" and Clang)) then
return mute_game(msg ,data, target)
end
if ((matches[2] == "keyboard" and not Clang) or (matches[2] == "کیبورد" and Clang)) then
return mute_keyboard(msg ,data, target)
end
end

if ((matches[1] == "unmute" and not Clang) or (matches[1] == "باصدا" and Clang)) and is_mod(msg) then
local target = msg.to.id
if ((matches[2] == "all" and not Clang) or (matches[2] == "همه" and Clang)) then
return unmute_all(msg, data, target)
end
if ((matches[2] == "gif" and not Clang) or (matches[2] == "گیف" and Clang)) then
return unmute_gif(msg, data, target)
end
if ((matches[2] == "text" and not Clang) or (matches[2] == "متن" and Clang)) then
return unmute_text(msg, data, target)
end
if ((matches[2] == "photo" and not Clang) or (matches[2] == "عکس" and Clang)) then
return unmute_photo(msg ,data, target)
end
if ((matches[2] == "video" and not Clang) or (matches[2] == "فیلم" and Clang)) then
return unmute_video(msg ,data, target)
end
if ((matches[2] == "videonote" and not Clang) or (matches[2] == "فیلم سلفی" and Clang)) then
return unmute_video_note(msg ,data, target)
end
if ((matches[2] == "audio" and not Clang) or (matches[2] == "اهنگ" and Clang)) then
return unmute_audio(msg ,data, target)
end
if ((matches[2] == "voice" and not Clang) or (matches[2] == "صدا" and Clang)) then
return unmute_voice(msg ,data, target)
end
if ((matches[2] == "sticker" and not Clang) or (matches[2] == "استیکر" and Clang)) then
return unmute_sticker(msg ,data, target)
end
if ((matches[2] == "contact" and not Clang) or (matches[2] == "مخاطب" and Clang)) then
return unmute_contact(msg ,data, target)
end
if ((matches[2] == "fwd" and not Clang) or (matches[2] == "فور" and Clang)) then
return unmute_forward(msg ,data, target)
end
if ((matches[2] == "location" and not Clang) or (matches[2] == "موقعیت" and Clang)) then
return unmute_location(msg ,data, target)
end
if ((matches[2] == "document" and not Clang) or (matches[2] == "اسناد" and Clang)) then
return unmute_document(msg ,data, target)
end
if ((matches[2] == "tgservice" and not Clang) or (matches[2] == "خدمات تلگرام" and Clang)) then
return unmute_tgservice(msg ,data, target)
end
if ((matches[2] == "inline" and not Clang) or (matches[2] == "اینلاین" and Clang)) then
return unmute_inline(msg ,data, target)
end
if ((matches[2] == "game" and not Clang) or (matches[2] == "بازی" and Clang)) then
return unmute_game(msg ,data, target)
end
if ((matches[2] == "keyboard" and not Clang) or (matches[2] == "کیبورد" and Clang)) then
return unmute_keyboard(msg ,data, target)
end
end
if ((matches[1] == "gpinfo" and not Clang) or (matches[1] == "اطلاعات گروه" and Clang)) and is_mod(msg) and msg.to.type == "channel" then
local function group_info(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if not lang then
ginfo = "⇋ *Group Info :*\nAdmin Count : *"..data.administrator_count.."*\nMember Count : *"..data.member_count.."*\nKicked Count : *"..data.kicked_count.."*\nGroup ID : *"..data.channel.id.."*"
-- print(serpent.block(data))
elseif lang then
ginfo = "*اطلاعات گروه :*\nتعداد مدیران : *"..data.administrator_count.."*\nتعداد اعضا : *"..data.member_count.."*\nتعداد اعضای حذف شده : *"..data.kicked_count.."*\nشناسه گروه : *"..data.channel.id.."*"
-- print(serpent.block(data))
end
        tdbot.sendMessage(arg.chat_id, arg.msg_id, 1, ginfo, 1, 'md')
end
 tdbot.getChannelFull(msg.to.id, group_info, {chat_id=msg.to.id,msg_id=msg.id})
end
if ((matches[1] == 'newlink' and not Clang) or (matches[1] == "لینک جدید" and Clang)) and is_mod(msg) then
			local function callback_link (arg, data)
   local hash = "gp_lang:"..msg.to.id
   local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data) 
				if not data.invite_link then
					administration[tostring(msg.to.id)]['settings']['linkgp'] = nil
					save_data(_config.moderation.data, administration)
       if not lang then
       return tdbot.sendMessage(msg.to.id, msg.id, 1, "⇋ Bot ➲ Not group creator\nset a link for group with using /setlink"..msg_caption, 1, 'md')
       elseif lang then
       return tdbot.sendMessage(msg.to.id, msg.id, 1, "↜ ربات سازنده گروه نیست\nبا دستور setlink/ لینک جدیدی برای گروه ثبت کنید"..msg_caption, 1, 'md')
    end
				else
					administration[tostring(msg.to.id)]['settings']['linkgp'] = data.invite_link
					save_data(_config.moderation.data, administration)
        if not lang then
       return tdbot.sendMessage(msg.to.id, msg.id, 1, "⇋ *Newlink Created*", 1, 'md')
        elseif lang then
       return tdbot.sendMessage(msg.to.id, msg.id, 1, "↜ لینک جدید ساخته شد", 1, 'md')
            end
				end
			end
 tdbot.exportChatInviteLink(msg.to.id, callback_link, nil)
		end
		if ((matches[1] == 'setlink' and not Clang) or (matches[1] == "تنظیم لینک" and Clang)) and is_owner(msg) then
			data[tostring(chat)]['settings']['linkgp'] = 'waiting'
			save_data(_config.moderation.data, data)
      if not lang then
			return '⇋ Please send the new group *link* now'
    else 
         return '↜ لطفا لینک گروه خود را ارسال کنید'
       end
		end

		if msg.text then
   local is_link = msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text:match("^([https?://w]*.?t.me/joinchat/%S+)$")
			if is_link and data[tostring(chat)]['settings']['linkgp'] == 'waiting' and is_owner(msg) then
				data[tostring(chat)]['settings']['linkgp'] = msg.text
				save_data(_config.moderation.data, data)
            if not lang then
				return "⇋ *Newlink* ➲ set"
           else
           return "↜ لینک جدید ذخیره شد"
		 	end
       end
		end
    if ((matches[1] == 'link' and not Clang) or (matches[1] == "لینک" and Clang)) and is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "⇋ First create a link for group with using ➲ newlink\nIf bot not group creator set a link with using ➲ setlink"
     else
        return "↜ ابتدا با دستور newlink/ لینک جدیدی برای گروه بسازید\nو اگر ربات سازنده گروه نیس با دستور setlink/ لینک جدیدی برای گروه ثبت کنید"
      end
      end
     if not lang then
       text = "<b>⇋ Group Link :</b>\n"..linkgp..msg_caption
     else
      text = "<b>↜ لینک گروه :</b>\n"..linkgp..msg_caption
         end
        return tdbot.sendMessage(chat, msg.id, 1, text, 1, 'html')
     end
    if ((matches[1] == 'linkpv' and not Clang) or (matches[1] == "لینک پیوی" and Clang)) and is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "⇋ First create a link for group with using ➲ newlink\nIf bot not group creator set a link with using ➲ setlink"
     else
        return "↜ ابتدا با دستور newlink لینک جدیدی برای گروه بسازید\nو اگر ربات سازنده گروه نیس با دستور setlink لینک جدیدی برای گروه ثبت کنید"
      end
      end
     if not lang then
     tdbot.sendMessage(user, "", 1, "<b>Group Link "..msg.to.title.." :</b>\n"..linkgp..msg_caption, 1, 'html')
     else
      tdbot.sendMessage(user, "", 1, "<b>لینک گروه "..msg.to.title.." :</b>\n"..linkgp..msg_caption, 1, 'html')
         end
      if not lang then
        return "⇋ *Group Link Was Send In Your Private Message*"
       else
        return "↜ لینک گروه به پیوی شما ارسال شد"
        end
     end
  if ((matches[1] == "setrules" and not Clang) or (matches[1] == "تنظیم قوانین" and Clang)) and matches[2] and is_mod(msg) then
    data[tostring(chat)]['rules'] = matches[2]
	  save_data(_config.moderation.data, data)
     if not lang then
    return "⇋ *Group rules* ➲ set"
   else 
  return "↜ قوانین گروه ثبت شد"
   end
  end
  if ((matches[1] == "rules" and not Clang) or (matches[1] == "قوانین" and Clang)) then
 if not data[tostring(chat)]['rules'] then
   if not lang then
     rules = "♡ The Default Rules :\n✦ No Flood.\n✦ No Spam.\n✦ No Advertising.\n✦ Try to stay on topic.\n✦ Forbidden any racist, sexual, homophobic or gore content.\n⇝ Repeated failure to comply with these rules will cause ban."..msg_caption
    elseif lang then
       rules = "♡ قوانین پپیشفرض:\n✦ ارسال پیام مکرر ممنوع.\n✦ اسپم ممنوع.\n✦ تبلیغ ممنوع.\n✦ سعی کنید از موضوع خارج نشید.\n✦ هرنوع نژاد پرستی, شاخ بازی و پورنوگرافی ممنوع .\n⇜ از قوانین پیروی کنید, در صورت عدم رعایت قوانین اول اخطار و در صورت تکرار مسدود."..msg_caption
 end
        else
     rules = "*Group Rules :*\n"..data[tostring(chat)]['rules']
      end
    return rules
  end
if ((matches[1] == "res" and not Clang) or (matches[1] == "کاربری" and Clang)) and matches[2] and is_mod(msg) then
    tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="res"})
  end
if ((matches[1] == "whois" and not Clang) or (matches[1] == "شناسه" and Clang)) and matches[2] and is_mod(msg) then
tdbot_function ({
    _ = "getUser",
    user_id = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="whois"})
  end
		if ((matches[1]:lower() == 'setchar' and not Clang) or (matches[1] == "حداکثر حروف مجاز" and Clang)) then
			if not is_mod(msg) then
				return
			end
			local chars_max = matches[2]
			data[tostring(msg.to.id)]['settings']['set_char'] = chars_max
			save_data(_config.moderation.data, data)
    if not lang then
     return "⇋ *Character sensitivity* has been set to : *[ "..matches[2].." ]*"
   else
     return "↜ حداکثر حروف مجاز در پیام تنظیم شد به : *[ "..matches[2].." ]*"
		end
  end
  if ((matches[1]:lower() == 'setflood' and not Clang) or (matches[1] == "تنظیم پیام مکرر" and Clang)) and is_mod(msg) then
			if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 50 then
				return "Wrong number, range is *[2-50]*"
      end
			local flood_max = matches[2]
			data[tostring(chat)]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
			if not lang then
    return "⇋ Group *flood* sensitivity has been set to : *[ "..matches[2].." ]*"
    else
    return '↜ محدودیت پیام مکرر به *'..tonumber(matches[2])..'* تنظیم شد.'
    end
       end
  if ((matches[1]:lower() == 'setfloodtime' and not Clang) or (matches[1] == "تنظیم زمان بررسی" and Clang)) and is_mod(msg) then
			if tonumber(matches[2]) < 2 or tonumber(matches[2]) > 10 then
				return "Wrong number, range is *[2-10]*"
      end
			local time_max = matches[2]
			data[tostring(chat)]['settings']['time_check'] = time_max
			save_data(_config.moderation.data, data)
			if not lang then
    return "⇋ Group *flood* check time has been set to : *[ "..matches[2].." ]*"
    else
    return "↜ حداکثر زمان بررسی پیام های مکرر تنظیم شده : *[ "..matches[2].." ]*"
    end
       end
		if ((matches[1]:lower() == 'clean' and not Clang) or (matches[1] == "پاک کردن" and Clang)) and is_owner(msg) then
			if ((matches[2] == 'mods' and not Clang) or (matches[2] == "مدیران" and Clang)) then
				if next(data[tostring(chat)]['mods']) == nil then
            if not lang then
					return "⇋ No *moderators* in this group"
             else
                return "↜ هیچ مدیری برای گروه انتخاب نشده است"
				end
            end
				for k,v in pairs(data[tostring(chat)]['mods']) do
					data[tostring(chat)]['mods'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            if not lang then
				return "⇋ All *moderators* ➲ demoted"
          else
            return "↜ تمام مدیران گروه تنزیل مقام شدند"
			end
         end
			if ((matches[2] == 'filterlist' and not Clang) or (matches[2] == "لیست فیلتر" and Clang)) then
				if next(data[tostring(chat)]['filterlist']) == nil then
     if not lang then
					return "⇋ *Filtered words list* is empty"
         else
					return "↜ لیست کلمات فیلتر شده خالی است"
             end
				end
				for k,v in pairs(data[tostring(chat)]['filterlist']) do
					data[tostring(chat)]['filterlist'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
       if not lang then
				return "⇋ *Filtered words list* ➲ cleaned"
           else
				return "↜ لیست کلمات فیلتر شده پاک شد"
           end
			end
			if ((matches[2] == 'rules' and not Clang) or (matches[2] == "قوانین" and Clang)) then
				if not data[tostring(chat)]['rules'] then
            if not lang then
					return "⇋ No *rules* available"
             else
               return "↜ قوانین برای گروه ثبت نشده است"
             end
				end
					data[tostring(chat)]['rules'] = nil
					save_data(_config.moderation.data, data)
             if not lang then
				return "⇋ *Group rules* ➲ cleaned"
          else
            return "↜ قوانین گروه پاک شد"
			end
       end
			if ((matches[2] == 'welcome' and not Clang) or (matches[2] == "خوشامد" and Clang)) then
				if not data[tostring(chat)]['setwelcome'] then
            if not lang then
					return "⇋ *Welcome Message not set*"
             else
               return "↜ پیام خوشآمد گویی ثبت نشده است"
             end
				end
					data[tostring(chat)]['setwelcome'] = nil
					save_data(_config.moderation.data, data)
             if not lang then
				return "⇋* Welcome message* ➲ cleaned"
          else
            return "↜ پیام خوشآمد گویی پاک شد "
			end
       end
			if ((matches[2] == 'about' and not Clang) or (matches[2] == "درباره" and Clang)) then
        if msg.to.type == "chat" then
				if not data[tostring(chat)]['about'] then
            if not lang then
					return "⇋ No *description* available"
            else
              return "↜ پیامی مبنی بر درباره گروه ثبت نشده است"
          end
				end
					data[tostring(chat)]['about'] = nil
					save_data(_config.moderation.data, data)
        elseif msg.to.type == "channel" then
   tdbot.changeChannelDescription(chat, "", dl_cb, nil)
             end
             if not lang then
				return "⇋ *Group description* ➲ cleaned"
           else
              return "↜ پیام مبنی بر درباره گروه پاک شد"
             end
		   	end
        end
		if ((matches[1]:lower() == 'clean' and not Clang) or (matches[1] == "پاک کردن" and Clang)) and is_admin(msg) then
			if ((matches[2] == 'owners' and not Clang) or (matches[2] == "مالکان" and Clang)) then
				if next(data[tostring(chat)]['owners']) == nil then
             if not lang then
					return "⇋ No *owners* in this group"
            else
                return "↜ مالکی برای گروه انتخاب نشده است"
            end
				end
				for k,v in pairs(data[tostring(chat)]['owners']) do
					data[tostring(chat)]['owners'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            if not lang then
				return "⇋ All *owners* ➲ demoted"
           else
            return "↜ تمامی مالکان گروه تنزیل مقام شدند"
          end
			end
     end
if ((matches[1] == "setname" and not Clang) or (matches[1] == "تنظیم نام" and Clang)) and matches[2] and is_mod(msg) then
local gp_name = matches[2]
tdbot.changeChatTitle(chat, gp_name, dl_cb, nil)
end
  if ((matches[1] == "setabout" and not Clang) or (matches[1] == "تنظیم درباره" and Clang)) and matches[2] and is_mod(msg) then
     if msg.to.type == "channel" then
   tdbot.changeChannelDescription(chat, matches[2], dl_cb, nil)
    elseif msg.to.type == "chat" then
    data[tostring(chat)]['about'] = matches[2]
	  save_data(_config.moderation.data, data)
     end
     if not lang then
    return "⇋* Group description* ➲ set"
    else
     return "↜ پیام مبنی بر درباره گروه ثبت شد"
      end
  end
  if ((matches[1] == "about" and not Clang) or (matches[1] == "درباره" and Clang)) and msg.to.type == "chat" and is_owner(msg) then
 if not data[tostring(chat)]['about'] then
     if not lang then
     about = "⇋ No *description* available"
      elseif lang then
      about = "↜ پیامی مبنی بر درباره گروه ثبت نشده است"
       end
        else
     about = "⇋ *Group Description :*\n"..data[tostring(chat)]['about']
      end
    return about
  end
  if ((matches[1] == 'filter' and not Clang) or (matches[1] == "فیلتر" and Clang)) and is_mod(msg) then
    return filter_word(msg, matches[2])
  end
  if ((matches[1] == 'unfilter' and not Clang) or (matches[1] == "حذف فیلتر" and Clang)) and is_mod(msg) then
    return unfilter_word(msg, matches[2])
  end
  if ((matches[1] == 'filterlist' and not Clang) or (matches[1] == "لیست فیلتر" and Clang)) and is_mod(msg) then
    return filter_list(msg)
  end
if ((matches[1] == "settings" and not Clang) or (matches[1] == "تنظیمات" and Clang)) and is_mod(msg) then
return group_settings(msg, target)
end
if ((matches[1] == "mutelist" and not Clang) or (matches[1] == "لیست بیصدا" and Clang)) and is_mod(msg) then
return mutes(msg, target)
end
if ((matches[1] == "modlist" and not Clang) or (matches[1] == "لیست مدیران" and Clang)) and is_mod(msg) then
return modlist(msg)
end
if ((matches[1] == "ownerlist" and not Clang) or (matches[1] == "لیست مالکان" and Clang)) and is_owner(msg) then
return ownerlist(msg)
end
if ((matches[1] == "whitelist" and not Clang) or (matches[1] == "لیست سفید" and Clang)) and not matches[2] and is_mod(msg) then
return whitelist(msg.to.id)
end

if ((matches[1]:lower() == "panel" and not Clang) or (matches[1] == "پنل" and Clang)) and is_mod(msg) then
local function found_helper(TM, Beyond)
local function inline_query_cb(TM, BD)
      if BD.results and BD.results[0] then
		tdbot.sendInlineQueryResultMessage(msg.to.id, 0, 0, 1, BD.inline_query_id, BD.results[0].id, dl_cb, nil)
    else
    if not lang then
    text = "⇋ *Helper is offline*\n\n"
        elseif lang then
    text = "↜ ربات هلپر خاموش است\n\n"
    end
  return tdbot.sendMessage(msg.to.id, msg.id, 0, text, 0, "md")
   end
end
tdbot.getInlineQueryResults(Beyond.id, msg.to.id, 0, 0, msg.to.id, 0, inline_query_cb, nil)
end
tdbot.searchPublicChat(tostring(helper_username), found_helper, nil)
end

if (matches[1]:lower() == "setlang" and not Clang) and is_owner(msg) then
local hash = "gp_lang:"..msg.to.id
if matches[2] == "fa" then
redis:set(hash, true)
return "↜ *زبان گروه تنظیم شد به : فارسی*"..msg_caption
  elseif matches[2] == "en" then
 redis:del(hash)
return "⇋ Group Language Set To: EN"..msg_caption
end
end
if (matches[1] == 'زبان' and Clang) and is_owner(msg) then
local hash = "gp_lang:"..msg.to.id
if matches[2] == "فارسی" then
redis:set(hash, true)
return "↜ *زبان گروه تنظیم شد به : فارسی*"..msg_caption
  elseif matches[2] == "انگلیسی" then
 redis:del(hash)
return "⇋ Group Language Set To: EN"..msg_caption
end
end

if (matches[1]:lower() == "setcmd" and not Clang) and is_owner(msg) then
local hash = "cmd_lang:"..msg.to.id
if matches[2] == "fa" then
redis:set(hash, true)
   if lang then
return "↜ *زبان دستورات ربات تنظیم شد به : فارسی*"..msg_caption
else
return "⇋ Bot Commands Language Set To: Fa"..msg_caption
end
end
end
if (matches[1]:lower() == 'ping' and not Clang) or (matches[1]:lower() == 'انلاینی' and Clang) then
if not lang then
return "Pong ;)"
   else
return "آنلاینم ;)" 
   end
end
if (matches[1]:lower() == "دستورات انگلیسی" and Clang) and is_owner(msg) then
local hash = "cmd_lang:"..msg.to.id
redis:del(hash)
   if lang then
return "↜ *زبان دستورات ربات تنظیم شد به : انگلیسی*"..msg_caption
else
return "⇋ Bot Commands Language Set To: EN"..msg_caption
end
end

if (matches[1] == "help" and not Clang) and is_mod(msg) then
if not lang then
text = [[
❥ *Rex v1 Bot Commands:*

➲ `sudohelp`
➳ *Show Sudo & botAdmins Help*

➲ `modhelp`
➳ *Show Owners & Mods Help*

➲ `lockhelp`
➳ *Show Lock Commands Help*

➲ `mutehelp`
➳ *Show Mute Commands Help*

➲ `funhelp`
➳ *Show Fun Help*


❥ Good Luck ツ
            
↬ @RexCompany
]]

elseif lang then

text = [[
❥ *Rex v1 Bot Commands:*

➲ `sudohelp`
↭ *راهنمای سودو و ادمین های ربات*

➲ `modhelp`
↭ *راهنمای صاحبان و مدیران گروه*

➲ `lockhelp`
↭ *راهنمای دستورات لوک ربات*

➲ `mutehelp`
↭ *راهنمای دستورات مات ربات*

➲ `funhelp`
↭ *راهنمای سرگرمی*
            
            
❥ Good Luck ツ

↬ @RexCompany
]]
end
return text
end

if (matches[1] == "راهنما" and Clang) and is_mod(msg) then
if not lang then
text = [[
❥ *Rex v1 Bot Commands:*

↜ `راهنمای سودو`
➳ *Show Sudo & botAdmins Help*

↜ `راهنمای مدیر`
➳ *Show Owners & Mods Help*

↜ `راهنمای لوک`
➳ *Show Lock Commands Help*

↜ `راهنمای مات`
➳ *Show Mute Commands Help*

↜ *راهنمای سرگرمی*
➳ `Show Fun Help`


❥ Good Luck ツ
            
↬ @RexCompany
]]

elseif lang then

text = [[
❥ *Rex v1 Bot Commands:*

↜ `راهنمای سودو`
↭ *راهنمی سودو و ادمین های ربات*

↜ `راهنمای مدیر`
↭ *راهنمای صاحبان و مدیران گروه*

↜ `راهنمای لوک`
↭ *راهنمای دستورات لوک ربات*

↜ `راهنمای مات`
↭ *راهنمای دستورات مات ربات*

↜ `راهنمای سرگرمی`
↭ *راهنمای سرگرمی*


↫ موفق باشید ツ
            
↬ @RexCompany
]]
end
return text
end

if (matches[1] == "modhelp" and not Clang) and is_mod(msg) then
if not lang then
text = [[
✧ *Rex v1 Moderators Help:*

➲ *setowner* `[username|id|reply]`
⇋ Set Group Owner(Multi Owner)

➲ *remowner* `[username|id|reply]`
⇋ Remove User From Owner List

➲ *promote* `[username|id|reply]`
⇋ Promote User To Group Admin

➲ *demote* `[username|id|reply]`
⇋ Demote User From Group Admins List

➲ *setflood* `[1-50]`
⇋ Set Flooding Number

➲ *setchar* `[Number]`
⇋ Set Flooding Characters

➲ *setfloodtime* `[1-10]`
⇋ Set Flooding Time

➲ *silent* `[username|id|reply]`
⇋ Silent User From Group

➲ *unsilent* `[username|id|reply]` 
⇋ Unsilent User From Group

➲ *kick* `[username|id|reply]` 
⇋ Kick User From Group

➲ *ban* `[username|id|reply]` 
⇋ Ban User From Group

➲ *unban* `[username|id|reply]` 
⇋ UnBan User From Group

➲ *whitelist* [+-] `[username|id|reply]`
⇋ Add Or Remove User From White List

➲ *res* `[username]`
⇋ Show User ID

➲ *id* `[reply]`
⇋ Show User ID

➲ *whois* `[id]`
⇋ Show User's Username And Name

➲ *set* `[rules | name | link | about | welcome]`
⇋ Bot Set Them

➲ *clean* `[bans | mods | bots | rules | about | silentlist | filtelist | welcome]` 
⇋ Bot Clean Them

➲ *filter* `[word]`
⇋ Word filter

➲ *unfilter* `[word]`
⇋ Word unfilter

➲ *pin* `[reply]`
⇋ Pin Your Message

➲ *unpin* 
⇋ Unpin Pinned Message

➲ *welcome enable/disable*
⇋ Enable Or Disable Group Welcome

➲ *settings*
⇋ Show Group Settings

➲ *mutelist*
⇋ Show Mutes List

➲ *silentlist*
⇋ Show Silented Users List

➲ *filterlist*
⇋ Show Filtered Words List

➲ *banlist*
⇋ Show Banned Users List

➲ *ownerlist*
⇋ Show Group Owners List 

➲ *modlist* 
⇋ Show Group Moderators List

➲ *whitelist* 
⇋ Show Group White List Users

➲ *rules*
⇋ Show Group Rules

➲ *about*
⇋ Show Group Description

➲ *id*
⇋ Show Your And Chat ID

➲ *gpinfo*
⇋ Show Group Information

➲ *newlink*
⇋ Create A New Link

➲ *link*
⇋ Show Group Link

➲ *linkpv*
⇋ Send Group Link In Your Private Message

➲ *setwelcome* `[text]`
⇋ set Welcome Message

➲ *setlang* `[fa | en]`
⇋ Set Persian/English Language

➲ *setcmd* `[fa | en]`
⇋ Set CMD Persian/English Language


✎ *This Help List Only For Moderators/Owners!*
            
✎ `Its Means, Only Group Moderators/Owners Can Use It!`

❥ *Good luck ツ*

↬ @RexCompany
]]

elseif lang then

text = [[
✧ *Rex v1 Moderators Help:*

➲ *setowner* `[username|id|reply]`
↭ انتخاب مالک گروه(قابل انتخاب چند مالک)

➲ *remowner* `[username|id|reply]`
↭ حذف کردن فرد از فهرست مالکان گروه

➲ *promote* `[username|id|reply]`
↭ ارتقا مقام کاربر به مدیر گروه

➲ *demote* `[username|id|reply]`
↭ تنزیل مقام مدیر به کاربر

➲ *setflood* `[1-50]`
↭ تنظیم حداکثر تعداد پیام مکرر

➲ *setchar* `[Number]`
↭ تنظیم حداکثر کاراکتر پیام مکرر

➲ *setfloodtime* `[1-10]`
↭ تنظیم زمان ارسال پیام مکرر

➲ *silent* `[username|id|reply]`
↭ بیصدا کردن کاربر در گروه

➲ *unsilent* `[username|id|reply]`
↭ در آوردن کاربر از حالت بیصدا در گروه

➲ *kick* `[username|id|reply]`
↭ حذف کاربر از گروه

➲ *ban* `[username|id|reply]`
↭ مسدود کردن کاربر از گروه

➲ *unban* `[username|id|reply]`
↭ در آوردن از حالت مسدودیت کاربر از گروه

➲ *whitelist* `[+|-]` `[یوزرنیم|ایدی|ریپلی]` 
↭ افزودن افراد به لیست سفید

➲ *res* `[username]`
↭ نمایش شناسه کاربر

➲ *id* `[reply]`
↭ نمایش شناسه کاربر

➲ *whois* `[id]`
↭ نمایش نام کاربر, نام کاربری و اطلاعات حساب

➲ *set* `[rules | name | link | about | welcome]`
↭ ربات آنهارا ثبت خواهد کرد

➲ *clean* `[bans | mods | rules | about | silentlist | filterlist | welcome]`
↭ ربات آنهارا پاک خواهد کرد

➲ *filter* `[word]`
↭ فیلتر‌کلمه مورد نظر

➲ *unfilter* `[word]`
↭ ازاد کردن کلمه مورد نظر

➲ *pin* `[reply]`
↭ ربات پیام شمارا در گروه پین خواهد کرد

➲ *unpin *
↭ ربات پیام پین شده در گروه را حذف خواهد کرد

➲ *welcome* enable/disable
↭ فعال یا غیرفعال کردن خوشامد گویی

➲ *settings*
↭ نمایش تنظیمات گروه

➲ *mutelist*
↭ نمایش فهرست بیصدا های گروه

➲ *silentlist*
↭ نمایش فهرست افراد بیصدا

➲ *filterlist*
↭ نمایش لیست کلمات فیلتر شده

➲ *banlist*
↭ نمایش افراد مسدود شده از گروه

➲ *ownerlist*
↭ نمایش فهرست مالکان گروه

➲ *modlist*
↭ نمایش فهرست مدیران گروه

➲ *whitelist*
↭ نمایش افراد سفید شده از گروه

➲ *rules*
↭ نمایش قوانین گروه

➲ *about*
↭ نمایش درباره گروه

➲ *id*
↭ نمایش شناسه شما و گروه

➲ *gpinfo*
↭ نمایش اطلاعات گروه

➲ *newlink*
↭ ساخت لینک جدید

➲ *setlink*
↭ تنظیم لینک جدید

➲ *link*
↭ نمایش لینک گروه

➲ *linkpv*
↭ ارسال لینک گروه به پیوی شما

➲ *setwelcome* `[text]`
↭ ثبت پیام خوش آمد گویی

➲ *setlang* `[fa | en]`
↭ تنظیم زبان ربات به فارسی یا انگلیسی

➲ *setcmd* `[fa | en]`
↭ تنظیم زبان دستورات ربات به فارسی یا انگلیسی


✐ *این راهنما فقط برای مدیران/مالکان گروه میباشد!*

✐ `این به این معناست که فقط مدیران/مالکان گروه میتوانند از دستورات بالا استفاده کنند!`

↫ موفق باشید *;)*
            
↬ @RexCompany
]]
end
return text
end

if (matches[1] == "راهنمای مدیر" and Clang) and is_mod(msg) then
if not lang then
text = [[

✧ *راهنمای مدیریتی ورژن یک رکس*

↜ مالک `[نام کاربری|ایدی|ریپلای]` 
⇋ Set Group Owner(Multi Owner)

↜ حذف مالک `[نام کاربری|ایدی|ریپلای]` 
⇋ Remove User From Owner List

↜ مدیر `[نام کاربری|ایدی|ریپلای]` 
⇋ Promote User To Group Admin

↜ حذف مدیر `[نام کاربری|ایدی|ریپلای]` 
⇋ Demote User From Group Admins List

↜ تنظیم پیام مکرر `[1-50]`
⇋ Set Flooding Number

↜ حداکثر حروف مجاز `[عدد]`
⇋ Set Flooding Characters

↜ تنظیم زمان بررسی `[1-10]`
⇋ Set Flooding Time

↜ سایلنت `[نام کاربری|ایدی|ریپلای]` 
⇋ Silent User From Group

↜ ان سایلنت `[نام کاربری|ایدی|ریپلای]` 
⇋ Unsilent User From Group

↜ اخراج `[نام کاربری|ایدی|ریپلای]` 
⇋ Kick User From Group

↜ بن `[نام کاربری|ایدی|ریپلای]` 
⇋ Ban User From Group

↜ ان بن `[نام کاربری|ایدی|ریپلای]` 
⇋ UnBan User From Group

↜ لیست سفید `[+-]` `[نام کاربری|ایدی|ریپلای]` 
⇋ Add Or Remove User From White List

↜ کاربری `[نام کاربری]`
⇋ Show User ID

↜ ایدی `[ریپلای]`
⇋ Show User ID

↜ شناسه `[ایدی]`
⇋ Show User's Username And Name

↜ تنظیم`[قوانین | نام | لینک | درباره | خوشامد]`
⇋ Bot Set Them

↜ پاک کردن `[بن | مدیران | ربات | قوانین | درباره | لیست سایلنت | خوشامد]`   
⇋ Bot Clean Them

↜ فیلتر `[کلمه]`
⇋ Word filter

↜ حذف فیلتر `[کلمه]`
⇋ Word unfilter

↜ پین `[ریپلای]`
⇋ Pin Your Message

↜ ان پین
⇋ Unpin Pinned Message

↜ خوشامد فعال/غیرفعال
⇋ Enable Or Disable Group Welcome

↜ تنظیمات
⇋ Show Group Settings

↜ لیست بیصدا
⇋ Show Mutes List

↜ لیست سایلنت
⇋ Show Silented Users List

↜ لیست فیلتر
⇋ Show Filtered Words List

↜ لیست بن
⇋ Show Banned Users List

↜ لیست مالکان
⇋ Show Group Owners List 

↜ لیست مدیران
⇋ Show Group Moderators List

↜ لیست سفید
⇋ Show Group White List Users

↜ قوانین
⇋ Show Group Rules

↜ درباره
⇋ Show Group Description

↜ ایدی
⇋ Show Your And Chat ID

↜ اطلاعات گروه
⇋ Show Group Information

↜ لینک جدید
⇋ Create A New Link

↜ تنظیم لینک
⇋ Set A New Link

↜ لینک
⇋ Show Group Link

↜ لینک پیوی
⇋ Send Group Link In Your Private Message

↜ تنظیم خوشامد `[متن]`
⇋ set Welcome Message

↜ زبان `[فارسی | انگلیسی]`
⇋ Set Persian/English Language

↜ دستورات `[فارسی | انگلیسی]`
⇋ Set CMD Persian/English Language

✎ *This Help List Only For Moderators/Owners!*
            
✎ `Its Means, Only Group Moderators/Owners Can Use It!`

❥ *Good luck ツ*
            
↬ @RexCompany
]]

elseif lang then

text = [[
✧ *راهنمای مدیریتی ورژن یک رکس*
            

↜ مالک `[یوزرنیم|ایدی|ریپلی]` 
↭ انتخاب مالک گروه(قابل انتخاب چند مالک)

↜ حذف مالک `[یوزرنیم|ایدی|ریپلی]` 
↭ حذف کردن فرد از فهرست مالکان گروه

↜ مدیر `[یوزرنیم|ایدی|ریپلی]` 
↭ ارتقا مقام کاربر به مدیر گروه

↜ حذف مدیر `[یوزرنیم|ایدی|ریپلی]` 
↭ تنزیل مقام مدیر به کاربر

↜ تنظیم پیام مکرر `[2-50]`
↭ تنظیم حداکثر تعداد پیام مکرر

↜ حداکثر حروف مجاز `[عدد]`
↭ تنظیم حداکثر کاراکتر پیام مکرر

↜ تنظیم زمان بررسی `[1-10]`
↭ تنظیم زمان ارسال پیام مکرر

↜ سایلنت `[یوزرنیم|ایدی|ریپلی]` 
↭ بیصدا کردن کاربر در گروه

↜ ان سایلنت `[یوزرنیم|ایدی|ریپلی]` 
↭ در آوردن کاربر از حالت بیصدا در گروه

↜ اخراج `[یوزرنیم|ایدی|ریپلی]` 
↭ حذف کاربر از گروه

↜ بن `[یوزرنیم|ایدی|ریپلی]` 
↭ مسدود کردن کاربر از گروه

↜ ان بن `[یوزرنیم|ایدی|ریپلی]` 
↭ در آوردن از حالت مسدودیت کاربر از گروه

↜ کاربری `[یوزرنیم]`
↭ نمایش شناسه کاربر

↜ ایدی `[ریپلی]`
↭ نمایش شناسه کاربر

↜ شناسه `[ایدی]`
↭ نمایش نام کاربر, نام کاربری و اطلاعات حساب

↜ تنظیم` [قوانین | نام | لینک | درباره | خوشامد]`
↭ ربات آنهارا ثبت خواهد کرد

↜ پاک کردن `[بن | مدیران | ربات | قوانین | درباره | لیست سایلنت | خوشامد]`   
↭ ربات آنهارا پاک خواهد کرد

↜ لیست سفید `[+|-]` `[یوزرنیم|ایدی|ریپلی]` 
↭ افزودن افراد به لیست سفید

↜ فیلتر `[کلمه]`
↭ فیلتر‌کلمه مورد نظر

↜ حذف فیلتر `[کلمه]`
↭ ازاد کردن کلمه مورد نظر

↜ پین `[ریپلای]`
↭ ربات پیام شمارا در گروه پین خواهد کرد

↜ ان پین
↭ ربات پیام پین شده در گروه را حذف خواهد کرد

↜ خوشامد فعال/غیرفعال
↭ فعال یا غیرفعال کردن خوشامد گویی

↜ تنظیمات
↭ نمایش تنظیمات گروه

↜ لیست بیصدا
↭ نمایش فهرست بیصدا های گروه

↜ لیست سایلنت
↭ نمایش فهرست افراد بیصدا

↜ لیست فیلتر
↭ نمایش لیست کلمات فیلتر شده

↜ لیست سفید
↭ نمایش افراد سفید شده از گروه

↜ لیست بن
↭ نمایش افراد مسدود شده از گروه

↜ لیست مالکان
↭ نمایش فهرست مالکان گروه

↜ لیست مدیران
↭ نمایش فهرست مدیران گروه

↜ قوانین
↭ نمایش قوانین گروه

↜ درباره
↭ نمایش درباره گروه

↜ ایدی
↭ نمایش شناسه شما و گروه

↜ اطلاعات گروه
↭ نمایش اطلاعات گروه

↜ لینک جدید
↭ ساخت لینک جدید

↜ لینک
↭ نمایش لینک گروه

↜ تنظیم لینک
↭ تنظیم لینک جدید برای گروه

↜ لینک پیوی
↭ ارسال لینک گروه به پیوی شما

↜ زبان انگلیسی
↭ تنظیم زبان انگلیسی

↜ زبان فارسی
↭ تنظیم زبان فارسی

↜ دستورات انگلیسی
↭ تنظیم دستورات انگلیسی

↜ دستورات فارسی
↭ تنظیم دستورات فارسی

↜ تنظیم خوشامد [متن]
↭ ثبت پیام خوش آمد گویی


✐ *این راهنما فقط برای مدیران/مالکان گروه میباشد!*

✐ `این به این معناست که فقط مدیران/مالکان گروه میتوانند از دستورات بالا استفاده کنند!`

↫ موفق باشید *;)*

↬ @RexCompany
]]
end
return text
end
if (matches[1] == "lockhelp" and not Clang) and is_mod(msg) then
if not lang then
text = [[
*✧ Rex Lock Help Commands:*🔐


❥ To Lock 🔒

➲ Lock link

➲ Lock join

➲ Lock tag

➲ Lock edit

➲ Lock arabic

➲ Lock webpage

➲ Lock bots

➲ Lock spam

➲ Lock flood

➲ Lock markdown

➲ Lock mention

➲ Lock pin


⚠️ If This Actions Lock, Bot Check Actions And Delete Them


❥ To Unlock 🔓


➲ unlock link

➲ unlock join

➲ unlock tag

➲ unlock edit

➲ unlock arabic

➲ unlock webpage

➲ unlock bots

➲ unlock spam

➲ unlock flood

➲ unlock markdown

➲ unlock mention

➲ unlock pin


⚠️ If This Actions Unlock, Bot Not Delete Them


*✎ This Help List Only For Moderators/Owners!*
 
`✎ Its Means, Only Group Moderators/Owners Can Use It!`


❥ Good luck ツ           
            
↬ @RexCompany
]]
elseif lang then

text = [[
*✧ Rex Lock Help Commands:*🔐


⇜ برای قفل کردن 🔒

➲ Lock link

➲ Lock join

➲ Lock tag

➲ Lock edit

➲ Lock arabic

➲ Lock webpage

➲ Lock bots

➲ Lock spam

➲ Lock flood

➲ Lock markdown

➲ Lock mention

➲ Lock pin


⚠️ در صورت قفل بودن فعالیت ها, ربات آنها را حذف خواهد کرد


⇜ برای بازکردن 🔓


➲ unlock link

➲ unlock join

➲ unlock tag

➲ unlock edit

➲ unlock arabic

➲ unlock webpage

➲ unlock bots

➲ unlock spam

➲ unlock flood

➲ unlock markdown

➲ unlock mention

➲ unlock pin


⚠️ در صورت قفل نبودن فعالیت ها, ربات آنها را حذف نخواهد کرد

            
*✐ این راهنما فقط برای مدیران/مالکان گروه میباشد!*
 
`✐ این به این معناست که فقط مدیران/مالکان گروه میتوانند از دستورات بالا استفاده کنند!`


↫ موفق باشید *;)*

↬ @RexCompany      
]]
end
return text
end

if (matches[1] == "راهنمای لوک" and Clang) and is_mod(msg) then
if not lang then
text = [[
*✧ Rex Lock Help Commands:*🔐


❥ To Lock 🔒
↜ قفل لینک

↜ قفل ورود

↜ قفل تگ

↜ قفل ویرایش

↜ قفل عربی

↜قفل وب

↜ قفل ربات

↜ قفل هرزنامه

↜ قفل پیام مکرر

↜ قفل فونت

↜ قفل فراخوانی

↜ قفل پین


⚠️ If This Actions Lock, Bot Check Actions And Delete Them

❥ To Unlock 🔓

↜ بازکردن لینک

↜ بازکردن ورود

↜ بازکردن تگ

↜ بازکردن ویرایش

↜ بازکردن عربی

↜ بازکردن وب

↜ بازکردن ربات

↜ بازکردن هرزنامه

↜ بازکردن پیام مکرر

↜ بازکردن فونت

↜ بازکردن فراخوانی

↜ بازکردن پین


⚠️ If This Actions Unlock, Bot Not Delete Them

*✎ This Help List Only For Moderators/Owners! *

`✎ Its Means, Only Group Moderators/Owners Can Use It!`


❥ Good luck ツ

↬ @RexCompany
]]
elseif lang then

text = [[
*✧ Rex Lock Help Commands:*🔐


⇜ برای قفل کردن 🔒

↜ قفل لینک

↜ قفل ورود

↜ قفل تگ

↜ قفل ویرایش

↜ قفل عربی

↜قفل وب

↜ قفل ربات

↜ قفل هرزنامه

↜ قفل پیام مکرر

↜ قفل فونت

↜ قفل فراخوانی

↜ قفل پین


⚠️ در صورت قفل بودن فعالیت ها, ربات آنها را حذف خواهد کرد


⇜ برای بازکردن 🔓


↜ بازکردن لینک

↜ بازکردن ورود

↜ بازکردن تگ

↜ بازکردن ویرایش

↜ بازکردن عربی

↜ بازکردن وب

↜ بازکردن ربات

↜ بازکردن هرزنامه

↜ بازکردن پیام مکرر

↜ بازکردن فونت

↜ بازکردن فراخوانی

↜ بازکردن پین


⚠️ در صورت قفل نبودن فعالیت ها, ربات آنها را حذف نخواهد کرد

            
*✐ این راهنما فقط برای مدیران/مالکان گروه میباشد!*
 
`✐ این به این معناست که فقط مدیران/مالکان گروه میتوانند از دستورات بالا استفاده کنند!`


↫ موفق باشید *;)*

↬ @RexCompany          
]]
end
return text
end
if (matches[1] == "mutehelp" and not Clang) and is_mod(msg) then
if not lang then
text = [[
✧ Rex mute Help Commands:

❥ To mute 🔇


➲ mute gif

➲ mute photo

➲ mute document

➲ mute sticker

➲ mute keybord

➲ mute video

➲ mute videonote

➲ mute text

➲ mute fwd

➲ mute location

➲ mute audio

➲ mute voice

➲ mute contact

➲ mute inline

➲ mute all


⚠️ If This Actions Lock, Bot Check Actions And Delete Them


❥ To Unmute 🔈


➲ unmute gif

➲ unmute photo

➲ unmute document

➲ unmute sticker

➲ unmute keybord

➲ unmute video

➲ unmute videonote

➲ unmute text

➲ unmute fwd

➲ unmute location

➲ unmute audio

➲ unmute voice

➲ unmute contact

➲ unmute inline

➲ unmute all


⚠️ If This Actions Unlock, Bot Not Delete Them


✎ This Help List Only For Moderators/Owners!

✎ Its Means, Only Group Moderators/Owners Can Use It!


❥ Good luck ツ

↬ @RexCompany
]]
elseif lang then

text = [[
✧ Rex mute Help Commands: 

⇜ برای بیصدا کردن 🔇


➲ mute gif

➲ mute photo

➲ mute document

➲ mute sticker

➲ mute keybord

➲ mute video

➲ mute videonote

➲ mute text

➲ mute fwd

➲ mute location

➲ mute audio

➲ mute voice

➲ mute contact

➲ mute inline

➲ mute all
            

⚠️ در صورت بیصدا بودن فعالیت ها, ربات آنهارا حذف خواهد کرد


⇜ برای باصدا کردن  🔈


➲ unmute gif

➲ unmute photo

➲ unmute document

➲ unmute sticker

➲ unmute keybord

➲ unmute video

➲ unmute videonote

➲ unmute text

➲ unmute fwd

➲ unmute location

➲ unmute audio

➲ unmute voice

➲ unmute contact

➲ unmute inline

➲ unmute all


⚠️ در صورت بیصدا نبودن فعالیت ها, ربات آنهارا حذف نخواهد کرد


✐ *این راهنما فقط برای مدیران/مالکان گروه میباشد!*

✐ `این به این معناست که فقط مدیران/مالکان گروه میتوانند از دستورات بالا استفاده کنند!`


↫ موفق باشید *;)*

↬ @RexCompany
]]
end
return text
end
if (matches[1] == "راهنمای مات" and Clang) and is_mod(msg) then
if not lang then
text = [[
✧ Rex mute Help Commands: 

❥ To mute 🔇


↜ بیصدا گیف

↜ بیصدا عکس

↜ بیصدا اسناد

↜ بیصدا استیکر

↜ بیصدا کیبورد

↜ بیصدا فیلم

↜ بیصدا فیلم سلفی

↜ بیصدا متن

↜ بیصدا فور

↜ بیصدا موقعیت

↜ بیصدا اهنگ

↜ بیصدا صدا

↜ بیصدا مخاطب

↜ بیصدا اینلاین

↜ بیصدا همه


⚠️ If This Actions Lock, Bot Check Actions And Delete Them


❥ To Unmute 🔈


↜ باصدا گیف

↜ باصدا عکس

↜ باصدا اسناد

↜ باصدا استیکر

↜ باصدا کیبورد

↜ باصدا فیلم

↜ باصدا فیلم سلفی

↜ باصدا متن

↜ باصدا فور

↜ باصدا موقعیت

↜ باصدا اهنگ

↜ باصدا صدا

↜ باصدا مخاطب

↜ باصدا اینلاین

↜ باصدا همه


⚠️ If This Actions Unlock, Bot Not Delete Them


✎ This Help List Only For Moderators/Owners!

✎ Its Means, Only Group Moderators/Owners Can Use It!


❥ Good luck ツ

↬ @RexCompany
]]
elseif lang then

text = [[
✧ Rex mute Help Commands: 

⇜ برای بیصدا کردن 🔇


↜ بیصدا گیف

↜ بیصدا عکس

↜ بیصدا اسناد

↜ بیصدا استیکر

↜ بیصدا کیبورد

↜ بیصدا فیلم

↜ بیصدا فیلم سلفی

↜ بیصدا متن

↜ بیصدا فور

↜ بیصدا موقعیت

↜ بیصدا اهنگ

↜ بیصدا صدا

↜ بیصدا مخاطب

↜ بیصدا اینلاین

↜ بیصدا همه


⚠️ در صورت بیصدا بودن فعالیت ها, ربات آنهارا حذف خواهد کرد


⇜ برای باصدا کردن  🔈


↜ باصدا گیف

↜ باصدا عکس

↜ باصدا اسناد

↜ باصدا استیکر

↜ باصدا کیبورد

↜ باصدا فیلم

↜ باصدا فیلم سلفی

↜ باصدا متن

↜ باصدا فور

↜ باصدا موقعیت

↜ باصدا اهنگ

↜ باصدا صدا

↜ باصدا مخاطب

↜ باصدا اینلاین

↜ باصدا همه


⚠️ در صورت بیصدا نبودن فعالیت ها, ربات آنهارا حذف نخواهد کرد


✐ *این راهنما فقط برای مدیران/مالکان گروه میباشد!*

✐ `این به این معناست که فقط مدیران/مالکان گروه میتوانند از دستورات بالا استفاده کنند!`



↫ موفق باشید *;)*

↬ @RexCompany
]]
end
return text
end
--------------------- Welcome -----------------------
	if ((matches[1] == "welcome" and not Clang) or (matches[1] == "خوشامد" and Clang)) and is_mod(msg) then
		if ((matches[2] == "enable" and not Clang) or (matches[2] == "فعال" and Clang)) then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "yes" then
       if not lang then
				return "⇋ Group *welcome* is Already ➲ enabled"
       elseif lang then
				return "↜ خوشآمد گویی از قبل فعال بود"
           end
			else
		data[tostring(chat)]['settings']['welcome'] = "yes"
	    save_data(_config.moderation.data, data)
       if not lang then
				return "⇋ Group *welcome* ➲ enabled"
       elseif lang then
				return "↜ خوشآمد گویی فعال شد"
          end
			end
		end
		
		if ((matches[2] == "disable" and not Clang) or (matches[2] == "غیرفعال" and Clang)) then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "no" then
      if not lang then
				return "⇋ Group *Welcome* is Already ➲ disabled"
      elseif lang then
				return "↜ خوشآمد گویی از قبل فعال نبود"
         end
			else
		data[tostring(chat)]['settings']['welcome'] = "no"
	    save_data(_config.moderation.data, data)
      if not lang then
				return "⇋ Group *welcome* ➲ disabled"
      elseif lang then
				return "↜ خوشآمد گویی غیرفعال شد"
          end
			end
		end
	end
	if ((matches[1] == "setwelcome" and not Clang) or (matches[1] == "تنظیم خوشامد" and Clang)) and matches[2] and is_mod(msg) then
		data[tostring(chat)]['setwelcome'] = matches[2]
	    save_data(_config.moderation.data, data)
       if not lang then
		return "⇋ Welcome Message ➲ Set To :\n*"..matches[2].."*\n\n*You can use :*\n_{gpname} Group Name_\n_{rules} ➣ Show Group Rules_\n_{time} ➣ Show time english _\n_{date} ➣ Show date english _\n_{timefa} ➣ Show time persian _\n_{datefa} ➣ show date persian _\n_{name} ➣ New Member First Name_\n_{username} ➣ New Member Username_"..msg_caption
       else
		return "↜ پیام خوشآمد گویی تنظیم شد به :\n*"..matches[2].."*\n\n*شما میتوانید از*\n_{gpname} نام گروه_\n_{rules} ➣ نمایش قوانین گروه_\n_{time} ➣ ساعت به زبان انگلیسی _\n_{date} ➣ تاریخ به زبان انگلیسی _\n_{timefa} ➣ ساعت به زبان فارسی _\n_{datefa} ➣ تاریخ به زبان فارسی _\n_{name} ➣ نام کاربر جدید_\n_{username} ➣ نام کاربری کاربر جدید_\n_استفاده کنید_"..msg_caption
        end
     end
	-- end
end
-----------------------------------------
local checkmod = true

local function pre_process(msg)
local chat = msg.to.id
local user = msg.from.id
local hash = "gp_lang:"..chat
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
 if checkmod and msg.text and msg.to.type == 'channel' then
 	checkmod = false
	tdbot.getChannelMembers(msg.to.id, 0, 200, 'Administrators', function(a, b)
	local secchk = true
		for k,v in pairs(b.members) do
			if v.user_id == tonumber(our_id) then
				secchk = false
			end
		end
		if secchk then
			checkmod = false
			if not lang then
				return tdbot.sendMessage(msg.to.id, 0, 1, '⇋ Welcome Message ➲ Set To_Robot isn\'t Administrator, Please promote to Admin!', 1, "md")
			else
				return tdbot.sendMessage(msg.to.id, 0, 1, '↜ لطفا برای کارکرد کامل دستورات، ربات را به مدیر گروه ارتقا دهید.', 1, "md")
			end
		end
	end, nil)
 end
	local function welcome_cb(arg, data)
	local url , res = http.request('http://api.beyond-dev.ir/time/')
          if res ~= 200 then return "No connection" end
      local jdat = json:decode(url)
		administration = load_data(_config.moderation.data)
    if administration[arg.chat_id]['setwelcome'] then
     welcome = administration[arg.chat_id]['setwelcome']
      else
     if not lang then
     welcome = "⇋ *Welcome Dude*"
    elseif lang then
     welcome = "↜ خوش آمدید"
        end
     end
 if administration[tostring(arg.chat_id)]['rules'] then
rules = administration[arg.chat_id]['rules']
else
   if not lang then
     rules = "♡ The Default Rules :\n✦ No Flood.\n✦ No Spam.\n✦ No Advertising.\n✦ Try to stay on topic.\n✦ Forbidden any racist, sexual, homophobic or gore content.\n⇝ Repeated failure to comply with these rules will cause ban.\n@RexCompany"
    elseif lang then
       rules = "♡ قوانین پپیشفرض:\n✦ ارسال پیام مکرر ممنوع.\n✦ اسپم ممنوع.\n✦ تبلیغ ممنوع.\n✦ سعی کنید از موضوع خارج نشید.\n✦ هرنوع نژاد پرستی, شاخ بازی و پورنوگرافی ممنوع .\n⇜ از قوانین پیروی کنید, در صورت عدم رعایت قوانین اول اخطار و در صورت تکرار مسدود.\n@RexCompany"
 end
end
if data.username then
user_name = "@"..check_markdown(data.username)
else
user_name = ""
end
		local welcome = welcome:gsub("{rules}", rules)
		local welcome = welcome:gsub("{name}", check_markdown(data.first_name..' '..(data.last_name or '')))
		local welcome = welcome:gsub("{username}", user_name)
		local welcome = welcome:gsub("{time}", jdat.ENtime)
		local welcome = welcome:gsub("{date}", jdat.ENdate)
		local welcome = welcome:gsub("{timefa}", jdat.FAtime)
		local welcome = welcome:gsub("{datefa}", jdat.FAdate)
		local welcome = welcome:gsub("{gpname}", arg.gp_name)
		tdbot.sendMessage(arg.chat_id, arg.msg_id, 0, welcome, 0, "md")
	end
	if data[tostring(chat)] and data[tostring(chat)]['settings'] then
	if msg.adduser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "yes" then
			tdbot.getUser(msg.adduser, welcome_cb, {chat_id=chat,msg_id=msg.id,gp_name=msg.to.title})
		else
			return false
		end
	end
	if msg.joinuser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "yes" then
			tdbot.getUser(msg.sender_user_id, welcome_cb, {chat_id=chat,msg_id=msg.id,gp_name=msg.to.title})
		else
			return false
        end
		end
	end

 end
 
return {
patterns ={
"^(id)$",
"^(id) (.*)$",
"^(pin)$",
"^(ping)$",
"^(unpin)$",
"^(gpinfo)$",
"^(test)$",
"^(add)$",
"^(rem)$",
"^(panel)$",
"^(modhelp)$",
"^(whitelist) ([+-])$",
"^(whitelist) ([+-]) (.*)$",
"^(whitelist)$",
"^(setowner)$",
"^(setowner) (.*)$",
"^(remowner)$",
"^(remowner) (.*)$",
"^(promote)$",
"^(promote) (.*)$",
"^(demote)$",
"^(demote) (.*)$",
"^(modlist)$",
"^(ownerlist)$",
"^(lock) (.*)$",
"^(unlock) (.*)$",
"^(settings)$",
"^(mutelist)$",
"^(mute) (.*)$",
"^(unmute) (.*)$",
"^(link)$",
"^(linkpv)$",
"^(setlink)$",
"^(newlink)$",
"^(rules)$",
"^(setrules) (.*)$",
"^(about)$",
"^(setabout) (.*)$",
"^(setname) (.*)$",
"^(clean) (.*)$",
"^(setflood) (%d+)$",
"^(setchar) (%d+)$",
"^(setfloodtime) (%d+)$",
"^(res) (.*)$",
"^(whois) (%d+)$",
"^(help)$",
"^(lockhelp)$",
"^(mutehelp)$",
"^(setlang) (.*)$",
"^(setcmd) (.*)$",
"^(filter) (.*)$",
"^(unfilter) (.*)$",
"^(filterlist)$",
"^([https?://w]*.?t.me/joinchat/%S+)$",
"^([https?://w]*.?telegram.me/joinchat/%S+)$",
"^(setwelcome) (.*)",
"^(welcome) (.*)$",
"^(زبان) (.*)$",
"^(دستورات انگلیسی)$",
"^(ایدی)$",
"^(انلاینی)$",
"^(ایدی) (.*)$",
'^(تنظیمات)$',
'^(پنل)$',
'^(پین)$',
'^(ان پین)$',
'^(ادد)$',
'^(ریم)$',
'^(ادمین گروه)$',
'^(ادمین گروه) (.*)$',
'^(حذف ادمین گروه) (.*)$',
'^(حذف ادمین گروه)$',
'^(لیست سفید) ([+-]) (.*)$',
'^(لیست سفید) ([+-])$',
'^(لیست سفید)$',
'^(مالک)$',
'^(مالک) (.*)$',
'^(حذف مالک) (.*)$',
'^(حذف مالک)$',
'^(مدیر)$',
'^(مدیر) (.*)$',
'^(حذف مدیر)$',
'^(حذف مدیر) (.*)$',
'^(قفل) (.*)$',
'^(بازکردن) (.*)$',
'^(بیصدا) (.*)$',
'^(باصدا) (.*)$',
'^(لینک جدید)$',
'^(لینک جدید) (خصوصی)$',
'^(اطلاعات گروه)$',
'^(دستورات) (.*)$',
'^(قوانین)$',
'^(لینک)$',
'^(تنظیم لینک)$',
'^(تنظیم قوانین) (.*)$',
'^(لینک) (پیوی)$',
'^(کاربری) (.*)$',
'^(شناسه) (%d+)$',
'^(تنظیم پیام مکرر) (%d+)$',
'^(تنظیم زمان بررسی) (%d+)$',
'^(حداکثر حروف مجاز) (%d+)$',
'^(پاک کردن) (.*)$',
'^(درباره)$',
'^(تنظیم نام) (.*)$',
'^(تنظیم درباره) (.*)$',
'^(لیست فیلتر)$',
'^(لیست بیصدا)$',
'^(لیست مالکان)$',
'^(لیست مدیران)$',
'^(راهنما)$',
'^(راهنمای مدیر)',
'^(راهنمای لوک)',
'^(راهنمای مات)',
'^(فیلتر) (.*)$',
'^(حذف فیلتر) (.*)$',
'^(خوشامد) (.*)$',
'^(تنظیم خوشامد) (.*)$',


},
run=run,
pre_process = pre_process
}
--end groupmanager.lua #Rex Company#
