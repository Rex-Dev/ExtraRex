--Begin Core.lua By #RexCompany
local function getindex(t,id) 
	for i,v in pairs(t) do 
		if v == id then 
			return i 
		end 
	end 
	return nil 
end 

local function reload_plugins( ) 
	plugins = {} 
	load_plugins() 
end

--By @Rex_Developer
local function already_sudo(user_id)
	for k,v in pairs(_config.sudo_users) do
		if user_id == v then
			return k
		end
	end
	-- If not found
	return false
end
local url , res = https.request('https://api.grandteam.ir/time/')
  if res ~= 200 then return end
local jd = json:decode(url)
--By @Rex_Developer
local function sudolist(msg)
	local sudo_users = _config.sudo_users
	local text = "Sudo Users :\n"
	for i=1,#sudo_users do
		text = text..i.." - "..sudo_users[i].."\n"
	end
	return text
end

local function options(msg, GP_id)
local hash = "gp_lang:"..GP_id
local lang = redis:get(hash) 
     if not lang then
	 text = '❥ Welcome To *Group Panel*\n\n`● '..jd.ENdate..'`\n'
	keyboard = {} 
	keyboard.inline_keyboard = {
         {
            {text = "👍 "..tostring(redis:get("MaTaDoRLikes")), callback_data="/like:"..GP_id},
            {text = "👎 "..tostring(redis:get("MaTaDoRDisLikes")), callback_data="/dislike:"..GP_id}
        },
        {
            {text = '₪ time ➲ '..os.date("%H : %M"), callback_data = '/time:'..GP_id}
        },
		{
			{text = "⇝ Settings ⚙️", callback_data="/settings:"..GP_id},
			{text = "⇝ MuteList 🔇", callback_data="/mutelist:"..GP_id}
		},
        {
            {text = '⇝ Group Info 💠', callback_data = '/more:'..GP_id}
        },
		{
			{text = '⇝ Help ❕', callback_data = '/help:'..GP_id},
            {text = '⇝ TV  🖥', callback_data = '/tv:'..GP_id}
            
		},
        {
			{text = '⇝ Support 📞', callback_data = '/sup:'..GP_id},
            {text = '⇝ About Us 🔎', callback_data = '/rex:'..GP_id}
		},
		{
			{text= '⇝ Change Language' ,callback_data = '/persian:'..GP_id}
		},
        {
			{text= 'Exit ⇜' ,callback_data = '/exit:'..GP_id}
		}
	}
  elseif lang then
	 text = '↫ به پنل تنظیمات گروه خوشآمدید \n\n`● تاریخ ⇜ '..jd.FAdate..'`\n'
	keyboard = {} 
	keyboard.inline_keyboard = {
        {
            {text = "👍 "..tostring(redis:get("MaTaDoRLikes")), callback_data="/like:"..GP_id},
            {text = "👎 "..tostring(redis:get("MaTaDoRDisLikes")), callback_data="/dislike:"..GP_id}
        },
        {
            {text = '₪ time ➲ '..os.date("%H : %M"), callback_data = '/time:'..GP_id}
        },
		{
			{text = "⇜ تنظیمات ⚙️", callback_data="/settings:"..GP_id},
			{text = "⇜ لیست بیصدا 🔇", callback_data="/mutelist:"..GP_id}
		},
        {
            {text = '⇜ درباره گروه 💠', callback_data = '/more:'..GP_id}
        },
		{
			{text = '⇜ راهنما ❕', callback_data = '/help:'..GP_id},
            {text = '⇜ تلیویزیون  🖥', callback_data = '/tvfa:'..GP_id}
            
		},
        {
			{text = '⇜ پشتیبانی 📞', callback_data = '/sup:'..GP_id},
            {text = '⇜ درباره ما 🔎', callback_data = '/rex:'..GP_id}
		},
		{
			{text= '⇜ تغییر زبان' ,callback_data = '/english:'..GP_id}
		},
        {
			{text= '⇜ خروج' ,callback_data = '/exit:'..GP_id}
		}	
	}
  end
    edit_inline(msg.message_id, text, keyboard)
end

function moresetting(msg, data, GP_id)
local hash = "gp_lang:"..GP_id
local lang = redis:get(hash) 
local settings = data[tostring(GP_id)]["settings"]
   if not lang then
 text = '❥ Welcome To *More Settings*'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = '⇝ Flood Sensitivity ', callback_data = 'RexCompany'}
		},
		{
			{text = "➕", callback_data='/floodup:'..GP_id}, 
			{text = tostring(settings.num_msg_max), callback_data="RexCompany"},
			{text = "➖", callback_data='/flooddown:'..GP_id}
		},
		{
			{text = '⇝ Character Sensitivity ', callback_data = 'RexCompany'}
		},
		{
			{text = "➕", callback_data='/charup:'..GP_id}, 
			{text = tostring(settings.set_char), callback_data="RexCompany"},
			{text = "➖", callback_data='/chardown:'..GP_id}
		},
		{
			{text = '⇝ Flood Check Time ', callback_data = 'RexCompany'}
		},
		{
			{text = "➕", callback_data='/floodtimeup:'..GP_id}, 
			{text = tostring(settings.time_check), callback_data="RexCompany"},
			{text = "➖", callback_data='/floodtimedown:'..GP_id}
		},
		{
			{text = '↷ Back ', callback_data = '/settings:'..GP_id}
		}				
	}
   elseif lang then
 text = '↫ به تنظیمات بیشتر خوش آمدید '
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = '⇜ حداکثر پیام های مکرر', callback_data = 'RexCompany'}
		},
		{
			{text = "➕", callback_data='/floodup:'..GP_id}, 
			{text = tostring(settings.num_msg_max), callback_data="RexCompany"},
			{text = "➖", callback_data='/flooddown:'..GP_id}
		},
		{
			{text = '⇜ حداکثر حروف مجاز', callback_data = 'RexCompany'}
		},
		{
			{text = "➕", callback_data='/charup:'..GP_id}, 
			{text = tostring(settings.set_char), callback_data="RexCompany"},
			{text = "➖", callback_data='/chardown:'..GP_id}
		},
		{
			{text = '⇜ زمان بررسی پیام های مکرر', callback_data = 'RexCompany'}
		},
		{
			{text = "➕", callback_data='/floodtimeup:'..GP_id}, 
			{text = tostring(settings.time_check), callback_data="RexCompany"},
			{text = "➖", callback_data='/floodtimedown:'..GP_id}
		},
		{
			{text = '⇜ بازگشت', callback_data = '/settings:'..GP_id}
		}				
	}
   end
    edit_inline(msg.message_id, text, keyboard)
end

function setting(msg, data, GP_id)
local hash = "gp_lang:"..GP_id
local lang = redis:get(hash) 
	if data[tostring(GP_id)] and data[tostring(GP_id)]['settings'] then
		settings = data[tostring(GP_id)]['settings']
	else
		return
	end
	if settings.lock_link then
		lock_link = settings.lock_link
	else
		lock_link = 'no'
	end
    if settings.lock_link_kick then
		lock_link_kick = settings.lock_link_kick
	else
		lock_link_kick = 'no'
	end
	if settings.lock_join then
		lock_join = settings.lock_join
	else
		lock_join = 'no'
	end
	if settings.lock_tag then
		lock_tag = settings.lock_tag
	else
		lock_tag = 'no'
	end
	if settings.lock_pin then
		lock_pin = settings.lock_pin
	else
		lock_pin = 'no'
	end
	if settings.lock_arabic then
		lock_arabic = settings.lock_arabic
	else
		lock_arabic = 'no'
	end
	if settings.lock_mention then
		lock_mention = settings.lock_mention
	else
		lock_mention = 'no'
	end
		if settings.lock_edit then
		lock_edit = settings.lock_edit
	else
		lock_edit = 'no'
	end
		if settings.lock_spam then
		lock_spam = settings.lock_spam
	else
		lock_spam = 'no'
	end
	if settings.flood then
		lock_flood = settings.flood
	else
		lock_flood = 'no'
	end
	if settings.lock_markdown then
		lock_markdown = settings.lock_markdown
	else
		lock_markdown = 'no'
	end
	if settings.lock_webpage then
		lock_webpage = settings.lock_webpage
	else
		lock_webpage = 'no'
	end
	if settings.lock_bots then
		lock_bots = settings.lock_bots
	else
		lock_bots = 'no'
	end
	if settings.welcome then
		group_welcone = settings.welcome
	else
		group_welcone = 'no'
	end
    if not lang then
 text = '⇝ Welcome To *Group Settings* ⚙️'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "⇝ Lock Edit", callback_data='RexCompany'}, 
			{text = lock_edit, callback_data="/lockedit:"..GP_id}
		},
		{
			{text = "⇝ Lock Link", callback_data='/locklinks:'..GP_id}, 
			{text = lock_link, callback_data="/locklink:"..GP_id}
		},
		{
			{text = "⇝ Lock Tags", callback_data='RexCompany'}, 
			{text = lock_tag, callback_data="/locktags:"..GP_id}
		},
		{
			{text = "⇝ Lock Join", callback_data='RexCompany'}, 
			{text = lock_join, callback_data="/lockjoin:"..GP_id}
		},
		{
			{text = "⇝ Lock Flood", callback_data='RexCompany'}, 
			{text = lock_flood, callback_data="/lockflood:"..GP_id}
		},
		{
			{text = "⇝ Lock Spam", callback_data='RexCompany'}, 
			{text = lock_spam, callback_data="/lockspam:"..GP_id}
		},
		{
			{text = "⇝ Lock Mention", callback_data='RexCompany'}, 
			{text = lock_mention, callback_data="/lockmention:"..GP_id}
		},
		{
			{text = "⇝ Lock Arabic", callback_data='RexCompany'}, 
			{text = lock_arabic, callback_data="/lockarabic:"..GP_id}
		},
		{
			{text = "⇝ Lock Webpage", callback_data='RexCompany'}, 
			{text = lock_webpage, callback_data="/lockwebpage:"..GP_id}
		},
		{
			{text = "⇝ Lock Markdown", callback_data='RexCompany'}, 
			{text = lock_markdown, callback_data="/lockmarkdown:"..GP_id}
		},
		{
			{text = "⇝ Lock Pin", callback_data='RexCompany'}, 
			{text = lock_pin, callback_data="/lockpin:"..GP_id}
		},
		{
			{text = "⇝ Lock Bots", callback_data='RexCompany'}, 
			{text = lock_bots, callback_data="/lockbots:"..GP_id}
		},
		{
			{text = "⇝ Group Welcome", callback_data='RexCompany'}, 
			{text = group_welcone, callback_data="/welcome:"..GP_id}
		},
		{
			{text = '⇝ More Settings ', callback_data = '/moresettings:'..GP_id}
		},
		{
			{text = '⇝ Back ', callback_data = '/option:'..GP_id}
		}				
	}
     elseif lang then
 text = '⇜ به تنظیمات گروه خوش آمدید ⚙️'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "⇜ قفل ویرایش", callback_data='RexCompany'}, 
			{text = lock_edit, callback_data="/lockedit:"..GP_id}
		},
		{
			{text = "⇜ قفل لینک", callback_data='RexCompany'}, 
			{text = lock_link, callback_data="/locklink:"..GP_id}
		},
		{
			{text = "⇜ قفل تگ", callback_data='RexCompany'}, 
			{text = lock_tag, callback_data="/locktags:"..GP_id}
		},
		{
			{text = "⇜ قفل ورود", callback_data='RexCompany'}, 
			{text = lock_join, callback_data="/lockjoin:"..GP_id}
		},
		{
			{text = "⇜ قفل پیام های مکرر", callback_data='RexCompany'}, 
			{text = lock_flood, callback_data="/lockflood:"..GP_id}
		},
		{
			{text = "⇜ قفل هرزنامه", callback_data='RexCompany'}, 
			{text = lock_spam, callback_data="/lockspam:"..GP_id}
		},
		{
			{text = "⇜ قفل فراخوانی", callback_data='RexCompany'}, 
			{text = lock_mention, callback_data="/lockmention:"..GP_id}
		},
		{
			{text = "⇜ قفل عربی", callback_data='RexCompany'}, 
			{text = lock_arabic, callback_data="/lockarabic:"..GP_id}
		},
		{
			{text = "⇜ قفل صفحات وب", callback_data='RexCompany'}, 
			{text = lock_webpage, callback_data="/lockwebpage:"..GP_id}
		},
		{
			{text = "⇜ قفل فونت", callback_data='RexCompany'}, 
			{text = lock_markdown, callback_data="/lockmarkdown:"..GP_id}
		},
		{
			{text = "⇜ قفل سنجاق کردن", callback_data='RexCompany'}, 
			{text = lock_pin, callback_data="/lockpin:"..GP_id}
		},
		{
			{text = "⇜ قفل ربات ها", callback_data='RexCompany'}, 
			{text = lock_bots, callback_data="/lockbots:"..GP_id}
		},
		{
			{text = "⇜ خوشآمد گویی", callback_data='RexCompany'}, 
			{text = group_welcone, callback_data="/welcome:"..GP_id}
		},
		{
			{text = '⇜ تنظیمات بیشتر ', callback_data = '/moresettings:'..GP_id}
		},
		{
			{text = '> بازگشت ', callback_data = '/option:'..GP_id}
		}				
	}
  end
    edit_inline(msg.message_id, text, keyboard)
end

