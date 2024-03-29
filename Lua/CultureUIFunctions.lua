-- Culture UI Functions
-- Author: Gedemon
-- DateCreated: 4/23/2012 11:30:06 PM
--------------------------------------------------------------

print("Loading Culture UI Functions...")
print("-------------------------------------")


-------------------------------------------------
-- Plot Over text update functions
-------------------------------------------------

local tipControls = {}
TTManager:GetTypeControlTable( "HexDetails", tipControls )

local m_iCurrentX = -1
local m_iCurrentY = -1

local m_fTime = 0

function GetCulturePlotHelpString(plot)

	local plotCulture = {}

	for playerID = 0, GameDefines.MAX_PLAYERS do
		table.insert(plotCulture, {ID = playerID, Value = plot:GetCulture(playerID) })
	end

	table.sort(plotCulture, function(a,b) return a.Value > b.Value end)

	local AddedString = ""

	-- this will load from revolution mod...-
	local bShowRevolutionInfo = false

	local totalCulture = plot:GetTotalCulture()
	if (totalCulture > 0) then -- don't mess with the universe
		AddedString = AddedString .. "[NEWLINE]Culture : " .. GetCultureValueString(totalCulture) .. " [ICON_CULTURE]"
		if ( DEBUG_SHOW_PLOT_CULTURE ) then
			AddedString = AddedString .. " (" .. totalCulture .. ") at Plot (" .. tostring(GetPlotKey ( plot )) .. ")"
		end
		local other = 0
		for i = 1, #plotCulture do
			local playerID = plotCulture[i].ID
			if (i <= CULTURE_MAX_LINE_UI) and (plotCulture[i].Value > 0) then
				
				local pPlayer = Players[playerID]
				local civAdj = ""
				if pPlayer and pPlayer:IsEverAlive() then
					civAdj = pPlayer:GetCivilizationAdjective()
				else
					civAdj = "unknown"
				end
				AddedString = AddedString .. "[NEWLINE]" .. tostring(plot:GetCulturePercent(playerID)) .. "%  " .. civAdj

				if bShowRevolutionInfo and cultureRelations[owner][cultureID] then
					AddedString = AddedString .. "  (" .. GetRelationValueString(cultureRelations[owner][cultureID]) .. ")"
				end
			else
				other = other + plot:GetCulturePercent(playerID)
			end
		end
		
		if other > 0 then
			AddedString = AddedString .. "[NEWLINE]" .. tostring(other) .. "% Other cultures"
		end
	end
	return AddedString
end

-- Cursor UI On Mouse Over Plot
function UpdatePlotHelptext()
	-- Add plot culture UI in Plot Mouse Over box
	local plot = Map.GetPlot( m_iCurrentX, m_iCurrentY );
	if (plot ~= nil) then
		if ( plot:GetTotalCulture() > 0 ) then
			local AddedString = GetCulturePlotHelpString(plot)				
			if ( ContextPtr:LookUpControl("/InGame/PlotHelpManager") ) then
				TextString = tipControls.Text:GetText()
				if ( string.find(TextString, "Culture", 1, true) == nil ) then -- prevent text flooding on world view auto-scrolling
					tipControls.Text:SetText( TextString .. AddedString )
					tipControls.Grid:DoAutoSize();
					ContextPtr:LookUpControl("/InGame/PlotHelpManager/TheBox"):SetToolTipType( "HexDetails" )
				end
			end			
		end
	end
end

function Reset()
	m_fTime = 0
	ContextPtr:LookUpControl("/InGame/PlotHelpManager/TheBox"):SetToolTipType()
end

function ProcessInput( uiMsg, wParam, lParam )
    if( uiMsg == MouseEvents.MouseMove ) then
        x, y = UIManager:GetMouseDelta()
        if( x ~= 0 or y ~= 0 ) then 
			Reset()
        end
	end	
end
ContextPtr:SetInputHandler( ProcessInput )

function OnUpdate( fDTime )

	local bHasMouseOver = ContextPtr:LookUpControl("/InGame/PlotHelpManager/TheBox"):HasMouseOver()

	if( not bHasMouseOver ) then
		return
	end

	m_fTime = m_fTime + fDTime;

	if( m_fTime > (OptionsManager.GetTooltip1Seconds() / 100) ) then
		UpdatePlotHelptext()
	end
end
ContextPtr:SetUpdate( OnUpdate )

function DoUpdateXY( hexX, hexY )

	local plot = Map.GetPlot( hexX, hexY )
	
	if (plot ~= nil) then
		m_iCurrentX = hexX
		m_iCurrentY = hexY
	end
	
end
Events.SerialEventMouseOverHex.Add( DoUpdateXY )

