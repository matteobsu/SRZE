function [idx] = find_idxH(dataset)
%FIND_idxH Summary of this function goes here
%   This function finds the high energy treshold, for a multix LAC
%   measurement
if(length(dataset)>4)
    dmu = diff(smoothn(dataset,1));
    ddmu = diff(dmu);
    ddmu(isnan(ddmu))=0;
    idx = 0;
    interval = round(length(ddmu)*1/2);
    for i=1:interval
        right = ddmu(length(ddmu)+1-i);
        left = ddmu(length(ddmu)-i);
        if(left>0 && right<0)
            idx = length(ddmu)-i;
            break
        end
    end
    idx = idx+2;
    if(idx==0)
        idx = length(dataset);
    end
else
    idx = length(dataset)+2;
end

% figure, plot(ddmu), title('$\delta^2\mu(E)/\delta E^2$')
% line([idx-2 idx-2],[min(ddmu) max(ddmu)],'color','k','linestyle','-.')
end

