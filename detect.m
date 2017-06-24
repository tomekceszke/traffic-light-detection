%% This script will detect traffic ligth's color 
%% in an infinitive loop.
%%
%% Author: Tomasz Ceszke 2017
 
%% ----------- init
clear ; close all; 
more off
pkg load image;

source('conf/settings.m');
source('lib/features.m');
source('lib/log_reg.m');

%% ----------- load learned factors
load 'theta.mat'; 

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
  
  X = zeros(1,numel(live_image));
  X = reshape(double(rgb2gray(live_image)),1,[]);
  if normalization    
    X = normalize(X,0);
  end
  [r h] = recognize(theta,X);
  if r==1 
    color = 'GREEN';
  else
    color = 'RED';
  end
  fprintf('%s h(x)=%.2f\n',color,h)
end