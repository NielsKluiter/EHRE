%Simple test run with ICP and GMLVQ
uniqueL = zeros(100,2);
gamma = zeros(100,2);
cf = zeros(100,1);
cr = zeros(100,1);

correct = lbl(selectedbin,:);
tic; [uniqueL, gamma, cf, cr] = inductive_cp(data(~selectedbin,:), lbl(~selectedbin,:), data(selectedbin,:), @gmlvq, @nc_gmlvq); toc
