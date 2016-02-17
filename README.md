# matlabcode

### Run requirements:
- Matlab - written for R2015a but should be compatible with most recent versions
- Psychtoolbox - download + installation instructions: http://psychtoolbox.org/download/
- data subfolder within the folder containing the scripts

### Scripts 
#### runSquares3b.m
- wrapper script that creates, presents, and then plots the error rate of a subject’s performance on three behavioral mini-experiments, including a practice session at the start 
- the order of mini-experiment is randomized based on the subject number -- input at the command line 
- the task is to enumerate the number of squares/arches in each display for each mini-experiment.
- *Be sure to modify the Priority level* (re: other applications/processes running). It must be updated at line 8 based on your operating system - use 9 for Mac OSx, and 2 for Windows 

#### squareVariables.m
- function to modify variables across multilple experiments easily
- For debugging, the default window size is set to 800x800 pixels, and the default number of presentations per stimulus type (7 numerosities x 3 experiments) is 1. These should be updated for data collection.

#### basicrect3.m
- control experiment with concentric squares
- creates stimulus set, presents it, and passes the data back to the wrapper script
- each presentation contains 1-7 squares, all displays are unique for each subject
- a self-timed break occurs every 50 trials (when in data-collection mode, fewer than 50 trials with debug settings)

#### basicOpenBot.m 
- test condition with concentric arches with open bottoms 
- creates stimulus set, presents it, and passes the data back to the wrapper script
- each presentation contains 1-7 squares, all displays are unique for each subject
- a self-timed break occurs every 50 trials (when in data-collection mode, fewer than 50 trials with debug settings)

#### basicOpenBotEven.m
- test condition with concentric arches with even length open bottoms 
- creates stimulus set, presents it, and passes the data back to the wrapper script
- each presentation contains 1-7 squares, all displays are unique for each subject
- a self-timed break occurs every 50 trials (when in data-collection mode, fewer than 50 trials with debug settings)

### Other 
#### graymask.png
- a grayscale noise image to serve as a mask between trials to avoid afterimage effects

#### data folder
- folder accessed by runSquares3b.m to store datafiles
