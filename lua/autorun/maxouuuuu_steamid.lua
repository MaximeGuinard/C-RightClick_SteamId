local maxouuuuu_steamid = {}

if SERVER then
	

end

if CLIENT then

	local function clickleft()

		local t = "Faites clique gauche sur un joueur pour copier son SteamID"

		surface.SetFont("Trebuchet24")
		local w,h = surface.GetTextSize(t)

		draw.RoundedBox(0,(ScrW()/2)-(w/2)-5,32,w+10,h,Color(0,0,0,200))
		draw.SimpleText(t,"Trebuchet24",ScrW()/2,32,Color(255,255,255,255), TEXT_ALIGN_CENTER)


	end

	hook.Add( "OnContextMenuOpen", "maxouuuuu_steamid_add", function()
		if not maxouuuuu.Admin.Groups[ LocalPlayer():GetUserGroup() ] then
   			hook.Add("HUDPaint","maxouuuuu_steamid_hudpaint2",clickleft)
   		end
	end)

	hook.Add( "OnContextMenuClose", "maxouuuuu_steamid_supress", function()
		if not maxouuuuu.Admin.Groups[ LocalPlayer():GetUserGroup() ] then
			hook.Remove("HUDPaint","maxouuuuu_steamid_hudpaint2")
		end
	end)

	hook.Add("HUDPaint","maxouuuuu_steamid_hudpaint",function()

		if maxouuuuu.Admin.Groups[ LocalPlayer():GetUserGroup() ] then
			if IsValid(maxouuuuu.Admin.ContextMenuBottom) and maxouuuuu.Admin.ContextMenuBottom:IsVisible() then
				
				if not LocalPlayer():HasAdminMode() then
					local t = "Faites clique gauche sur un joueur pour copier son SteamID"

					surface.SetFont("Trebuchet24")
					local w,h = surface.GetTextSize(t)

					draw.RoundedBox(0,(ScrW()/2)-(w/2)-5,10,w+10,h,Color(0,0,0,200))
					draw.SimpleText(t,"Trebuchet24",ScrW()/2,10,Color(255,255,255,255), TEXT_ALIGN_CENTER)
				end

			end
		end

	end)

	hook.Add( "GUIMousePressed", "maxouuuuu_steamid_Click", function( code, vector )

		if ( code == MOUSE_LEFT && !input.IsButtonDown( MOUSE_RIGHT ) ) then

			local eyepos = LocalPlayer():EyePos()
			local eyevec = vector

			local ply = LocalPlayer()
			local filter = ply:GetViewEntity()

			if ( filter == ply ) then
				local veh = ply:GetVehicle()

				if ( veh:IsValid() && ( !veh:IsVehicle() || !veh:GetThirdPersonMode() ) ) then
					-- A dirty hack for prop_vehicle_crane. util.TraceLine returns the vehicle but it hits phys_bone_follower - something that needs looking into
					filter = { filter, veh, unpack( ents.FindByClass( "phys_bone_follower" ) ) }
				end
			end

			local trace = util.TraceLine( {
				start = eyepos,
				endpos = eyepos + eyevec * 1024,
				filter = filter
			} )

			-- Hit COLLISION_GROUP_DEBRIS and stuff
			if ( !trace.Hit || !IsValid( trace.Entity ) ) then
				trace = util.TraceLine( {
					start = eyepos,
					endpos = eyepos + eyevec * 1024,
					filter = filter,
					mask = MASK_ALL
				} )
			end

			local ent = trace.Entity

			if not (IsValid(ent)) then return end

			if ent.IsBot == nil then
				
				return

			end

			if maxouuuuu.Admin.Groups[ LocalPlayer():GetUserGroup() ] then

				if (ent:IsBot() or ent:IsPlayer()) and IsValid(maxouuuuu.Admin.ContextMenuBottom) and maxouuuuu.Admin.ContextMenuBottom:IsVisible() then
					
					SetClipboardText(ent:SteamID())
					notification.AddLegacy( "Vous avez bien copié le SteamID : "..ent:SteamID(), 0, 2 ) 

				end

			else

				if (ent:IsBot() or ent:IsPlayer()) and IsValid(g_ContextMenu) and g_ContextMenu:IsVisible() then
					
					SetClipboardText(ent:SteamID())
					notification.AddLegacy( "Vous avez bien copié le SteamID : "..ent:SteamID(), 0, 2 ) 

				end

			end

		end

	end )


end