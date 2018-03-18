
--Begin Fun.lua By @BeyondTeam

--Edited Fun.lua By @RexCompany
--------------------------------

local function run_bash(str)
    local cmd = io.popen(str)
    local result = cmd:read('*all')
    return result
end
--------------------------------
local api_key = nil
local base_api = "https://maps.googleapis.com/maps/api"
--------------------------------
local function get_latlong(area)
	local api      = base_api .. "/geocode/json?"
	local parameters = "address=".. (URL.escape(area) or "")
	if api_key ~= nil then
		parameters = parameters .. "&key="..api_key
	end
	local res, code = https.request(api..parameters)
	if code ~=200 then return nil  end
	local data = json:decode(res)
	if (data.status == "ZERO_RESULTS") then
		return nil
	end
	if (data.status == "OK") then
		lat  = data.results[1].geometry.location.lat
		lng  = data.results[1].geometry.location.lng
		acc  = data.results[1].geometry.location_type
		types= data.results[1].types
		return lat,lng,acc,types
	end
end
--------------------------------
local function get_staticmap(area)
	local api        = base_api .. "/staticmap?"
	local lat,lng,acc,types = get_latlong(area)
	local scale = types[1]
	if scale == "locality" then
		zoom=8
	elseif scale == "country" then 
		zoom=4
	else 
		zoom = 13 
	end
	local parameters =
		"size=600x300" ..
		"&zoom="  .. zoom ..
		"&center=" .. URL.escape(area) ..
		"&markers=color:red"..URL.escape("|"..area)
	if api_key ~= nil and api_key ~= "" then
		parameters = parameters .. "&key="..api_key
	end
	return lat, lng, api..parameters
end
--------------------------------
local function get_weather(location)
	print("Finding weather in ", location)
	local BASE_URL = "http://api.openweathermap.org/data/2.5/weather"
	local url = BASE_URL
	url = url..'?q='..location..'&APPID=eedbc05ba060c787ab0614cad1f2e12b'
	url = url..'&units=metric'
	local b, c, h = http.request(url)
	if c ~= 200 then return nil end
	local weather = json:decode(b)
	local city = weather.name
	local country = weather.sys.country
	local temp = '⇋ دمای شهر '..city..' هم اکنون '..weather.main.temp..' درجه سانتی گراد می باشد\n____________________'
	local conditions = 'شرایط فعلی آب و هوا : '
	if weather.weather[1].main == 'Clear' then
		conditions = conditions .. 'آفتابی☀'
	elseif weather.weather[1].main == 'Clouds' then
		conditions = conditions .. 'ابری ☁☁'
	elseif weather.weather[1].main == 'Rain' then
		conditions = conditions .. 'بارانی ☔'
	elseif weather.weather[1].main == 'Thunderstorm' then
		conditions = conditions .. 'طوفانی ☔☔☔☔'
	elseif weather.weather[1].main == 'Mist' then
		conditions = conditions .. 'مه 💨'
	end
	return temp .. '\n' .. conditions
end
--------------------------------
local function calc(exp)
	url = 'http://api.mathjs.org/v1/'
	url = url..'?expr='..URL.escape(exp)
	b,c = http.request(url)
	text = nil
	if c == 200 then
    text = 'Result = '..b..'\n____________________'..msg_caption
	elseif c == 400 then
		text = b
	else
		text = 'Unexpected error\n'
		..'Is api.mathjs.org up?'
	end
	return text
end
--------------------------------
function exi_file(path, suffix)
    local files = {}
    local pth = tostring(path)
	local psv = tostring(suffix)
    for k, v in pairs(scandir(pth)) do
        if (v:match('.'..psv..'$')) then
            table.insert(files, v)
        end
    end
    return files
end
--------------------------------
function file_exi(name, path, suffix)
	local fname = tostring(name)
	local pth = tostring(path)
	local psv = tostring(suffix)
    for k,v in pairs(exi_file(pth, psv)) do
        if fname == v then
            return true
        end
    end
    return false
end
--------------------------------
function run(msg, matches) 
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
	if (matches[1]:lower() == 'calc' and not Clang) or (matches[1]:lower() == 'ماشین حساب' and Clang) and matches[2]  and is_mod(msg) then 
		if msg.to.type == "pv" then 
			return 
       end
		return calc(matches[2])
	end
