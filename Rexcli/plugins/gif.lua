local function run(msg, matches)
 if matches[1] == "gif"or matches[1] =="گیف" and is_sudo(msg) then 
local modes = {
              "memories-anim-logo",
              "alien-glow-anim-logo",
              "flash-anim-logo",
              "flaming-logo",
              "whirl-anim-logo",
              "highlight-anim-logo",
              "burn-in-anim-logo",
              "shake-anim-logo",
              "inner-fire-anim-logo",
              "jump-anim-logo"
            }
            local text = URL.escape(matches[2])
            local url2 = "http://www.flamingtext.com/net-fu/image_output.cgi?_comBuyRedirect=false&script=" .. modes[math.random(#modes)] .. "&text=" .. text .. "&symbol_tagname=popular&fontsize=70&fontname=futura_poster&fontname_tagname=cool&textBorder=15&growSize=0&antialias=on&hinting=on&justify=2&letterSpacing=0&lineSpacing=0&textSlant=0&textVerticalSlant=0&textAngle=0&textOutline=off&textOutline=false&textOutlineSize=2&textColor=%230000CC&angle=0&blueFlame=on&blueFlame=false&framerate=75&frames=5&pframes=5&oframes=4&distance=2&transparent=off&transparent=false&extAnim=gif&animLoop=on&animLoop=false&defaultFrameRate=75&doScale=off&scaleWidth=240&scaleHeight=120&&_=1469943010141"
  local title , res = http.request(url2) 
  local jdat = json:decode(title) 
  local gif = jdat.src 
  local file = download_to_file(gif,'t2g.gif') 
     tdbot.sendDocument(msg.to.id, file, msg_caption, nil, msg.id, 0, 1, nil, dl_cb, nil)
	end
end 
return { 
patterns = { 

   "^(gif) (.*)$", 
"^(گیف) (.*)$", 
 }, 
run = run, 
} 
