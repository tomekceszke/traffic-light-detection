%% This script will test how accurate is   
%% detection of traffic ligth's color.
%% Testing samples should be located into two sub-folders: 
%% test/green/ and test/red/
%%
%% Author: Tomasz Ceszke 2017

%% ----------- init
common;

%% ----------- load learned factors
load theta; 

%% ----------- settings
green_light_test_path = strcat(datasource_path_prefix,'test/green/');
yellow_light_test_path = strcat(datasource_path_prefix,'test/yellow/');
red_light_test_path = strcat(datasource_path_prefix,'test/red/');

%% ----------- datasource
green_test_images = getImages(green_light_test_path);
fprintf('Loaded %d green light test samples\n', columns(green_test_images));
red_test_images = getImages(red_light_test_path);
fprintf('Loaded %d red light test samples\n', columns(red_test_images));

X_green_samples = [prepareFeature(green_test_images)];
X_red_samples = [prepareFeature(red_test_images)];

%% ----------- features
X = [prepareFeature(green_test_images); prepareFeature(red_test_images)];

%% ----------- labels
Y = [ones(columns(green_test_images),1); zeros(columns(red_test_images),1)];

%% ----------- check accuracy
accuracy = recognize(theta,X);
fprintf('\nAccuracy for test samples: %d%%\n\n',round(mean(double(accuracy == Y)) * 100));