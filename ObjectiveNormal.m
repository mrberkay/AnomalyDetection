function [f] = ObjectiveNormal (beta_test, X, xivector)
% Objective function for fmincon where xi is Normal distribution
% NOTE: xivecctor is transposed and delivered to ObjectiveFunction.m
% betas are delivered as (d x p) x 1 from fmincon --> DO NOT Transpose

f = norm((xivector - X*beta_test))^2;
    
end