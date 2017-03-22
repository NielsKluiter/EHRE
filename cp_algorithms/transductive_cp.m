function [ gamma, cf, cr] = transductive_cp( X, L, xnew, W, A)
%Does transductive conformal prediction
%   Inputs:
%   -X    - data:                       n-by-dim
%   -L    - labels:                     n-by-1
%   -xnew - data point to be predicted: 1-by-dim
%   -W    - function that trains a model using a certain algorithm, expects
%           as input data like X and labels like L, make sure the output
%           fits in one variable (a struct might be a solution)
%   -A    - function that calculates non-conformity measure, expects as
%           input one vector from X, one label from L and the output from W

%   Outputs:
%   -gamma - (1-epsilon) prediction region
epsilon = 0.05;
%   -cf    - confidence measure
%   -cr    - credibility measure

[n,dim] = size(X);
[uniqueL,idxL,L] = unique(L);
[labelCount,~] = size(uniqueL);

a = zeros(n+1,1);
p = zeros(labelCount,1);

Xfull = [X ; xnew];
for idx = idxL'
    y = L(idx);
    Lfull = [L ; y];
    parfor i = 1:n+1
        Di = Xfull(1:end ~= i,:);
        Li = Lfull(1:end ~= i,:);
        a(i) = A(Xfull(i),Lfull(i),W(Di,Li));
    end
    p(y) = sum(a >= a(n+1))/(n+1);
end
[P,I] = sort(p,'descend');
gamma = (uniqueL(I(P>epsilon)));
cf = 1-P(2);
cr = P(1);