-- Minimap UI On Mouse Over Plot
function CultureOnMouseOverHex( hexX, hexY )
	-- Add plot culture UI in PlotHelp box
	local plot = Map.GetPlot( hexX, hexY );
	if (plot ~= nil) then
		if ( plot:GetTotalCulture() > 0 ) then		
			local AddedString = GetCulturePlotHelpString(plot)
			if ( ContextPtr:LookUpControl("/InGame/WorldView/PlotHelpText") ) then
				TextString = ContextPtr:LookUpControl("/InGame/WorldView/PlotHelpText/Text"):GetText()
				ContextPtr:LookUpControl("/InGame/WorldView/PlotHelpText/Text"):SetText( TextString .. AddedString )
				ContextPtr:LookUpControl("/InGame/WorldView/PlotHelpText/TextBox"):DoAutoSize()
			end
		end
	end
end
Events.SerialEventMouseOverHex.Add( CultureOnMouseOverHex )


-------------------------------------------------
-- Policies text update functions
-------------------------------------------------

function OnEventReceived( popupInfo )
	
	if( popupInfo.Type ~= ButtonPopupTypes.BUTTONPOPUP_CHOOSEPOLICY ) or not USE_POLICIES then
		return
	end
	
	local text = ""
	local addedText = ""

	-- Liberty Branch
	local libertyBranchID = GameInfo.PolicyBranchTypes["POLICY_BRANCH_LIBERTY"].ID
	
	addedText = "[NEWLINE][NEWLINE]Adopting Liberty will allow foreign's [ICON_CULTURE] Culture Groups to grow at same rate as your's in your cities, and add [COLOR_POSITIVE_TEXT]2[ENDCOLOR] relation points per turn for separatist [ICON_CULTURE] Culture Group."
	addedText = addedText .. "[NEWLINE][NEWLINE]Completing the Liberty tree add [COLOR_POSITIVE_TEXT]3[ENDCOLOR] more RP/turn for separatist [ICON_CULTURE] Culture Group."
	
	text = ContextPtr:LookUpControl("/InGame/SocialPolicyPopup/BranchButton" .. libertyBranchID):GetToolTipString()
	if ( string.find(text, addedText, 1, true) == nil ) then
		ContextPtr:LookUpControl("/InGame/SocialPolicyPopup/BranchButton" .. libertyBranchID):SetToolTipString(text .. addedText)
	end

	text = ContextPtr:LookUpControl("/InGame/SocialPolicyPopup/BranchBack" .. libertyBranchID):GetToolTipString()
	if ( string.find(text, addedText, 1, true) == nil ) then
		ContextPtr:LookUpControl("/InGame/SocialPolicyPopup/BranchBack" .. libertyBranchID):SetToolTipString(text .. addedText)
	end
	
	-- Tradition Branch
	local traditionBranchID = GameInfo.PolicyBranchTypes["POLICY_BRANCH_TRADITION"].ID

	addedText = "[NEWLINE][NEWLINE]Adopting Tradition will convert [COLOR_POSITIVE_TEXT]2%[ENDCOLOR] of foreign's [ICON_CULTURE] Culture Groups in your cities each turn."
	addedText = addedText .. "[NEWLINE][NEWLINE]Completing the Tradition tree raise the convertion rate to [COLOR_POSITIVE_TEXT]5%[ENDCOLOR]."
	
	text = ContextPtr:LookUpControl("/InGame/SocialPolicyPopup/BranchButton" .. traditionBranchID):GetToolTipString()
	if ( string.find(text, addedText, 1, true) == nil ) then
		ContextPtr:LookUpControl("/InGame/SocialPolicyPopup/BranchButton" .. traditionBranchID):SetToolTipString(text .. addedText)
	end

	text = ContextPtr:LookUpControl("/InGame/SocialPolicyPopup/BranchBack" .. traditionBranchID):GetToolTipString()
	if ( string.find(text, addedText, 1, true) == nil ) then
		ContextPtr:LookUpControl("/InGame/SocialPolicyPopup/BranchBack" .. traditionBranchID):SetToolTipString(text .. addedText)
	end

end
Events.SerialEventGameMessagePopup.Add( OnEventReceived )


function GetCultureValueString(value)
	if value < 50 then
		return "feeble"
	end
	if value < 200 then
		return "low"
	end
	if value < 500 then
		return "sparse"
	end
	if value < 2000 then
		return "average"
	end
	if value < 5000 then
		return "established"
	end
	return "entrenched"
end


function GetRelationValueString(value)
	if not value then
		Dprint("ERROR: value is nil for GetRelationValueString(value)")
		return nil
	end
	if value < THRESHOLD_EXASPERATED then
		return "[COLOR_NEGATIVE_TEXT]exasperated[ENDCOLOR]"
	end
	if value < THRESHOLD_WOEFUL then
		return "[COLOR_NEGATIVE_TEXT]woeful[ENDCOLOR]"
	end
	if value < THRESHOLD_UNHAPPY then
		return "unhappy"
	end
	if value < THRESHOLD_CONTENT then
		return "content"
	end
	if value < THRESHOLD_HAPPY then
		return "happy"
	end
	if value < THRESHOLD_JOYFUL then
		return "[COLOR_POSITIVE_TEXT]joyful[ENDCOLOR]"
	end
	return "[COLOR_POSITIVE_TEXT]enthusiastic[ENDCOLOR]"
end