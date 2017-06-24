%% Author: Tomasz Ceszke 2017

1;

function images = getImages(path, extension)
  imagefiles = dir(strcat(path,extension));      
  files_count = length(imagefiles);
  images = cell(files_count);
  if files_count == 0
    return;
  end
  for i=1:files_count
     currentfilename = imagefiles(i).name;
     currentimage = imread(strcat(path,currentfilename));
     images{i} = rgb2gray(currentimage);
  end
end


function displaySamples(green_images, red_images, images_to_show)
  green = [green_images(randperm(size(green_images,2))(1:images_to_show)){:}];
  pad = repmat(255, 10, size(green,2));
  red = [red_images(randperm(size(red_images,2))(1:images_to_show)){:}];
  imshow([green; pad; red])  
  drawnow;  
end

function X = prepareFeatures(images)
  images_count = columns(images);
  X = zeros(images_count,numel(images{1}));
  for k=1:images_count
    X(k,:) = reshape(images{k},1,[]);
  end
end

function X = normalize(X, compute)  
  if compute
    mu = zeros(1, size(X, 2));
    sigma = zeros(1, size(X, 2));
  else
    load mu;
    load sigma;
  end  
  
  for n = 1:size(X, 2)
    %if mod(n,size(X, 2)/100)==0
    %  fprintf('.')
    %end
    if compute
      mu(n) = mean(X(:,n));     
      X(:,n) = X(:,n)- mu(n);     
      sigma(n) = std(X(:,n));     
      X(:,n) = X(:,n)/ sigma(n);
    else
      X(:,n) = (X(:,n)- mu(n))/sigma(n);
    end
  end
  if compute
    save mu.mat mu;
    save sigma.mat sigma;
  end
end
