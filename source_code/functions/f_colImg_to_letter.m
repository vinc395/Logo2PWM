function [letter,startp,endp,letterImg,restImg]=f_colImg_to_letter(colImg)

% convert to a line image
tmp1 = min( colImg, [], 2 );

% for a sub image, give every element a cluster code (color code)
codes = zeros(length(tmp1), 1);
for i=1:length(tmp1)
    codes(i) = f_determin_color( double(reshape(tmp1(i,1, :), [1,3]) ) );
end


% find the start and end points for the biggest letter (the biggest cluster)
startp = length(tmp1);
endp=startp;
% old_code = 5;
curr_code = 5; % start from white
ct = 0;
edge_secure = 2;


% 
for i=2:length(tmp1)
    if codes(i)==5
        
    elseif codes(i)~=5
        ct = ct +1;
        if ct==edge_secure
            curr_code = codes(i);
            startp = i-edge_secure+1;
            break
        end
    end
end


ct = 0;
%startp,
% find the end point
%for i=startp+4:length(tmp1)
if startp ~= 0
    
for i=startp:length(tmp1)
    if codes(i) ~= curr_code
        ct = ct +1;
        if ct==edge_secure
            endp = i-edge_secure+1;
            break;
        end
    end
end
%codes,
%startp, endp,

letterImg = colImg(startp:endp, :,:);
restImg = colImg(endp:end, :,:); % rest of image

if curr_code == 1
    letter = 'T';
elseif curr_code == 2
    letter = 'A';
elseif curr_code == 3
    letter = 'C';
elseif curr_code == 4
    letter = 'G';
else
    letter = '!';
end

% if ix == 3
%     startp,endp,
% end

end
