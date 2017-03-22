function [uniqueL, measures] = heuristic( X, L, xnew, W, A )
%Does a heuristic confidence and credibility estimation
%Note that this is an older version that I no longer use

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

for l = idxL'
    anew = A(xnew, l, model);
    for ii = 1:size(anew,2)
        measures(l,ii) = sum(a >= anew(:,ii))/n; %scale by size of calibration set
    end;
    %measures(l) = A(xnew, l, model);
end