function mutelists(msg, data, GP_id)
local hash = "gp_lang:"..GP_id
local lang = redis:get(hash) 
    if data[tostring(GP_id)] and data[tostring(GP_id)]['mutes'] then
		mutes = data[tostring(GP_id)]['mutes']
	else
		return
	end
	if mutes.mute_all then
		mute_all = mutes.mute_all
	else
		mute_all = 'no'
	end
	if mutes.mute_gif then
		mute_gif = mutes.mute_gif
	else
		mute_gif = 'no'
	end
   if mutes.mute_photo then
		mute_photo = mutes.mute_photo
	else
		mute_photo = 'no'
	end
	if mutes.mute_sticker then
		mute_sticker = mutes.mute_sticker
	else
		mute_sticker = 'no'
	end
	if mutes.mute_contact then
		mute_contact = mutes.mute_contact
	else
		mute_contact = 'no'
	end
	if mutes.mute_inline then
		mute_inline = mutes.mute_inline
	else
		mute_inline = 'no'
	end
	if mutes.mute_game then
		mute_game = mutes.mute_game
	else
		mute_game = 'no'
	end
	if mutes.mute_text then
		mute_text = mutes.mute_text
	else
		mute_text = 'no'
	end
	if mutes.mute_keyboard then
		mute_keyboard = mutes.mute_keyboard
	else
		mute_keyboard = 'no'
	end
	if mutes.mute_forward then
		mute_forward = mutes.mute_forward
	else
		mute_forward = 'no'
	end
	if mutes.mute_location then
		mute_location = mutes.mute_location
	else
		mute_location = 'no'
	end
   if mutes.mute_document then
		mute_document = mutes.mute_document
	else
		mute_document = 'no'
	end
	if mutes.mute_voice then
		mute_voice = mutes.mute_voice
	else
		mute_voice = 'no'
	end
	if mutes.mute_audio then
		mute_audio = mutes.mute_audio
	else
		mute_audio = 'no'
	end
	if mutes.mute_video then
		mute_video = mutes.mute_video
	else
		mute_video = 'no'
	end
	if mutes.mute_tgservice then
		mute_tgservice = mutes.mute_tgservice
	else
		mute_tgservice = 'no'
	end
   if not lang then
	 text = '⇝ Welcome To *Group Mutelist* 🔇'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "⇝ Mute All", callback_data='RexCompany'}, 
			{text = mute_all, callback_data="/muteall:"..GP_id}
		},
		{
			{text = "⇝ Mute Gifs", callback_data='RexCompany'}, 
			{text = mute_gif, callback_data="/mutegif:"..GP_id}
		},
		{
			{text = "⇝ Mute Text", callback_data='RexCompany'}, 
			{text = mute_text, callback_data="/mutetext:"..GP_id}
		},
		{
			{text = "⇝ Mute Inline", callback_data='RexCompany'}, 
			{text = mute_inline, callback_data="/muteinline:"..GP_id}
		},
		{
			{text = "⇝ Mute Game", callback_data='RexCompany'}, 
			{text = mute_game, callback_data="/mutegame:"..GP_id}
		},
		{
			{text = "⇝ Mute Photo", callback_data='RexCompany'}, 
			{text = mute_photo, callback_data="/mutephoto:"..GP_id}
		},
		{
			{text = "⇝ Mute Video", callback_data='RexCompany'}, 
			{text = mute_video, callback_data="/mutevideo:"..GP_id}
		},
		{
			{text = "⇝ Mute Audio", callback_data='RexCompany'}, 
			{text = mute_audio, callback_data="/muteaudio:"..GP_id}
		},
		{
			{text = "⇝ Mute Voice", callback_data='RexCompany'}, 
			{text = mute_voice, callback_data="/mutevoice:"..GP_id}
		},
		{
			{text = "⇝ Mute Sticker", callback_data='RexCompany'}, 
			{text = mute_sticker, callback_data="/mutesticker:"..GP_id}
		},
		{
			{text = "⇝ Mute Contact", callback_data='RexCompany'}, 
			{text = mute_contact, callback_data="/mutecontact:"..GP_id}
		},
		{
			{text = "⇝ Mute Forward", callback_data='RexCompany'}, 
			{text = mute_forward, callback_data="/muteforward:"..GP_id}
		},
		{
			{text = "⇝ Mute Location", callback_data='RexCompany'}, 
			{text = mute_location, callback_data="/mutelocation:"..GP_id}
		},
		{
			{text = "⇝ Mute Document", callback_data='RexCompany'}, 
			{text = mute_document, callback_data="/mutedocument:"..GP_id}
		},
		{
			{text = "⇝ Mute TgService", callback_data='RexCompany'}, 
			{text = mute_tgservice, callback_data="/mutetgservice:"..GP_id}
		},
		{
			{text = "⇝ Mute Keyboard", callback_data='RexCompany'}, 
			{text = mute_keyboard, callback_data="/mutekeyboard:"..GP_id}
		},
		{
			{text = '⇝ Back ', callback_data = '/option:'..GP_id}
		}				
	}
   elseif lang then
	 text = '⇜ به لیست بیصدای گروه خوش آمدید 🔇'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "⇜ بیصدا همه", callback_data='RexCompany'}, 
			{text = mute_all, callback_data="/muteall:"..GP_id}
		},
		{
			{text = "⇜ بیصدا تصاویر متحرک", callback_data='RexCompany'}, 
			{text = mute_gif, callback_data="/mutegif:"..GP_id}
		},
		{
			{text = "⇜ بیصدا متن", callback_data='RexCompany'}, 
			{text = mute_text, callback_data="/mutetext:"..GP_id}
		},
		{
			{text = "⇜ بیصدا اینلاین", callback_data='RexCompany'}, 
			{text = mute_inline, callback_data="/muteinline:"..GP_id}
		},
		{
			{text = "⇜ بیصدا بازی", callback_data='RexCompany'}, 
			{text = mute_game, callback_data="/mutegame:"..GP_id}
		},
		{
			{text = "⇜ بیصدا عکس", callback_data='RexCompany'}, 
			{text = mute_photo, callback_data="/mutephoto:"..GP_id}
		},
		{
			{text = "⇜ بیصدا فیلم", callback_data='RexCompany'}, 
			{text = mute_video, callback_data="/mutevideo:"..GP_id}
		},
		{
			{text = "⇜ بیصدا آهنگ", callback_data='RexCompany'}, 
			{text = mute_audio, callback_data="/muteaudio:"..GP_id}
		},
		{
			{text = "⇜ بیصدا صدا", callback_data='RexCompany'}, 
			{text = mute_voice, callback_data="/mutevoice:"..GP_id}
		},
		{
			{text = "⇜ بیصدا استیکر", callback_data='RexCompany'}, 
			{text = mute_sticker, callback_data="/mutesticker:"..GP_id}
		},
		{
			{text = "⇜ بیصدا مخاطب", callback_data='RexCompany'}, 
			{text = mute_contact, callback_data="/mutecontact:"..GP_id}
		},
		{
			{text = "⇜ بیصدا نقل و قول", callback_data='RexCompany'}, 
			{text = mutes.mute_forward, callback_data="/muteforward:"..GP_id}
		},
		{
			{text = "⇜ بیصدا موقعیت", callback_data='RexCompany'}, 
			{text = mute_location, callback_data="/mutelocation:"..GP_id}
		},
		{
			{text = "⇜ بیصدا فایل", callback_data='RexCompany'}, 
			{text = mute_document, callback_data="/mutedocument:"..GP_id}
		},
		{
			{text = "⇜ بیصدا خدمات تلگرام", callback_data='RexCompany'}, 
			{text = mute_tgservice, callback_data="/mutetgservice:"..GP_id}
		},
		{
			{text = "⇜ بیصدا کیبورد", callback_data='RexCompany'}, 
			{text = mute_keyboard, callback_data="/mutekeyboard:"..GP_id}
		},
		{
			{text = '⇜ بازگشت ', callback_data = '/option:'..GP_id}
		}				
	}
  end
    edit_inline(msg.message_id, text, keyboard)
end

local function run(msg, matches)
	local data = load_data(_config.moderation.data)
--------------Begin Msg Matches---------------
	if matches[1] == "sudolist" and is_sudo(msg) then
		return sudolist(msg)
	end
	if tonumber(msg.from.id) == sudo_id then
		if matches[1]:lower() == "setsudo" then
			if matches[2] and not msg.reply_to_message then
				local user_id = matches[2]
				if already_sudo(tonumber(user_id)) then
					return 'User '..user_id..' is already sudo users'
				else
					table.insert(_config.sudo_users, tonumber(user_id)) 
					print(user_id..' added to sudo users') 
					save_config() 
					reload_plugins(true) 
					return "User "..user_id.." added to sudo users" 
				end
		elseif not matches[2] and msg.reply_to_message then
			local user_id = msg.reply_to_message.from.id
			if already_sudo(tonumber(user_id)) then
				return 'User '..user_id..' is already sudo users'
			else
				table.insert(_config.sudo_users, tonumber(user_id)) 
				print(user_id..' added to sudo users') 
				save_config() 
				reload_plugins(true) 
				return "User "..user_id.." added to sudo users" 
			end
		end
	end
	if matches[1]:lower() == "remsudo" then
	if matches[2] and not msg.reply_to_message then
		local user_id = tonumber(matches[2]) 
		if not already_sudo(user_id) then
			return 'User '..user_id..' is not sudo users'
		else
			table.remove(_config.sudo_users, getindex( _config.sudo_users, k)) 
			print(user_id..' removed from sudo users') 
			save_config() 
			reload_plugins(true) 
			return "User "..user_id.." removed from sudo users"
		end
	elseif not matches[2] and msg.reply_to_message then
		local user_id = tonumber(msg.reply_to_message.from.id) 
		if not already_sudo(user_id) then
			return 'User '..user_id..' is not sudo users'
		else
			table.remove(_config.sudo_users, getindex( _config.sudo_users, k)) 
			print(user_id..' removed from sudo users') 
			save_config() 
			reload_plugins(true) 
			return "User "..user_id.." removed from sudo users"
		end
	end
	end
	end
--------------End Msg Matches---------------

--------------Begin Inline Query---------------
if msg.query and msg.query:match("-%d+") and is_sudo(msg) then
	local chatid = "-"..msg.query:match("%d+")
	keyboard = {}
	keyboard.inline_keyboard = {
		{
			{text = '❥ Go To Group Option ', callback_data = '/lang:'..chatid}
		},
		{
			{text= '⇝ Exit' ,callback_data = '/exit:'..chatid}
		}					
	}
	send_inline(msg.id,'settings','Group Option','Tap Here','Please select an option.!',keyboard)
end
if msg.query and msg.query:match("-%d++") and is_sudo(msg) then
	local chatid = "-"..msg.query:match("%d++")
	keyboard = {}
	keyboard.inline_keyboard = {
		{
			{text = '❥ Go To Group Help ', callback_data = '/lang:'..chatid}
		},
		{
			{text= '⇝ Exit' ,callback_data = '/exit:'..chatid}
		}					
	}
	send_inline(msg.id,'settings','Group Option','Tap Here','Please select an option.!',keyboard)
end
if msg.cb then
local hash = "gp_lang:"..matches[2]
local lang = redis:get(hash) 
	if matches[1] == '/lang' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
	local text = '⇝ Please Select An *Language* 🇺🇸'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "⚡️ English", callback_data="/english:"..matches[2]},
			{text = '⚡️ فارسی ', callback_data = '/persian:'..matches[2]}
		},
		{
			{text= ' Exit ⇜' ,callback_data = '/exit:'..matches[2]}
		}				
	}
    edit_inline(msg.message_id, text, keyboard)
	end
end
	if matches[1] == '/english' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
    redis:del(hash)
   sleep(1)
	options(msg, matches[2])
	end
end
	if matches[1] == '/persian' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
    redis:set(hash, true)
   sleep(1)
	options(msg, matches[2])
	end
end
	if matches[1] == '/option' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
	options(msg, matches[2])
	end
end
if matches[1] == '/settings' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/mutelist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/moresettings' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		moresetting(msg, data, matches[2])
	end
end

          -- ####################### Settings ####################### --
if matches[1] == '/locklinks' then
if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
    else
keyboard = {}
    keyboard.inline_keyboard = {
        {
            {text = "lock|unlock",callback_data = '/locklink:'..matches[2]},
            {text = "kick",callback_data = '/kicklink:'..matches[2]}
        },
        {
            {text = "Ban",callback_data = '/banlink:'..matches[2]},
            {text = "Warn",callback_data = '/warnlink:'..matches[2]}
        },  
        {
            {text = "Back",callback_data = '/option:'..matches[2]}
        }
 }
end
edit_inline(msg.message_id, '⏰ time ➲ '..os.date("%H : %M"), keyboard)
end

