function [uniqueL, measures] = heuristic( X, L, xnew, W, A )
%Does a heuristic confidence and credibility estimation
%   Inputs:
%   -X    - data:                       n-by-dim
%   -L    - labels:                     n-by-1
%   -xnew - data point to be predicted: 1-by-dim
%   -W    - function that trains a model using a certain algorithm, expects
%           as input data like X and labels like L, make sure the output
%           fits in one variable (a struct might be a solution)
%   -A    - function that calculates non-conformity measure, expects as
%           input one vector from X, one label from L and the output from W

[uniqueL,idxL,L] = unique(L);

model = W(X,L); % Train a model
n = size(X,1);
a = zeros(n,1);

for i = 1:n
    xi = X(i,:);
    yi = L(i,:);
    a(i) = A(xi,yi,model);
end

measures = zeros(size(uniqueL,1),1);

for idx = idxL'
    l = L(idx);
    anew = A(xnew, l, model);
    for ii = 1:size(anew,2)
        measures(l,ii) = sum(a >= anew(:,ii))/n; %scale by size of calibration set
    end;
    %measures(l) = A(xnew, l, model);
end