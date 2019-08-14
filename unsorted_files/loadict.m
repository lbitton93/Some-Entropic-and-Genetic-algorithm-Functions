function [] = loadict()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%global Dictor;
global MIT4;
MIT4 = load('MIT4.mat','MIT4')
%Dictor  = matfile('dictionary.mat');
load('dictionary4', 'Dictor')
end

