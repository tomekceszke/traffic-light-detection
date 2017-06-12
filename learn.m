%% This script will teach machine (by computing thetas) 
%% to detect traffic ligth's color.
%% Training samples should be located into two sub-folders: green/ and red/
%%
%% Author: Tomasz Ceszke 2017


%% ----------- init 
common;

%% ----------- settings
lambda = 0.1;
iterations = 30;
method = 1;

green_light_path = strcat(datasource_path_prefix,'train/green/');
red_light_path = strcat(datasource_path_prefix,'train/red/');   

%% ----------- functions
function [images] = getImages(path)
  global images_extension;
  imagefiles = dir(strcat(path,images_extension));      
  files_count = length(imagefiles);
  for i=1:files_count
     currentfilename = imagefiles(i).name;
     currentimage = imread(strcat(path,currentfilename));
     images{i} = rgb2gray(currentimage);
  end
end

function [X] = prepareFeatures(images)
  global image_h;
  global image_w;
  images_count = columns(images);
  X = zeros(images_count,image_h*image_w);
  for k=1:images_count
    X(k,:) = reshape(images{k},1,image_h*image_w);
  end
end

function [J, grad] = costFunction(theta, X, y, lambda)
  global verb;
  J = 0;
  grad = zeros(size(theta));
  m = length(y); % number of training examples
  h = sigmoid(X*theta);
  theta_reg = theta;
  theta_reg(1) = 0;
  reg = sum((lambda/(2*m))*(theta_reg.^2));
  J = (1/m)*(-y'*log(h)-(1-y)'*log(1-h))+reg;  
  grad = (1/m)*X'*(h-y) + (lambda/m)*theta_reg;
  grad(1) = (1/m)*X(:,1)'*(h-y);
  %grad = grad(:);  
  if verb 
    disp(J);
  else 
    fprintf('.');
  end;
end

function [theta cost] = train(X, Y, lambda, iterations, method)
  m = size(X, 1);
  n = size(X, 2);
  X = [ones(m, 1) X];
  initial_theta = zeros(n + 1, 1);
  options = optimset('GradObj', 'on', 'MaxIter', iterations);
%  if method==1
    [theta cost] = fminunc(@(t)(costFunction(t, X, Y, lambda)),initial_theta, options);  
%  elseif method==2
%  end
end

function p = accuracy(theta, X)
  m = size(X, 1); 
  p = zeros(m, 1);
  X = [ones(m, 1) X];
  for x_row = 1:rows(X) % [x0...x400]
    %for theta_row = 1:rows(all_theta) % [theta0;...theta400;] 
    h=sigmoid(X(x_row,:)*theta);
    [a,ia] = max(h);
    p(x_row)=ia;
    %end
    %if mod(x_row,10)==1 
      fprintf('.');
    %end
  end  
end

%% ----------- datasource
green_images = getImages(green_light_path);
fprintf('Loaded %d green light samples\n', columns(green_images));
%imshow(green_images{1});
red_images = getImages(red_light_path);
fprintf('Loaded %d red light samples\n', columns(red_images));
%imshow(red_images{1})
%displaySamples();

%% ----------- features
X = [prepareFeatures(green_images); prepareFeatures(red_images)];

%% ----------- labels
Y = [ones(columns(green_images),1); zeros(columns(red_images),1)];

%% ----------- train
fprintf('Press any key...\n\n');
pause;

fprintf('Training...');
[theta cost] = train(X,Y,lambda,iterations, method);
save theta.mat theta;

%% ----------- check accuracy
accuracy = recognize(theta,X);
fprintf('\nDone.\n Cost: %.3f Accuracy: %d%%\n\n',cost,round(mean(double(accuracy == Y)) * 100));











