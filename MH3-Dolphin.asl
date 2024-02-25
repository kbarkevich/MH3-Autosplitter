/***************************************************************************/
/* Autosplitter for IL/RTA runs of Monster Hunter Tri (Emulated - Dolphin) */
/* Author: Ze SpyRo                                                        */
/***************************************************************************/

state("Dolphin") {}

startup {
	vars.ConvertEndian = (Func<uint, uint>)((value) => {
		return ((value & 0x000000ff) << 24) +
            ((value & 0x0000ff00) << 8) +
            ((value & 0x00ff0000) >> 8) +
            ((value & 0xff000000) >> 24);
	});
	vars.ConvertEndianShort = (Func<ushort, ushort>)((value) => {
		return (ushort)((ushort)((value & 0xff) << 8) | ((value >> 8) & 0xff));
	});
	
	vars.CompletedQuestsLen = 0;
	vars.CompletedQuests = new ushort[400];
	vars.MarkQuestCompleted = (Func<ushort, int>)((v) => {
		vars.CompletedQuests[vars.CompletedQuestsLen] = v;
		vars.CompletedQuestsLen = vars.CompletedQuestsLen + 1;
		return 1;
	});
	vars.IsQuestCompleted = (Func<ushort, bool>)((v) => {
		for (int i = 0; i < vars.CompletedQuestsLen; i++) {
			if (vars.CompletedQuests[i] == v)
				return true;
		}
		return false;
	});
	vars.ClearQuestsCompleted = (Func<int>)(() => {
		vars.CompletedQuestsLen = 0;
		return 1;
	});
	
	settings.Add("IL", true, "Checked to configure for IL, unchecked to configure for RTA");
	settings.Add("...", false, "--------------------VILLAGE RTA SPLITS--------------------");
	settings.Add("1000", false, "Harvest 'Shroom");
	settings.Add("1001", false, "Prescription Pick-up");
	settings.Add("1002", false, "Goldenfish Opportunity");
	settings.Add("1003", false, "Farm Aid");
	settings.Add("1004", false, "Guts: It's What's for Dinner");
	settings.Add("1005", false, "Sunken Treasures");
	settings.Add("1010", false, "Bug Hunt");
	settings.Add("1011", false, "Secret of the Crystal Bones");
	settings.Add("1012", false, "No Guts, No Glory");
	settings.Add("1013", false, "Big Game Hunting");
	settings.Add("1014", false, "Who's the Boss?");
	settings.Add("1020", false, "Rhenoplos Rampage!");
	settings.Add("1021", false, "Herbivore Egg Hunt!");
	settings.Add("1022", false, "Pest Control");
	settings.Add("1023", false, "The Deadliest Catch");
	settings.Add("1024", false, "Playing with Fire");
	settings.Add("1025", false, "Trapping a Trickster");
	settings.Add("1026", false, "Save Our Boat");
	settings.Add("1027", false, "Leading the Charge");
	settings.Add("1028", false, "A Royal Pain");
	settings.Add("1030", false, "Lost in Blue");
	settings.Add("1031", false, "Leader of the Icepack");
	settings.Add("1032", false, "Cold Stones");
	settings.Add("1033", false, "Hunter Killer");
	settings.Add("1034", false, "Harvest Tour: Sandy Plains");
	settings.Add("1035", false, "Harvest Tour: Flooded Forest");
	settings.Add("1036", false, "Dragon Lady");
	settings.Add("1037", false, "The Creeping Venom");
	settings.Add("1038", false, "A Royal Rumble");
	settings.Add("1039", false, "Poached Wyvern Eggs");
	settings.Add("1040", false, "Best the Lava Beasts!");
	settings.Add("1041", false, "Heat Exhaustion");
	settings.Add("1042", false, "The Lord of the Seas");
	settings.Add("1043", false, "Harvest Tour: Tundra");
	settings.Add("1044", false, "The Wrath of Rathalos");
	settings.Add("1045", false, "A Bard's Tale");
	settings.Add("1046", false, "The Horned Dragon");
	settings.Add("1047", false, "The Omen");
	settings.Add("1048", false, "Denizen of the Molten Deep");
	settings.Add("1049", false, "The Volcano's Fury");
	settings.Add("1050", false, "Uragaan's Trail");
	settings.Add("1060", false, "Mating Season");
	settings.Add("1061", false, "Four Horns");
	settings.Add("1062", false, "Dangerous Waters");
	settings.Add("1063", false, "White Wind of the Tundra");
	settings.Add("1064", false, "The Death of Sky and Sea");
	settings.Add("1065", false, "A Burnt Offering");
	settings.Add("2000", false, "No Love for Ludroth");
	settings.Add("2001", false, "Shakalaka Savior!");
	settings.Add("2002", false, "Accident Investigation");
	settings.Add("2003", false, "Trial of the Sea Dragon");
	settings.Add("2004", false, "Fell the Lagiacrus!");
	settings.Add("2005", false, "Save Moga Village!");
	settings.Add("2006", false, "The Decisive Battle");
	settings.Add("....", false, "--------------------CITY LOW RANK RTA SPLITS--------------------");
	settings.Add("10000", false, "Harvest 'Shroom");
	settings.Add("10001", false, "Sunken Treasures");
	settings.Add("10002", false, "The Perfect Panacea");
	settings.Add("10003", false, "The Jaggi Menace");
	settings.Add("10004", false, "Help the \"Hunter\"");
	settings.Add("10005", false, "Playing with Fire");
	settings.Add("10006", false, "The Fisherman's Tale");
	settings.Add("10007", false, "Secret of the Crystal Bones");
	settings.Add("10008", false, "No Guts, No Glory");
	settings.Add("10009", false, "Jaggi Population Control");
	settings.Add("10010", false, "Tracking the Trickster");
	settings.Add("10011", false, "Goldenfish Oppertunity");
	settings.Add("10012", false, "No Love for Ludroth");
	settings.Add("10013", false, "The Fisherman's Tale");
	settings.Add("10050", false, "Harvest Tour: Deserted Isle");
	settings.Add("10051", false, "Bug Hunt");
	settings.Add("10052", false, "Wyvern Conservation");
	settings.Add("10053", false, "A Royal Pain");
	settings.Add("10054", false, "Harvest Tour: Sandy Plains");
	settings.Add("10055", false, "Rhenoplos Rampage!");
	settings.Add("10056", false, "Poached Herbivore Eggs");
	settings.Add("10057", false, "Specimen Collection");
	settings.Add("10058", false, "Flooded Forest Extermination");
	settings.Add("10059", false, "Scene of the Crime");
	settings.Add("10060", false, "Lady and the Gobul");
	settings.Add("10061", false, "The Merchant's Mission");
	settings.Add("10062", false, "Blood from a Stone");
	settings.Add("10063", false, "Leader of the Icepack");
	settings.Add("10064", false, "The Butler's Great Baggi");
	settings.Add("10100", false, "We Need a Hero");
	settings.Add("10101", false, "Into the Danger Zone");
	settings.Add("10102", false, "Wanted Alive");
	settings.Add("10103", false, "Harvest Tour: Flooded Forest");
	settings.Add("10104", false, "Rotten Fish");
	settings.Add("10105", false, "Harvest Tour: Tundra");
	settings.Add("10106", false, "The Creeping Venom");
	settings.Add("10107", false, "The Lost Expedition");
	settings.Add("10108", false, "The Bard's Barioth");
	settings.Add("10109", false, "Roll the Uroktor");
	settings.Add("10110", false, "Powder Burns");
	settings.Add("10111", false, "The Volcano's Fury");
	settings.Add("10112", false, "To Catch an Uragaan");
	settings.Add("10113", false, "[Advanced] Double Trouble");
	settings.Add("10114", false, "[Advanced] Fort Gigginox");
	settings.Add("10115", false, "[Advanced] Rathalos Alert");
	settings.Add("10116", false, "[Advanced] Agnaktor Alert");
	settings.Add("14000", false, "Leading the Charge");
	settings.Add("14001", false, "The Fisherman's Fiend");
	settings.Add("14002", false, "The Festival of Fear");
	settings.Add(".....", false, "--------------------CITY HIGH RANK RTA SPLITS--------------------");
	settings.Add("15000", false, "Harvest Tour: Deserted Isle");
	settings.Add("15001", false, "Jump a Jaggi");
	settings.Add("15002", false, "Playing with Fire");
	settings.Add("15003", false, "Reel In a Rathian");
	settings.Add("15004", false, "Harvest Tour: Sandy Plains");
	settings.Add("15005", false, "No Guts, No Glory");
	settings.Add("15006", false, "Jumping for Jaggi");
	settings.Add("15007", false, "The Mysterious Mimic");
	settings.Add("15008", false, "Ambush the Ambusher");
	settings.Add("15009", false, "Avenging the Fallen Hunter");
	settings.Add("15010", false, "Neopteron Pest Control");
	settings.Add("15011", false, "A Ludroth Lickin'");
	settings.Add("15012", false, "Fine Kettle of Fish");
	settings.Add("15013", false, "The Fisherman's Tale");
	settings.Add("15014", false, "Grab a Gobul");
	settings.Add("15015", false, "[Advanced] Fearsome Twosome");
	settings.Add("15016", false, "[Advanced] Barroth Buster");
	settings.Add("15017", false, "[Advanced] Grab a Gobul");
	settings.Add("15018", false, "[Advanced] The Jaggia Menace");
	settings.Add("15050", false, "Rathalos Research");
	settings.Add("15051", false, "Into the Danger Zone");
	settings.Add("15052", false, "Harvest Tour: Flooded Forest");
	settings.Add("15053", false, "Rotten Fish");
	settings.Add("15054", false, "Harvest Tour: Tundra");
	settings.Add("15055", false, "Leader of the Icepack");
	settings.Add("15056", false, "The Creeping Venom");
	settings.Add("15057", false, "Gigginox RX");
	settings.Add("15058", false, "The Lost Expedition");
	settings.Add("15059", false, "Roll the Uroktor");
	settings.Add("15060", false, "Run Down a Rathalos");
	settings.Add("15061", false, "The Thrill of the Hunt");
	settings.Add("15062", false, "The Molten Monstrosity");
	settings.Add("15063", false, "Agnaktor Alert");
	settings.Add("15064", false, "[Advanced] Run Down Rathalos");
	settings.Add("15065", false, "[Advanced] Lick a Lagiacrus");
	settings.Add("15066", false, "[Advanced] Bump Off Barioth");
	settings.Add("15067", false, "[Advanced] Heroes Wanted");
	settings.Add("15100", false, "Deep-six a Deviljho");
	settings.Add("15101", false, "Bedevil a Deviljho");
	settings.Add("15102", false, "Into the Fire");
	settings.Add("15103", false, "Double Trouble");
	settings.Add("15105", false, "The Princess's Pride");
	settings.Add("15106", false, "A Sea of Dragons");
	settings.Add("15107", false, "Tragedy on the Tundra");
	settings.Add("15108", false, "A Burnt Offering");
	settings.Add("16000", false, "The Festival of Fear");
	settings.Add("16001", false, "Rumble in the Great Desert");
	settings.Add("19000", false, "Double Trouble");
	settings.Add("19001", false, "The Brilliant Darkness");

	vars.GetQuestName = (Func<ushort, string>)((v) => {
		switch(v) {
			case 1000: return "Harvest 'Shroom";
			case 1001: return "Prescription Pick-up";
			case 1002: return "Goldenfish Opportunity";
			case 1003: return "Farm Aid";
			case 1004: return "Guts: It's What's for Dinner";
			case 1005: return "Sunken Treasures";
			case 1010: return "Bug Hunt";
			case 1011: return "Secret of the Crystal Bones";
			case 1012: return "No Guts, No Glory";
			case 1013: return "Big Game Hunting";
			case 1014: return "Who's the Boss?";
			case 1020: return "Rhenoplos Rampage!";
			case 1021: return "Herbivore Egg Hunt!";
			case 1022: return "Pest Control";
			case 1023: return "The Deadliest Catch";
			case 1024: return "Playing with Fire";
			case 1025: return "Trapping a Trickster";
			case 1026: return "Save Our Boat";
			case 1027: return "Leading the Charge";
			case 1028: return "A Royal Pain";
			case 1030: return "Lost in Blue";
			case 1031: return "Leader of the Icepack";
			case 1032: return "Cold Stones";
			case 1033: return "Hunter Killer";
			case 1034: return "Harvest Tour: Sandy Plains";
			case 1035: return "Harvest Tour: Flooded Forest";
			case 1036: return "Dragon Lady";
			case 1037: return "The Creeping Venom";
			case 1038: return "A Royal Rumble";
			case 1039: return "Poached Wyvern Eggs";
			case 1040: return "Best the Lava Beasts!";
			case 1041: return "Heat Exhaustion";
			case 1042: return "The Lord of the Seas";
			case 1043: return "Harvest Tour: Tundra";
			case 1044: return "The Wrath of Rathalos";
			case 1045: return "A Bard's Tale";
			case 1046: return "The Horned Dragon";
			case 1047: return "The Omen";
			case 1048: return "Denizen of the Molten Deep";
			case 1049: return "The Volcano's Fury";
			case 1050: return "Uragaan's Trail";
			case 1060: return "Mating Season";
			case 1061: return "Four Horns";
			case 1062: return "Dangerous Waters";
			case 1063: return "White Wind of the Tundra";
			case 1064: return "The Death of Sky and Sea";
			case 1065: return "A Burnt Offering";
			case 2000: return "No Love for Ludroth";
			case 2001: return "Shakalaka Savior!";
			case 2002: return "Accident Investigation";
			case 2003: return "Trial of the Sea Dragon";
			case 2004: return "Fell the Lagiacrus!";
			case 2005: return "Save Moga Village!";
			case 2006: return "The Decisive Battle";
			// ------------- start online low rank -------------
			case 10000: return "Harvest 'Shroom";
			case 10001: return "Sunken Treasures";
			case 10002: return "The Perfect Panacea";
			case 10003: return "The Jaggi Menace";
			case 10004: return "Help the \"Hunter\"";
			case 10005: return "Playing with Fire";
			case 10006: return "The Fisherman's Tale";
			case 10007: return "Secret of the Crystal Bones";
			case 10008: return "No Guts, No Glory";
			case 10009: return "Jaggi Population Control";
			case 10010: return "Tracking the Trickster";
			case 10011: return "Goldenfish Oppertunity";
			case 10012: return "No Love for Ludroth";
			case 10013: return "The Fisherman's Tale";
			case 10050: return "Harvest Tour: Deserted Isle";
			case 10051: return "Bug Hunt";
			case 10052: return "Wyvern Conservation";
			case 10053: return "A Royal Pain";
			case 10054: return "Harvest Tour: Sandy Plains";
			case 10055: return "Rhenoplos Rampage!";
			case 10056: return "Poached Herbivore Eggs";
			case 10057: return "Specimen Collection";
			case 10058: return "Flooded Forest Extermination";
			case 10059: return "Scene of the Crime";
			case 10060: return "Lady and the Gobul";
			case 10061: return "The Merchant's Mission";
			case 10062: return "Blood from a Stone";
			case 10063: return "Leader of the Icepack";
			case 10064: return "The Butler's Great Baggi";
			case 10100: return "We Need a Hero";
			case 10101: return "Into the Danger Zone";
			case 10102: return "Wanted Alive";
			case 10103: return "Harvest Tour: Flooded Forest";
			case 10104: return "Rotten Fish";
			case 10105: return "Harvest Tour: Tundra";
			case 10106: return "The Creeping Venom";
			case 10107: return "The Lost Expedition";
			case 10108: return "The Bard's Barioth";
			case 10109: return "Roll the Uroktor";
			case 10110: return "Powder Burns";
			case 10111: return "The Volcano's Fury";
			case 10112: return "To Catch an Uragaan";
			case 10113: return "[Advanced] Double Trouble";
			case 10114: return "[Advanced] Fort Gigginox";
			case 10115: return "[Advanced] Rathalos Alert";
			case 10116: return "[Advanced] Agnaktor Alert";
			case 14000: return "Leading the Charge";
			case 14001: return "The Fisherman's Fiend";
			case 14002: return "The Festival of Fear";
			// ------------- start online high rank -------------
			case 15000: return "Harvest Tour: Deserted Isle";
			case 15001: return "Jump a Jaggi";
			case 15002: return "Playing with Fire";
			case 15003: return "Reel In a Rathian";
			case 15004: return "Harvest Tour: Sandy Plains";
			case 15005: return "No Guts, No Glory";
			case 15006: return "Jumping for Jaggi";
			case 15007: return "The Mysterious Mimic";
			case 15008: return "Ambush the Ambusher";
			case 15009: return "Avenging the Fallen Hunter";
			case 15010: return "Neopteron Pest Control";
			case 15011: return "A Ludroth Lickin'";
			case 15012: return "Fine Kettle of Fish";
			case 15013: return "The Fisherman's Tale";
			case 15014: return "Grab a Gobul";
			case 15015: return "[Advanced] Fearsome Twosome";
			case 15016: return "[Advanced] Barroth Buster";
			case 15017: return "[Advanced] Grab a Gobul";
			case 15018: return "[Advanced] The Jaggia Menace";
			case 15050: return "Rathalos Research";
			case 15051: return "Into the Danger Zone";
			case 15052: return "Harvest Tour: Flooded Forest";
			case 15053: return "Rotten Fish";
			case 15054: return "Harvest Tour: Tundra";
			case 15055: return "Leader of the Icepack";
			case 15056: return "The Creeping Venom";
			case 15057: return "Gigginox RX";
			case 15058: return "The Lost Expedition";
			case 15059: return "Roll the Uroktor";
			case 15060: return "Run Down a Rathalos";
			case 15061: return "The Thrill of the Hunt";
			case 15062: return "The Molten Monstrosity";
			case 15063: return "Agnaktor Alert";
			case 15064: return "[Advanced] Run Down Rathalos";
			case 15065: return "[Advanced] Lick a Lagiacrus";
			case 15066: return "[Advanced] Bump Off Barioth";
			case 15067: return "[Advanced] Heroes Wanted";
			case 15100: return "Deep-six a Deviljho";
			case 15101: return "Bedevil a Deviljho";
			case 15102: return "Into the Fire";
			case 15103: return "Double Trouble";
			case 15105: return "The Princess's Pride";
			case 15106: return "A Sea of Dragons";
			case 15107: return "Tragedy on the Tundra";
			case 15108: return "A Burnt Offering";
			case 16000: return "The Festival of Fear";
			case 16001: return "Rumble in the Great Desert";
			case 19000: return "Double Trouble";
			case 19001: return "The Brilliant Darkness";
			default: return "Unknown";
		}
	});
}

