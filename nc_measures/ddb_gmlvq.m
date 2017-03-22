function [ A ] = nc_gmlvq( xi, yi, gmlvq_system )
%Calculates GMLVQ conformity measure for distance to decision boundary
%Input:
%xi: feature vector to find the NC measure of
%yi: the actual label of xi
%gmlvq_system: system trained using ml_algorithms/gmlvq.m:

% input
prot=gmlvq_system.protos;         % prototypes 
lambda=gmlvq_system.lambda;       % relevance matrix lambda
plbl=gmlvq_system.plbl;           % prototype labels 
mf=gmlvq_system.mean_features;    % mean features from potential z-score
st=gmlvq_system.std_features;     % st.dev. from potential z-score transf.

ztr = 1; %if z-score transformation was done in the training

omat=sqrtm(lambda); % symmetric matrix square root as one representation
                    % of the distance measure 

nfv = size(xi,1);                     % number of feature vectors in training set
ndim = size(xi,2);         % dimension of feature vectors

% if z-transformation was applied in training, apply the same here:
if (ztr==1); 
    for i=1:nfv;
        xi(i,:) = (xi(i,:)-mf)./st; 
    end;
end;

% call glvqcosts, crout=crisp labels
% score between 0= "class 1 certainly" and 1= "any other class"                                         
% margin and costf are meaningful only if lbl is ground truth

np = length(plbl); 
omat = omat/sqrt(sum(sum(omat.*omat))); % normalized omat

for iii = 1:nfv
    lbc = yi;
    distl = nan(np,1);
    for jk=1:np;
        distl(jk) = norm( omat*(xi(iii,:)-prot(jk,:))')^2;
    end;

    correct   = find (plbl == 1); %lbc
    incorrect = find (plbl ~= 1);
    [dJJ, JJJ] = min (distl (correct));
    [dKK, KKK] = min (distl (incorrect));
    %if yi == 1
    %    dJJ = dJJ + gmlvq_system.bias;
    %else
    %    dKK = dKK + gmlvq_system.bias;
    %end
    JJ=correct(JJJ); KK=incorrect(KKK);   % winner indices 

    %a dJJ
    dProts = norm( omat*(prot(JJ,:) - prot(KK,:))')^2; %b
    %c dKK

    %A = plbl(JJ)*(dJJ<=dKK) + plbl(KK)*(dJJ>dKK);
    A(iii) = (dJJ - dKK)/(2*dProts); %Negative distance from decision
    %boundary
    %A(iii) = dJJ/dKK;
    %A(iii) = (dJJ - dKK)/(dKK + dJJ);
    %A(iii) = dJJ - dKK;
end;
%A = dKK;
end

