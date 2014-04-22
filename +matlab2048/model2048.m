classdef model2048 < handle
	%model2048 implements the model of the Game
	
	properties (SetAccess = private)
		Board
	end
	
	properties (Access = private)
		isGameOver = 0;
	end
	
	events
		BoardUpdated
		GameOver
	end
	
	methods
		function obj = model2048()
			% initialize the board with zeros
			obj.Board = zeros(4,4);
			
			% add 2 random numbers to the Board to start the game
			obj.addNewBlock;
			obj.addNewBlock;
		end % constructor
		
		function move(obj, direction)
			% only if the game is not over
			if obj.isGameOver == 0
				% store the board to check if anything has changed after the move
				oldBoard = obj.Board;
				% do the move depending on the direction
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
					otherwise
						% do nothing
				end
				% finally add a new block if anything changed
				if ~isequal(oldBoard, obj.Board)
					obj.addNewBlock;
				end
			end
			
		end % move
	end
	
	methods (Access = private)
		function addNewBlock(obj)
			% only if the game is not over
			if obj.isGameOver == 0
				% find the zeros and pick one randomly
				zerosID = find(obj.Board==0);
				if ~isempty(zerosID)
					num = randi(numel(zerosID),1);
					
					% add a 2 or a 4 (90% chance to add a 2, 10% chance to add a 4)
					if randi(10) < 10
						value = 2;
					else
						value = 4;
					end
					obj.Board(zerosID(num)) = value;
					
					% Broadcast event
					notify(obj, 'BoardUpdated');
				end
				
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
		end % addNewBlock
	end
end