init {
	vars.questInProgress = false;
	vars.questMaxFrames = 0;
	vars.questRemainingFrames = 0;

	// 0x80000000 based Dolphin memory
    vars.ptr = game.MemoryPages(true).FirstOrDefault(p => p.Type == MemPageType.MEM_MAPPED && p.State == MemPageState.MEM_COMMIT && (int)p.RegionSize == 0x2000000).BaseAddress;
    // 0x90000000 based Dolphin memory
	vars.ptr2 = game.MemoryPages(true).FirstOrDefault(p => p.Type == MemPageType.MEM_MAPPED && p.State == MemPageState.MEM_COMMIT && (int)p.RegionSize == 0x4000000).BaseAddress;

	print("  => MEM80- address found at: 0x" + vars.ptr.ToString("X"));
	print("  => MEM90- address found at: 0x" + vars.ptr2.ToString("X"));

	vars.State = new MemoryWatcher<uint> (vars.ptr + 0x658684);
	vars.State.Update(game);
	vars.DeepState = new MemoryWatcher<uint> (vars.ptr2 + (int)((vars.ConvertEndian((vars.State.Current))& 0xFFFFFF) + 0x10));
	vars.DeepState.Update(game);
	vars.DeeperState = new MemoryWatcher<byte> (vars.ptr2 + (int)((vars.ConvertEndian((vars.DeepState.Current))& 0xFFFFFF)));
	vars.DeeperState.Update(game);

	vars.QuestDataPtr = new MemoryWatcher<uint> (vars.ptr + 0x6c5894);
	vars.QuestDataPtr.Update(game);
	vars.QuestMaxFramesPtr = new MemoryWatcher<ushort> (vars.ptr2 + (int)(vars.ConvertEndian((uint)vars.QuestDataPtr.Current)& 0xFFFFFF) + 0x013A);
	vars.QuestMaxFramesPtr.Update(game);
	vars.QuestIDPtr = new MemoryWatcher<ushort> (vars.ptr2 + (int)(vars.ConvertEndian((uint)vars.QuestDataPtr.Current)& 0xFFFFFF) + 0x002C);
	vars.QuestIDPtr.Update(game);

	vars.RemainingFramesPtr1 = new MemoryWatcher<uint> (vars.ptr2 + (int)((vars.ConvertEndian((vars.DeepState.Current))& 0xFFFFFF) + 0xdc));
	vars.RemainingFramesPtr1.Update(game);
	vars.RemainingFramesPtr2 = new MemoryWatcher<uint> (vars.ptr + (int)((vars.ConvertEndian((uint)vars.DeepState.Current)& 0xFFFFFF) + 0x24));
	vars.RemainingFramesPtr2.Update(game);

	vars.QuestEnded = new MemoryWatcher<byte> (vars.ptr + 0x658e48);

	vars.GameModeState = new MemoryWatcher<byte> (vars.ptr + 0x658604);
	vars.PlayMode_ck = new MemoryWatcher<byte> (vars.ptr + 0x658605);
	vars.PlayMode_ck2 = new MemoryWatcher<byte> (vars.ptr + 0x658606);

	vars.Ex1 = new MemoryWatcher<byte> (vars.ptr + 0x65860a);
	vars.Ex2 = new MemoryWatcher<byte> (vars.ptr + 0x658da8);
	vars.Ex3 = new MemoryWatcher<byte> (vars.ptr + 0x658da9);
	vars.Ex4 = new MemoryWatcher<byte> (vars.ptr + 0x658daa);
	vars.Ex5 = new MemoryWatcher<byte> (vars.ptr + 0x658dab);
	vars.Ex6 = new MemoryWatcher<byte> (vars.ptr + 0x658dac);
	vars.Ex7 = new MemoryWatcher<byte> (vars.ptr + 0x658dad);
	vars.Ex8 = new MemoryWatcher<byte> (vars.ptr + 0x658e57);

	vars.Exx1 = new MemoryWatcher<uint> (vars.ptr + 0x66ac88);
	vars.Exx2 = new MemoryWatcher<uint> (vars.ptr + 0x66acb8);
	vars.Exx3 = new MemoryWatcher<uint> (vars.ptr + 0x66ac98);
	vars.Exx4 = new MemoryWatcher<uint> (vars.ptr + 0x66acc8);
	vars.Exx5 = new MemoryWatcher<uint> (vars.ptr + 0x66acd8);
	vars.Exx6 = new MemoryWatcher<uint> (vars.ptr + 0x66ace8);
	vars.isNotLoading = "1";
	
	var scanner = new SignatureScanner(game, vars.ptr + 0x6a0000, 0x2000);
	var ptr = scanner.ScanAll(new SigScanTarget(0, "00 00 10 69 00 00 00 00 00 00 00 00 12"), 0x1).ToArray();
	vars.PreviousMusicStarts = ptr.Length;
}

