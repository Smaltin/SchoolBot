import os

import discord
from dotenv import load_dotenv
from icalevents.icalevents import events
from discord.ext import commands
bot = commands.Bot(command_prefix='s!')
load_dotenv()
TOKEN = os.getenv('DISCORD_TOKEN')
es  = events("https://calendar.google.com/calendar/ical/tmrfv98l1ptl89p7hcqu0uhksc%40group.calendar.google.com/private-b682d26b2bf2f1072b9e7ff1734ff934/basic.ics")

@bot.event
async def on_ready():
    print(f'{bot.user}')

@bot.command(name='sendtest', help='Just a test command.')
async def test(ctx):
    await ctx.send('Testing.')

@bot.command(name='ban', help='Banhammer\'d.')
@commands.has_any_role("Kars, Supreme Being","Wamuu")
async def ban (ctx, member:discord.User=None, reason=None):
    await ctx.guild.ban(member, reason=reason)
    await ctx.send('We have won.')

bot.run(TOKEN)
