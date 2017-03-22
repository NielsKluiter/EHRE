%Simple testrun with ICP and GMLVQ on the artificial data set
uniqueL = zeros(100,2);
gamma = zeros(100,2);
cf = zeros(100,1);
cr = zeros(100,1);

%correct = lbl(selectedbin,:);
tic; [uniqueL, gamma, cf, cr] = inductive_cp(randset', lbl', outliers', @gmlvq, @ddb_gmlvq); toc
