function y = removeZeros(x)
	y = zeros(4,1);
	if x==zeros(4,1)
		% do nothing in this case
		return
	else
		idx = find(x~=0);
		y(1:numel(idx)) = x(idx);
	end
end
