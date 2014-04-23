classdef Tile < uiextras.CardPanel
	%Tile a rectangle with text and color in a CardPanel container
	
	properties (Dependent)
		Text
		Color
	end
	
	properties (Access = private)
		hAxes
		hRectangle
		hText
	end
	
	methods
		function obj = Tile(t,c)
			obj.hAxes=axes(...
				'Parent',obj,...
				'XTick', [],...
				'YTick', [],...
				'PlotBoxAspectRatio', [1 1 1],...
				'Visible', 'off');
			axis square;
			
			obj.hRectangle=rectangle(...
				'Parent', obj.hAxes,...
				'Curvature', [0.2 0.2],...
				'EdgeColor', [0 0 0],...
				'FaceColor', c);
			
			obj.hText=text(...
				'Parent', obj.hAxes,...
				'String', t,...
				'Position', [0.5 0.5],...
				'FontUnits', 'Pixels', ...
				'FontSize', 48,...
				'VerticalAlignment', 'middle', ...
				'HorizontalAlignment', 'center');
		end
		
		function value = get.Text(obj)
			value = get(obj.hText, 'String');
		end
		
		function set.Text(obj, t)
			set(obj.hText, 'String', t);
		end
		
		function value = get.Color(obj)
			value = get(obj.hRectangle, 'FaceColor');
		end
		
		function set.Color(obj, c)
			set(obj.hRectangle, 'FaceColor', c);
		end
	end
	
end

