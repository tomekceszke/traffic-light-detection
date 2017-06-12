%% Common settigns and methods
%%
%% Author: Tomasz Ceszke 2017
 
clear ; close all; clc
more off
pkg load image;

%% ----------- settings
global images_extension = '*.png';
global image_h = 114;
global image_w = 84;
global datasource_path_prefix = 'datasource/traffic_lights_wejherowo/';
global verb = 0;

%% ----------- functions
function g = sigmoid(z)
  g = 1.0 ./ (1.0 + exp(-z));
end

function displaySamples(samples)
  % todo: implement
end

function [r h] = recognize(theta, X)
  m = size(X, 1);
  X = [ones(m, 1) X];
  h = sigmoid(X*theta);
  r = round(h);
end