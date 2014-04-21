classdef model2048 < handle
	%model2048 Game class
	%   this class defines the model for the 2048 game
	
	properties
		Board = nan(4,4)
	end
	
	events
		blockAdded
	end
	
	methods
		function obj = model2048()
			% create a Board with 2 numbers
			obj.addNewBlock;
			obj.addNewBlock;
		end
		
		function addNewBlock(obj)
			% find the NaNs and pick one randomly
			nanID = find(isnan(obj.Board));
			num = randi(numel(nanID),1);
			
			% add a 2 or a 4 (90% chance to add a 2, 10% chance to add a 4)
			if randi(10) < 10
				val = 2;
			else
				val = 4;
			end
			obj.Board(nanID(num)) = val;
		end
	end
	
end

