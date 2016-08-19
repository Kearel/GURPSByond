/proc/generate_character_sheet(var/list/data, var/modification_level = 0)
	. = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\
	<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"\
	    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\
	<!--\
	***** BEGIN LICENSE BLOCK *****\
	Copyright (c) 1998-2016 by Richard A. Wilkes. All rights reserved.\
	This Source Code Form is subject to the terms of the Mozilla Public License,\
	version 2.0. If a copy of the MPL was not distributed with this file, You\
	can obtain one at http://mozilla.org/MPL/2.0/.\
	This Source Code Form is \"Incompatible With Secondary Licenses\", as defined\
	by the Mozilla Public License, version 2.0.\
	***** END LICENSE BLOCK *****\
	-->\
	<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\">\
	    <head>\
	        <meta http-equiv=\"content-type\" content=\"text/html; charset=utf-8\" />\
	        <title>[data["name"]]</title>\
	        <style type=\"text/css\" title=\"text/css\">\
	             /* <!\[CDATA\[ */\
	             body\
	             {\
	                 color: black;\
	                 background-color: white;\
	                 font: normal 7pt/9pt 'Lucida Sans','Arial',sans-serif;\
	                 margin: 4pt;\
	             }\
	             table, tbody, tr, td\
	             {\
	                 margin: 0;\
	                 border-spacing: 0;\
	                 border-collapse: collapse;\
	                 font: normal 7pt/9pt 'Lucida Sans', 'Arial',sans-serif;\
	             }\
	             table, tbody, tr { padding: 0; }\
	             td\
	             {\
	                 padding: 1pt 1pt 0 1pt;\
	                 verticle-align: top;\
	                 white-space: nowrap;\
	             }\
	             .note\
	             {\
	                 font: normal 6pt/8pt 'Lucida Sans', 'Arial',sans-serif;\
	                 color: gray;\
	                 display: block-inline;\
	                 white-space: normal;\
	             }\
	             .secondary { display: block; }\
	             .top_info { margin: 0; }\
	             .list, .info { margin: 2pt 0 0 0; }\
	             .list, .info, .top_info\
	             {\
	                 width: 100%;\
	                 border: 1pt solid black;\
	             }\
	             #advantages { width: 270pt; }\
	             #skills {width: 269pts; }\
	             #spells, #melee_weapons, #ranged_peaons, #equipment, #notes, #copyright {width: 540pt; }\
	             .list td { border: 1pt solid black; }\
	             .odd { background-color: #FFF; }\
	             .even {background-color: #E8FFE8; }\
	             #encumberance_move_dodge td, #hit_location td, #description td.label { border-left: 1pt solid black; }\
	             #copyright {\
	                 color: gray;\
	                 font: italic 7pt/9pt 'Lucida Sans', 'Arial',sans-serif;\
	                 text-align: center;\
	                 white-space: normal;\
	                 margin: 4pt;\
	             }\
	             .top_border  { border-top: 1pt solid black; }\
	             .title\
	             {\
	                 border: 1pt solid black;\
	                 background-color: silver;\
	                 color: black;\
	                 text-align: center;\
	             }\
	             .description, .value, .rvalue, .natrual_damage { width: 100%; }\
	             .quantity, .cost, .weight, .cost_summary, .weight_summar, .ref, .level, .accuracy, .damage, .range, .rof, .shots, .bulk, .recoil, .strength, .block, .reach, .points, .spell_level, .relative_spell_level, .skill_level, .relative_skill_level, .rvalue { text-align: right; }\
	             .state, .parry, .natural_damage { text-align: center; }\
	             .wrapper\
	             {\
	                 width: 540pt;\
	                 border: none;\
	             }\
	             .wrapper > tbody > tr > td { padding: 0; }\
	             .spacer { width: 2pt; }\
	             .rowspacer1 { padding: 1pt 0 0 0; }\
	             .rowspacer2 { padding: 2pt 0 0 0; }\
	             .rowspacer3 { padding: 3pt 0 0 0; }\
	             .rowspacer4 { padding: 4pt 0 0 0; }\
	             .rowspacer5 { padding: 5pt 0 0 0; }\
	             .clabel { text-align: center; }\
	             .label { text-align: right; }\
	             .label, .clabel\
	             {\
	                 color: gray;\
	                 background-color: inherit;\
	             }\
	             .encumbrance\
	             {\
	                 background-color: #FCF2C4;\
	                 color: inherit;\
	             }\
	             #portrait\
	             {\
	                 width: 60pt;\
	                 height: 80pt;\
	             }\
	             td.portrait { width: 60pt; }\
	             td.portrait_cell\
	             {\
	                 padding: 0;\
	                 background-color: black;\
	             }\
	             /*]]> */\
	</style>\
	    </head>\
	    <body>\
	        <table class=\"wrapper\">\
	            <tr>\
	                <td class=\"portrait\" rowspan=\"2\"2>\
	                    <table class=\"top_info\">\
	                        <tr>\
	                            <td class=\"title\">Portrait</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"portrait_cell\"><img id=\"portrait\" src=\"[data["portrait"]].png\" alt=\"Portrait\"</td>\
	                        </tr>\
	                    </table>\
	                </td>\
	                <td class=\"spacer\" rowspan=\"2\"2></td>\
	                <td>\
	                     <table id=\"identity\" class=\"top_info\">\
	                         <tr>\
	                             <td class=\"title\" colspan=\"2\">Identity</td>\
	                         </tr>\
	                         <tr>\
	                             <td class=\"label\">Name:</td>\
	                             <td class=\"value\">[data["name"]]</td>\
	                         </tr>\
	                         <tr>\
	                             <td class=\"label\">Title:</td>\
	                             <td class=\"value\">[data["title"]]</td>\
	                         </tr>\
	                         <tr>\
	                             <td class=\"label\">Religion:</td>\
	                             <td class=\"value\">[data["religion"]]</td>\
	                         </tr>\
	                     </table>\
	                </td>\
	                <td class=\"spacer\"></td>\
	                <td>\
	                    <table id=\"player_info\" class=\"top_info\">\
	                        <tr>\
	                            <td class=\"title\" colspan=\"2\">Player Information</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Player:</td>\
	                            <td class=\"value\">[data["player"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Campaign:</td>\
	                            <td class=\"value\">[data["campaign"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Created On:</td>\
	                            <td class=\"value\">[data["creation_date"]]</td>\
	                        </tr>\
	                    </table>\
	                </td>\
	                <td class=\"spacer\" rowspan=\"2\"></td>\
	                <td rowspan=\"2\">\
	                    <table id=\"points\" class=\"top_info\">\
	                        <tr>\
	                            <td class=\"title\" colspan=\"2\">[data["total_points"]] Points</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Attributes:</td>\
	                            <td class=\"rvalue\">[data["attribute_points"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Advantages:</td>\
	                            <td class=\"rvalue\">[data["advantage_points"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Disadvantages:</td>\
	                            <td class=\"rvalue\">[data["disadvantage_points"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Quirks:</td>\
	                            <td class=\"rvalue\">[data["quirk_points"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Skills:</td>\
	                            <td class=\"rvalue\">[data["skill_points"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Spells:</td>\
	                            <td class=\"rvalue\">[data["spell_points"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Race:</td>\
	                            <td class=\"rvalue\">[data["race_points"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"rowspacer2\" colspan=\"2\"></td>\
	                        </tr>\
	                        <tr class=\"top_border\">\
	                            <td class=\"rowspacer1\" colspan=\"2\"></td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Earned:</td>\
	                            <td class=\"rvalue\">[data["points"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"rowspacer1\" colspan=\"2\"></td>\
	                        </tr>\
	                    </table>\
	                </td>\
	            </tr>\
	            <tr>\
	                <td colspan=\"3\">\
	                    <table id=\"description\" class=\"info\">\
	                        <tr>\
	                            <td class=\"title\" colspan=\"6\">Description</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Race:</td>\
	                            <td class=\"value\">[data["race"]]</td>\
	                            <td class=\"label\">Height:</td>\
	                            <td class=\"value\">[data["height"]]</td>\
	                            <td class=\"label\">Hair:</td>\
	                            <td class=\"value\">[data["hair"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Gender:</td>\
	                            <td class=\"value\">[data["gender"]]</td>\
	                            <td class=\"label\">Weight:</td>\
	                            <td class=\"value\">[data["weight"]]</td>\
	                            <td class=\"label\">Eyes:</td>\
	                            <td class=\"value\">[data["eyes"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Age:</td>\
	                            <td class=\"value\">[data["age"]]</td>\
	                            <td class=\"label\">Size:</td>\
	                            <td class=\"value\">[data["size"]]</td>\
	                            <td class=\"label\">Skin:</td>\
	                            <td class=\"value\">[data["skin"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Birthday:</td>\
	                            <td class=\"value\">[data["birthday"]]</td>\
	                            <td class=\"label\">TL:</td>\
	                            <td class=\"value\">[data["TL"]]</td>\
	                            <td class=\"label\">Hand:</td>\
	                            <td class=\"value\">[data["hand"]]</td>\
	                        </tr>\
	                    </table>\
	                </td>\
	            </tr>\
	        </table>\
	        <table class=\"wrapper\">\
	            <tr>\
	                <td rowspan=\"2\">\
	                    <table id=\"attributes\" class=\"info\">\
	                        <tr>\
	                            <td class=\"title\" colspan=\"2\">Attributes</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Strength (ST):</td>\
	                            <td class=\"rvalue\">[data["Strength"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Dexterity (DX):</td>\
	                            <td class=\"rvalue\">[data["Dexterity"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Intelligence (IQ):</td>\
	                            <td class=\"rvalue\">[data["Intelligence"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Health (HT):</td>\
	                            <td class=\"rvalue\">[data["Health"]]</td>\
	                        </tr>\
	                        <tr class=\"top_border\">\
	                            <td class=\"label\">Will:</td>\
	                            <td class=\"rvalue\">[data["Will"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Fright Check:</td>\
	                            <td class=\"rvalue\">[data["Fright"]]</td>\
	                        </tr>\
	                        <tr class=\"top_border\">\
	                            <td class=\"label\">Basic Speed:</td>\
	                            <td class=\"rvalue\">[data["Basic Speed"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Basic Move:</td>\
	                            <td class=\"rvalue\">[data["Basic Move"]]</td>\
	                        </tr>\
	                        <tr class=\"top_border\">\
	                            <td class=\"label\">Perception:</td>\
	                            <td class=\"rvalue\">[data["Perception"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Vision:</td>\
	                            <td class=\"rvalue\">[data["Vision"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Hearing:</td>\
	                            <td class=\"rvalue\">[data["Hearing"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Taste &amp; Smell:</td>\
	                            <td class=\"rvalue\">[data["Taste Smell"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Touch:</td>\
	                            <td class=\"rvalue\">[data["Touch"]]</td>\
	                        </tr>\
	                        <tr class=\"top_border\">\
	                            <td class=\"natural_damage\" colspan=\"2\"><span class=\"label\">thr: </span>[data["thrust_dice"]]<span class=\"label\">, sw: </span>[data["swing_dice"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"rowspacer2\" colspan=\"2\"></td>\
	                        </tr>\
	                    </table>\
	                </td>\
	                <td class=\"spacer\" rowspan=\"2\"></td>\
	                <td>\
	                    <table id=\"encumbrance_move_dodge\" class=\"info\">\
	                        <tr>\
	                            <td class=\"title\" colspan=\"4\">Encumbrance, Move &amp; Dodge</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"title\">Level</td>\
	                            <td class=\"title\">Max Load</td>\
	                            <td class=\"title\">Move</td>\
	                            <td class=\"title\">Dodge</td>\
	                        </tr>"
	for(var/i in 0 to 4)
		. +=               "<tr>\
		                        <td class=\"label\">[encumberance_levels[i+1]] ([i])</td>\
		                        <td class=\"rvalue\">[data["basic lift"] * encumberance_levels[encumberance_levels[i+1]]]</td>\
		                        <td class=\"rvalue\">[data["Basic Move Real"] * (1-0.2*i)]</td>\
		                        <td class=\"rvalue\">[data["Dodge Real"]-i]</td>\
		                    </tr>"
	. +=               "</table>\
	                </td>\
	                <td class=\"spacer\" rowspan=\"2\"></td>\
	                <td rowspan=\"2\">\
	                    <table id=\"hit_location\" class=\"info\">\
	                        <tr>\
	                            <td class=\"title\" colspan=\"4\">Hit Location</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"title\">Roll</td>\
	                            <td class=\"title\">Where</td>\
	                            <td class=\"title\">-</td>\
	                            <td class=\"title\">DR</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"clabel\">@ROLL</td>\
	                            <td class=\"clabel\">@WHERE</td>\
	                            <td class=\"label\">@PENALTY</td\
	                            <td class=\"rvalue\">@DR</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"rowspacer4\"></td>\
	                            <td class=\"rowspacer4\"></td>\
	                            <td class=\"rowspacer4\"></td>\
	                            <td class=\"rowspacer4\"></td>\
	                        </tr>\
	                    </table>\
	                </td>\
	                <td class=\"spacer\" rowspan=\"2\"></td>\
	                <td rowspan=\"2\">\
	                    <table id=\"fp_hp\" class=\"info\">\
	                        <tr>\
	                            <td class=\"title\" colspan=\"2\">Fatigue/Hit Points</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Current FP:</td>\
	                            <td class=\"rvalue\">[data["fp"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Basic FP:</td>\
	                            <td class=\"rvalue\">[data["FP"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"rowspacer1\" colspan=\"2\"></td>\
	                        </tr>\
	                        <tr class=\"top_border\">\
	                            <td class=\"label\">Tired:</td>\
	                            <td class=\"rvalue\">[round(data["FP Real"]/4)]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Collapse:</td>\
	                            <td class=\"rvalue\">[data["collapse fatigue"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Unconscious:</td>\
	                            <td class=\"rvalue\">[-data["FP Real"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"rowspacer1\" colspan=\"2\"></td>\
	                        </tr>\
	                        <tr class=\"top_border\">\
	                            <td class=\"label\">Current HP:</td>\
	                            <td class=\"rvalue\">[data["hp"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Basic HP:</td>\
	                            <td class=\"rvalue\">[data["HP"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"rowspacer1\" colspan=\"2\"></td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Reeling:</td>\
	                            <td class=\"rvalue\">[round(data["HP Real"]/4)]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Collapse:</td>\
	                            <td class=\"rvalue\">[data["collapse health"]]</td>\
	                        </tr>"
	for(var/i in 1 to 4)
		. +=               "<tr>\
	                            <td class=\"label\">Check #[i]:</td>\
	                            <td class=\"rvalue\">[data["death threshold [i]"]]</td>\
	                        </tr>"
	. +=                    "<tr>\
	                            <td class=\"label\">Death:</td>\
	                            <td class=\"rvalue\">[data["death threshold 5"]]</td>\
	                        </tr>\
	                    </table>\
	                </td>\
	            </tr>\
	            <tr>\
	                <td>\
	                    <table id=\"lifting\" class=\"info\">\
	                        <tr>\
	                            <td class=\"title\" colspan=\"2\">Lifting &amp; Moving Things</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Basic Lift:</td>\
	                            <td class=\"rvalue\">[data["basic lift"]]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">One-Handed Lift:</td>\
	                            <td class=\"rvalue\">[data["basic lift"]*2]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Two-Handed Lift:</td>\
	                            <td class=\"rvalue\">[data["basic lift"]*8]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Shove &amp; Knock Over:</td>\
	                            <td class=\"rvalue\">[data["basic lift"]*12]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Running Shove &amp; Knock Over:</td>\
	                            <td class=\"rvalue\">[data["basic lift"]*24]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Carry On Back:</td>\
	                            <td class=\"rvalue\">[data["basic lift"]*15]</td>\
	                        </tr>\
	                        <tr>\
	                            <td class=\"label\">Shift Slightly:</td>\
	                            <td class=\"rvalue\">[data["basic lift"]*50]</td>\
	                        </tr>\
	                    </table>\
	                </td>\
	            </tr>\
	        </table>\
	        <table class=\"wrapper\">\
	            <tr>\
	                <td>\
	                    <table id=\"advantages\" class=\"list\">\
	                        <tr>\
	                            <td class=\"title\">Advantages &amp; Disadvantages</td>\
	                            <td class=\"title\">Pts</td>\
	                            <td class=\"title\">Ref</td>\
	                        </tr>\
	                        <tr class=\"@EVEN_ODD\">\
	                            <td class=\"description\">Description</td>\
	                            <td class=\"points\">Points</td>\
	                            <td class=\"ref\">Ref</td>\
	                        </tr>\
	                    </table>\
	                </td>\
	                <td class=\"spacer\"></td>\
	                <td>\
	                    <table id=\"skills\" class=\"list\">\
	                        <tr>\
	                            <td class=\"title\">Skills</td>\
	                            <td class=\"title\">SL</td>\
	                            <td class=\"title\">RSL</td>\
	                            <td class=\"title\">Pts</td>\
	                            <td class=\"title\">Ref</td>\
	                        </tr>"
	if(data["skill list"] && length(data["skill list"]))
		var/list/skill_list = data["skill list"]
		for(var/a in 1 to skill_list.len)
			var/list/skill = skill_list["[a]"]
			. +=            "<tr class=\"[a%2==0 ? "even" : "odd"]\">\
	                            <td class=\"description\">[skill["name"]]</td>\
	                            <td class=\"skill_level\">[skill["level"]]</td>\
	                            <td class=\"relative_skill_level\">[skill["relative skill level"]]</td>\
	                            <td class=\"points\">[skill["points"]]</td>\
	                            <td class=\"ref\">Ref</td>"
	. +=                    "</tr>\
	                    </table>\
	                </td>\
	            </tr>\
	        </table>\
	        <table id=\"spells\" class=\"list\">\
	            <tr>\
	                <td class=\"title\">Spells</td>\
	                <td class=\"title\">Class</td>\
	                <td class=\"title\">Mana Cost</td>\
	                <td class=\"title\">Time</td>\
	                <td class=\"title\">SL</td>\
	                <td class=\"title\">RSL</td>\
	                <td class=\"title\">Pts</td>\
	                <td class=\"title\">Ref</td>\
	            </tr>\
	            <tr class=\"@EVEN_ODD\">\
	                <td class=\"description\">Description</td>\
	                <td class=\"spell_class\">Class\
	                    <div class=\"secondary\">College</div></td>\
	                <td class=\"mana\">Mana Cost\
	                    <div class=\"secondary\">Mana Maintain</div></td>\
	                <td class=\"time\">Time Cast\
	                    <div class=\"secondary\">Duration</div></td>\
	                <td class=\"spell_level\">SL</td>\
	                <td class=\"relative_spell_level\">RSL</td>\
	                <td class=\"points\">Points</td>\
	                <td class=\"ref\">Ref</td>\
	            </tr>\
	       </table>\
	       <table id=\"melee_weapons\" class=\"list\">\
	           <tr>\
	               <td class=\"title\">Melee Weapons</td>\
	               <td class=\"title\">Usage</td>\
	               <td class=\"title\">Lvl</td>\
	               <td class=\"title\">Parry</td>\
	               <td class=\"title\">Block</td>\
	               <td class=\"title\">Damage</td>\
	               <td class=\"title\">Reach</td>\
	               <td class=\"title\">ST</td>\
	           </tr>\
	           <tr class\"@EVEN_ODD\">\
	               <td class=\"description\">DESCRIPTION</td>\
	               <td class=\"usage\">USAGE</td>\
	               <td class=\"level\">LEVEL</td>\
	               <td class=\"parry\">PARRY</td>\
	               <td class=\"block\">BLOCK</td>\
	               <td class=\"damage\">DAMAGE</td>\
	               <td class=\"reach\">REACH</td>\
	               <td class=\"strength\">STRENGTH</td>\
	           </tr>\
	       </table>\
	       <table id=\"ranged_weapons\" class=\"list\">\
	           <tr>\
	               <td class=\"title\">Ranged Weapons</td>\
	               <td class=\"title\">Usage</td>\
	               <td class=\"title\">Lvl</td>\
	               <td class=\"title\">Acc</td>\
	               <td class=\"title\">Damage</td>\
	               <td class=\"title\">Range</td>\
	               <td class=\"title\">RoF</td>\
	               <td class=\"title\">Shots</td>\
	               <td class=\"title\">Bulk</td>\
	               <td class=\"title\">Rcl</td>\
	               <td class=\"title\">ST</td>\
	           </tr>\
	           <tr class\"@EVEN_ODD\">\
	               <td class=\"description\">DESCRIPTION</td>\
	               <td class=\"usage\">USAGE</td>\
	               <td class=\"level\">LEVEL</td>\
	               <td class=\"accuracy\">ACCURACY</td>\
	               <td class=\"damage\">DAMAGE</td>\
	               <td class=\"range\">RANGE</td>\
	               <td class=\"rof\">ROF</td>\
	               <td class=\"shots\">SHOTS</td>\
	               <td class=\"bulk\">BULK</td>\
	               <td class=\"recoil\">RECOIL</td>\
	               <td class=\"strength\">STRENGTH</td>\
	           </tr>\
	       </table>\
	       <table id=\"equipment\" class=\"list\">\
	           <tr>\
	               <td class=\"title\">Equipment (Carried Weight, Carried Value)</td>\
	               <td class=\"title\">&radic;</td>\
	               <td class=\"title\">#</td>\
	               <td class=\"title\">$</td>\
	               <td class=\"title\">W</td>\
	               <td class=\"title\">&sum; $</td>\
	               <td class=\"title\">&sum; W</td>\
	               <td class=\"title\">Ref</td>\
	           </tr>"
	if(data["equipment list"] && length(data["equipment list"]))
		var/list/equip_list = data["equipment list"]
		for(var/e in 1 to equip_list.len)
			var/list/item = equip_list["[e]"]
			. += "\
	           <tr>\
	               <td class=\"description\">[item["name"]]</td>\
	               <td class=\"state\">[item["state"]]</td>\
	               <td class=\"quantity\">[item["amount"]]</td>\
	               <td class=\"cost\">[item["cost per"]]</td>\
	               <td class=\"weight\">[item["weight per"]]</td>\
	               <td class=\"cost_summary\">[item["cost total"]]</td>\
	               <td class=\"cost_summary\">[item["weight total"]]</td>\
	               <td class=\"ref\">[item["page number"]]</td>\
	           </tr>\
	       </table>\
	    </body>\
	</html>"