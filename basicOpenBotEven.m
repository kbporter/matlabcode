%% BASIC C shape, edges even
function [Open] = basicOpenBotEven(Vars,numkey,numreps)

w = Vars.w;
Open.numreps = numreps;
% load noise mask to present in between trials
maskimg = imread('graymask.png');
mask = Screen('MakeTexture',w,maskimg);

%% MAKE THE SQUARE SIZES LIST

for inum = 1:Vars.numsizes
    interDist = Vars.interDistFlex;
    interDist = round(rand*interDist)+Vars.interDistConstant;
    if inum ==1
        stimRect(1:4,inum) = [Vars.x0 - interDist, Vars.y0 - interDist, Vars.x0+interDist, Vars.y0+interDist]';
    else
        stimRect(1:4,inum) = [stimRect(1,inum-1)-interDist,stimRect(2,inum-1)-interDist,stimRect(3,inum-1)+interDist,stimRect(4,inum-1)+interDist]';
    end
end


%%%%%%%%%%%%%%%%TRIAL SPECIFICATIONS %%%%%%%%%%%%%%%%%%%%%%%

itrial = 1;
for inum = 1:Vars.maxnum
    for irep = 1:Open.numreps
        %shuffle the order of the square sizes
        tempind = randperm(Vars.numsizes);
        %select only the first n
        randRect = stimRect(:,tempind(1:inum));
        %sort them in decending order and store for each trial
        tempRect = randRect';
        tempRect = sortrows(tempRect,-1);
        tempRect(:,4) = tempRect(length(tempRect(:,2)),4);
        squarelist(itrial) = {sortrows(tempRect,-1)'};
        itrial = itrial+1;
    end
end

randind = randperm(Vars.maxnum*Open.numreps);
randSquareList = squarelist(randind);



%% PRE-PRESENTATION

Screen('FillRect',w,Vars.bgColor, Vars.rect);
Screen('DrawingFinished', w, 0); %clear buffer
Screen('Flip',w, [], 0);

Open.ExpStart=GetSecs;

breaknumber = 1;
%% RUN EXPERIMENT
    
  for itrial = 1:Vars.maxnum*Open.numreps
    KeyIsDown = 0;
    KeyCode = zeros(1,256); %clear keys
    if itrial/50==floor(itrial/50) && itrial ~= Vars.maxnum*Open.numreps
        Screen('FillRect',w,Vars.bgColor, Vars.rect);
        DrawFormattedText(w, sprintf('This is rest break number %d out of 4. \n Press the space bar when you are ready to continue.',breaknumber),Vars.sx,Vars.sy);
        Screen('flip',w);
        WaitSecs(1);
        while KeyIsDown==0;
            [KeyIsDown,Secs,KeyCode] = KbCheck; %start checking for response
        end
        breaknumber = breaknumber +1;
    end
    %draw fixation for 1 s
    Screen('FillRect',w,Vars.bgColor, Vars.rect);
    Screen('FillRect',w,[0 0 0],Vars.fixrectv); %fixation cross
    Screen('FillRect',w,[0 0 0],Vars.fixrecth);
    Screen('Flip',w,[],1);
    WaitSecs(1) %keep it on the screen for 1 s
    
    %clear screen
    Screen('FillRect',w,Vars.bgColor, Vars.rect);
    %draw squares for current trial
    numsquare = length(randSquareList{itrial}(1,:));
    Open.CorrectResp(itrial) = numsquare;
    while numsquare > 0
        Screen('FrameRect',w,[0 0 0], randSquareList{itrial}(:,numsquare),Vars.penWidth);
        Screen('FillRect',w,Vars.bgColor,randSquareList{itrial}(:,numsquare)+[Vars.penWidth Vars.penWidth -Vars.penWidth Vars.penWidth]');
        numsquare = numsquare-1;
    end
    Screen('DrawingFinished',w,1)
    Screen('Flip',w,[],1); %change to 1 if want to stay on screen next flip
    ImageOnset=GetSecs;
    %end drawing stim

    % leave stimulus on screen for 200 ms
    while GetSecs-ImageOnset<.2
    end
    
    Screen('FillRect',w,Vars.bgColor, Vars.rect);
    Screen('DrawTexture',w,mask);
    Screen('Flip',w,[],1)
        
    [StoreKey, Secs] = numKeyReport(numkey); % wait for number keypress 
    
    Open.StartTime(itrial)=ImageOnset;   %the start time of each trial
    Open.TimePressed(itrial)=Secs;    %The time the key was pressed on each trial
    Open.NumResp(itrial)=StoreKey; % record response
    Open.ReportRT(itrial)=Secs-ImageOnset;  %Reaction time (time pressed-trial start)
    Open.TrialEnd(itrial)=GetSecs; %end of trial.
end
% clear screen
    Screen('FillRect',w,Vars.bgColor, Vars.rect);
    Screen('Flip',w,[],1)

% calculate error rate    
for inum = 1:Vars.maxnum
   list = find(Open.CorrectResp==inum);
   tally = 0;
   for i = 1:length(list)
      if Open.CorrectResp(list(i))==Open.NumResp(list(i))
         tally = tally+1; 
      end
   end
   Open.ErrorRate(inum) = 1-(tally/numreps);
end

% save stimuli lists within struct
Open.randSquareList = randSquareList; Open.squarelist = squarelist; 

Open.ExpEnd=GetSecs; %end of experiment
