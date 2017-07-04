%% This script will teach machine (by computing thetas) 
%% to detect traffic ligth's color.
%%
%% Author: Tomasz Ceszke 2017

clear ; close all; 
more off
pkg load image;

source('conf/settings.m');
source('lib/features.m');
source('lib/log_reg.m');

%% ----------- datasource
fprintf('Loading data...\n')
green_images = getImages(strcat(datasource_path_prefix,'train/green/'), extension);
fprintf('Loaded %d green light samples\n', columns(green_images));
red_images = getImages(strcat(datasource_path_prefix,'train/red/'), extension);
fprintf('Loaded %d red light samples\n', columns(red_images));
fprintf('Press any key...\n');
pause;

%% ----------- features
fprintf('Preparing features...\n')
X = [prepareFeatures(green_images); prepareFeatures(red_images)];
displaySamples(green_images, red_images, samples_to_show);
fprintf('Sample features: %d  %d  %d\n', X(1), X(2), X(3));
if normalization
  fprintf('Normalizing...')
  X  = normalize(X,1);
  fprintf('\n')
  fprintf('Sample features after normalization: %f  %f  %f\n', X(1), X(2), X(3));
end

%% ----------- label
fprintf('Preparing label...\n')
y = [ones(columns(green_images),1); zeros(columns(red_images),1)];

%% ----------- train
fprintf('Press any key...\n');
pause;
% gradient descent
fprintf('Training using gradient descent method...');
%tic
[theta cost] = trainUsingGradient(X,y,alpha,lambda,iterations);
%toc
save theta.mat theta;
figure;
plot(1:numel(cost), cost, '-b', 'LineWidth', 3);
xlabel('Number of iterations');
ylabel('Cost J');
drawnow;
hold on;
%% check accuracy
accuracy = recognize(theta,X);
fprintf('\nDone.\n Final cost: %.3f \t Accuracy: %d%% \t Sample thetas: %f  %f  %f\n\n', cost(end),round(mean(double(accuracy == y)) * 100), theta(1), theta(2), theta(3));


%fprintf('Press any key...\n');
%pause;

%% ----- fminunc
%fprintf('Training using bundled function fminunc..');
%tic
%[theta cost] = trainUsingFminunc(X,y,lambda,iterations);
%toc
%save theta.mat theta;
%plot(1:numel(cost), cost, '-r', 'LineWidth', 3);
%legend('Gradient descent', 'Fminunc')
%% check accuracy
%accuracy = recognize(theta,X);
%fprintf('\nDone.\n Final cost: %.3f \t Accuracy: %d%% \t Sample thetas: %f  %f  %f\n\n', cost(end),round(mean(double(accuracy == y)) * 100), theta(1), theta(2), theta(3));