update {
	// IS QUEST IN PROGRESS?
	vars.questInProgress = false;
	bool firstUpdated = vars.State.Update(game);
	bool secondUpdated = false;
	if (vars.State.Current > 0x00) {
		if (firstUpdated)
			vars.DeepState = new MemoryWatcher<uint> (vars.ptr2 + (int)((vars.ConvertEndian((vars.State.Current))& 0xFFFFFF) + 0x10));
		secondUpdated = vars.DeepState.Update(game);
		if (vars.DeepState.Current > 0x00) {
			if (secondUpdated || firstUpdated)
				vars.DeeperState = new MemoryWatcher<byte> (vars.ptr2 + (int)((vars.ConvertEndian((vars.DeepState.Current))& 0xFFFFFF)));
			vars.DeeperState.Update(game);
			vars.questInProgress = vars.DeeperState.Current == 2;
		}
	}

	// QUEST TIMER AND "RETURNING IN 60/20/10 SECONDS" TIMER
	if (vars.State.Current > 0x00) {
		if (vars.DeepState.Current > 0x00) {
			if (secondUpdated || firstUpdated)
				vars.RemainingFramesPtr1 = new MemoryWatcher<uint> (vars.ptr2 + (int)((vars.ConvertEndian((vars.DeepState.Current))& 0xFFFFFF) + 0xdc));
			bool didPtr1Update = vars.RemainingFramesPtr1.Update(game);
			if (vars.RemainingFramesPtr1.Current > 0x00) {
				if (didPtr1Update || secondUpdated || firstUpdated)
					vars.RemainingFramesPtr2 = new MemoryWatcher<uint> (vars.ptr + (int)((vars.ConvertEndian(vars.RemainingFramesPtr1.Current)& 0xFFFFFF) + 0x24));
				vars.RemainingFramesPtr2.Update(game);
			}
		}
	}

	// QUEST MAX FRAMES AND ID
	bool questDataUpdated = vars.QuestDataPtr.Update(game);
	if (vars.QuestDataPtr.Current > 0x00) {
		if (questDataUpdated) {
			vars.QuestMaxFramesPtr = new MemoryWatcher<ushort> (vars.ptr2 + (int)(vars.ConvertEndian((uint)vars.QuestDataPtr.Current)& 0xFFFFFF) + 0x013A);
			vars.QuestIDPtr = new MemoryWatcher<ushort> (vars.ptr2 + (int)(vars.ConvertEndian((uint)vars.QuestDataPtr.Current)& 0xFFFFFF) + 0x002C);
		}
		vars.QuestMaxFramesPtr.Update(game);
		vars.QuestIDPtr.Update(game);
	}

	vars.QuestEnded.Update(game);

	vars.questMaxFrames = vars.ConvertEndianShort((ushort)vars.QuestMaxFramesPtr.Current) * 60 * 30;
	vars.questRemainingFrames = vars.ConvertEndian((uint)vars.RemainingFramesPtr2.Current);
	vars.questID = vars.ConvertEndianShort((ushort)vars.QuestIDPtr.Current);

	/*
	print(vars.questRemainingFrames.ToString() + " / " + vars.questMaxFrames.ToString());
	print(vars.ConvertEndian(vars.State.Current).ToString("X") + "  " + 
		vars.ConvertEndian(vars.DeepState.Current).ToString("X") + "  " + 
		vars.ConvertEndian(vars.DeeperState.Current).ToString("X"));
	print("");
	*/

	//print(vars.Ex1.Current.ToString("X") + " " + vars.Ex2.Current.ToString("X") + " " + vars.Ex3.Current.ToString("X") + " " + vars.Ex4.Current.ToString("X") +
	//	 " " + vars.Ex5.Current.ToString("X") + " " + vars.Ex6.Current.ToString("X") + " " + vars.Ex7.Current.ToString("X") + " " + vars.Ex8.Current.ToString("X"));
	vars.up = vars.Exx1.Update(game);
	vars.up = vars.up || vars.Exx2.Update(game);
	vars.up = vars.up || vars.Exx3.Update(game);
	vars.up = vars.up || vars.Exx4.Update(game);
	vars.up = vars.up || vars.Exx5.Update(game);
	vars.up = vars.up || vars.Exx6.Update(game);
	vars.up = vars.up || vars.Ex1.Update(game);
	vars.up = vars.up || vars.Ex2.Update(game);
	vars.up = vars.up || vars.Ex3.Update(game);
	vars.up = vars.up || vars.Ex4.Update(game);
	vars.up = vars.up || vars.Ex5.Update(game);
	vars.up = vars.up || vars.Ex6.Update(game);
	vars.up = vars.up || vars.Ex7.Update(game);
	vars.up = vars.up || vars.Ex8.Update(game);
	vars.up = vars.up || vars.PlayMode_ck.Update(game);
	vars.up = vars.up || vars.GameModeState.Update(game);
	vars.up = vars.up || vars.PlayMode_ck2.Update(game);
	vars.isNotLoading = (vars.Exx1.Current | vars.Exx2.Current | vars.Exx3.Current | vars.Exx4.Current | vars.Exx5.Current | vars.Exx6.Current).ToString("X");
	if (false && vars.up) {
		print(" ");
		print(vars.GameModeState.Current.ToString("X") + " " + vars.PlayMode_ck.Current.ToString("X") + " " + vars.PlayMode_ck2.Current.ToString("X"));
		print(vars.Ex1.Current.ToString("X") + " " + vars.Ex2.Current.ToString("X") + " " + vars.Ex3.Current.ToString("X") + " " + vars.Ex4.Current.ToString("X") +
			" " + vars.Ex5.Current.ToString("X") + " " + vars.Ex6.Current.ToString("X") + " " + vars.Ex7.Current.ToString("X") + " " + vars.Ex8.Current.ToString("X"));
		print(vars.Exx1.Current.ToString("X") + " " + vars.Exx2.Current.ToString("X") + " " + vars.Exx3.Current.ToString("X") + " " + vars.Exx4.Current.ToString("X") +
			 " " + vars.Exx5.Current.ToString("X") + " " + vars.Exx6.Current.ToString("X"));
	}
}

