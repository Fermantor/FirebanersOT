local healDelay = 7000
local healAmount = 300000
local healPercentStart = 12.5
local condition = Condition(CONDITION_REGENERATION, CONDITIONID_DEFAULT)
condition:setParameter(CONDITION_PARAM_SUBID, 88888)
condition:setParameter(CONDITION_PARAM_TICKS, healDelay)
condition:setParameter(CONDITION_PARAM_HEALTHGAIN, 0.01)
condition:setParameter(CONDITION_PARAM_HEALTHTICKS, healDelay)

local gazHaragothHeal = CreatureEvent("gazHaragothHeal")
function gazHaragothHeal.onThink(creature)
	local hp = (creature:getHealth()/creature:getMaxHealth())*100
	if (hp < healPercentStart and not creature:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT, 88888)) then
		creature:addCondition(condition)
		creature:say("Gaz'haragoth begins to draw on the nightmares to HEAL himself!", TALKTYPE_ORANGE_2)
		addEvent(function(cid)
			local creature = Creature(cid)
			if not creature then
				return
			end
			doTargetCombatHealth(0, creature, COMBAT_HEALING, healAmount, healAmount, CONST_ME_MAGIC_BLUE)
			creature:say("Gaz'haragoth HEALS himself!", TALKTYPE_ORANGE_2)
			return true
		end, healDelay, creature:getId())
	end
end
gazHaragothHeal:register()
