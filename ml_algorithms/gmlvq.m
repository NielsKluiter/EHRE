function [ gmlvq_system ] = gmlvq( X, L )
%Trains a GMLVQ system - parameters can be changed in 'set_parameters' in
%the toolbox
%X - data   - n-by-dim
%L - labels - n-by-1
total_steps = 50;

[gmlvq_system, ~, ~] = run_single(X,L,total_steps);

end

