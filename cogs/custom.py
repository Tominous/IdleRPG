"""
The IdleRPG Discord Bot
Copyright (C) 2018-2019 Diniboy and Gelbpunkt

This software is dual-licensed under the GNU Affero General Public License for non-commercial and the Travitia License for commercial use.
For more information, see README.md and LICENSE.md.
"""
import discord
from discord.ext import commands


def is_ken():
    def predicate(ctx):
        return ctx.author.id == 318_824_057_158_107_137

    return commands.check(predicate)


class Custom(commands.Cog):
    def __init__(self, bot):
        self.bot = bot

    @commands.command(hidden=True)
    async def onetruechild(self, ctx):
        """In loving memory of Mary Johanna, ex-developer."""
        await ctx.send("His name is `#no homo` :heart:")

    @is_ken()
    @commands.command(hidden=True)
    async def ken(self, ctx, user: discord.Member):
        """[Ken only] Hug someone."""
        em = discord.Embed(
            title="Ken Hug!",
            description=f"{ctx.author.mention} hugged {user.mention}! Awww!",
        )
        em.set_image(
            url="https://cdn.discordapp.com/attachments/515954333368713235/518539871665520641/image0.gif"  # noqa
        )
        await ctx.send(embed=em)


def setup(bot):
    bot.add_cog(Custom(bot))
