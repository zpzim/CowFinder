

function [I] = cowFinder(X)

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

    I2 = or(or(matchWhite, matchBlack), matchBrown);

    I3 = I;
    for i =  1:size(I,1)
        for j = 1:size(I,2)
            if I2(i,j)
                I3(i,j,:) = [0 0 255];
            end
        end
    end
    image(I3)
end
