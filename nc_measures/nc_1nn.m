function [ A ] = nc_1nn(xnew, y, data)
%Works with ml algorithm: pass_on
%Calculates the non-conformity measure for nearest neighbour
%data - Collected data: values and labels
%xnew - Vector to be predicted
%y - Possible prediction
%present - true xnew is in X as last value, false is xnew not in X

X = data(:,1:end-1); % Data vectors
L = data(:,end);     % Labels

distances = pdist2(X,xnew,'euclidean');

A = min(distances(L == y)) / min(distances(L ~= y));

end

