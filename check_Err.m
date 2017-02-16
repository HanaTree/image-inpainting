function [ Err ] = check_Err(restored, original,rows,cols)

avg = 0;

for j=1:length(rows)
        x=rows(j);
        y=cols(j);
        diff = restored(x,y)-original(x,y);
        diff2 = abs(diff)*abs(diff);
        %avg = (avg*(j-1)+diff2)/j*100;
        avg = uint64(avg) + uint64(diff2);
end

% s = size(restored);
% 
% numRows = s(1);
% numCols = s(2);
% 
% sum = 0;
% 
% for i=1:numRows
%     for j=1:numCols
%         diff = abs(restored(i,j)-original(i,j));
%         sum = sum + diff*diff;
%     end
% end

Err = avg/40233;

end