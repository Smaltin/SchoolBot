--this is gonna be really shit, I haven't programmed in what feels like an eternity even though it was only 4 days.
local discordia = require('discordia')
local client = discordia.Client()
local prefix = "!"
local clock = discordia.Clock()
clock:start()

client:on('ready', function()
	print('Logged in as '.. client.user.username..'#'..client.user.discriminator)
  client:setGame("Booting up...")
end)

client:on('messageCreate', function(message)
  if message.author.id == "97122523086340096" then
    if message.content == '!shutdown' then
      client:setGame("Shutting down...")
      message:delete()
      os.exit()
    elseif message.content:sub(1, #prefix+4) == prefix.."say " then
      message.channel:send(message.content:sub(#prefix+5))
      message:delete()
    end
  end
end)

client:run('Bot NzQ2NDg2NjQ5MzE1MTMxNTI0.X0BB3g.8Dmm1pH-RNu0Ge_QbuEl9kBMopI')
