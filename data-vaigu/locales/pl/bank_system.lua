return {
	["YOU_ARE_WITHDRAWING_AMOUNT"] = function(context)
		return T("You are withdrawing :amount: money, are you sure?", { amount = context.amount })
	end,
}
