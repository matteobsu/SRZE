function [idx] = find_idxL(dataset)
%FIND_idxL Summary of this function goes here
%   This function finds the high energy treshold, for a multix LAC
%   measurement
dmu = diff(smoothn(dataset,1));
dmu(isnan(dmu))=0;
idx = 0;
interval = round(length(dmu)*1/4);
for i=1:interval
    if(length(dmu)==1)
        idx=1;
        break
    else
        left = dmu(i);
        right = dmu(i+1);
        if(left>0 && right<0)
            idx = i+1;
            break
        end
    end
    if(idx==0)
        idx = 1;
    end
end
% figure, plot(dmu), title('$\delta\mu(E)/\delta E$')
% line([idx idx],[min(dmu) max(dmu)],'color','k','linestyle','-.')
end

