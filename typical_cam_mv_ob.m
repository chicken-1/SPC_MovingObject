clc,
clear all,
close all,
% Parameters
frameSize = 64;
objectSize = 10;
s = 35;

img = zeros(frameSize, frameSize);

%%%%%%% Linear moving %%%%%%%
xStart = 1; % Starting x position
yPos = 30; % y position (centered vertically)
if s == 0
    img(yPos:yPos + objectSize - 1, round(xPos):round(xPos + objectSize - 1)) = 255;
else
% Loop to create the blur effect 
for i = 0:s-1
    xPos = xStart + i * 1;
    
    if round(xPos) + objectSize - 1 <= frameSize
        intensity = 255 - ((s - i) / s)*255;
        mea = zeros(frameSize, frameSize);        
        mea(yPos:yPos + objectSize - 1, xPos:xPos + objectSize - 1) = intensity;
        img = img + mea;
    end
end
end

%%%%%%% Diagonally moving %%%%%%%
% xStart = 1; % Starting x position
% yStart = 1; % Starting y position (centered vertically)
% 
% % Loop to create the blur effect
% for i = 0:s-1
%    % Calculate the current position of the square
%     xPos = xStart + i; % Increment x position based on speed
%     yPos = yStart + i; % Increment y position for diagonal movement
%     
%     % Ensure the square does not go out of bounds
%     if round(xPos) + objectSize - 1 <= frameSize && round(yPos) + objectSize - 1 <= frameSize
%         % Draw the square at the current position with decreasing intensity
%         intensity = 255 - ((s - i) / s) * 255; % Decrease intensity over time
%         img(yPos:yPos + objectSize - 1, xPos:xPos + objectSize - 1) = intensity;
%     end
% end

%%%%%%% oscillation %%%%%%%


img = img / max(img(:));
% Display the static blurry image
imshow(img, 'InitialMagnification', 'fit');
% title(sprintf('Exposure Time %f, speed %d', exposureTime, speed));
