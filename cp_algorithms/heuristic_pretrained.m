function [uniqueL, measures] = heuristic_pretrained( X, L, xnew, W, A )
%Does a heuristic confidence and credibility estimationv given an already trained model
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

measures = zeros(size(uniqueL,1),1);

for idx = idxL'
    l = L(idx);
    anew = A(xnew, l, model);
    for ii = 1:size(anew,2)
        %measures(l,ii) = sum(a >= anew(:,ii))/n; %scale by size of calibration set
        measures(l,ii) = sum(a(L==l) >= anew(:,ii))/sum(L==l); %rank by class of interest
    end;
    %measures(l) = A(xnew, l, model);
end