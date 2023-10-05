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

%%% 2(a)  %%%%
n1 = size(w1,1) ;
n2 = size(w2,1) ;

y1= [ones(n1,1) w1];
y2= [ones(n2,1) w2];

Y = [y1;-y2];

a = [ 0 0 0]';
b=0.1;
LR = 0.25;
Theta=0.001;
n=n1+n2;
[a,iterations,cF] = Batch_PLA_relax(w1,w2,y1,y2,n,Y,a,b,LR,Theta);
figure
plot(cF);
xlabel('Iteration number');
ylabel('Crit Func');
title('Criterion function for 2(a)');

disp("Final a values=");
disp(strcat(num2str(a(1)),", ",num2str(a(2)),", ",num2str(a(3))));

decision_boundary(a,y1,y2,"w1","w2","Problem 2(a)");
disp(strcat("Number of iterations=",num2str(iterations)));




%%%% 2b %%%%%
n1 = size(w1,1) ;
n2 = size(w2,1) ;
y1= [ones(n1,1) w1];
y2= [ones(n2,1) w2];
Y = [y1;-y2];
a = [ 0 0 0]';
b=0.5;

n=n1+n2;
[a,iterations,cF] = Batch_PLA_relax(w1,w2,y1,y2,n,Y,a,b,LR,Theta);
figure
plot(cF);
xlabel('Iteration number');
ylabel('Crit Func');
title('Criterion function for 2(b)');

disp("Final a values=");
disp(strcat(num2str(a(1)),", ",num2str(a(2)),", ",num2str(a(3))));
decision_boundary(a,y1,y2,"w1","w2","Problem 2(b)");
disp(strcat("Number of iterations =",num2str(iterations)));


%%%% 2(C)%%%%%

a = [ 0 0 0]';
b=0.1;

n=n1+n2;
[a,iterations,cF] = Single_PLA_relax(w1,w2,y1,y2,n,Y,a,b,LR,Theta);
figure
plot(cF);
xlabel('Iteration number');
ylabel('Crit. Func. Value');
title('Criterion function for 2(c)');

disp("Final a values=");
disp(strcat(num2str(a(1)),", ",num2str(a(2)),", ",num2str(a(3))));
decision_boundary(a,y1,y2,"w1","w2","Problem 2(c)");
disp(strcat("Number of iterations =",num2str(iterations)));



%Functions

function [a,iter,cF] = Single_PLA_relax(w1,w2,y1,y2,n,Y,a,b,LR,Theta)
error = 1;
k = 1;
n = size(Y,1);
iter=1;
while (error > Theta)
cF(iter) = 0;
%for k=1:n
y = Y(k,:)';
if a'*y <= b
cost = (1/norm(y,2)^2)*(b - a'*y)*y;
cF(iter) = (1/(2*norm(y,2)^2))*(a'*y - b)^2;
end

a = a + LR*cost;
error = norm(LR*cost,2);
k=mod(k,n)+1;


iter=iter+1;


end


end


function [a,iter,cF] = Batch_PLA_relax(w1,w2,y1,y2,n,Y,a,b,LR,Theta);
error = 100;
iter = 1;

while (error > Theta)
y_miss = [0; 0; 0];
cF(iter) = 0; %CRITERON FUNCTION

for i = 1:n
y = Y(i,:)';
if a'*y <= b
cF(iter) = cF(iter) + (1/(2*norm(y,2)^2))*(a'*y - b)^2;
cost = (1/norm(y,2)^2)*(b - a'*y)*y;
y_miss = y_miss + cost;
end
end
a = a + LR*y_miss;
error = norm(LR*y_miss,2);
iter = iter + 1;
end

end

function [] = decision_boundary(a,y1,y2,W1,W2,title_plot)
figure

scatter(y1(:,2),y1(:,3),'r');
hold on

scatter(y2(:,2),y2(:,3),'b');

x1=-10:0.1:10;
x2 = (-a(2)*x1 -a(1))./a(3);
hold on
plot(x1,x2,'k');
xlabel('x1');
ylabel('x2');
legend(W1,W2,'Separating Line')
title(title_plot);

end