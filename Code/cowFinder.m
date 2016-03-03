

function [Z] = cowFinder(X, thresh)
    redThresholds = [165 226
                     5   75 
                     230  255];
    greenThresholds = [ 115 165
                        15   60 
                        210  255];
    blueThresholds = [50 95
                      15  50 
                      160 255];


    I = imread(X);
    red = I(:,:,1);
    green = I(:,:,2);
    blue = I(:,:,3);
    redMatch = zeros(size(I,1), size(I,2));
    greenMatch = redMatch;
    blueMatch = redMatch;

	x = 1;

	% Find Brown Matches
	matchBrownR = and(red >= redThresholds(x,1), red <= redThresholds(x,2));
	matchBrownG = and(green >= greenThresholds(x,1), green <= greenThresholds(x,2));
	matchBrownB = and(blue >= blueThresholds(x,1), blue <= blueThresholds(x,2));
	matchBrown = and(matchBrownR,and(matchBrownG,matchBrownB));

	x = x+1;

	% Find Black Matches
	matchBlackR = and(red >= redThresholds(x,1), red <= redThresholds(x,2));
	matchBlackG = and(green >= greenThresholds(x,1), green <= greenThresholds(x,2));
	matchBlackB = and(blue >= blueThresholds(x,1), blue <= blueThresholds(x,2));
	matchBlack = and(matchBlackR,and(matchBlackG,matchBlackB));

	x = x+1;
   
	% Find White Matches
	matchWhiteR = and(red >= redThresholds(x,1), red <= redThresholds(x,2));
	matchWhiteG = and(green >= greenThresholds(x,1), green <= greenThresholds(x,2));
	matchWhiteB = and(blue >= blueThresholds(x,1), blue <= blueThresholds(x,2));
	matchWhite = and(matchWhiteR,and(matchWhiteG,matchWhiteB));

    CowFound = or(or(matchWhite, matchBlack), matchBrown);
    ModImage = I;
    Gx = floor(size(I,1) / 16);
    Gy = floor(size(I,2) / 16);
    
    
    
    ret = zeros(Gx,Gy);
    for i =  1:size(I,1)
        blkI = floor(i / Gx) + 1;
        for j = 1:size(I,2)
            if CowFound(i,j)
                ModImage(i,j,:) = [0 0 255];
                blkJ = floor(j / Gy) + 1;
                ret(blkI,blkJ) = ret(blkI,blkJ) + 1;  
            end
        end
    end
    
    retMeetThresh = ret < thresh;
    for i =  1:size(I,1)
        blkI = floor(i / Gx) + 1;
        for j = 1:size(I,2)
            blkJ = floor(j / Gy) + 1;
            if retMeetThresh(blkI,blkJ)
                ModImage(i,j,:) = [255 0 0]; 
            end
        end
    end
    WithGrid = cowGrid(ModImage,16,16);
    image(WithGrid)
    Z = ret;
end

function [I] = cowGrid(I, x, y)
    Gx = floor(size(I,1) / x);
    Gy = floor(size(I,2) / y);
    disp(Gx)
    disp(Gy)
    for i = 1:size(I,1)
        for j = 1:size(I,2)
            if(mod(i,Gx) == 0)
                I(i,j,:) = [0, 0, 0];
                I(i+1,j,:) = [0,0,0];
                I(i - 1, j, : ) = [0,0,0];
            end
            if(mod(j,Gy) == 0)
                I(i,j,:) = [0, 0, 0];
                I(i,j+1,:) = [0,0,0];
                I(i,j-1, : ) = [0,0,0];
            end
        end
    end
end

