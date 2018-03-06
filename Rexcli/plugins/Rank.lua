do

local function run(msg, matches)
if matches[1]=="مقام" and is_sudo(msg) or matches[1]=="rank" or matches[1]=="Rank" and is_sudo(msg) then  
return  "●● شما صاحب ربات میباشید 😐🖤"
elseif matches[1]=="مقام من" and is_admin(msg) or matches[1]=="rank" or matches[1]=="Rank" and is_admin(msg) then 
return  "●● شما ادمین ربات میباشید 😐🖤"
elseif matches[1]=="مقام من" and is_owner(msg) or matches[1]=="rank" or matches[1]=="Rank" and is_owner(msg) then 
return  "●● شما صاحب گروه میباشید 😐🖤"
elseif matches[1]=="مقام من" and is_mod(msg) or matches[1]=="rank" or matches[1]=="Rank" and is_mod(msg) then 
return  "●● شما مدیر گروه میباشید 😐🖤"
else
return  "●● شما هیچ عنی نیستید 😐🖤"
end

end

return {
  patterns = {
    "^[!/#]([Rr]ank)$",
    "^([Rr]ank)$",
    "^(مقام)$",
    },
  run = run
}
end