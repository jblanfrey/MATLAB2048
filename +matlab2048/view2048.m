classdef view2048 < hgsetget
	%view2048 Implements a view of model2048
	
	properties (Access = private)
		Figure
		Grid
		Blocks
		Model
		Colors
		Listeners = cell(0,1);
		ScreenSize  % Screen size ([width height])
	end
	
	events
		KeyPressed
	end
	
	methods
		function app = view2048(model)
			% the model
			app.Model = model;
			
			% main figure
			app.Figure = figure(...
				'MenuBar', 'none',...
				'NumberTitle', 'off',...
				'Name', 'MATLAB 2048',...
				'Position', [app.ScreenSize/2-[300, 300] 600 600],...
				'CloseRequestFcn', @app.onCloseApp,...
				'KeyPressFcn', @app.onKeyPressed);
			
			% a grid to handle all the blocks
			app.Grid = uiextras.Grid(...
				'Parent', app.Figure);
			
			% 16 Blocks
			for k=1:16
				app.Blocks{k}=matlab2048.Tile('0', [210 210 210]/255);
				set(app.Blocks{k}, 'Parent', app.Grid);
			end
			
			% read colors from file
			app.Colors = colors2048();
			
			% update the user interface
			app.onBoardUpdated(app.Model);
			
			% set up tthe grid to be 4x4
			set(app.Grid, 'RowSizes', -1*ones(4,1), 'ColumnSizes', -1*ones(4,1));
			
			% add listener
			listenerBoardUpdated = event.listener( model, 'BoardUpdated', @app.onBoardUpdated);
			listenerGameOver = event.listener( model, 'GameOver', @app.onGameOver);
			app.Listeners = {listenerBoardUpdated, listenerGameOver};
		end % constructor
	end
	
	methods (Access = private)
		function onBoardUpdated(obj, src, ~)
			for n=1:4
				for m=1:4
					text = num2str(src.Board(m,n));
					% set the text
					set(obj.Blocks{m+(n-1)*4}, 'Text', text);
					% get/set the RGB color based on the value
					color = obj.Colors(text,:).RGB;
					set(obj.Blocks{m+(n-1)*4}, 'Color', color/255);
				end
			end
		end % onBoardUpdated
		
		function onCloseApp(obj, ~, ~)
			delete(obj.Figure);
		end
		
		function onKeyPressed(obj, ~, evtdata)
			data = matlab2048.KeyPressedEventData(evtdata.Key);
			notify(obj, 'KeyPressed', data);
		end % onKeyPressed
		
		function onGameOver(~, ~, ~)
			disp('Game Over');
		end
		
	end % events handlers
	
	methods
		function val = get.ScreenSize(~)
			set(0, 'Units', 'Pixels')
			sc = get(0, 'ScreenSize');
			val = sc(3:4);
		end % get.ScreenSize
	end % accessors
end


