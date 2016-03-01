

function [I] = cowFinder(X)

    redThresholds = [165 226
                     0   75 
                     245  256];
    greenThresholds = [ 115 165
                        0   60 
                        230  256];
    blueThresholds = [50 95
                      0  50 
                      190 256];


    I = imread(X);
    red = I(:,:,1);
    green = I(:,:,2);
    blue = I(:,:,3);
    redMatch = zeros(size(I,1), size(I,2));
    greenMatch = redMatch;
    blueMatch = redMatch;

    for x = 1:3
        match = and(red > redThresholds(x,1), red < redThresholds(x,2));
        redMatch = or(redMatch, match);
    end
    for x = 1:3
        match = and(green > greenThresholds(x,1), green < greenThresholds(x,2));
        greenMatch = or(greenMatch, match);
    end
    for x = 1:3
        match = and(blue > blueThresholds(x,1), blue < blueThresholds(x,2));
        blueMatch = or(blueMatch, match);
    end
    I2 = and(and(redMatch, greenMatch), blueMatch);
    %disp(I2)
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
