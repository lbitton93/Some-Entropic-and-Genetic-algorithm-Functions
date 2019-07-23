function [F] = curve1(b,t)
% function based on the planck curve
%   Detailed explanation goes here
a=b.*2e15;
F = (a./t.^2).*(1./exp(b./t -1));
end

