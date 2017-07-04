%% This script will test how accurate is   
%% detection of traffic ligth's color.
%% Testing samples should be located into two sub-folders: 
%% test/green/ and test/red/
%%
%% Author: Tomasz Ceszke 2017

%% ----------- init
clear ; close all; 
more off
pkg load image;

source('conf/settings.m');
source('lib/features.m');
source('lib/log_reg.m');

%% ----------- load theta
load 'theta.mat'; 

%% ----------- test data
green_test_images = getImages(strcat(datasource_path_prefix,'test/green/'), extension);
fprintf('Loaded %d green light test samples\n', columns(green_test_images));
red_test_images = getImages(strcat(datasource_path_prefix,'test/red/'),extension);
fprintf('Loaded %d red light test samples\n', columns(red_test_images));

%% ----------- features
X = [prepareFeatures(green_test_images); prepareFeatures(red_test_images)];
if normalization
  fprintf('Normalizing...')
  X  = normalize(X,0);
  fprintf('\n')
end

%% ----------- labels
Y = [ones(columns(green_test_images),1); zeros(columns(red_test_images),1)];

%% ----------- check accuracy
fprintf('Testing...')
accuracy = recognize(theta,X);
fprintf('\nAccuracy for test samples: %d%%\n\n',round(mean(double(accuracy == Y)) * 100));