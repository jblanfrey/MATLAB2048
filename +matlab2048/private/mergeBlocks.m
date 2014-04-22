function x=mergeBlocks(x)
	if x(1)==x(2) && x(1)~=0
		if x(3)==x(4) && x(3)~=0
			x = [x(1)+x(2); x(3)+x(4); 0; 0];
		else
			x = [x(1)+x(2); x(3); x(4); 0];
		end
	elseif x(2)==x(3) && x(2)~=0
		x = [x(1); x(2)+x(3); x(4); 0];
	elseif x(3)==x(4) && x(3)~=0
		x = [x(1); x(2); x(3)+x(4); 0];
	else
		%do nothing
	end
end
