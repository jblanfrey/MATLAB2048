classdef controller2048 < handle
	%239 Summary of this class goes here
	%   Detailed explanation goes here
	
	properties
		Model
		View
		Listeners = cell(0,1);
	end
	
	methods
		function obj = controller2048(model, view)
			% store Model and View
			obj.Model = model;
			obj.View = view;
			
			% add listener
			listener = event.listener( view, 'KeyPressed', @obj.onKeyPressed);
			obj.Listeners = {listener};
		end % constructor
		
		function onKeyPressed(obj, ~, evtdata)
			switch evtdata.Key
				case 'leftarrow'
					obj.Model.move('left');
				case 'rightarrow'
					obj.Model.move('right');
				case 'downarrow'
					obj.Model.move('down');
				case 'uparrow'
					obj.Model.move('up');
				otherwise
					%do nothing
			end
		end
	end
	
end

