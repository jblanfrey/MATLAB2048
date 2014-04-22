classdef model2048 < handle
	%model2048 implements the model of the Game
	
	properties
		Board = zeros(4,4);
		isGameOver = 0;
	end
	
	events
		BoardUpdated
		GameOver
	end
	
	methods
		function obj = model2048()
			% create a Board with 2 numbers
			obj.addNewBlock;
			obj.addNewBlock;
		end % constructor
		
		function move(obj, direction)
			switch direction
				case 'up'
					board = obj.Board;
					board = moveBase(board);
					obj.Board = board;
				case 'down'
					board = flipud(obj.Board);
					board = moveBase(board);
					obj.Board = flipud(board);
				case 'left'
					board = obj.Board';
					board = moveBase(board);
					obj.Board = board';
				case 'right'
					board = flipud(obj.Board');
					board = moveBase(board);
					obj.Board = flipud(board)';
			end
			% finally add a new block
			obj.addNewBlock;
		end % main method
		
		function addNewBlock(obj)
			if obj.isGameOver ==0
				% find the zeros and pick one randomly
				zerosID = find(obj.Board==0);
				num = randi(numel(zerosID),1);
				
				% add a 2 or a 4 (90% chance to add a 2, 10% chance to add a 4)
				if randi(10) < 10
					value = 2;
				else
					value = 4;
				end
				indexUpdated = zerosID(num);
				obj.Board(indexUpdated) = value;
				
				% Broadcast event
				notify(obj, 'BoardUpdated');
				
				% is the game over?
				% if there is no zero and no identical contiguous numbers, the game is over
				if nnz(obj.Board)==16
					d1 = diff(obj.Board, 1, 1);
					d2 = diff(obj.Board, 1, 2);
					if (numel(find(d1==0)) + numel(find(d2==0))) == 0
						obj.isGameOver = 1;
						notify(obj, 'GameOver');
					end
				end
			end
		end % addNewBlock (fires event)
	end
	
end

