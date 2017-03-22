function [uniqueL, gamma, cf, cr] = inductive_cp( X, L, xnew, W, A)
%Does inductive conformal prediction
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
%   -gamma - prediction region for epsilon

%If we really want random
rng shuffle
rng

epsilon = 0.05;
split = 0.80; % - The fraction of data to use as proper training set
%   -cf    - confidence measure
%   -cr    - credibility measure
[n,~] = size(X);

m = floor(split * n);   %Proper training set size
k = n - m;              %Calibration set size

%Do a random rearrangement
newOrder = randperm(n)
X = X(newOrder,:);
L = L(newOrder,:);
[uniqueL,idxL,L] = unique(L);

Dtr = X(1:m,:); %Proper training set
Ltr = L(1:m,:);
Dcal = X(m+1:end,:); %Calibration set
Lcal = L(m+1:end,:);

model = W(Dtr,Ltr); % Train a model

% Get non conformity values for the calibration set
ai = zeros(k,1);
for i = 1:k
    xi = Dcal(i,:);
    yi = Lcal(i,:);
    ai(i) = A(xi,yi,model);
end

[labelCount,~] = size(uniqueL);
p = zeros(labelCount,1);

for idx = idxL'
    y = L(idx);
    xnew
    a = A(xnew, y, model) %non conformity of xnew with y
    for ii = 1:size(a,2)
        p(y,ii) = sum(ai >= a(:,ii))/k; %scale by size of calibration set
    end;
end;

% Calculate output
[P,I] = sort(p,'descend');
%gamma = (uniqueL(I(P>epsilon)));
gamma = p;
cf = 1-P(2,:);
cr = P(1,:);