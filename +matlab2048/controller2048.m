classdef controller2048 < handle
	%controller2048 This class allows a user to interact with the model and
	%the view
	
	properties (Access = private)
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
	end
	
	methods (Access = private)
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
					% do nothing
			end
		end
	end
	
end

