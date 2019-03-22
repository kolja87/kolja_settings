macroScript test_ui
    category:"kolja_scripts-rnd"
    ButtonText:"modeling_toolkit"
    toolTip:"Some modeling helper commands."
    silentErrors:false
    autoUndoEnabled:true
(
	-- Define rollout ui elements and commands to execute on events.
    rollout kolja_modeling_toolkit_rollout "Kolja's Modeling Tools" width:168 height:408
    (
    	GroupBox 'grp_Colors' "colors" pos:[8,8] width:152 height:144 align:#left
    	button 'btn_SetGrayClr' "gray color" pos:[16,24] width:136 height:24 align:#left
    	button 'btn_SetBlueClr' "blue color" pos:[16,56] width:136 height:24 align:#left
		button 'btn_SetGreenClr' "green clr" pos:[16,88] width:136 height:24 align:#left
		button 'btn_MaterialUndefined' "material to undefined" pos:[16,120] width:136 height:24 align:#left

    	GroupBox 'grp_Pos' "XForm" pos:[8,160] width:152 height:120 align:#left
		button 'btn_PivotToOrigin' "pivot to origin" pos:[16,176] width:136 height:24 align:#left
		button 'btn_PivotToCenter' "pivot to center" pos:[16,208] width:136 height:24 align:#left
    	button 'btn_MoveToOrigin' "move to origin" pos:[16,208] width:136 height:24 align:#left
		button 'btn_ResetXForm' "reset xform and colapse" pos:[16,240] width:136 height:24 align:#left
		
		groupBox 'grp_Geometry' "geometry" pos:[8,280] width:152 height:48 align:#left
		button 'btn_CollapseToEditPoly' "collapse to edit poly" pos:[16,296] width:136 height:24 align:#left
		
    	groupBox 'grp_Create' "Create" pos:[8,336] width:152 height:48 align:#left
    	button 'btn_ShadowPlane' "new shadow plane" pos:[16,352] width:136 height:24 align:#left
		
		-- Set wire color of selected objects to standard 50% gray color
    	on btn_SetGrayClr pressed do
    	(
    		objs = selection as array
    		For item in objs do
    		(
    			item.wirecolor = gray
    		)
		)
		
		-- Set wire color of selected objects to custom blue color
    	on btn_SetBlueClr pressed do
    	(
    		objs = selection as array
    		For item in objs do
    		(
    			item.wirecolor = color 19 19 71
    		)
		)
		
		-- Set wire color of selected objects to custom green color
    	on btn_SetGreenClr pressed do
    	(
    		objs = selection as array
    		For item in objs do
    		(
    			item.wirecolor = color 30 70 33
    		)
		)
		
		-- Set material to undefined or null
		on btn_MaterialUndefined pressed do
		(
			objs = selection as array
			For item in objs do
			(
				item.material = null
			)
		)

		-- Move pivot point to world origin [0,0,0] of selected objects
    	on btn_PivotToOrigin pressed do
    	(
    		objs = selection as array
    		For item in objs do
    		(
    			item.pivot = [0,0,0]
    		)
		)

		-- Move pivot point to center of object
		on btn_PivotToCenter pressed do
			(
				objs = selection as array
				For item in objs do
				(
					item.pivot = item.center
				)
			)
		
		-- Move selected objects to world origin [0,0,0]
    	on btn_MoveToOrigin pressed do
	    (
			objs = selection as Array
			for item in objs do
			(
				item.pos = [0,0,0]
			)
		)
		
		-- Reset xform of slected objects and collapse them to editable poly base geometry level
    	on btn_ResetXForm pressed do
	    (
			objs = selection as array

			for item in objs do
			(
				ResetXForm item

				if selection.count != 0 do
				(
					with redraw off
					(
						for o in selection where canconvertto o Editable_Poly do
						(
							if not isKindOf o Editable_Poly do convertToPoly o
							PolyToolsModeling.Quadrify off off
						)
					)
				)
			)
		)
		
		-- Collapse modifier stack to editable poly
		on btn_CollapseToEditPoly pressed do
		(
			objs = selection as array

			for item in objs do
			(
				if selection.count != 0 do
				(
					with redraw off
					(
						for o in selection where canconvertto o Editable_Poly do
						(
							if not isKindOf o Editable_Poly do convertToPoly o
							PolyToolsModeling.Quadrify off off
						)
					)
				)
			)
		)

		-- Create shadow plane 100x100cm
		on btn_ShadowPlane pressed do
		(
			shadowPlane = Plane position:[0,0,0] width:100.0 length:100.0 wirecolor:gray widthsegs:1 lengthsegs:1 name:"shadow_plane"
			convertTo shadowPlane Editable_Poly
		)
    )
	
	-- Create rollout when toolbar button is clicked
	createDialog kolja_modeling_toolkit_rollout
)
	
	

