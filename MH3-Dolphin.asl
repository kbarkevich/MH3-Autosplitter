/***********************************************************************/
/* Autosplitter for IL runs of Monster Hunter Tri (Emulated - Dolphin) */
/* Author: Ze SpyRo                                                    */
/***********************************************************************/

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
	settings.Add("IL", true, "Checked to configure for IL, unchecked to configure for RTA");
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

	// QUEST MAX FRAMES
	bool questDataUpdated = vars.QuestDataPtr.Update(game);
	if (vars.QuestDataPtr.Current > 0x00) {
		if (questDataUpdated)
			vars.QuestMaxFramesPtr = new MemoryWatcher<ushort> (vars.ptr2 + (int)(vars.ConvertEndian((uint)vars.QuestDataPtr.Current)& 0xFFFFFF) + 0x013A);
		vars.QuestMaxFramesPtr.Update(game);
	}

	vars.QuestEnded.Update(game);

	vars.questMaxFrames = vars.ConvertEndianShort((ushort)vars.QuestMaxFramesPtr.Current) * 60 * 30;
	vars.questRemainingFrames = vars.ConvertEndian((uint)vars.RemainingFramesPtr2.Current);

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
	vars.isNotLoading = vars.Exx1.Current | vars.Exx2.Current | vars.Exx3.Current | vars.Exx4.Current | vars.Exx5.Current | vars.Exx6.Current;
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
	print("SPLITTING!");
}

onReset {
	print("RESETTING");
}

gameTime {
	if (settings["IL"]) {
		float secs = (vars.questMaxFrames - vars.questRemainingFrames) / 30.0f;
		return TimeSpan.FromSeconds(secs);
	}
}

isLoading {
	if (!settings["IL"])
		return vars.isNotLoading == 0x00000000;
}

start {
	if (settings["IL"])
		return vars.questInProgress && (vars.QuestEnded.Current == 0);
}

split {
	if (settings["IL"])
		return (vars.questInProgress) && (vars.QuestEnded.Current > 0);
}

reset {
	if (settings["IL"])
		return (!vars.questInProgress) && (vars.QuestEnded.Current == 0);
}
