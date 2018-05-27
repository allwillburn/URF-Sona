if GetObjectName(GetMyHero()) ~= "Jax" then return end

local JaxMenu = Menu("Jax", "Jax")

JaxMenu:SubMenu("Combo", "Combo")

JaxMenu.Combo:Boolean("Q", "Use Q in combo", true)
JaxMenu.Combo:Boolean("W", "Use W in combo", true)
JaxMenu.Combo:Boolean("E", "Use E in combo", true)
JaxMenu.Combo:Boolean("R", "Use R in combo", true)

JaxMenu:SubMenu("Misc", "Misc")
JaxMenu.Misc:Boolean("Level", "Auto level spells", true)
JaxMenu.Misc:Boolean("Ghost", "Auto Ghost", true)

OnTick(function (myHero)

	local target = GetCurrentTarget()

	--AUTO LEVEL UP
	if JaxMenu.Misc.Level:Value() then

			spellorder = {_Q, _W, _E, _Q, _W, _R, _Q, _W, _W, _Q, _R, _Q, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				LevelSpell(spellorder[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
			end

	end

	--COMBO
	if IOW:Mode() == "Combo" then

		if JaxMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, 700) then
			CastTargetSpell(target, _Q)
		end

		if JaxMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, 700) then
			CastSpell(_W)
		end

		if JaxMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target, 700) then
			CastSpell(_E)
		end

		if JaxMenu.Combo.R:Value() and Ready(_R) and ValidTarget(target, 700) then
			CastSpell(_R)
		end

	end

       

	--AUTO IGNITE
	if JaxMenu.Misc.Ghost:Value() then

		if GetCastName(myHero, SUMMONER_1) == "SummonerHaste" and Ready(SUMMONER_1) then
			CastSpell(SUMMONER_1)
		elseif GetCastName(myHero, SUMMONER_2) == "SummonerHaste" and Ready(SUMMONER_2) then
			CastSpell(Summoner_2)
		end

	end

end)
