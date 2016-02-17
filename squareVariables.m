
function [Vars,numreps] = squareVariables()


%% DECLARE VARIABLES
Vars.penWidth = 3; %line thickness
Vars.maxnum = 7; %max numerosity presented 
Vars.numsizes = 10; % number of size options for squares
% numreps = 30; % num repetitions per numerosity (for data collection)
numreps = 1; % short version for debugging 
Vars.interDistFlex = 5; % the ratio btw. this and Constant is the impt one for how much space is btw the squares at minimum (impt 4 jitter) - smaller ratio Flex/Constant= more space
Vars.interDistConstant = 12; % min distance btw square sizes
Vars.windSize = [0 0 800 800]; % screen size for debugging
% Vars.windSize = []; % screen size for actual data collection (full screen)
Vars.bgColor = [128 128 128]; % gray background color (RGB)
Vars.colors = [200 50 50; 50 50 200; 200 200 50]'; % colors for experiments that require different color stimuli
Vars.width = 1; %fixation cross dimensions 
Vars.height = 5;
