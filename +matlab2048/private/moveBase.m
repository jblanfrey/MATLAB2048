function board = moveBase(board)
	for k = 1:4
		% first remove zeros
		board(:,k) = removeZeros(board(:,k));
		% and then merge blocks that can be merged
		board(:,k) = mergeBlocks(board(:,k));
	end
end
