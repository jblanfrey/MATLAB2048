classdef app2048 < handle
	%app2048 MVC
	
	properties (Access = private)
		Model
		View
		Controller
	end
	
	methods
		function app = app2048()
			app.Model = matlab2048.model2048;
			app.View = matlab2048.view2048(app.Model);
			app.Controller = matlab2048.controller2048(app.Model, app.View);
		end
	end
	
end

