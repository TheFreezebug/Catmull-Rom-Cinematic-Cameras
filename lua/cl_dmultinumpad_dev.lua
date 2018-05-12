DNumPadMultiHackz = {}

function DNumPadMultiHackz.Add(self, key_val, pButton)
	local bin_flag = 2 ^ key_val

	pButton.LastToggle = CurTime() + .1 -- hackz

	if bit.band(self.m_KeyFlags , bin_flag) ~= bin_flag then
		self.m_KeyFlags = self.m_KeyFlags + bin_flag
		
		self:UpdateConVar()
	end
end

function DNumPadMultiHackz.Remove(self, key_val, pButton)
	local bin_flag = 2 ^ key_val

	if pButton.LastToggle > CurTime() then return end

	if bit.band(self.m_KeyFlags , bin_flag) == bin_flag then
		self.m_KeyFlags = self.m_KeyFlags - bin_flag
		
		self:UpdateConVar()
	end
end

function DNumPadMultiHackz.Update(self)
	if self.m_CVarName then
		--print("Update: ", self.m_KeyFlags)
		RunConsoleCommand(self.m_CVarName, self.m_KeyFlags)
		--print("---")
	end
end

function DNumPadMultiHackz.Set(self, data)
	self:Clear()
	
	for k, _ in pairs(data) do
		self.Buttons[k]:DoClick() -- ?
		--print("Setting ", k, "...\n")
	end
end

function DNumPadMultiHackz.Press(self, pButton, iButtonNumber)
	
		
		pButton.WasSelectedActive = not pButton.WasSelectedActive
		
		pButton:SetSelected(pButton.WasSelectedActive)
		
		local hackz = (pButton.WasSelectedActive and DNumPadMultiHackz.Add(self, iButtonNumber, pButton) or DNumPadMultiHackz.Remove(self, iButtonNumber, pButton))
	--end
end

