function [uniqueL, measures] = heuristic_pretrained_pl( X, L, xnew, W, A )
%Does a heuristic confidence and credibility estimation given an already trained model
%Get three measures, one for the entire set, one for class 1 and one for class 2, works
%For two class problems only
%   Inputs:
%   -X    - data:                       n-by-dim
%   -L    - labels:                     n-by-1
%   -xnew - data point to be predicted: 1-by-dim
%   -W    - A model trained using a certain algorithm, that is compatible as input for A
%   -A    - function that calculates non-conformity measure, expects as
%           input one vector from X, one label from L and the output from W

[uniqueL,idxL,L] = unique(L);

model = W;
n = size(X,1);
a = zeros(n,1);

for i = 1:n
    xi = X(i,:);
    yi = L(i,:);
    a(i) = A(xi,yi,model);
end

measures = zeros(3,1);

anew = A(xnew, 1, model);
for ii = 1:size(anew,2)
    measures(1,ii) = sum(a >= anew(:,ii))/n; %scale by size of calibration set
    measures(2,ii) = sum(a(L==1) >= anew(:,ii))/sum(L==1); %rank by class of interest
    measures(3,ii) = sum(a(L~=1) >= anew(:,ii))/sum(L~=1); %rank by class of interest
end;
    %measures(l) = A(xnew, l, model);
end