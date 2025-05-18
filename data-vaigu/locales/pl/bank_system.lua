local accountBalanceStrings = {
	{ requiredBalance = 10 ^ 9, text = "Jestes jednym z naszych najbogatszych klientow." },
	{ requiredBalance = 10 ^ 8, text = "Do biednych nie nalezysz.." },
	{ requiredBalance = 10 ^ 7, text = "Udalo ci sie zebrac milion sztuk zlota!" },
	{ requiredBalance = 10 ^ 6, text = "Uzbierales troche groszy." },
}

return {
	["You can {deposit}, {withdraw} and {transfer} your money here. If you need to monitor your finances, ask be for {balance}."] = "Mozesz tu wplacic ({deposit}), wyplacic ({withdraw}) i przelac ({transfer}) swoje pieniadze. Jesli chcesz przejrzec swoje finanse, zapytaj mnie o stan konta ({balance}).",

	["ACCOUNT_BALANCE"] = function(context)
		local balance = Bank.balance(context.player)
		local balanceString = ""
		for _, data in pairs(accountBalanceStrings) do
			if balance >= data.requiredBalance then
				balanceString = data.text
				break
			end
		end
		balanceString = balanceString .. T(" Twoj stan konta to :balance: sztuk zlota.", { balance = balance })
		return balanceString
	end,
	["DECLARE_DEPOSIT_AMOUNT"] = "Ile sztuk zlota chcialbys wplacic?",
	["DECLARE_WITHDRAW_AMOUNT"] = "Ile sztuk zlota chcialbys wyplacic?",
	["DECLARE_TRANSFER_AMOUNT"] = "Ile sztuk zlota chcialbys przelac?",
	["DECLARE_TRANSFER_RECIPIENT"] = function(context)
		local amount = PlayerCustomDialogDataRegistry:Get(context.player).amount
		return T("Do kogo chcialbys przelac :amount: sztuk zlota?", { amount = amount })
	end,

	["CONFIRM_DEPOSIT"] = function(context)
		local amount = context.amount
		if context.amount == "all" then
			amount = context.player:getMoney()
		end
		return T("Czy jestes pewien, ze chcesz wplacic :amount: sztuk zlota?", { amount = amount })
	end,
	["CONFIRM_WITHDRAW"] = function(context)
		local amount = PlayerCustomDialogDataRegistry:Get(context.player).amount
		return T("Czy jestes pewien, ze chcesz wyplacic :amount: sztuk zlota ze swojego konta?", { amount = amount })
	end,
	["CONFIRM_TRANSFER"] = function(context)
		local amount = PlayerCustomDialogDataRegistry:Get(context.player).amount
		local recipient = PlayerCustomDialogDataRegistry:Get(context.player).recipient
		return T("Czy na pewno chcesz przelac :amount: sztuk zlota do :recipient:?", { amount = amount, recipient = recipient })
	end,

	["DEPOSIT_OK"] = function(context)
		local amount = PlayerCustomDialogDataRegistry:Get(context.player).amount
		return T("W porzadku. Na twoj rachunek wplynelo :amount: sztuk zlota. Mozesz je wywplacic w dowolnym momencie.", { amount = amount })
	end,
	["WITHDRAW_OK"] = function(context)
		local amount = PlayerCustomDialogDataRegistry:Get(context.player).amount
		return T("Prosze oto, :amount: zlota. Czy moge cos jeszcze dla ciebie zrobic?", { amount = amount })
	end,
	["TRANSFER_OK"] = function(context)
		local amount = PlayerCustomDialogDataRegistry:Get(context.player).amount
		local recipient = PlayerCustomDialogDataRegistry:Get(context.player).recipient
		return T("W porzadku. Przelalismy :amount: sztuk zlota do :recipient.", { amount = amount, recipient = recipient })
	end,

	["You do not have enough gold."] = "Nie masz tyle zlota",

	["DEPOSIT_CANCEL"] = "Jasne. Czy cos jeszcze moge dla ciebie zrobic?",
	["WITHDRAW_CANCEL"] = "Klient nasz Pan! Wroc, gdy bedziesz chcial wyplacic swoje zloto.",
	["TRANSFER_CANCEL"] = "W porzadku. Czy jest cos jeszce co moge dla ciebie zrobic?",
}
