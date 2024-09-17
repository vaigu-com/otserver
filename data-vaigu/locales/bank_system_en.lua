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
		return balanceString
	end,
	["DECLARE_DEPOSIT_AMOUNT"] = "Please tell me how much gold it is you would like to deposit.",
	["DECLARE_WITHDRAW_AMOUNT"] = "Please tell me how much gold you would like to withdraw.",
	["DECLARE_TRANSFER_AMOUNT"] = "Please tell me the amount of gold you would like to transfer.",
	["DECLARE_TRANSFER_RECIPIENT"] = function(context)
		local amount = PlayerCustomDialogDataRegistry():Get(context.player).amount
		return T("Who would you like transfer :amount: gold to?", { amount = amount })
	end,

	["CONFIRM_DEPOSIT"] = function(context)
		local amount = context.amount
		if context.amount == "all" then
			amount = context.player:getMoney()
		end
		return T("Would you really like to deposit :amount: gold?", { amount = amount })
	end,
	["CONFIRM_WITHDRAW"] = function(context)
		local amount = PlayerCustomDialogDataRegistry():Get(context.player).amount
		return T("Are you sure you wish to withdraw :amount: gold from your bank account?", { amount = amount })
	end,
	["CONFIRM_TRANSFER"] = function(context)
		local amount = PlayerCustomDialogDataRegistry():Get(context.player).amount
		local recipient = PlayerCustomDialogDataRegistry():Get(context.player).recipient
		return T("So you would like to transfer :amount: gold to :recipient:?", { amount = amount, recipient = recipient })
	end,

	["DEPOSIT_OK"] = function(context)
		local amount = PlayerCustomDialogDataRegistry():Get(context.player).amount
		return T("Alright, we have added the amount of :amount: gold to your {balance}. You can {withdraw} your money anytime you want to.", { amount = amount })
	end,
	["WITHDRAW_OK"] = function(context)
		local amount = PlayerCustomDialogDataRegistry():Get(context.player).amount
		return T("Here you are, :amount: gold. Please let me know if there is something else I can do for you.", { amount = amount })
	end,
	["TRANSFER_OK"] = function(context)
		local amount = PlayerCustomDialogDataRegistry():Get(context.player).amount
		local recipient = PlayerCustomDialogDataRegistry():Get(context.player).recipient
		return T("Very well. You have transferred :amount: gold to :recipient.", { amount = amount, recipient = recipient })
	end,

	["You do not have enough gold."] = "You do not have enough gold.",

	["DEPOSIT_CANCEL"] = "As you wish. Is there something else I can do for you?",
	["WITHDRAW_CANCEL"] = "The customer is king! Come back anytime you want to if you wish to {withdraw} your money.",
	["TRANSFER_CANCEL"] = "Alright, is there something else I can do for you?",
}
