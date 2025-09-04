function Monster:handleCobraOnSpawn()
	if Game.getStorageValueByKey(Global.Storage.CobraFlask) >= os.time() then
		self:setHealth(self:getMaxHealth() * 0.75)
		self:getPosition():sendMagicEffect(CONST_ME_GREEN_RINGS)
	else
		Game.setStorageValueByKey(Global.Storage.CobraFlask, -1)
	end
end
