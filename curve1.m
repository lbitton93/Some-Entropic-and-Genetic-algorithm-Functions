function [F] = curve1(b,t)
% function based on the planck curve
%   Detailed explanation goes here
a=b;
F = 30*(a./t.^2).*(1./exp(0.05*b./t -1));
end

