--this is gonna be really shit, I haven't programmed in what feels like an eternity even though it was only 4 days.
local discordia = require('discordia')
local client = discordia.Client()
local prefix = "!"
local NotificationChannelId = "746454515045105744"
local MessageId = "746578059443830816"
local NotificationChannelId2 = "746810941009559643"
local MessageId2 = "746850552511594526"
local clock = discordia.Clock()
clock:start()

client:on('ready', function()
	print('Logged in as '.. client.user.username..'#'..client.user.discriminator)
  client:setGame("Booting up...")
  local Channel = client:getChannel(NotificationChannelId)
  local Channel2 = client:getChannel(NotificationChannelId2)
  if Channel then
    local EditMe = Channel:getMessage(MessageId)
    if EditMe then
      EditMe:setContent("Booting up...")
    end
  end
  if Channel2 then
    local EditMe = Channel2:getMessage(MessageId2)
    if EditMe then
      EditMe:setContent("Booting up...")
    end
  end
end)

client:on('messageCreate', function(message)
  if message.author.id == "97122523086340096" then
    if message.content == '!shutdown' then
      client:setGame("Shutting down...")
      local Channel = client:getChannel(NotificationChannelId)
      if Channel then
        local EditMe = Channel:getMessage(MessageId)
        if EditMe then
          EditMe:setContent("Bot Offline")
        end
      end
      local Channel2 = client:getChannel(NotificationChannelId2)
      if Channel2 then
        local EditMe = Channel2:getMessage(MessageId2)
        if EditMe then
          EditMe:setContent("Bot Offline")
        end
      end
      message:delete()
      os.exit()
    elseif message.content:sub(1, #prefix+4) == prefix.."say " then
      message.channel:send(message.content:sub(#prefix+5))
      message:delete()
    end
  end
end)

function pingEveryone()
end

function getNextPeriodTime()
  local dateinfo = os.date('*t')
  local wday = dateinfo.wday
  local minutespassed = (dateinfo.hour * 60) + dateinfo.min
  if wday == 2 then
    if minutespassed < 517 then --8:37 (Period 1)
      return 517
    elseif minutespassed < 568 then --9:28 (Passing)
      return 568
    elseif minutespassed < 578 then --9:38 (Period 2)
      return 578
    elseif minutespassed < 624 then --10:24 (Break + Passing)
      return 624
    elseif minutespassed < 639 then --10:39 (Period 3)
      return 639
    elseif minutespassed < 685 then --11:25 (Passing)
      return 685
    elseif minutespassed < 695 then --11:35 (Period 4)
      return 695
    elseif minutespassed < 741 then --12:21 (Lunch)
      return 741
    elseif minutespassed < 773 then --12:53 (Passing)
      return 773
    elseif minutespassed < 783 then -- 1:03 (Period 5)
      return 783
    elseif minutespassed < 829 then -- 1:49 (Passing)
      return 829
    elseif minutespassed < 839 then -- 1:59 (Period 6)
      return 839
    elseif minutespassed < 885 then -- 2:45 (After School)
      return 885
    else
      return 1915 -- 24:00 (1440) + 7:55 (475)
    end
  elseif wday == 3 or wday == 4 or wday == 5 or wday == 6 then
    if minutespassed < 475 then --7:55 (Period 1/2)
      return 475
    elseif minutespassed < 579 then --9:39 (Passing)
      return 579
    elseif minutespassed < 589 then --9:49 (Tutorial)
      return 589
    elseif minutespassed < 620 then --10:20 (Break + Passing)
      return 620
    elseif minutespassed < 620 then --10:20 (Break + Passing)
      return 620
    elseif minutespassed < 635 then --10:35 (Period 3/4)
      return 635
    elseif minutespassed < 739 then --12:19 (Lunch)
      return 739
    elseif minutespassed < 771 then --12:51 (Passing)
      return 771
    elseif minutespassed < 781 then --1:01 (Period 5/6)
      return 781
    elseif minutespassed < 885 then --2:45 (After School)
      return 885
    elseif minutespassed >= 885 and wday ~= 6 then
      return 1915 ----Day (1440) + Next Day @ 7:55 (475)
    else
      return 4837 --Friday (144) + Saturday (1440) + Sunday (1440) + Monday @ 8:37 (517)
    end
  elseif wday == 7 then
    return 3397 --Saturday (1440) + Sunday (1440) + Monday @ 8:37 (517)
  else
    return 1957 --Sunday (1440) + Monday @ 8:37 (517)
  end
end

function timeuntilclass()
  local dateinfo = os.date('*t')
  --local minutespassed = ((dateinfo.hour * 60) + dateinfo.min) --actually seconds passed
  local secondsOfNextPeriod = getNextPeriodTime() * 60
  local secondsPassed = (((dateinfo.hour * 60) + dateinfo.min) * 60) + dateinfo.sec
  local seconds =  secondsOfNextPeriod - secondsPassed
  if seconds <= 0 then
    return "00:00:00";
  else
    hours = string.format("%02.f", math.floor(seconds/3600));
    mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
    secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
    return hours..":"..mins..":"..secs
  end
end

function invalidDay()
  local dateinfo = os.date('*t')
  local yearday = dateinfo.yday
  local blacklisteddays = {251, 307, 314, 316, 328, 329, 330, 331, 332, 350, 351, 352}
  for _,v in pairs(blacklisteddays) do
    if v == yearday then
      return true
    end
  end
  return false
end

clock:on('sec', function(d)
  if not invalidDay() then
    print('time until next: '..timeuntilclass())
    if d.sec % 5 == 0 then
      client:setGame(timeuntilclass())
    end
    if d.sec % 2 == 0 then
      local Channel = client:getChannel(NotificationChannelId)
      local Channel2 = client:getChannel(NotificationChannelId2)
      if Channel then
        local EditMe = Channel:getMessage(MessageId)
        if EditMe then
          EditMe:setContent("Time until next period/break: "..timeuntilclass())
        end
      end
      if Channel2 then
        local EditMe = Channel2:getMessage(MessageId2)
        if EditMe then
          EditMe:setContent("Time until next period/break: "..timeuntilclass())
        end
      end
    end
  else
    client:setGame("Blacklisted Date")
  end
end)

client:run('Bot NzQ2NDg2NjQ5MzE1MTMxNTI0.X0BB3g.8Dmm1pH-RNu0Ge_QbuEl9kBMopI')
