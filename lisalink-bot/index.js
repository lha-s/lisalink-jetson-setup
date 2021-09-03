const TelegramBot = require('node-telegram-bot-api');
const ip = require("ip")
//const token = "1845492305:AAHpAeqKBwlt0hLfq6FFCjy2bcWsnphfsvg"
const token = "1837648452:AAGm0YWTX4T7Gz1Mg98k-uNcn49KzJG_cL0"
const bot = new TelegramBot(token, {polling: true});
const UserVar = process.env.HOME || "";
const User = UserVar.substring(6);

bot.on('message', (msg) => {
	const chatId = msg.chat.id;

	const text = msg.text;

	console.log(text)

	if (text.toLowerCase() == User || text.toLowerCase() == "all") {
		bot.sendMessage(chatId, User + ' : ' + ip.address());
		return ;
	}
	else
		bot.sendMessage(chatId, 'Invalid jetson name!');
});