if matches[1] == '/kicklink' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local locklink = data[tostring(matches[2])]["settings"]["lock_link_kick"]
		if locklink == "no" then
   if not lang then
			text = '🔐 Link ➲ kicked'
   elseif lang then
			text = 'قفل لینک فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_link_kick"] = "yes"
			save_data(_config.moderation.data, data)
		elseif locklink == "yes" then
   if not lang then
			text = '🔐 Link ➲ Unkicked'
   elseif lang then
			text = 'قفل لینک غیر فعال شد 🔐'
    end
			data[tostring(matches[2])]["settings"]["lock_link_kick"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/locklink' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local locklink = data[tostring(matches[2])]["settings"]["lock_link"]
		if locklink == "no" then
   if not lang then
			text = '🔐 Link ➲ Locked'
   elseif lang then
			text = 'قفل لینک فعال شد'
    end
			data[tostring(matches[2])]["settings"]["lock_link"] = "yes"
			save_data(_config.moderation.data, data)
		elseif locklink == "yes" then
   if not lang then
			text = '🔐 Link ➲ Unlocked'
   elseif lang then
			text = 'قفل لینک غیر فعال شد 🔐'
    end
			data[tostring(matches[2])]["settings"]["lock_link"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockedit' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local lockedit = data[tostring(matches[2])]["settings"]["lock_edit"]
		if lockedit == "no" then
   if not lang then
			text = '🔐 Edit ➲ Locked'
   elseif lang then
			text = 'قفل ویرایش فعال شد 🔐'
    end
			data[tostring(matches[2])]["settings"]["lock_edit"] = "yes"
			save_data(_config.moderation.data, data)
		elseif lockedit == "yes" then
   if not lang then
			text = '🔐 Edit ➲ Unlocked'
   elseif lang then
			text = 'قفل ویرایش غیر فعال شد 🔐'
    end
			data[tostring(matches[2])]["settings"]["lock_edit"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/locktags' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_tag"]
		if chklock == "no" then
   if not lang then
			text = '🔐 Tags ➲ Locked'
   elseif lang then
			text = 'قفل تگ فعال شد 🔐'
    end
            data[tostring(matches[2])]["settings"]["lock_tag"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
   if not lang then
			text = '🔐 Tags ➲ Unlocked'
   elseif lang then
			text = 'قفل تگ غیر فعال شد 🔐'
    end
			data[tostring(matches[2])]["settings"]["lock_tag"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockjoin' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_join"]
		if chklock == "no" then
   if not lang then
			text = '🔐 Join ➲ Locked'
   elseif lang then
			text = 'قفل ورود فعال شد 🔐'
    end
            data[tostring(matches[2])]["settings"]["lock_join"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
   if not lang then
			text = '🔐 Join ➲ Unlocked'
   elseif lang then
			text = 'قفل ورود غیر فعال شد 🔐'
    end
			data[tostring(matches[2])]["settings"]["lock_join"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockflood' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["flood"]
		if chklock == "no" then
   if not lang then
			text = '🔐 Flood ➲ Locked'
   elseif lang then
			text = 'قفل پیام های مکرر فعال شد 🔐'
    end
            data[tostring(matches[2])]["settings"]["flood"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
   if not lang then
			text = '🔐 Flood ➲ Unlocked'
   elseif lang then
			text = 'قفل پیام های مکرر غیر فعال شد 🔐'
    end
			data[tostring(matches[2])]["settings"]["flood"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockspam' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_spam"]
		if chklock == "no" then
   if not lang then
			text = '🔐 Spam ➲ Locked'
   elseif lang then
			text = 'قفل هرزنامه فعال شد 🔐'
    end
            data[tostring(matches[2])]["settings"]["lock_spam"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
   if not lang then
			text = '🔐 Spam ➲ Unlocked'
   elseif lang then
			text = 'قفل هرزنامه غیر فعال شد 🔐'
    end
			data[tostring(matches[2])]["settings"]["lock_spam"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockmention' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_mention"]
		if chklock == "no" then
   if not lang then
			text = '🔐 Mention ➲ Locked'
   elseif lang then
			text = 'قفل فراخوانی فعال شد 🔐'
    end
            data[tostring(matches[2])]["settings"]["lock_mention"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
   if not lang then
			text = '🔐 Mention ➲ Unlocked'
   elseif lang then
			text = 'قفل فراخوانی غیر فعال شد 🔐'
    end
			data[tostring(matches[2])]["settings"]["lock_mention"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockarabic' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_arabic"]
		if chklock == "no" then
   if not lang then
			text = '🔐 Arabic ➲ Locked'
   elseif lang then
			text = 'قفل عربی فعال شد 🔐'
    end
            data[tostring(matches[2])]["settings"]["lock_arabic"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
   if not lang then
			text = '🔐 Arabic ➲ Unlocked'
   elseif lang then
			text = 'قفل عربی غیر فعال شد 🔐'
    end
			data[tostring(matches[2])]["settings"]["lock_arabic"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockwebpage' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_webpage"]
		if chklock == "no" then
   if not lang then
			text = '🔐 Webpage ➲ Locked'
   elseif lang then
			text = 'قفل صفحات وب فعال شد 🔐'
    end
            data[tostring(matches[2])]["settings"]["lock_webpage"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
   if not lang then
			text = '🔐 Webpage ➲ Unlocked'
   elseif lang then
			text = 'قفل صفحات وب غیر فعال شد 🔐'
    end
			data[tostring(matches[2])]["settings"]["lock_webpage"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockmarkdown' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_markdown"]
		if chklock == "no" then
   if not lang then
			text = '🔐 Markdown ➲ Locked'
   elseif lang then
			text = 'قفل فونت فعال شد 🔐'
    end
            data[tostring(matches[2])]["settings"]["lock_markdown"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
   if not lang then
			text = '🔐 Markdown ➲ Unlocked'
   elseif lang then
			text = 'قفل فونت غیر فعال شد 🔐'
    end
			data[tostring(matches[2])]["settings"]["lock_markdown"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockpin' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_pin"]
		if chklock == "no" then
   if not lang then
			text = '🔐 Pin ➲ Locked'
   elseif lang then
			text = 'قفل سنجاق کردن فعال شد 🔐'
    end
            data[tostring(matches[2])]["settings"]["lock_pin"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
   if not lang then
			text = '🔐 Pin ➲ Unlocked'
   elseif lang then
			text = 'قفل سنجاق کردن غیر فعال شد 🔐'
    end
			data[tostring(matches[2])]["settings"]["lock_pin"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockbots' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["lock_bots"]
		if chklock == "no" then
   if not lang then
			text = '🔐 Bots ➲ Locked'
   elseif lang then
			text = 'قفل ربات ها فعال شد 🔐'
    end
            data[tostring(matches[2])]["settings"]["lock_bots"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
   if not lang then
			text = '🔐 Bots ➲ Unlocked'
   elseif lang then
			text = 'قفل ربات ها غیر فعال شد 🔐'
    end
			data[tostring(matches[2])]["settings"]["lock_bots"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/welcome' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chklock = data[tostring(matches[2])]["settings"]["welcome"]
		if chklock == "no" then
   if not lang then
			text = '🔐 Welcome ➲ Enabled'
   elseif lang then
			text = 'خوش آمد گویی فعال شد 🔐'
    end
            data[tostring(matches[2])]["settings"]["welcome"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chklock == "yes" then
   if not lang then
			text = '🔐 Welcome ➲ Disabled'
   elseif lang then
			text = 'خوش آمد گویی غیر فعال شد 🔐'
    end
			data[tostring(matches[2])]["settings"]["welcome"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/floodup' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local flood_max = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['num_msg_max'] then
				flood_max = data[tostring(matches[2])]['settings']['num_msg_max']
			end
		end
		if tonumber(flood_max) < 30 then
			flood_max = tonumber(flood_max) + 1
			data[tostring(matches[2])]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
   if not lang then
			text = "🔐 Flood Sensitivity ➲ Set To : "..flood_max
   elseif lang then
			text = "حساسیت پیام های مکرر تنظیم شد به 🔐 : "..flood_max
    end
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/flooddown' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local flood_max = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['num_msg_max'] then
				flood_max = data[tostring(matches[2])]['settings']['num_msg_max']
			end
		end
		if tonumber(flood_max) > 2 then
			flood_max = tonumber(flood_max) - 1
			data[tostring(matches[2])]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
   if not lang then
			text = "🔐 Flood Sensitivity ➲ Set To : "..flood_max
   elseif lang then
			text = "حساسیت پیام های مکرر تنظیم شد به 🔐 : "..flood_max
    end
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/charup' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local char_max = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['set_char'] then
				char_max = data[tostring(matches[2])]['settings']['set_char']
			end
		end
		if tonumber(char_max) < 1000 then
			char_max = tonumber(char_max) + 1
			data[tostring(matches[2])]['settings']['set_char'] = char_max
			save_data(_config.moderation.data, data)
   if not lang then
			text = "🔐 Character Sensitivity ➲ Set To : "..char_max
   elseif lang then
			text = "تعداد حروف مجاز تنظیم شد به 🔐 : "..char_max
    end
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/chardown' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local char_max = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['set_char'] then
				char_max = data[tostring(matches[2])]['settings']['set_char']
			end
		end
		if tonumber(char_max) > 2 then
			char_max = tonumber(char_max) - 1
			data[tostring(matches[2])]['settings']['set_char'] = char_max
			save_data(_config.moderation.data, data)
   if not lang then
			text = "🔐 Character Sensitivity ➲ Set To : "..char_max
   elseif lang then
			text = "تعداد حروف مجاز تنظیم شد به 🔐 : "..char_max
    end
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/floodtimeup' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local check_time = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['time_check'] then
				check_time = data[tostring(matches[2])]['settings']['time_check']
			end
		end
		if tonumber(check_time) < 10 then
			check_time = tonumber(check_time) + 1
			data[tostring(matches[2])]['settings']['time_check'] = check_time
			save_data(_config.moderation.data, data)
   if not lang then
			text = "🔐 Flood Check Time ➲ Set To : "..check_time
   elseif lang then
			text = "زمان بررسی پیام های مکرر تنظیم شد به 🔐: "..check_time
    end
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/floodtimedown' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local check_time = 5
        if data[tostring(matches[2])] then
			if data[tostring(matches[2])]['settings']['time_check'] then
				check_time = data[tostring(matches[2])]['settings']['time_check']
			end
		end
		if tonumber(check_time) > 2 then
			check_time = tonumber(check_time) - 1
			data[tostring(matches[2])]['settings']['time_check'] = check_time
			save_data(_config.moderation.data, data)
   if not lang then
			text = "🔐 Flood Check Time ➲ Set To : "..check_time
   elseif lang then
			text = "زمان بررسی پیام های مکرر تنظیم شد به 🔐: "..check_time
    end
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end

			-- ###################### Mute ###################### --
			
if matches[1] == '/muteall' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_all"]
		if chkmute == "no" then
    if not lang then
			text = '🔊 All ➲ Muted'
    elseif lang then
        text = 'بیصدا کردن همه فعال شد 🔊'
    end
            data[tostring(matches[2])]["mutes"]["mute_all"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = '🔊 All ➲ Unmuted'
    elseif lang then
        text = 'بیصدا کردن همه غیر فعال شد 🔊'
    end
			data[tostring(matches[2])]["mutes"]["mute_all"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutegif' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_gif"]
		if chkmute == "no" then
    if not lang then
			text = '🔊 Gifs ➲ Muted'
    elseif lang then
        text = 'بیصدا کردن تصاویر متحرک فعال شد 🔊'
    end
            data[tostring(matches[2])]["mutes"]["mute_gif"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = '🔊 Gifs ➲ Unmuted'
    elseif lang then
        text = 'بیصدا کردن تصاویر متحرک غیر فعال شد 🔊'
    end
			data[tostring(matches[2])]["mutes"]["mute_gif"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutetext' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_text"]
		if chkmute == "no" then
    if not lang then
			text = '🔊 Text ➲ Muted'
    elseif lang then
        text = 'بیصدا کردن متن فعال شد 🔊'
    end
            data[tostring(matches[2])]["mutes"]["mute_text"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = '🔊 Text ➲ Unmuted'
    elseif lang then
        text = 'بیصدا کردن متن غیر فعال شد 🔊'
    end
			data[tostring(matches[2])]["mutes"]["mute_text"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/muteinline' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_inline"]
		if chkmute == "no" then
    if not lang then
			text = '🔊 Inline ➲ Muted'
    elseif lang then
        text = 'بیصدا کردن اینلاین فعال شد 🔊'
    end
            data[tostring(matches[2])]["mutes"]["mute_inline"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = '🔊 Inline ➲ Unmuted'
    elseif lang then
        text = 'بیصدا کردن اینلاین غیر فعال شد 🔊'
    end
			data[tostring(matches[2])]["mutes"]["mute_inline"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutegame' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_game"]
		if chkmute == "no" then
    if not lang then
			text = '🔊 Game ➲ Muted'
    elseif lang then
        text = 'بیصدا کردن بازی فعال شد 🔊'
    end
            data[tostring(matches[2])]["mutes"]["mute_game"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = '🔊 Game ➲ Unmuted'
    elseif lang then
        text = 'بیصدا کردن بازی غیر فعال شد 🔊'
    end
			data[tostring(matches[2])]["mutes"]["mute_game"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutephoto' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_photo"]
		if chkmute == "no" then
    if not lang then
			text = '🔊 Photo ➲ Muted'
    elseif lang then
        text = 'بیصدا کردن عکس فعال شد 🔊'
    end
            data[tostring(matches[2])]["mutes"]["mute_photo"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = '🔊 Photo ➲ Unmuted'
    elseif lang then
        text = 'بیصدا کردن عکس غیر فعال شد 🔊'
    end
			data[tostring(matches[2])]["mutes"]["mute_photo"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutevideo' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_video"]
		if chkmute == "no" then
    if not lang then
			text = '🔊 Video ➲ Muted'
    elseif lang then
        text = 'بیصدا کردن فیلم فعال شد 🔊'
    end
            data[tostring(matches[2])]["mutes"]["mute_video"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = '🔊 Video ➲ Unmuted'
    elseif lang then
        text = 'بیصدا کردن فیلم غیر فعال شد 🔊'
    end
			data[tostring(matches[2])]["mutes"]["mute_video"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/muteaudio' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_audio"]
		if chkmute == "no" then
    if not lang then
			text = '🔊 Audio ➲ Muted'
    elseif lang then
        text = 'بیصدا کردن آهنگ فعال شد 🔊'
    end
            data[tostring(matches[2])]["mutes"]["mute_audio"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = '🔊 Audio ➲ Unmuted'
    elseif lang then
        text = 'بیصدا کردن آهنگ غیر فعال شد 🔊'
    end
			data[tostring(matches[2])]["mutes"]["mute_audio"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutevoice' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_voice"]
		if chkmute == "no" then
    if not lang then
			text = '🔊 Voice ➲ Muted'
    elseif lang then
        text = 'بیصدا کردن صدا فعال شد 🔊'
    end
            data[tostring(matches[2])]["mutes"]["mute_voice"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = '🔊 Voice ➲ Unmuted'
    elseif lang then
        text = 'بیصدا کردن صدا غیر فعال شد 🔊'
    end
			data[tostring(matches[2])]["mutes"]["mute_voice"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutesticker' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_sticker"]
		if chkmute == "no" then
    if not lang then
			text = '🔊 Sticker ➲ Muted'
    elseif lang then
        text = 'بیصدا کردن استیکر فعال شد 🔊'
    end
            data[tostring(matches[2])]["mutes"]["mute_sticker"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = '🔊 Sticker ➲ Unmuted'
    elseif lang then
        text = 'بیصدا کردن استیکر غیر فعال شد 🔊'
    end
			data[tostring(matches[2])]["mutes"]["mute_sticker"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutecontact' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_contact"]
		if chkmute == "no" then
    if not lang then
			text = '🔊 Contact ➲ Muted'
    elseif lang then
        text = 'بیصدا کردن مخاطب فعال شد 🔊'
    end
            data[tostring(matches[2])]["mutes"]["mute_contact"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = '🔊 Contact ➲ Unmuted'
    elseif lang then
        text = 'بیصدا کردن مخاطب غیر فعال شد 🔊'
    end
			data[tostring(matches[2])]["mutes"]["mute_contact"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/muteforward' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_forward"]
		if chkmute == "no" then
    if not lang then
			text = '🔊 Forward ➲ Muted'
    elseif lang then
        text = 'بیصدا کردن نقل و قول فعال شد 🔊'
    end
            data[tostring(matches[2])]["mutes"]["mute_forward"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = '🔊 Forward ➲ Unmuted'
    elseif lang then
        text = 'بیصدا کردن نقل و قول غیر فعال شد 🔊'
    end
			data[tostring(matches[2])]["mutes"]["mute_forward"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutelocation' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_location"]
		if chkmute == "no" then
    if not lang then
			text = '🔊 Location ➲ Muted'
    elseif lang then
        text = 'بیصدا کردن موقعیت فعال شد 🔊'
    end
            data[tostring(matches[2])]["mutes"]["mute_location"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = '🔊 Location ➲ Unmuted'
    elseif lang then
        text = 'بیصدا کردن موقعیت غیر فعال شد 🔊'
    end
			data[tostring(matches[2])]["mutes"]["mute_location"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutedocument' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_document"]
		if chkmute == "no" then
    if not lang then
			text = '🔊 Document ➲ Muted'
    elseif lang then
        text = 'بیصدا کردن فایل فعال شد 🔊'
    end
            data[tostring(matches[2])]["mutes"]["mute_document"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = '🔊 Document ➲ Unmuted'
    elseif lang then
        text = 'بیصدا کردن فایل غیر فعال شد 🔊'
    end
			data[tostring(matches[2])]["mutes"]["mute_document"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutetgservice' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_tgservice"]
		if chkmute == "no" then
    if not lang then
			text = '🔊 TgService ➲ Muted'
    elseif lang then
        text = 'بیصدا کردن خدمات تلگرام فعال شد 🔊'
    end
            data[tostring(matches[2])]["mutes"]["mute_tgservice"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = '🔊 TgService ➲ Unmuted'
    elseif lang then
        text = 'بیصدا کردن خدمات تلگرام غیر فعال شد 🔊'
    end
			data[tostring(matches[2])]["mutes"]["mute_tgservice"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutekeyboard' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local chkmute = data[tostring(matches[2])]["mutes"]["mute_keyboard"]
		if chkmute == "no" then
    if not lang then
			text = '🔊 Keyboard ➲ Muted'
    elseif lang then
        text = 'بیصدا کردن کیبورد شیشه ای فعال شد 🔊'
    end
            data[tostring(matches[2])]["mutes"]["mute_keyboard"] = "yes"
			save_data(_config.moderation.data, data)
		elseif chkmute == "yes" then
    if not lang then
			text = '🔊 Keyboard ➲ unmuted'
    elseif lang then
        text = 'بیصدا کردن کیبورد شیشه ای غیر فعال شد 🔊'
    end
			data[tostring(matches[2])]["mutes"]["mute_keyboard"] = "no"
			save_data(_config.moderation.data, data)
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end

            -- ####################### More #######################--
			
if matches[1] == '/more' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
    if not lang then
		local text = '❥ Welcome To More Option'
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇝ OwnerList", callback_data="/ownerlist:"..matches[2]},
				{text = "⇝ ModList", callback_data="/modlist:"..matches[2]}
			},
			{
				{text = "⇝ SillentList", callback_data="/silentlist:"..matches[2]},
				{text = "⇝ FilterList", callback_data="/filterlist:"..matches[2]}
			},
			{
				{text = "⇝ BanList", callback_data="/bans:"..matches[2]},
				{text = "⇝ WhiteList", callback_data="/whitelists:"..matches[2]}
        },
			{
				{text = "⇝ Group Link", callback_data="/link:"..matches[2]},
				{text = "⇝ Group Rules", callback_data="/rules:"..matches[2]}
			},
			{
				{text = "⇝ Show Welcome", callback_data="/showwlc:"..matches[2]},
			},
			{ 
				{text = "Back To Option ⇜", callback_data="/option:"..matches[2]}
			}
		}
   elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ لیست مالکین", callback_data="/ownerlist:"..matches[2]},
				{text = "⇜ لیست مدیران", callback_data="/modlist:"..matches[2]}
			},
			{
				{text = "⇜ لیست سایلنت", callback_data="/silentlist:"..matches[2]},
				{text = "⇜ لیست فیلتر", callback_data="/filterlist:"..matches[2]}
			},
			{
				{text = "⇜ لیست بن", callback_data="/bans:"..matches[2]},
				{text = "⇜ لیست سفید", callback_data="/whitelists:"..matches[2]}
        },
			{
				{text = "⇜ لینک گروه", callback_data="/link:"..matches[2]},
				{text = "⇜ قوانین گروه", callback_data="/rules:"..matches[2]}
			},
			{
				{text = "⇜ نمایش پیام خوشامد", callback_data="/showwlc:"..matches[2]},
			},
			{ 
				{text = "⇜ بازگشت به تنظیمات کلی", callback_data="/option:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, 'text', keyboard)
	end
end

if matches[1] == '/ownerlist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local i = 1
		if next(data[tostring(matches[2])]['owners']) == nil then --fix way
     if not lang then
			text = "➲ No *owner* in this group!"
   elseif lang then
			text = "↫ هیچ مالکی برای گروه تعیین نشده"
   end
		else
     if not lang then
			text = "●•۰ *List Of Group Owners :*\n"
   elseif lang then
			text = "●•۰ لیست مالکین گروه :\n"
   end
			for k,v in pairs(data[tostring(matches[2])]['owners']) do
				text = text ..i.. '- '..v..' [' ..k.. '] \n'
				i = i + 1
			end
		end
     if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇝ Demote All Owners", callback_data="/cleanowners:"..matches[2]}
			},
			{ 
				{text = "Back ⇜", callback_data="/more:"..matches[2]}
			}
		}
   elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ برکناری تمام مالکین", callback_data="/cleanowners:"..matches[2]}
			},
			{ 
				{text = "⇜ بازگشت", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/cleanowners' then
	if not is_admin1(msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "⚠️ You Are Not Bot Admin")
   elseif lang then
		get_alert(msg.cb_id, "شما ادمین ربات نیستید")
   end
	else
		if next(data[tostring(matches[2])]['owners']) == nil then
     if not lang then
			text = "➲ No *owner* in this group!"
   elseif lang then
			text = "↫ هیچ مالکی برای گروه تعیین نشده"
   end
		else
     if not lang then
			text = " All *Group Owners* ➲ *Demoted* ツ"
   elseif lang then
			text = "ツ تمام مالکین از مقام خود برکنار شدند"
   end
			for k,v in pairs(data[tostring(matches[2])]['owners']) do
				data[tostring(matches[2])]['owners'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
    if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = " Back ⇜", callback_data="/ownerlist:"..matches[2]}
			}
		}
   elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ بازگشت", callback_data="/ownerlist:"..matches[2]}
			}
		}
   end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/filterlist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		if next(data[tostring(matches[2])]['filterlist']) == nil then --fix way
   if not lang then
			text = "➲ *Filter List* Is Empty"
     elseif lang then
			text = "↫ لیست کلمات فیلتر شده خالی است"
     end
		else 
			local i = 1
   if not lang then
			text = '●•۰ *List Of Filtered Words List :*\n'
     elseif lang then
			text = '●•۰ لیست کلمات فیلتر شده :\n'
    end
			for k,v in pairs(data[tostring(matches[2])]['filterlist']) do
				text = text..''..i..' - '..check_markdown(k)..'\n'
				i = i + 1
			end
		end
    if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇝ Clean", callback_data="/cleanfilterlist:"..matches[2]}
			},
			{ 
				{text = " Back ⇜", callback_data="/more:"..matches[2]}
			}
		}
   elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ پاک کردن", callback_data="/cleanfilterlist:"..matches[2]}
			},
			{ 
				{text = "⇜ بازگشت", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/cleanfilterlist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		if next(data[tostring(matches[2])]['filterlist']) == nil then
   if not lang then
			text = "➲ *Filter List* Is Empty"
     elseif lang then
			text = "↫ لیست کلمات فیلتر شده خالی است"
     end
		else
   if not lang then
			text = " *Filter List* ➲ *Cleaned* ツ"
     elseif lang then
			text = "ツ لیست کلمات فیلتر پاک شد"
     end
			for k,v in pairs(data[tostring(matches[2])]['filterlist']) do
				data[tostring(matches[2])]['filterlist'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
   if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = " Back ⇜", callback_data="/filterlist:"..matches[2]}
			}
		}
     elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ بازگشت", callback_data="/filterlist:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/modlist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local i = 1
		if next(data[tostring(matches[2])]['mods']) == nil then --fix way
     if not lang then
			text = "➲ No *moderator* in this group"
   elseif lang then
			text = "↫ هیچ مدیری برای گروه تعیین نشده"
   end
		else
     if not lang then
			text = "●•۰ *List Of Moderators :*\n"
   elseif lang then
			text = "●•۰ لیست مدیران گروه :\n"
   end
			for k,v in pairs(data[tostring(matches[2])]['mods']) do
				text = text ..i.. '- '..v..' [' ..k.. '] \n'
				i = i + 1
			end
		end
     if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇝ Demote All Moderators", callback_data="/cleanmods:"..matches[2]}
			},
			{ 
				{text = " Back ⇜", callback_data="/more:"..matches[2]}
			}
		}
   elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ برکناری تمام مدیران", callback_data="/cleanmods:"..matches[2]}
			},
			{ 
				{text = "⇜ بازگشت", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/cleanmods' then
	if not is_owner1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Group Owner")
   elseif lang then
		get_alert(msg.cb_id, "شما صاحب گروه نیستید")
   end
	else
		if next(data[tostring(matches[2])]['mods']) == nil then
     if not lang then
			text = "➲ No *moderator* in this group"
   elseif lang then
			text = "↫ هیچ مدیری برای گروه تعیین نشده"
   end
		else
     if not lang then
			text = " All *Moderators* ➲ *Demoted* ツ"
   elseif lang then
			text = "ツ تمام مدیران از مقام خود برکنار شدند"
   end
			for k,v in pairs(data[tostring(matches[2])]['mods']) do
				data[tostring(matches[2])]['mods'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = " Back ⇜", callback_data="/modlist:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/bans' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local i = 1
		if next(data[tostring(matches[2])]['banned']) == nil then --fix way
     if not lang then
			text = "➲ No *banned users* in this group"
   elseif lang then
			text = "↫ هیچ فردی از این گروه محروم نشده"
   end
		else
     if not lang then
			text = "●•۰ *List Of Banned Users :*\n"
   elseif lang then
			text = "●•۰ لیست افراد محروم شده از گروه :\n"
   end
			for k,v in pairs(data[tostring(matches[2])]['banned']) do
				text = text ..i.. '- '..v..' [' ..k.. '] \n'
				i = i + 1
			end
		end
   if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇝ Unban All Banned Users", callback_data="/cleanbans:"..matches[2]}
			},
			{ 
				{text = " Back ⇜", callback_data="/more:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ پاک کردن لیست بن ", callback_data="/cleanbans:"..matches[2]}
			},
			{ 
				{text = "⇜ بازگشت", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/silentlist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local i = 1
		if next(data[tostring(matches[2])]['is_silent_users']) == nil then --fix way
     if not lang then
			text = "➲ No *silent users* in this group"
   elseif lang then
			text = "↫ هیچ فردی در این گروه سایلنت نشده"
   end
		else
     if not lang then
			text = "●•۰ *List Of Silent Users :*\n"
   elseif lang then
			text = "●•۰ لیست افراد سایلنت شده :\n"
   end
			for k,v in pairs(data[tostring(matches[2])]['is_silent_users']) do
				text = text ..i.. '- '..v..' [' ..k.. '] \n'
				i = i + 1
			end
		end
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇝ Unsilent All Silent Users", callback_data="/cleansilentlist:"..matches[2]}
			},
			{ 
				{text = " Back ⇜", callback_data="/more:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ پاک کردن لیست سایلنت", callback_data="/cleansilentlist:"..matches[2]}
			},
			{ 
				{text = "⇜ بازگشت", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/cleansilentlist' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		if next(data[tostring(matches[2])]['is_silent_users']) == nil then
     if not lang then
			text = "➲ No *silent users* in this group"
   elseif lang then
			text = "↫ هیچ فردی در این گروه سایلنت نشده"
   end
		else
     if not lang then
			text = " All *Silent Users* ➲ *Unsilent* ツ"
   elseif lang then
			text = "ツ تمام افراد سایلنت شده از سایلنت خارج شدند"
   end
			for k,v in pairs(data[tostring(matches[2])]['is_silent_users']) do
				data[tostring(matches[2])]['is_silent_users'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = " Back ⇜", callback_data="/silentlist:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ بازگشت", callback_data="/silentlist:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/cleanbans' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		if next(data[tostring(matches[2])]['banned']) == nil then
     if not lang then
			text = "➲ No *banned users* in this group"
   elseif lang then
			text = "↫ هیچ فردی از این گروه محروم نشده"
   end
		else
     if not lang then
			text = "All *Banned Users* ➲ *Unbanned* ツ"
   elseif lang then
			text = "ツ تمام افراد محروم شده از محرومیت این گروه خارج شدند"
   end
			for k,v in pairs(data[tostring(matches[2])]['banned']) do
				data[tostring(matches[2])]['banned'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = " Back ⇜", callback_data="/bans:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ بازگشت", callback_data="/bans:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/link' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local linkgp = data[tostring(matches[2])]['settings']['linkgp']
		if not linkgp then
   if not lang then
			text = "➲ First set a *link* for group with using /setlink"
    elseif lang then
			text = "↫ ابتدا با دستور setlink/ لینک جدیدی برای گروه تعیین کنید"
  end
		else
   if not lang then
			text = "●•۰ [Group Link Is Here]("..linkgp..")\n"
    elseif lang then
			text = "●•۰ [لینک گروه اینجاست]("..linkgp..")\n"
        end
		end
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = " Back ⇜", callback_data="/more:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ بازگشت", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end

if matches[1] == '/rules' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local rules = data[tostring(matches[2])]['rules']
		if not rules then
   if not lang then
     text = "♡ The Default Rules :\n✦ No Flood.\n✦ No Spam.\n✦ No Advertising.\n✦ Try to stay on topic.\n✦ Forbidden any racist, sexual, homophobic or gore content.\n➡️ Repeated failure to comply with these rules will cause ban.\n"
    elseif lang then
       text = "♡ قوانین پپیشفرض:\n✦ ارسال پیام مکرر ممنوع.\n✦ اسپم ممنوع.\n✦ تبلیغ ممنوع.\n✦ سعی کنید از موضوع خارج نشید.\n✦ هرنوع نژاد پرستی, شاخ بازی و پورنوگرافی ممنوع .\n➡️ از قوانین پیروی کنید, در صورت عدم رعایت قوانین اول اخطار و در صورت تکرار مسدود.\n"
 end
		elseif rules then
     if not lang then
			text = '●•۰ *Group Rules :*\n'..rules
   elseif lang then
			text = '●•۰ قوانین گروه :\n'..rules
       end
		end
   if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇝ Clean", callback_data="/cleanrules:"..matches[2]}
			},
			{ 
				{text = " Back ⇜", callback_data="/more:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ پاک کردن", callback_data="/cleanrules:"..matches[2]}
			},
			{ 
				{text = "⇜ بازگشت", callback_data="/more:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/cleanrules' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local rules = data[tostring(matches[2])]['rules']
		if not rules then
    if not lang then
			text = "➲ `No Rules Available`"
   elseif lang then
			text = "↫ `قوانین گروه ثبت نشده`"
   end
		else
    if not lang then
			text = "*Group Rules* ➲ *Cleaned* ツ"
   elseif lang then
			text = "ツ *قوانین گروه پاک شد*"
  end
			data[tostring(matches[2])]['rules'] = nil
			save_data(_config.moderation.data, data)
		end
  if not lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = " Back ⇜", callback_data="/rules:"..matches[2]}
			}
		}
  elseif lang then
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ بازگشت", callback_data="/rules:"..matches[2]}
			}
		}
  end
		edit_inline(msg.message_id, text, keyboard)
	end
end
		if matches[1] == '/whitelists' then
			if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		if next(data[tostring(matches[2])]['whitelist']) == nil then
			if not lang then
				text = "➲ White List is Empty."
			else
				text = "↫ لیست سفید خالی می باشد"
			end
		else 
			local i = 1
			if not lang then
				text = '●•۰ White List: \n'
			else
				text = '●•۰ لیست سفید: \n'
			end
			for k,v in pairs(data[tostring(matches[2])]['whitelist']) do
				text = text..''..i..' - '..check_markdown(v)..' ' ..k.. ' \n'
				i = i + 1
			end
		end
		local keyboard = {}
		if not lang then
		keyboard.inline_keyboard = {
			{
				{text = "⇝ Clean White List", callback_data="/cleanwhitelists:"..matches[2]}
			},
			{ 
				{text = " Back ⇜", callback_data="/more:"..matches[2]}
			}
		}
		else
		keyboard.inline_keyboard = {
			{
				{text = "⇜ حذف لیست سفید", callback_data="/cleanwhitelists:"..matches[2]}
			},
			{ 
				{text = "⇜ بازگشت", callback_data="/more:"..matches[2]}
			}
		}
		end
		edit_inline(msg.message_id, text, keyboard)
end
end

if matches[1] == '/cleanwhitelists' then
			if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		if next(data[tostring(matches[2])]['whitelist']) == nil then
			if not lang then
				text = "➲ White List is Empty."
			else
				text = "↫ لیست سفید خالی می باشد."
			end
		else
			if not lang then
				text = "White List Was Cleared. ツ"
			else
				text = "ツ لیست سفید حذف شد."
			end
			for k,v in pairs(data[tostring(matches[2])]['whitelist']) do
				data[tostring(matches[2])]['whitelist'][tostring(k)] = nil
				save_data(_config.moderation.data, data)
			end
		end
		local keyboard = {} 
		if not lang then
		keyboard.inline_keyboard = {

			{ 
				{text = " Back ⇜", callback_data="/more:"..matches[2]}
			}
		}
		else
				keyboard.inline_keyboard = {

			{ 
				{text = "⇜ بازگشت", callback_data="/more:"..matches[2]}
			}
		}
		end
		edit_inline(msg.message_id, text, keyboard)
		end
end
if matches[1] == '/showwlc' then
local text = ''
if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
		local wlc = data[tostring(matches[2])]['setwelcome']
		if not wlc then
		if not lang then
				text = "➲ Welcome Message Not Set.\n*Default Message :* Welcome Dude"
			else
				text = "↫ پیام خوشامد تنظیم نشده است."
			end
		else
		if not lang then
			text = '●•۰ Welcome Message:\n'..wlc
		else
			text = '●•۰ پیام خوشامد:\n'..wlc
		end
		end
		local keyboard = {} 
		if not lang then
		keyboard.inline_keyboard = {
			{ 
				{text = "⇝ Clean Welcome Message", callback_data="/cleanwlcmsg:"..matches[2]}
			},
			{ 
				{text = " Back ⇜", callback_data="/more:"..matches[2]}
			}
		}
		else
		keyboard.inline_keyboard = {
			{ 
				{text = "⇜ حذف پیام خوشامد", callback_data="/cleanwlcmsg:"..matches[2]}
			},
			{ 
				{text = "⇜ بازگشت", callback_data="/more:"..matches[2]}
			}
		}
		end
		edit_inline(msg.message_id, text, keyboard)
end
end
if matches[1] == '/cleanwlcmsg' then
local text = ''
if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
local wlc = data[tostring(matches[2])]['setwelcome']
		if not wlc then
		if not lang then
				text = "➲ Welcome Message Not Set."
			else
				text = "↫ پیام خوشامد تنظیم نشده است."
			end
		else
		if not lang then
			text = '➲ Welcome Message Was Cleaned.'
		else
			text = '↫ پیام خوشامد حذف شد.'
		end
		data[tostring(matches[2])]['setwelcome'] = nil
		save_data(_config.moderation.data, data)
end
local keyboard = {} 
		if not lang then
		keyboard.inline_keyboard = {

			{ 
				{text = " Back ⇜", callback_data="/more:"..matches[2]}
			}
		}
		else
				keyboard.inline_keyboard = {

			{ 
				{text = "⇜ بازگشت", callback_data="/more:"..matches[2]}
			}
		}
		end
		edit_inline(msg.message_id, text, keyboard)
end
end
         -- ####################### About Us ####################### --
if matches[1] == '/rex' then
    if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
    else
	local text = _config.info_text
    if not lang then
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "⇝ Mr Rex", url = 'https://telegram.me/Rex_Developer'}, 
			{text = "⇝ Sudo Hack", url = 'https://telegram.me/sudo_hack'}
		},
		{
			{text = '⇝ Our GitHub ', url = 'https://www.github.com/Rex-Company'}
		},
		{
			{text= 'Back ⇜' ,callback_data = '/option:'..matches[2]}
		}				
	}
   elseif lang then
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = "⇜ مستر رکس", url = 'https://telegram.me/Rex_Developer'}, 
			{text = "⇜ سودو هک", url = 'https://telegram.me/sudo_hack'}
		},
		{
			{text = '⇜ گیت هاب تیم ', url = 'https://www.github.com/Rex-Company'}
		},
		{
			{text= '⇜ بازگشت' ,callback_data = '/option:'..matches[2]}
		}				
	}
   end
    edit_inline(msg.message_id, text, keyboard)
end
end
if matches[1] == '/exit' then
	if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
	else
    if not lang then
		 text = '●•۰ *Group Panel Closed* ツ'
   elseif lang then
		 text = 'ツ پنل گروه بسته شده'
   end
		edit_inline(msg.message_id, text)
	end
end
if matches[1] == '/sup' then
    if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
    else
    if not lang then
	keyboard = {} 
	keyboard.inline_keyboard = {
		{ 
			{text = "⇝ Rex Support", url = 'https://telegram.me/rex_Support'},
			{text = '⇝ Group Support ', url = 'https://t.me/joinchat/G-qHLEkr5GWJJKMtrIxulg'}
		},
        {
            {text = '💥 Hell Bot For Speed Test Bots 💥', url = 'https://t.me/joinchat/G-qHLBBX6zopZQYwVM5_oQ'}
        },
		{
			{text= ' Back ⇜' ,callback_data = '/option:'..matches[2]}
		}				
	}
   elseif lang then
	keyboard = {} 
	keyboard.inline_keyboard = {
		{ 
			{text = "⇜ پشتیبان رکس", url = 'https://telegram.me/rex_Support'},
			{text = '⇜ گروه پشتیبانی ', url = 'https://t.me/joinchat/G-qHLEkr5GWJJKMtrIxulg'}
		},
		{
            {text = '💥 هل بوت برای تست سرعت ربات 💥', url = 'https://t.me/joinchat/G-qHLBBX6zopZQYwVM5_oQ'}
        },
		{
			{text= '⇜ بازگشت' ,callback_data = '/option:'..matches[2]}
		}				
	}
   end
    edit_inline(msg.message_id, '⇝ Welcome To Support Bot 📞', keyboard)
end
end
if matches[1] == '/help' then
    if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
    else
    local text = _config.info_text
    if not lang then
    text = '⇝ Welcome To *Group Help* ❕'
    keyboard = {}
    keyboard.inline_keyboard = {
        {
            {text = "⇝ Sudo Help 🤖",callback_data = '/sudohelp:'..matches[2]}
        },
        {
            {text = "⇝ Mod Help ❗️",callback_data = '/modhelp:'..matches[2]}
        },
        {
            {text = "⇝ Lock Help 🔐",callback_data = '/lockhelp:'..matches[2]}
        },
        {
            {text = "⇝ Mute Help 🔇",callback_data = '/mutehelp:'..matches[2]}
        },
        {
            {text = "⇝ Fun Help 🎁",callback_data = '/funhelp:'..matches[2]}
        },
        {
            {text = " Back ⇜",callback_data = '/option:'..matches[2]}
        }
 }
elseif lang then
	text = '‼️ به راهنمای گروه خوش آمدید '
    keyboard = {}
    keyboard.inline_keyboard = {
        {
            {text = "⇜ راهنمای سودو 🤖",callback_data = '/sudohelpfa:'..matches[2]}
        },
        {
            {text = "⇜ راهنمای مدیر ❗️",callback_data = '/modhelpfa:'..matches[2]}
        },
        {
            {text = "⇜ راهنمای قفل 🔐",callback_data = '/lockhelpfa:'..matches[2]}
        },
        {
            {text = "⇜ راهنمای بیصدا 🔇",callback_data = '/mutehelpfa:'..matches[2]}
        },
        {
            {text = "⇜ راهنمای سرگرمی 🎁",callback_data = '/funhelpfa:'..matches[2]}
        },
        {
            {text = "⇜ برگشت",callback_data = '/option:'..matches[2]}
        }
 }
   end
    edit_inline(msg.message_id, text, keyboard)
end
end
if matches[1] == '/sudohelp' then
    if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
    else
    if not lang then
    keyboard = {}
    keyboard.inline_keyboard = {
        {
            {text = " Back ⇜",callback_data = '/help:'..matches[2]}
        },
 }
end
edit_inline(msg.message_id, '✧ *Sudoer And Admins Rex TdBot Help* :\n\n➲ visudo `[username|id|reply]`\n⇋ Add Sudo\n\n➲ desudo `[username|id|reply]`\n⇋ Demote Sudo\n\n➲ sudolist\n⇋ Sudo(s) list\n\n➲ adminprom `[username|id|reply]`\n⇋ Add admin for bot\n\n➲ admindem `[username|id|reply]`\n⇋ Demote bot admin\n\n➲ setowner `[username|id|reply]`\n⇋ Set Group Owner(Multi Owner)\n\n➲ remowner `[username|id|reply]`\n⇋ Remove User From Owner List\n\n➲ adminlist \n\n➲ leave \n⇋ Leave current group\n\n➲ autoleave `[disable/enable]`\n⇋ Automatically leaves group\n\n➲ creategroup `[text]`\n⇋ Create normal group\n\n➲ createsuper `[text]`\n⇋ Create supergroup\n\n➲ tosuper \n⇋ Convert to supergroup\n\n➲ chats\n⇋ List of added groups\n\n➲ join `[id]`\n⇋ Adds you to the group\n\n➲ rem `[id]`\n⇋ Remove a group from Database\n\n➲ import `[link]`\n⇋ Bot joins via link\n\n➲ setbotname `[text]`\n⇋ Change bot,s name\n\n➲ setbotusername `[text]`\n⇋ Change bot,s username\n\n➲ delbotusername\n⇋ Delete bot,s username\n\n➲ markread `[off/on]`\n⇋ Second mark\n\n➲ broadcast `[text]`\n⇋ Send message to all added groups\n\n➲ bc `[text]` `[GroupID]`\n⇋ Send message to a specific group\n\n➲ sendfile `[folder]` `[file]`\n⇋ Send file from folder\n\n➲ sendplug `[plug]`\n⇋ Send plugin\n\n➲ save `[plugin name]` `[reply]`\n⇋ Save plugin by reply\n\n➲ savefile `[address/filename]` `[reply]`\n⇋ Save File by reply to specific folder\n\n➲ config\n⇋ Set Owner and Admin Group\n\n➲ clear cache\n⇋ Clear All Cache Of .telegram-bot/data\n\n➲ check\n⇋ Stated Expiration Date\n\n➲ check `[GroupID]`\n⇋ Stated Expiration Date Of Specific Group\n\n➲ charge `[GroupID]` `[Number Of Days]`\n⇋ Set Expire Time For Specific Group\n\n➲ charge `[Number Of Days]`\n⇋ Set Expire Time For Group\n\n➲ jointo `[GroupID]`\n⇋ Invite You To Specific Group\n\n➲ leave `[GroupID]`\n⇋ Leave Bot From Specific Group\n\n✎ This help is only for sudoers/bot admins.\n\n✎ This means only the sudoers and its bot admins can use mentioned commands.\n\n❥ Good luck ツ\n\n', keyboard)
end
end
if matches[1] == '/sudohelpfa' then
if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
    else
if lang then
keyboard = {}
    keyboard.inline_keyboard = {
        {
            {text = "⇜ برگشت", callback_data = '/help:'..matches[2]}
        },
 }
end
edit_inline(msg.message_id, '✧ *راهنمای ادمین و سودو های ربات رکس:*\n\n↜ سودو `[username|id|reply]`\n↭ اضافه کردن سودو\n\n↜ حذف سودو `[username|id|reply]`\n↭ حذف کردن سودو\n\n↜ لیست سودو \n↭ لیست سودو‌های ربات\n\n↜ ادمین `[username|id|reply]`\n↭ اضافه کردن ادمین به ربات\n\n↜ حذف ادمین `[username|id|reply]`\n↭ حذف فرد از ادمینی ربات\n\n↜ مالک `[username|id|reply]`\n↭ انتخاب مالک گروه(قابل انتخاب چند مالک)\n\n↜ حذف مالک `[username|id|reply]`\n↭ حذف کردن فرد از فهرست مالکان گروه\n\n↜ لیست ادمین \n↭ لیست ادمین ها\n\n↜ لیو \n↭ خارج شدن ربات از گروه\n\n↜ خروج خودکار `[غیرفعال/فعال | موقعیت]`\n↭ خروج خودکار\n\n↜ ساخت گروه `[اسم انتخابی]`\n↭ ساخت گروه ریلم\n\n↜ ساخت سوپرگروه `[اسم انتخابی]`\n↭ ساخت سوپر گروه\n\n↜ تبدیل به سوپرگروه\n↭ تبدیل به سوپر گروه\n\n↜ لیست گروه ها\n↭ لیست گروه های مدیریتی ربات\n\n↜ افزودن `[ایدی گروه]`\n↭ جوین شدن توسط ربات\n\n↜ حذف گروه `[ایدی گروه]`\n↭ حذف گروه ازطریق پنل مدیریتی\n\n↜ ورود لینک `[لینک]`\n↭ جوین شدن ربات توسط لینک\n\n↜ تغییر نام ربات `[text]`\n↭ تغییر اسم ربات\n\n↜ تغییر یوزرنیم ربات `[text]`\n↭ تغییر یوزرنیم ربات\n\n↜ حذف یوزرنیم ربات \n↭ پاک کردن یوزرنیم ربات\n\n↜ تیک دوم `[فعال/غیرفعال]`\n↭ تیک دوم\n\n↜ ارسال به همه `[متن]`\n↭ فرستادن پیام به تمام گروه های مدیریتی ربات\n\n↜ ارسال `[متن]` `[ایدی گروه]`\n↭ ارسال پیام مورد نظر به گروه خاص\n\n↜ ارسال فایل `[cd]` `[file]`\n↭ ارسال فایل موردنظر از پوشه خاص\n\n↜ ارسال پلاگین `[اسم پلاگین]`\n↭ ارسال پلاگ مورد نظر\n\n↜  ذخیره پلاگین `[اسم پلاگین]` `[reply]`\n↭ ذخیره کردن پلاگین\n\n↜ ذخیره فایل `[address/filename]` `[reply]`\n↭ ذخیره کردن فایل در پوشه مورد نظر\n\n↜ پیکربندی\n↭ اضافه کردن سازنده و مدیران گروه به مدیریت ربات\n\n↜ پاک کردن حافظه\n↭ پاک کردن کش مسیر .telegram-bot/data\n\n↜ اعتبار\n↭ اعلام تاریخ انقضای گروه\n\n↜ اعتبار `[ایدی گروه]`\n↭ اعلام تاریخ انقضای گروه مورد نظر\n\n↜ شارژ `[ایدی گروه]` `[تعداد روز]`\n↭ تنظیم تاریخ انقضای گروه مورد نظر\n\n↜ شارژ `[تعداد روز]`\n↭ تنظیم تاریخ انقضای گروه\n\n↜ ورود به `[ایدی گروه]`\n↭ دعوت شدن شما توسط ربات به گروه مورد نظر\n\n↜ لیو `[ایدی گروه]`\n↭ خارج شدن ربات از گروه مورد نظر\n\n*✐ این راهنما فقط برای سودو ها/ادمین های ربات میباشد!*\n\n`✐ این به این معناست که فقط سودو ها/ادمین های ربات میتوانند از دستورات بالا استفاده کنند!`\n\n↫ موفق باشید ;)\n\n', keyboard)
end
end
if matches[1] == '/modhelp' then
if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
    else
    if not lang then
keyboard = {}
    keyboard.inline_keyboard = {
        {
            {text = " Back ⇜", callback_data = '/help:'..matches[2]}
        },
 }
end
edit_inline(msg.message_id, '✧ *Rex v1 Moderators Help:*\n\n➲ setowner `[username|id|reply]`\n⇋ Set Group Owner(Multi Owner)\n\n➲ remowner `[username|id|reply]`\n⇋ Remove User From Owner List\n\n➲ promote `[username|id|reply]`\n⇋ Promote User To Group Admin\n\n➲ demote `[username|id|reply]`\n⇋ Demote User From Group Admins List\n\n➲ setflood `[1-50]`\n⇋ Set Flooding Number\n\n➲ setchar `[Number]`\n⇋ Set Flooding Characters\n\n➲ setfloodtime `[1-10]`\n⇋ Set Flooding Time\n\n➲ silent `[username|id|reply]`\n⇋ Silent User From Group\n\n➲ unsilent `[username|id|reply]`\n⇋ Unsilent User From Group\n\n➲ kick `[username|id|reply]`\n⇋ Kick User From Group\n\n➲ ban `[username|id|reply]`\n⇋ Ban User From Group\n\n➲ unban `[username|id|reply]`\n⇋ UnBan User From Group\n\n➲ whitelist `[+-]` `[username|id|reply]`\n⇋ Add Or Remove User From White List\n\n➲ res `[username]`\n⇋ Show User ID\n\n➲ id `[reply]`\n⇋ Show User ID\n\n➲ whois `[id]`\n⇋ Show User,s Username And Name\n\n➲ set `[rules | name | link | about | welcome]`\n⇋ Bot Set Them\n\n➲ clean `[bans | mods | bots | rules | about | silentlist | filtelist | welcome]`\n⇋ Bot Clean Them\n\n➲ filter `[word]`\n⇋ Word filter\n\n➲ unfilter `[word]`\n⇋ Word unfilter\n\n➲ pin `[reply]`\n⇋ Pin Your Message\n\n➲ unpin \n⇋ Unpin Pinned Message\n\n➲ welcome enable/disable\n⇋ Enable Or Disable Group Welcome\n\n➲ settings\n⇋ Show Group Settings\n\n➲ mutelist\n⇋ Show Mutes List\n\n➲ silentlist\n⇋ Show Silented Users List\n\n➲ filterlist\n⇋ Show Filtered Words List\n\n➲ banlist\n⇋ Show Banned Users List\n\n➲ ownerlist\n⇋ Show Group Owners List \n\n➲ modlist \n⇋ Show Group Moderators List\n\n➲ whitelist \n⇋ Show Group White List Users\n\n➲ rules\n⇋ Show Group Rules\n\n➲ about\n⇋ Show Group Description\n\n➲ id\n⇋ Show Your And Chat ID\n\n➲ gpinfo\n⇋ Show Group Information\n\n➲ newlink\n⇋ Create A New Link\n\n➲ link\n⇋ Show Group Link\n\n➲ linkpv\n⇋ Send Group Link In Your Private Message\n\n➲ setwelcome `[text]`\n⇋ set Welcome Message\n\n➲ setlang `[fa | en]`\n⇋ Set Persian/English Language\n\n➲ setcmd `[fa | en]`\n⇋ Set CMD Persian/English Language\n\n*✎ This Help List Only For Moderators/Owners!*\n\n`✎ Its Means, Only Group Moderators/Owners Can Use It!`\n\n❥ Good luck ツ\n\n', keyboard)
end
end
end
if matches[1] == '/modhelpfa' then
if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   elseif lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   end
    else
if not lang then
keyboard = {}
    keyboard.inline_keyboard = {
        {
            {text = "⇜ برگشت", callback_data = '/help:'..matches[2]}
        },
 }
end
edit_inline(msg.message_id, '✧ راهنمای مدیریتی ورژن یک رکس\n\n↜ مالک `[یوزرنیم|ایدی|ریپلی]` \n↭ انتخاب مالک گروه(قابل انتخاب چند مالک)\n\n↜ حذف مالک `[یوزرنیم|ایدی|ریپلی]` \n↭ حذف کردن فرد از فهرست مالکان گروه\n\n↜ مدیر `[یوزرنیم|ایدی|ریپلی]` \n↭ ارتقا مقام کاربر به مدیر گروه\n\n↜ حذف مدیر `[یوزرنیم|ایدی|ریپلی]` \n↭ تنزیل مقام مدیر به کاربر\n\n↜ تنظیم پیام مکرر `[2-50]`\n↭ تنظیم حداکثر تعداد پیام مکرر\n\n↜ حداکثر حروف مجاز `[عدد]`\n↭ تنظیم حداکثر کاراکتر پیام مکرر\n\n↜ تنظیم زمان بررسی `[1-10]`\n↭ تنظیم زمان ارسال پیام مکرر\n\n↜ سایلنت `[یوزرنیم|ایدی|ریپلی]` \n↭ بیصدا کردن کاربر در گروه\n\n↜ ان سایلنت `[یوزرنیم|ایدی|ریپلی]` \n↭ در آوردن کاربر از حالت بیصدا در گروه\n\n↜ اخراج `[یوزرنیم|ایدی|ریپلی]` \n↭ حذف کاربر از گروه\n\n↜ بن `[یوزرنیم|ایدی|ریپلی]` \n↭ مسدود کردن کاربر از گروه\n\n↜ ان بن `[یوزرنیم|ایدی|ریپلی]`\n↭ در آوردن از حالت مسدودیت کاربر از گروه\n\n↜ کاربری `[یوزرنیم]`\n↭ نمایش شناسه کاربر\n\n↜ ایدی `[ریپلی]`\n↭ نمایش شناسه کاربر\n\n↜ شناسه `[ایدی]`\n↭ نمایش نام کاربر, نام کاربری و اطلاعات حساب\n\n↜ تنظیم `[قوانین | نام | لینک | درباره | خوشامد]`\n↭ ربات آنهارا ثبت خواهد کرد\n\n↜ پاک کردن `[بن | مدیران | ربات | قوانین | درباره | لیست سایلنت | خوشامد]`\n↭ ربات آنهارا پاک خواهد کرد\n\n↜ لیست سفید `[+|-]` `[یوزرنیم|ایدی|ریپلی]` \n↭ افزودن افراد به لیست سفید\n\n↜ فیلتر `[کلمه]`\n↭ فیلتر‌کلمه مورد نظر\n\n↜ حذف فیلتر `[کلمه]`\n↭ ازاد کردن کلمه مورد نظر\n\n↜ پین `[ریپلای]`\n↭ ربات پیام شمارا در گروه پین خواهد کرد\n\n↜ ان پین\n↭ ربات پیام پین شده در گروه را حذف خواهد کرد\n\n↜ خوشامد فعال/غیرفعال\n↭ فعال یا غیرفعال کردن خوشامد گویی\n\n↜ تنظیمات\n↭ نمایش تنظیمات گروه\n\n↜ لیست بیصدا\n↭ نمایش فهرست بیصدا های گروه\n\n↜ لیست سایلنت\n↭ نمایش فهرست افراد بیصدا\n\n↜ لیست فیلتر\n↭ نمایش لیست کلمات فیلتر شده\n\n↜ لیست سفید\n↭ نمایش افراد سفید شده از گروه\n\n↜ لیست بن\n↭ نمایش افراد مسدود شده از گروه\n\n↜ لیست مالکان\n↭ نمایش فهرست مالکان گروه\n\n↜ لیست مدیران\n↭ نمایش فهرست مدیران گروه\n\n↜ قوانین\n↭ نمایش قوانین گروه\n\n↜ درباره\n↭ نمایش درباره گروه\n\n↜ ایدی\n↭ نمایش شناسه شما و گروه\n\n↜ اطلاعات گروه\n↭ نمایش اطلاعات گروه\n\n↜ لینک جدید\n↭ ساخت لینک جدید\n\n↜ لینک\n↭ نمایش لینک گروه\n\n↜ تنظیم لینک\n↭ تنظیم لینک جدید برای گروه\n\n↜ لینک پیوی\n↭ ارسال لینک گروه به پیوی شما\n\n↜ زبان انگلیسی\n↭ تنظیم زبان انگلیسی\n\n↜ زبان فارسی\n↭ تنظیم زبان فارسی\n\n↜ دستورات انگلیسی\n↭ تنظیم دستورات انگلیسی\n\n↜ دستورات فارسی\n↭ تنظیم دستورات فارسی\n\n↜ تنظیم خوشامد `[متن]`\n↭ ثبت پیام خوش آمد گویی\n\n*✐ این راهنما فقط برای مدیران/مالکان گروه میباشد!*\n\n`✐ این به این معناست که فقط مدیران/مالکان گروه میتوانند از دستورات بالا استفاده کنند!`\n\n↫ موفق باشید ;)\n\n', keyboard)
end
end
if matches[1] == '/lockhelp' then
if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
    else
    if not lang then
keyboard = {}
    keyboard.inline_keyboard = {
        {
            {text = " Back ⇜", callback_data = '/help:'..matches[2]}
        },
 }
end
edit_inline(msg.message_id, '*✧ Rex Lock Help Commands:*🔐\n\n❥ To Lock 🔒\n\n➲ Lock link\n\n➲ Lock join\n\n➲ Lock tag\n\n➲ Lock edit\n\n➲ Lock arabic\n\n➲ Lock webpage\n\n➲ Lock bots\n\n➲ Lock spam\n\n➲ Lock flood\n\n➲ Lock markdown\n\n➲ Lock mention\n\n➲ Lock pin\n\n⚠️ If This Actions Lock, Bot Check Actions And Delete Them\n\n❥ To Unlock 🔓\n\n➲ unlock link\n\n➲ unlock join\n\n➲ unlock tag\n\n➲ unlock edit\n\n➲ unlock arabic\n\n➲ unlock webpage\n\n➲ unlock bots\n\n➲ unlock spam\n\n➲ unlock flood\n\n➲ unlock markdown\n\n➲ unlock mention\n\n➲ unlock pin\n\n⚠️ If This Actions Unlock, Bot Not Delete Them\n\n*✎ This Help List Only For Moderators/Owners!*\n\n`✎ Its Means, Only Group Moderators/Owners Can Use It!`\n\n\n❥ Good luck ツ\n\n', keyboard)
end
end
if matches[1] == '/lockhelpfa' then
if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   elseif lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   end
    else
    if not lang then
keyboard = {}
    keyboard.inline_keyboard = {
        {
            {text = "⇜ برگشت", callback_data = '/help:'..matches[2]}
        },
 }
end
edit_inline(msg.message_id, '*✧ Rex Lock Help Commands:*🔐\n\n⇜ برای قفل کردن 🔒\n\n↜ قفل لینک\n\n↜ قفل ورود\n\n↜ قفل تگ\n\n↜ قفل ویرایش\n\n↜ قفل عربی\n\n↜ قفل وب\n\n↜ قفل ربات\n\n↜ قفل هرزنامه\n\n↜ قفل پیام مکرر\n\n↜ قفل فونت\n\n↜ قفل فراخوانی\n\n↜ قفل پین\n\n⚠️ در صورت قفل بودن فعالیت ها, ربات آنها را حذف خواهد کرد\n\n⇜ برای بازکردن 🔓\n\n↜ بازکردن لینک\n\n↜ بازکردن ورود\n\n↜ بازکردن تگ\n\n↜ بازکردن ویرایش\n\n↜ بازکردن عربی\n\n↜ بازکردن وب\n\n↜ بازکردن ربات\n\n↜ بازکردن هرزنامه\n\n↜ بازکردن پیام مکرر\n\n↜ بازکردن فونت\n\n↜ بازکردن فراخوانی\n\n↜ بازکردن پین\n\n⚠️ در صورت قفل نبودن فعالیت ها, ربات آنها را حذف نخواهد کرد\n\n*✐ این راهنما فقط برای مدیران/مالکان گروه میباشد!*\n\n`✐ این به این معناست که فقط مدیران/مالکان گروه میتوانند از دستورات بالا استفاده کنند!`\n\n\n↫ موفق باشید *;)*\n\n', keyboard)
end
end
if matches[1] == '/mutehelp' then
if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
    else
    if not lang then
keyboard = {}
    keyboard.inline_keyboard = {
        {
            {text = " Back ⇜", callback_data = '/help:'..matches[2]}
        },
 }
end
edit_inline(msg.message_id, '*✧ Rex mute Help Commands:*\n\n❥ To mute 🔇\n\n➲ mute gif\n\n➲ mute photo\n\n➲ mute document\n\n➲ mute sticker\n\n➲ mute keybord\n\n➲ mute video\n\n➲ mute video note\n\n➲ mute text\n\n➲ mute fwd\n\n➲ mute location\n\n➲ mute audio\n\n➲ mute voice\n\n\n\n➲ mute contact\n\n➲ mute inline\n\n➲ mute all\n\n⚠️ If This Actions Lock, Bot Check Actions And Delete Them\n\n❥ To Unmute 🔈\n\n➲ unmute gif\n\n➲ unmute photo\n\n➲ unmute document\n\n➲ unmute sticker\n\n➲ unmute keybord\n\n➲ unmute video\n\n➲ unmute videonote\n\n➲ unmute text\n\n➲ unmute fwd\n\n➲ unmute location\n\n➲ unmute audio\n\n➲ unmute voice\n\n➲ unmute contact\n\n➲ unmute inline\n\n➲ unmute all\n\n⚠️ If This Actions Unlock, Bot Not Delete Them\n\n*✎ This Help List Only For Moderators/Owners!*\n\n`✎ Its Means, Only Group Moderators/Owners Can Use It!`\n\n\n❥ Good luck ツ\n\n', keyboard)
end
end
if matches[1] == '/mutehelpfa' then
if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   elseif lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   end
    else
    if not lang then
keyboard = {}
    keyboard.inline_keyboard = {
        {
            {text = "⇜ برگشت", callback_data = '/help:'..matches[2]}
        },
 }
end
edit_inline(msg.message_id, '*✧ Rex mute Help Commands: *\n\n⇜ برای بیصدا کردن 🔇\n\n↜ بیصدا گیف\n\n↜ بیصدا عکس\n\n↜ بیصدا اسناد\n\n↜ بیصدا استیکر\n\n↜ بیصدا کیبورد\n\n↜ بیصدا فیلم\n\n↜ بیصدا فیلم سلفی\n\n↜ بیصدا متن\n\n↜ بیصدا فور\n\n↜ بیصدا موقعیت\n\n↜ بیصدا اهنگ\n\n↜ بیصدا صدا\n\n↜ بیصدا مخاطب\n\n↜ بیصدا اینلاین\n\n↜ بیصدا همه\n\n⚠️ در صورت بیصدا بودن فعالیت ها, ربات آنهارا حذف خواهد کرد\n\n⇜ برای باصدا کردن  🔈\n\n↜ باصدا گیف\n\n↜ باصدا عکس\n\n↜ باصدا اسناد\n\n↜ باصدا استیکر\n\n↜ باصدا کیبورد\n\n↜ باصدا فیلم\n\n↜ باصدا فیلم سلفی\n\n↜ باصدا متن\n\n↜ باصدا فور\n\n↜ باصدا موقعیت\n\n↜ باصدا اهنگ\n\n↜ باصدا صدا\n\n↜ باصدا مخاطب\n\n↜ باصدا اینلاین\n\n↜ باصدا همه\n\n⚠️ در صورت بیصدا نبودن فعالیت ها, ربات آنهارا حذف نخواهد کرد\n\n*✐ این راهنما فقط برای مدیران/مالکان گروه میباشد!*\n\n`✐ این به این معناست که فقط مدیران/مالکان گروه میتوانند از دستورات بالا استفاده کنند!`\n\n\n↫ موفق باشید *;)*\n\n', keyboard)
end
end
if matches[1] == '/funhelp' then
if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
    else
    if not lang then
keyboard = {}
    keyboard.inline_keyboard = {
        {
            {text = " Back ⇜", callback_data = '/help:'..matches[2]}
        },
 }
end
edit_inline(msg.message_id, '*✧ Rex v1 Fun Help Commands:*\n\n➲ time\n⇋ Get time in a sticker\n\n➲ short [link]\n⇋ Make short url\n\n➲ voice `[text]`\n⇋ Convert text to voice\n\n➲ tr `[lang]` `[word]`\n⇋ Translates FA to EN and EN to FA\n\n➲ sticker `[word]`\n⇋ Convert text to sticker\n\n➲ photo `[word]`\n⇋ Convert text to photo\n\n➲ calc `[number]`\n⇋ Calculator\n\n➲ praytime `[city]`\n⇋ Get Patent (Pray Time)\n\n➲ tosticker `[reply]`\n⇋ Convert photo to sticker\n\n➲ tophoto `[reply]`\n⇋ Convert text to photo\n\n➲ weather `[city]`\n⇋ Get weather\n\n➲ ping\n⇋ Be informed of the online being a robot.\n\n ↬ Good luck ツ \n\n', keyboard)
end
end
if matches[1] == '/funhelpfa' then
if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   elseif lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   end
    else
    if not lang then
keyboard = {}
    keyboard.inline_keyboard = {
        {
            {text = "⇜ برگشت", callback_data = '/help:'..matches[2]}
        },
 }
end
edit_inline(msg.message_id, '*✧ راهنمای فان رکس:*\n\n↜ ساعت\n↭ دریافت ساعت به صورت استیکر\n\n↜ لینک کوتاه `[لینک]`\n↭ کوتاه کننده لینک\n\n↜ صدا `[متن]`\n↭ تبدیل متن به صدا\n\n↜ ترجمه [زبان] `[متن]`\n↭ ترجمه متن فارسی به انگلیسی وبرعکس\n\n↜ استیکر `[متن]`\n↭ تبدیل متن به استیکر\n\n↜ عکس `[متن]`\n↭ تبدیل متن به عکس\n\n↜ ماشین حساب `[معادله]`\n↭ ماشین حساب\n\n↜ ساعات شرعی `[شهر]`\n⇋ ↭ اعلام ساعات شرعی\n\n↜ به استیکر `[ریپلی]`\n↭ تبدیل عکس به استیکر\n\n↜ به عکس `[ریپلی]`\n↭ تبدیل استیکر‌به عکس\n\n↜ اب و هوا `[شهر]`\n↭ دریافت اب وهوا\n\n↜ انلاینی\n↭ مطلع شدن از آنلاین بودن ربات\n\n↫ موفق باشید ツ\n\n', keyboard)
end
end
if matches[1] == '/tv' then
if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
    else
text = 'Tv Live'
keyboard = {}
    keyboard.inline_keyboard = {
        {
            {text = "⇝ Tv Iran 📺",callback_data = '/ir:'..matches[2]}
        },
        {
            {text = "⇝ Satellite Channel 🌐",callback_data = '/mahvare:'..matches[2]}
        },
        {
            {text = "Back ⇜",callback_data = '/option:'..matches[2]}
        }
 }
end
edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/tvfa' then
if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
    else
text = 'تلیویزیون فارسی'
keyboard = {}
    keyboard.inline_keyboard = {
        {
            {text = "⇜ شبکه های ایران 📺",callback_data = '/irfa:'..matches[2]}
        },
        {
            {text = "⇜ شبکه های ماهواره 🌐",callback_data = '/mahvarefa:'..matches[2]}
        },
        {
            {text = "⇜ برگشت",callback_data = '/option:'..matches[2]}
        }
 }
end
edit_inline(msg.message_id, text, keyboard)
end
if matches[1] == '/mahvare' then
    if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
    else
keyboard = {}
    keyboard.inline_keyboard = {
        {
            {text = "⇝ Cartoon NetWork", url = 'http://www.zengatv.com/live/20f69b5b-baca-11e1-bc3d-1231381a91e4.html'}
        },
        {
            {text = "⇝ Gem TV", url = 'http://www.giniko.com/watch.php?id=353'}
        },
        {
            {text = "⇝ Man o To", url = 'https://www.manototv.com/live'}
        },
        {
            {text = "⇝ PMC", url = 'https://pmc.tv'}
        },
        {
            {text = "⇝ Tv Persia", url = 'http://www.tvpersia.com/'}
        },
        {
            {text = "⇝ Porno 🔞", url = 'https://www.google.nl/url?sa=t&source=web&rct=j&url=https://www.pornhub.com/video/search%3Fsearch%3Donline&ved=2ahUKEwiJsIWE36PZAhVPalAKHUp_BSsQFjAAegQIExAB&usg=AOvVaw0XGTM_Z8oDqaVjplyNH_wj'}
        },
        {
            {text = "Back ⇜",callback_data = '/tv:'..matches[2]}
        }
 }
end
edit_inline(msg.message_id, '💠 Please Use of VPN', keyboard)
end
if matches[1] == '/mahvarefa' then
    if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
    else
keyboard = {}
    keyboard.inline_keyboard = {
        {
            {text = "⇜ انیمیشن", url = 'http://www.zengatv.com/live/20f69b5b-baca-11e1-bc3d-1231381a91e4.html'}
        },
        {
            {text = "⇜ جم تی وی", url = 'http://www.giniko.com/watch.php?id=353'}
        },
        {
            {text = "⇜ من و تو", url = 'https://www.manototv.com/live'}
        },
        {
            {text = "⇜ پی ام سی", url = 'https://pmc.tv'}
        },
        {
            {text = "⇜ تی وی پرشیا", url = 'http://www.tvpersia.com/'}
        },
        {
            {text = "⇜ پورن 🔞", url = 'https://www.google.nl/url?sa=t&source=web&rct=j&url=https://www.pornhub.com/video/search%3Fsearch%3Donline&ved=2ahUKEwiJsIWE36PZAhVPalAKHUp_BSsQFjAAegQIExAB&usg=AOvVaw0XGTM_Z8oDqaVjplyNH_wj'}
        },
        {
            {text = "⇜ برگشت",callback_data = '/tvfa:'..matches[2]}
        }
 }               
end
edit_inline(msg.message_id, '💠 Please Use of VPN', keyboard)
end
if matches[1] == '/ir' then
    if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
    else
keyboard = {}
    keyboard.inline_keyboard = {
        {
            {text = "⇝ Tv ➊", url = 'https://www.aparat.com/live/tv1'},
            {text = "⇝ Tv ➋", url = 'https://www.aparat.com/live/tv2'}
        },
        {
            {text = "⇝ Tv ➌", url = 'https://www.aparat.com/live/tv3'},
            {text = "⇝ Tv ➍", url = 'https://www.aparat.com/live/tv4'}
        },
        {
            {text = "⇝ Tv ➎", url = 'https://www.aparat.com/live/tv5'},
            {text = "⇝ Irinn", url = 'https://www.aparat.com/live/irinn'}
        },
        {
            {text = "⇝ Ifilm", url = 'https://www.aparat.com/live/ifilm'},
            {text = "⇝ Namayesh", url = 'https://www.aparat.com/live/namayesh'}
        },
        {
            {text = "⇝ Varsesh", url = 'https://www.aparat.com/live/varzesh'},
            {text = "⇝ Nasim", url = 'https://www.aparat.com/live/nasim'}
        },
        {
            {text = "⇝ mostanad", url = 'https://www.aparat.com/live/mostanad'},
            {text = "⇝ ofogh", url = 'https://www.aparat.com/live/ofogh'}
        },
        {
            {text = "⇝ pouya", url = 'https://www.aparat.com/live/pouya'}
        },
        {
            {text = "⇝ Hd", url = 'https://www.aparat.com/live/hd'},
            {text = "⇝ Press Tv", url = 'https://www.aparat.com/live/press'}
        },
        {
            {text = "Back ⇜",callback_data = '/tv:'..matches[2]}
        }
 }
end
edit_inline(msg.message_id, 'Tv Iran', keyboard)
end
if matches[1] == '/irfa' then
    if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
    else
keyboard = {}
    keyboard.inline_keyboard = {
        {
            {text = "⇜ شبکه ➊", url = 'https://www.aparat.com/live/tv1'},
            {text = "⇜ شبکه ➋", url = 'https://www.aparat.com/live/tv2'}
        },
        {
            {text = "⇜ شبکه ➌", url = 'https://www.aparat.com/live/tv3'},
            {text = "⇜ شبکه ➍", url = 'https://www.aparat.com/live/tv4'}
        },
        {
            {text = "⇜ شبکه ➎", url = 'https://www.aparat.com/live/tv5'},
            {text = "⇜ خبر", url = 'https://www.aparat.com/live/irinn'}
        },
        {
            {text = "⇜ آی فیلم", url = 'https://www.aparat.com/live/ifilm'},
            {text = "⇜ نمایش", url = 'https://www.aparat.com/live/namayesh'}
        },
        {
            {text = "⇜ ورزش", url = 'https://www.aparat.com/live/varzesh'},
            {text = "⇜ نسیم", url = 'https://www.aparat.com/live/nasim'}
        },
        {
            {text = "⇜ مستند", url = 'https://www.aparat.com/live/mostanad'},
            {text = "⇜ افق", url = 'https://www.aparat.com/live/ofogh'}
        },
        {
            {text = "⇜ پویا", url = 'https://www.aparat.com/live/pouya'}
        },
        {
            {text = "⇜ تماشا", url = 'https://www.aparat.com/live/hd'},
            {text = "⇜ پرس تی وی", url = 'https://www.aparat.com/live/press'}
        },
        {
            {text = "⇜ برگشت",callback_data = '/tvfa:'..matches[2]}
        }
 }   
end
edit_inline(msg.message_id, 'Tv Iran', keyboard)
end
if matches[1] == '/time' then
if not is_mod1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Moderator")
   elseif lang then
		get_alert(msg.cb_id, "شما مدیر نیستید")
   end
    else
if not lang then
keyboard = {}
    keyboard.inline_keyboard = {
        {
            {text = "Back",callback_data = '/option:'..matches[2]}
        }
 }
    elseif lang then
keyboard = {}
    keyboard.inline_keyboard = {
        {
            {text = "برگشت",callback_data = '/option:'..matches[2]}
        }
 }
end
edit_inline(msg.message_id, '⏰ time ➲ '..os.date("%H : %M"), keyboard)
end
end
if matches[1] == '/like' then
      if redis:get("IsDisLiked:"..msg.from.id) then
        redis:del("IsDisLiked:"..msg.from.id)
        local dislikes = redis:get("MaTaDoRDisLikes")
        redis:set("MaTaDoRDisLikes",dislikes - 1)
        redis:set("IsLiked:"..msg.from.id,true)
        local likes = redis:get("MaTaDoRLikes")
        redis:set("MaTaDoRLikes",likes + 1)
        get_alert(msg.cb_id, "تشکر فراوان از رای مثبت شما😄❤️")
      else
        if redis:get("IsLiked:"..msg.from.id) then
          redis:del("IsLiked:"..msg.from.id)
          local likes = redis:get("MaTaDoRLikes")
          redis:set("MaTaDoRLikes",likes - 1)
          get_alert(msg.cb_id, "خیلی بدی مگه چکار کردم رای مثبت رو پس گرفتی😢💔")
        else
          redis:set("IsLiked:"..msg.from.id,true)
          local likes = redis:get("MaTaDoRLikes")
          redis:set("MaTaDoRLikes",likes + 1)
          get_alert(msg.cb_id, "تشکر فراوان از رای مثبت شما😄❤️")
        end
      end
	  options(msg,matches[2])
  end
  if matches[1] == '/dislike' then
      if redis:get("IsLiked:"..msg.from.id) then
        redis:del("IsLiked:"..msg.from.id)
        local likes = redis:get("MaTaDoRLikes")
        redis:set("MaTaDoRLikes",likes - 1)
        redis:set("IsDisLiked:"..msg.from.id,true)
        local dislikes = redis:get("MaTaDoRDisLikes")
        redis:set("MaTaDoRDisLikes",dislikes + 1)
        get_alert(msg.cb_id, "خیلی بدی مگه چیکار کردم رای منفی دادی 😢💔")
      else
        if redis:get("IsDisLiked:"..msg.from.id) then
          redis:del("IsDisLiked:"..msg.from.id)
          local dislikes = redis:get("MaTaDoRDisLikes")
          redis:set("MaTaDoRDisLikes",dislikes - 1)
          get_alert(msg.cb_id, "وای مرسی که رای منفیت رو پس گرفتی 😀🌹")
        else
          redis:set("IsDisLiked:"..msg.from.id,true)
          local dislikes = redis:get("MaTaDoRDisLikes")
          redis:set("MaTaDoRDisLikes",dislikes + 1)
          get_alert(msg.cb_id, "خیلی بدی مگه چیکار کردم رای منفی دادی 😢💔")
        end
      end
	  options(msg,matches[2])
  end
end
--------------End Inline Query---------------


local function pre_process(msg)
-- print(serpent.block(msg), {comment=false})
--leave_group(msg.chat.id)
end

return {
	patterns ={
		"^-(%d+)$",
        "^-(%d++)$",
		"^###cb:(%d+)$",
        "^###cb:(%d++)$",
		"^[/](sudolist)$",
		"^[/](setsudo)$",
		"^[/](remsudo)$",
		"^[/](setsudo) (%d+)$",
		"^[/](remsudo) (%d+)$",
		"^###cb:(/option):(.*)$",
		"^###cb:(/lang):(.*)$",
        "^###cb:(/ir):(.*)$",
        "^###cb:(/irfa):(.*)$",
        "^###cb:(/mahvare):(.*)$",
        "^###cb:(/mahvarefa):(.*)$",
		"^###cb:(/persian):(.*)$",
		"^###cb:(/english):(.*)$",
		"^###cb:(/settings):(.*)$",
		"^###cb:(/mutelist):(.*)$",
        "^###cb:(/locklinks):(.*)$",
        "^###cb:(/kicklink):(.*)$",
		"^###cb:(/locklink):(.*)$",
		"^###cb:(/lockedit):(.*)$",
		"^###cb:(/locktags):(.*)$",
		"^###cb:(/lockjoin):(.*)$",
		"^###cb:(/lockpin):(.*)$",
		"^###cb:(/lockmarkdown):(.*)$",
		"^###cb:(/lockmention):(.*)$",
		"^###cb:(/lockarabic):(.*)$",
		"^###cb:(/lockwebpage):(.*)$",
		"^###cb:(/lockbots):(.*)$",
		"^###cb:(/lockspam):(.*)$",
		"^###cb:(/lockflood):(.*)$",
		"^###cb:(/welcome):(.*)$",
		"^###cb:(/muteall):(.*)$",
		"^###cb:(/mutegif):(.*)$",
		"^###cb:(/mutegame):(.*)$",
		"^###cb:(/mutevideo):(.*)$",
		"^###cb:(/mutevoice):(.*)$",
		"^###cb:(/muteinline):(.*)$",
		"^###cb:(/mutesticker):(.*)$",
		"^###cb:(/mutelocation):(.*)$",
		"^###cb:(/mutedocument):(.*)$",
		"^###cb:(/muteaudio):(.*)$",
		"^###cb:(/mutephoto):(.*)$",
		"^###cb:(/mutetext):(.*)$",
		"^###cb:(/mutetgservice):(.*)$",
		"^###cb:(/mutekeyboard):(.*)$",
		"^###cb:(/mutecontact):(.*)$",
		"^###cb:(/muteforward):(.*)$",
		"^###cb:(/setflood):(.*)$",
		"^###cb:(/floodup):(.*)$",
		"^###cb:(/flooddown):(.*)$",
		"^###cb:(/charup):(.*)$",
		"^###cb:(/chardown):(.*)$",
		"^###cb:(/floodtimeup):(.*)$",
		"^###cb:(/floodtimedown):(.*)$",
		"^###cb:(/moresettings):(.*)$",
		"^###cb:(/more):(.*)$",
		"^###cb:(/ownerlist):(.*)$",
		"^###cb:(/cleanowners):(.*)$",
		"^###cb:(/modlist):(.*)$",
		"^###cb:(/cleanmods):(.*)$",
		"^###cb:(/bans):(.*)$",
		"^###cb:(/rex):(.*)$",
        "^###cb:(/sup):(.*)$",
        "^###cb:(/help):(.*)$",
        "^###cb:(/sudohelp):(.*)$",
        "^###cb:(/tv):(.*)$",
        "^###cb:(/tvfa):(.*)$",
        "^###cb:(/time):(.*)$",
        "^###cb:(/like):(.*)$",
        "^###cb:(/dislike):(.*)$",
        "^###cb:(/sudohelpfa):(.*)$",
        "^###cb:(/modhelp):(.*)$",
        "^###cb:(/modhelpfa):(.*)$",
        "^###cb:(/lockhelp):(.*)$",
        "^###cb:(/lockhelpfa):(.*)$",
        "^###cb:(/funhelp):(.*)$",
        "^###cb:(/funhelpfa):(.*)$",
        "^###cb:(/mutehelp):(.*)$",
        "^###cb:(/mutehelpfa):(.*)$",
		"^###cb:(/cleanbans):(.*)$",
		"^###cb:(/filterlist):(.*)$",
		"^###cb:(/cleanfilterlist):(.*)$",
		"^###cb:(/whitelist):(.*)$",
		"^###cb:(/cleanwhitelist):(.*)$",
		"^###cb:(/silentlist):(.*)$",
		"^###cb:(/cleansilentlist):(.*)$",
		"^###cb:(/link):(.*)$",
		"^###cb:(/rules):(.*)$",
		"^###cb:(/cleanrules):(.*)$",
		"^###cb:(/exit):(.*)$",
		"^###cb:(/whitelists):(.*)$",
		"^###cb:(/cleanwhitelists):(.*)$",
		"^###cb:(/showwlc):(.*)$",
		"^###cb:(/cleanwlcmsg):(.*)$",

	},
	run=run,
	pre_process=pre_process
}