--------------------------------
function getRandomButts(attempt)
attempt = attempt or 0
attempt = attempt + 1
local res,status = http.request("http://api.obutts.ru/noise/1")
if status ~= 200 then return nil end
local data = json:decode(res)[1]
if not data and attempt <= 3 then
return getRandomButts(attempt)
end
return 'http://media.obutts.ru/' .. data.preview
end
--------------------------------
function getRandomBoobs(attempt)
attempt = attempt or 0
attempt = attempt + 1
local res,status = http.request("http://api.oboobs.ru/noise/1")
if status ~= 200 then return nil end
local data = json:decode(res)[1]
if not data and attempt < 10 then 
return getRandomBoobs(attempt)
end
return 'http://media.oboobs.ru/' .. data.preview
end
--------------------------------
	if (matches[1]:lower() == 'praytime' and not Clang) or (matches[1]:lower() == 'ساعات شرعی' and Clang)  and is_mod(msg) then
		if matches[2] then
			city = matches[2]
		elseif not matches[2] then
			city = 'Tehran'
		end
		local lat,lng,url	= get_staticmap(city)
		local dumptime = run_bash('date +%s')
		local code = http.request('http://api.aladhan.com/timings/'..dumptime..'?latitude='..lat..'&longitude='..lng..'&timezonestring=Asia/Tehran&method=7')
		local jdat = json:decode(code)
		local data = jdat.data.timings
		local text = 'شهر: '..city
		text = text..'\nاذان صبح: '..data.Fajr
		text = text..'\nطلوع آفتاب: '..data.Sunrise
		text = text..'\nاذان ظهر: '..data.Dhuhr
		text = text..'\nغروب آفتاب: '..data.Sunset
		text = text..'\nاذان مغرب: '..data.Maghrib
		text = text..'\nعشاء : '..data.Isha
		text = text..msg_caption
		return tdbot.sendMessage(msg.chat_id, 0, 1, text, 1, 'html')
	end
--------------------------------
	if (matches[1]:lower() == 'tophoto' and not Clang) or (matches[1]:lower() == 'به عکس' and Clang) and msg.reply_id  and is_mod(msg) then
		function tophoto(arg, data)
			function tophoto_cb(arg,data)
				if data.content.sticker then
					local file = data.content.sticker.sticker.path
					local secp = tostring(tcpath)..'/data/stickers/'
					local ffile = string.gsub(file, '-', '')
					local fsecp = string.gsub(secp, '-', '')
					local name = string.gsub(ffile, fsecp, '')
					local sname = string.gsub(name, 'webp', 'jpg')
					local pfile = 'data/photos/'..sname
					local pasvand = 'webp'
					local apath = tostring(tcpath)..'/data/stickers'
					if file_exi(tostring(name), tostring(apath), '') then
						os.rename(file, pfile)
						        tdbot.sendPhoto(msg.to.id, msg.id, pfile, 0, {}, 0, 0, msg_caption, 0, 0, 1, nil, dl_cb, nil)
					else
						tdbot.sendMessage(msg.to.id, msg.id, 1, '⇋ This *sticker* does not exist. Send *sticker* again.'..msg_caption, 1, 'md')
					end
				else
					tdbot.sendMessage(msg.to.id, msg.id, 1, '⇋ This is not a *sticker*.', 1, 'md')
				end
			end
            tdbot_function ({ _ = 'getMessage', chat_id = msg.chat_id, message_id = data.id }, tophoto_cb, nil)
		end
		tdbot_function ({ _ = 'getMessage', chat_id = msg.chat_id, message_id = msg.reply_id }, tophoto, nil)
    end
--------------------------------
	if (matches[1]:lower() == 'tosticker' and not Clang) or (matches[1]:lower() == 'به استیکر' and Clang) and msg.reply_id  and is_mod(msg) then
		function tosticker(arg, data)
			function tosticker_cb(arg,data)
				if data.content._ == 'messagePhoto' then
					file = data.content.photo.id
					local pathf = tcpath..'/files/photos/'..file..'.jpg'
					local pfile = 'data/photos/'..file..'.webp'
					if file_exi(file..'.jpg', tcpath..'/files/photos', 'jpg') then
						os.rename(pathf, pfile)
tdbot.sendDocument(msg.to.id, pfile, msg_caption, nil, msg.id, 0, 1, nil, dl_cb, nil)
					else
						tdbot.sendMessage(msg.to.id, msg.id, 1, '⇋ This photo does not exist. Send photo again.', 1, 'md')
					end
				else
					tdbot.sendMessage(msg.to.id, msg.id, 1, '⇋ This is not a photo.', 1, 'md')
				end
			end
			tdbot_function ({ _ = 'getMessage', chat_id = msg.chat_id, message_id = data.id }, tosticker_cb, nil)
		end
		tdbot_function ({ _ = 'getMessage', chat_id = msg.chat_id, message_id = msg.reply_id }, tosticker, nil)
    end
