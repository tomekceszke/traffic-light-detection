%% Author: Tomasz Ceszke 2017
 
1;
 
global cost_history;

function theta_reg = regularize(theta)
  theta_reg = theta;
  theta_reg(1) = 0;
end 

function g = sigmoid(z)
  g = 1.0 ./ (1.0 + exp(-z));  
end

function h = hypothesis(X, theta)
    h = sigmoid(X*theta);  
end

function J = cost(X, y, theta, lambda)
    global regularization;
    reg = 0;
    m = length(y);
    h = hypothesis(X,theta); 
    if regularization
      theta = regularize(theta); 
      reg = sum((lambda/(2*m))*(theta.^2));
    end
    J = (1/m)*(-y'*log(h)-(1-y)'*log(1-h))+reg;  
end

function [J, grad] = costFminunc(theta, X, y, lambda)
  m = length(y);
  h = hypothesis(X,theta);
  J = cost(X, y, theta, lambda);   
  grad = (1/m)*X'*(h-y) + (lambda/m)*regularize(theta);
  grad(1) = (1/m)*X(:,1)'*(h-y);
  fprintf('.');
end

function [theta cost_history] = gradientDescent(X, y, theta, alpha, lambda, iterations)  
  m = length(y);
  for iter = 1:iterations
    fprintf('.');
    temp_1theta(1) = theta(1)-(alpha/m)*X(:,1)'*(sigmoid(X*theta)-y);
    temp_theta = theta-alpha/m*X'*(sigmoid(X*theta)-y)+(lambda/m)*theta;    
    theta = temp_theta;
    theta(1) = temp_1theta;
    cost_history(iter) = cost(X, y, theta, lambda);
  end
end

function bstop = saveCostHistory(x, optv, state)
    global cost_history;
    cost_history(optv.iter)=optv.fval;
    %plot(optv.iter, optv.fval)  
    bstop = false;
endfunction

function [theta cost_history] = trainUsingGradient(X, Y, alpha, lambda, iterations)
  m = size(X, 1);
  n = size(X, 2);
  X = [ones(m, 1) X];
  initial_theta = zeros(n + 1, 1);  
  [theta cost_history] = gradientDescent(X, Y, initial_theta, alpha, lambda, iterations); 
end

function [theta cost_history] = trainUsingFminunc(X, Y, lambda, iterations)
  m = size(X, 1);
  n = size(X, 2);
  X = [ones(m, 1) X];
  initial_theta = zeros(n + 1, 1);
  global cost_history = zeros(iterations,1);
  options = optimset('GradObj', 'on', 'MaxIter', iterations,'OutputFcn', @saveCostHistory);
  theta = fminunc(@(t)(costFminunc(t, X, Y, lambda)),initial_theta, options);      
end

function p = accuracy(theta, X)
  m = size(X, 1); 
  p = zeros(m, 1);
  X = [ones(m, 1) X];
  for x_row = 1:rows(X) 
    h=sigmoid(X(x_row,:)*theta);
    [a,ia] = max(h);
    p(x_row)=ia;
  end  
end

function [r h] = recognize(theta, X)
  m = size(X, 1);
  X = [ones(m, 1) X];
  h = hypothesis(X,theta);
  r = round(h);
end

