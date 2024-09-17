local accountBalanceStrings = {
	{ requiredBalance = 100 * 10 ^ 6, text = "I think you must be one of the richest inhabitants in the world!" },
	{ requiredBalance = 100 * 10 ^ 6, text = "You have made ten millions and it still grows!" },
	{ requiredBalance = 100 * 10 ^ 6, text = "Wow, you have reached the magic number of a million gp!!!" },
	{ requiredBalance = 100 * 10 ^ 6, text = "You certainly have made a pretty penny." },
}

return {
	["ACCOUNT_BALANCE"] = function(context)
		local balance = Bank.balance(context.player)
		local balanceString = ""
		for _, data in pairs(accountBalanceStrings) do
			if balance >= data.requiredBalance then
				balanceString = data.text
				break
			end
		end
		balanceString = balanceString .. T(" Your account balance is :balance: gold.", { balance = balance })
	end,
	["CONFIRM_DEPOSIT"] = function(context)
		local amount = context.amount
		if context.amount == "all" then
			amount = context.player:getMoney()
		end
		return T("Would you really like to deposit :amount: gold?", { amount = amount })
	end,
	["DEPOSIT_OK"] = function(context)
		local gold = tonumber(MessageDataRegistry():Player(context.player):Last().msg)
		return T(
			"Alright, we have added the amount of :gold: gold to your {balance}. You can{withdraw} your money anytime you want to.",
			{ gold = gold }
		)
	end,
	["You do not have enough gold."] = "You do not have enough gold.",
}
