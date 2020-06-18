Citizen.CreateThread(function ()
	while(true) do
		Citizen.Wait(10)
		if(IsRecording()) then
			if(IsControlJustPressed(1,config.binding.stop_save_record)) then
				StopRecordingAndSaveClip()
			end
			
			if(IsControlJustPressed(1,config.binding.stop_discard_record)) then
				StopRecordingAndDiscardClip()
			end
		else
			--Doesn't seems to work
			if(IsControlJustPressed(1,config.binding.start_record_replay)) then
				StartRecording(0)
			end
		
			if(IsControlJustPressed(1,config.binding.start_record)) then
				StartRecording(1)
			end
		end
		
		if(IsControlJustPressed(1,config.binding.open_editor)) then
			NetworkSessionLeaveSinglePlayer()
			ActivateRockstarEditor()
		end
	end
end)