--------------------------------
	if (matches[1]:lower() == 'weather' and not Clang) or (matches[1]:lower() == 'اب و هوا' and Clang) then
		city = matches[2]
		local wtext = get_weather(city)
		if not wtext then
			wtext = 'مکان وارد شده صحیح نیست'
		end
		return wtext
	end
--------------------------------

--------------------------------
	if (matches[1]:lower() == 'time' and not Clang) or (matches[1]:lower() == 'ساعت' and Clang) then
		local url , res = http.request('http://api.beyond-dev.ir/time/')
		if res ~= 200 then
			return "No connection"
		end
		local colors = {'blue','green','yellow','magenta','Orange','DarkOrange','red'}
		local fonts = {'mathbf','mathit','mathfrak','mathrm'}
		local jdat = json:decode(url)
		local url = 'http://latex.codecogs.com/png.download?'..'\\dpi{600}%20\\huge%20\\'..fonts[math.random(#fonts)]..'{{\\color{'..colors[math.random(#colors)]..'}'..jdat.ENtime..'}}'
		local file = download_to_file(url,'time.webp')
		tdbot.sendDocument(msg.to.id, file, msg_caption, nil, msg.id, 0, 1, nil, dl_cb, nil)

	end
--------------------------------
	if (matches[1]:lower() == 'voice' and not Clang) or (matches[1]:lower() == 'صدا' and Clang) and is_mod(msg) then
 local text = matches[2]
    textc = text:gsub(' ','.')
    
  if msg.to.type == 'pv' then 
      return nil
      else
  local url = "http://tts.baidu.com/text2audio?lan=en&ie=UTF-8&text="..textc
  local file = download_to_file(url,'Rex.mp3')
 				tdbot.sendDocument(msg.to.id, file, msg_caption, nil, msg.id, 0, 1, nil, dl_cb, nil)
   end
end

 --------------------------------
	if (matches[1]:lower() == 'tr' and not Clang) or (matches[1]:lower() == 'ترجمه' and Clang) and is_mod(msg) then 
		url = https.request('https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20160119T111342Z.fd6bf13b3590838f.6ce9d8cca4672f0ed24f649c1b502789c9f4687a&format=plain&lang='..URL.escape(matches[2])..'&text='..URL.escape(matches[3]))
		data = json:decode(url)
		return 'زبان : '..data.lang..'\nترجمه : '..data.text[1]..'\n____________________'..msg_caption
	end
--------------------------------
	if (matches[1]:lower() == 'short' and not Clang) or (matches[1]:lower() == 'لینک کوتاه' and Clang) and is_mod(msg) then
		if matches[2]:match("[Hh][Tt][Tt][Pp][Ss]://") then
			shortlink = matches[2]
		elseif not matches[2]:match("[Hh][Tt][Tt][Pp][Ss]://") then
			shortlink = "https://"..matches[2]
		end
		local yon = http.request('http://api.yon.ir/?url='..URL.escape(shortlink))
		local jdat = json:decode(yon)
		local bitly = https.request('https://api-ssl.bitly.com/v3/shorten?access_token=f2d0b4eabb524aaaf22fbc51ca620ae0fa16753d&longUrl='..URL.escape(shortlink))
		local data = json:decode(bitly)
		local u2s = http.request('http://u2s.ir/?api=1&return_text=1&url='..URL.escape(shortlink))
		local llink = http.request('http://llink.ir/yourls-api.php?signature=a13360d6d8&action=shorturl&url='..URL.escape(shortlink)..'&format=simple')
		local text = ' 🌐لینک اصلی :\n'..check_markdown(data.data.long_url)..'\n\nلینکهای کوتاه شده با 6 سایت کوتاه ساز لینک : \n》کوتاه شده با bitly :\n___________________________\n'..(check_markdown(data.data.url) or '---')..'\n___________________________\n》کوتاه شده با u2s :\n'..(check_markdown(u2s) or '---')..'\n___________________________\n》کوتاه شده با llink : \n'..(check_markdown(llink) or '---')..'\n___________________________\n》لینک کوتاه شده با yon : \nyon.ir/'..(check_markdown(jdat.output) or '---')..'\n____________________'..msg_caption
		return tdbot.sendMessage(msg.chat_id, 0, 1, text, 1, 'html')
	end
--------------------------------
	if (matches[1]:lower() == 'sticker' and not Clang) or (matches[1]:lower() == 'استیکر' and Clang) and is_mod(msg) then
		local eq = URL.escape(matches[2])
		local w = "500"
		local h = "500"
		local txtsize = "100"
		local txtclr = "ff2e4357"
		if matches[3] then 
			txtclr = matches[3]
		end
		if matches[4] then 
			txtsize = matches[4]
		end
		if matches[5] and matches[6] then 
			w = matches[5]
			h = matches[6]
		end
		local url = "https://assets.imgix.net/examples/pione.jpg?blur=150&w="..w.."&h="..h.."&fit=crop&txt="..eq.."&txtsize="..txtsize.."&txtclr="..txtclr.."&txtalign=middle,center&txtfont=Futura%20Condensed%20Medium&mono=ff6598cc"
		local receiver = msg.to.id
		local  file = download_to_file(url,'text.webp')
		tdbot.sendDocument(msg.to.id, file, msg_caption, nil, msg.id, 0, 1, nil, dl_cb, nil)
	end
--------------------------------
	if (matches[1]:lower() == 'photo' and not Clang) or (matches[1]:lower() == 'عکس' and Clang) and is_mod(msg) then
		local eq = URL.escape(matches[2])
		local w = "500"
		local h = "500"
		local txtsize = "100"
		local txtclr = "ff2e4357"
		if matches[3] then 
			txtclr = matches[3]
		end
		if matches[4] then 
			txtsize = matches[4]
		end
		if matches[5] and matches[6] then 
			w = matches[5]
			h = matches[6]
		end
		local url = "https://assets.imgix.net/examples/pione.jpg?blur=160&w="..w.."&h="..h.."&fit=crop&txt="..eq.."&txtsize="..txtsize.."&txtclr="..txtclr.."&txtalign=middle,center&txtfont=Futura%20Condensed%20Medium&mono=ff6598cc"
		local receiver = msg.to.id
		local  file = download_to_file(url,'text.jpg')
			tdbot.sendPhoto(msg.to.id, msg.id, file, 0, {}, 0, 0, msg_caption, 0, 0, 1, nil, dl_cb, nil)
	end

if (matches[1]:lower () == 'creator' and not Clang) or (matches[1] == 'سازنده' and Clang) then
return '₪ My Creator ➲ @RexDeveloper'
end
--------------------------------
if matches[1] == "funhelp" and not Clang then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not lang then
helpfun_en = [[
✧ *Rex v1 Fun Help Commands:*

➲ `time`
⇋ *Get time in a sticker*

➲ *short* `[link]`
⇋ Make short url

➲ *voice* `[text]`
⇋ Convert text to voice

➲ *tr* `[lang] [word]`
⇋ Translates FA to EN and EN to FA

➲ *sticker* `[word]`
⇋ Convert text to sticker

➲ *photo* `[word]`
⇋ Convert text to photo

➲ *calc* `[number]`
⇋ Calculator

➲ *praytime* `[city]`
⇋ Get Patent (Pray Time)

➲ *tosticker* `[reply]`
⇋ Convert photo to sticker

➲ *tophoto* `[reply]`
⇋ Convert text to photo

➲ *weather* `[city]`
⇋ Get weather

➲ *Keepcalm* `[Name]` `[BackGround Color]` `[Text Color]` `[Crown Color]` `[Size]`
⇋ `KeepCalm Sticker`

➲ *Love First* `[Name]` `[Second Name]`
⇋ `Love Sticker`

➲ *emoji* `[word]`
⇋ `Convert text to Emoji`

➲ *ping*
⇋ `Be informed of the online being a robot.`

* ↬ Good luck ツ *
            
↬ @RexCompany]]
else

helpfun_en = [[
✧ *Rex v1 Fun Help Commands:*

➲ *time*
↭ دریافت ساعت به صورت استیکر

➲ *short* `[link]`
↭ کوتاه کننده لینک

➲ *voice* `[text]`
↭ تبدیل متن به صدا

➲ *tr* `[lang]` `[word]`
↭ ترجمه متن فارسی به انگلیسی وبرعکس

➲ *sticker* `[word]`
↭ تبدیل متن به استیکر

➲ *photo* `[word]`
↭ تبدیل متن به عکس

➲ *calc* `[number]`
↭ ماشین حساب

➲ *praytime* `[city]`
↭ اعلام ساعات شرعی

➲ *tosticker* `[reply]`
↭ تبدیل عکس به استیکر

➲ *tophoto* `[reply]`
↭ تبدیل استیکر‌به عکس

➲ *weather* `[city]`
↭ دریافت اب وهوا

➲ *Keepcalm* `[Name]` `[BackGround Color]` `[Text Color]` `[Crown Color]` `[Size]`
↭ `استیکر آروم باش`

➲ *Love First* `[Name]` `[Second Name]`
↭ `استیکر عشق` 

➲ *emoji* `[word]`
↭ `تبدیل متن به ایموجی`

➲ *ping*
↭ مطلع شدن از آنلاین بودن ربات

↫ موفق باشید ツ
            
↬ @RexCompany]]
end
return helpfun_en
end

if matches[1] == "راهنمای سرگرمی" and Clang then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not lang then
helpfun_fa = [[
✧ *Rex v1 Fun Help Commands:*

↜ *ساعت*
⇋ Get time in a sticker

↜ *لینک کوتاه* `[لینک]`
⇋ Make short url

↜ *صدا* `[متن]`
⇋ Convert text to voice

↜ *ترجمه* `[زبان] [کلمه]`

↜ *استیکر* `[متن]`
⇋ Convert text to sticker

↜ *به عکس* `[متن]`
⇋ Convert text to photo

↜ *ماشین حساب* `[معادله]`
⇋ Calculator

↜ *ساعات شرعی* `[شهر]`
⇋ Get Patent (Pray Time)

↜ *استیکر* `[ریپلی]`
⇋ Convert photo to sticker

↜ *عکس* `[ریپلی]`
⇋ Convert text to photo

↜ *اب و هوا* `[شهر]`
⇋ Get weather

↜ *انلاینی*
⇋ Be informed of the online being a robot.


↬ *Good luck ツ*
            
↬ @RexCompany ]]
else

helpfun_fa = [[
✧ *راهنمای فان ورژن یک رکس:*

↜ *ساعت*
↭ دریافت ساعت به صورت استیکر

↜ *لینک کوتاه* `[لینک]`
↭ کوتاه کننده لینک

↜ *صدا* `[متن]`
↭ تبدیل متن به صدا

↜ *ترجمه* `[زبان]` `[متن]`
↭ ترجمه متن فارسی به انگلیسی وبرعکس
_مثال:_
ترجمه en سلام

↜ *استیکر* `[متن]`
↭ تبدیل متن به استیکر

↜ *عکس* `[متن]`
↭ تبدیل متن به عکس

↜ *ماشین حساب* `[معادله]`
↭ ماشین حساب

↜ *ساعات شرعی* `[شهر]`
↭ اعلام ساعات شرعی

↜ *به استیکر* `[ریپلی]`
↭ تبدیل عکس به استیکر

↜ *عکس* `[ریپلی]`
↭ تبدیل استیکر‌به عکس

↜ *اب و هوا* `[شهر]`
↭ دریافت اب وهوا

↜ *انلاینی*
↭ مطلع شدن از آنلاین بودن ربات

            
↫ موفق باشید ツ
    
↬ @RexCompany]]
end
return helpfun_fa
end

end
--------------------------------
return {               
	patterns = {
      "^(funhelp)$",
        "^(creator)$",
    	"^(weather) (.*)$",
		"^(calc) (.*)$",
		"^(time)$",
		"^(tophoto)$",
		"^(tosticker)$",
		"^(voice) +(.*)$",
		"^([Pp]raytime) (.*)$",
		"^(praytime)$",
		"^([Tt]r) ([^%s]+) (.*)$",
		"^([Ss]hort) (.*)$",
		"^([Pp]hoto) (.+)$",
		"^(sticker) (.+)$",
        "^(راهنمای سرگرمی)$",
    	"^(اب و هوا) (.*)$",
		"^(ماشین حساب) (.*)$",
		"^(ساعت)$",
        "^(سازنده)$",
		"^(به عکس)$",
		"^(به استیکر)$",
		"^(صدا) +(.*)$",
		"^(ساعات شرعی) (.*)$",
		"^(ساعات شرعی)$",
		"^(ترجمه) ([^%s]+) (.*)$",
		"^(لینک کوتاه) (.*)$",
		"^(عکس) (.+)$",
		"^(استیکر) (.+)$"
		}, 
	run = run,
	}

--#Edited by @RexCompany :)
