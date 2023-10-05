clc;
clear all;
close all;

%DATA
w1 = [0.1 1.1;
6.8 7.1;
-3.5 -4.1;
2.0 2.7;
4.1 2.8;
3.1 5.0;
-0.8 -1.3;
0.9 1.2;
5.0 6.4;
3.9 4.0];
w2 = [7.1 4.2;
-1.4 -4.3;
4.5 0.0;
6.3 1.6;
4.2 1.9;
1.4 -3.2;
2.4 -4.0;
2.5 -6.1;
8.4 3.7;
4.1 -2.2];
w3 = [-3.0 -2.9;
0.5 8.7;
2.9 2.1;
-0.1 5.2;
-4.0 2.2;
-1.3 3.7;
-3.4 6.2;
-4.1 3.4;
-5.1 1.6;
1.9 5.1 ];
w4 = [-2.0 -8.4;
-8.9 0.2;
-4.2 -7.7;
-8.5 3.2;
-6.7 -4.0;
-0.5 -9.2;
-5.3 -6.7;
-8.7 -6.4;
-7.1 -9.7;
-8.0 -6.3];

%%% 1(a)  %%%%
n1 = size(w1,1) ;
n2 = size(w2,1) ;

y1= [ones(n1,1) w1];
y2= [ones(n2,1) w2];

Y = [y1;-y2];

a = [ 0 0 0]';
b=0.1;
LR = 0.1;
Theta=0.001;
n=n1+n2;


n1 = size(w1,1) ;
n2 = size(w2,1) ;
n = n1 + n2; % total sample number
Y = [ones(n1,1) w1;
-ones(n2,1) -w2];
a = [ 0 0 0]';
ita = 0.3;
theta = 0.001;
b = 0.5;
[a,k] = MyPerceptron_Batch_Relax(a,b,ita,theta,Y);
%MyHyperPlot(a,Y,n1,"w1","w2");
fprintf(strcat("Number of iterations needed to converge, k =",num2str(k), "\n"));





function [a,k] = MyPerceptron_Batch_Relax(a,b, ita, theta,Y)
error = 1;
k = 1;
n = size(Y,1);
while (error > theta)
sum_y_miss = [0; 0; 0];
criteria_func(k) = 0;
count(1,k) = 0;
for i = 1:n
y = Y(i,:)';
if a'*y <= b
criteria_func(k) = criteria_func(k) + (1/(2*norm(y,2)^2))*(a'*y - b)^2;
cost = (1/norm(y,2)^2)*(b - a'*y)*y;
sum_y_miss = sum_y_miss + cost;
count(1,k) = count(1,k) + 1;
end
end
a = a + ita*sum_y_miss;
error = norm(ita*sum_y_miss,2);
k = k + 1;
end
figure
plot(criteria_func);
xlabel('Number of passes k');
ylabel('Criterion Function Jr(a)');
title('Plot of criterion function');
end