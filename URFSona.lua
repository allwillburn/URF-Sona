if GetObjectName(GetMyHero()) ~= "Sona" then return end

local SonaMenu = Menu("Sona", "Sona")

SonaMenu:SubMenu("Combo", "Combo")

SonaMenu.Combo:Boolean("Q", "Use Q in combo", true)
SonaMenu.Combo:Boolean("W", "Use W in combo", true)
SonaMenu.Combo:Boolean("E", "Use E in combo", true)
SonaMenu.Combo:Boolean("R", "Use R in combo", true)

SonaMenu:SubMenu("Misc", "Misc")
SonaMenu.Misc:Boolean("Level", "Auto level spells", true)
SonaMenu.Misc:Boolean("Ghost", "Auto Ghost", true)
SonaMenu.Misc:Boolean("QWE", "Auto QWE", true)

OnTick(function (myHero)

	local target = GetCurrentTarget()

	--AUTO LEVEL UP
	if SonaMenu.Misc.Level:Value() then

			spellorder = {_Q, _W, _E, _Q, _W, _R, _Q, _W, _W, _Q, _R, _Q, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				LevelSpell(spellorder[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
			end

	end

	--COMBO
	if IOW:Mode() == "Combo" then

		if SonaMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, 850) then
			CastSpell(_Q)
		end

		if SonaMenu.Combo.W:Value() and Ready(_W) then
			CastSpell(_W)
		end

		if SonaMenu.Combo.E:Value() and Ready(_E) then
			CastSpell(_E)
		end

		if SonaMenu.Combo.R:Value() and Ready(_R) and ValidTarget(target, 900) then
			CastSkillShot(_R, target)
		end

	end

        --AUTO QWE
        if SonaMenu.Misc.QWE:Value() then        

                if Ready(_E) then
		        CastSpell(_E)
                end

                if Ready(_Q) then
	  	        CastSpell(_Q)
                end

	        if Ready(_W) then
		        CastSpell(_W)
	        end

        end

	--AUTO IGNITE
	if SonaMenu.Misc.Ghost:Value() then

		if GetCastName(myHero, SUMMONER_1) == "SummonerHaste" and Ready(SUMMONER_1) then
			CastSpell(SUMMONER_1)
		elseif GetCastName(myHero, SUMMONER_2) == "SummonerHaste" and Ready(SUMMONER_2) then
			CastSpell(Summoner_2)
		end

	end

end)