onStart {
	print("STARTING!");
}

onSplit {
	print("SPLITTING QUEST " + vars.GetQuestName(vars.questID) + "!");
	if (!settings["IL"])
		vars.MarkQuestCompleted(vars.questID);
}

onReset {
	print("RESETTING");
	vars.ClearQuestsCompleted();
}

gameTime {
	if (settings["IL"]) {
		float secs = (vars.questMaxFrames - vars.questRemainingFrames) / 30.0f;
		return TimeSpan.FromSeconds(secs);
	}
}

isLoading {
	if (!settings["IL"])
		return vars.isNotLoading == "0";
}

start {
	if (settings["IL"])
		return vars.questInProgress && (vars.QuestEnded.Current == 0);
	else {
		if (vars.isNotLoading == "FFFFFFFF") {
			var scanner = new SignatureScanner(game, vars.ptr + 0x6a0000, 0x2000);
			var ptr = scanner.ScanAll(new SigScanTarget(0, "00 00 10 69 00 00 00 00 00 00 00 00 12"), 0x1).ToArray();
			var result = ptr.Length;
			var returning = result > vars.PreviousMusicStarts;
			vars.PreviousMusicStarts = result;
			return returning;
		}
		return false;
	}
}

split {
	if (settings["IL"])
		return (vars.questInProgress) && (vars.QuestEnded.Current > 0);
	else
		return (vars.questInProgress) && (vars.QuestEnded.Current > 0) && (settings[vars.questID.ToString()]) && (!vars.IsQuestCompleted(vars.questID));
}

reset {
	if (settings["IL"])
		return (!vars.questInProgress) && (vars.QuestEnded.Current == 0);
}
