function [score] = read_Cache(sequence,Map)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
sequence = num2str(sequence);
score = Map(sequence);
end

