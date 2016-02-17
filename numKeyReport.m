function [StoreKey, Secs] = numKeyReport(numkey)

    KeyCode = zeros(1,256); %clear keys
    KeyIsDown = 0;
    Key = 0;
    TempNum=0;
 
    % ready to report
         while Key<1;
            [KeyIsDown,Secs,KeyCode] = KbCheck; %start checking for response
            if KeyIsDown
                TempNum=find(KeyCode);
                if 1<length(TempNum)
                    TempNum=0;
                end
                if (numkey(1)-1)<TempNum && TempNum<numkey(9)+1
                    Key=1;
                    StoreKey=TempNum-(numkey(1)-1);
                    clear TempNum
                else
                    clear TempNum
                    KeyCode = zeros(1,256); %clear key
                end
            end
        end                  
