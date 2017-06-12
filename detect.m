%% This script will detect traffic ligth's color 
%% in an infinitive loop.
%% The image file name should be scene.png 
%%
%% Author: Tomasz Ceszke 2017
 
%% ----------- init
common;

%% ----------- load learned factors
load theta;

%% ----------- settings
live_image_path = strcat(datasource_path_prefix,'scene.png');

%% 
fprintf('Path to detect: %s \n\n',live_image_path);
while 1
  pause(1);
  try
    live_image = imread(live_image_path); 
  catch
    disp('No image');
    continue;
  end
  X = reshape(double(rgb2gray(live_image)),1,image_h*image_w);
  [r h] = recognize(theta,X);
  if r==1 
    color = 'GREEN';
  else
    color = 'RED';
  end
  fprintf('%s h(x)=%.2f\n',color,h)
end