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

%%% 3(a)  %%%%


LR = 0.5;
bmin = 0.5;
kmax=500;

n1 = size(w1,1) ;
n2 = size(w3,1) ;

y1= [ones(n1,1) w1];
y2= [ones(n2,1) w3];

Y = [y1;-y2];


a = [ 0 0 0]';
n=n1+n2;

b = ones(n,1);
disp("for W1 and W3")
[a,iterations] = Ho_Kashyap(a,b,Y,n,LR,bmin,kmax);
disp("Final a values=");
disp(strcat(num2str(a(1)),", ",num2str(a(2)),", ",num2str(a(3))));
decision_boundary(a,y1,y2,"w1","w3","Problem 3(a)");



%%% 3(b)  %%%%
n1 = size(w4,1) ;
n2 = size(w2,1) ;

y1= [ones(n1,1) w4];
y2= [ones(n2,1) w2];

Y = [y1;-y2];


a = [ 0 0 0]';
n=n1+n2;

b = ones(n,1);
kmax = 500;
disp("For W4 and W2")
[a,iterations] = Ho_Kashyap(a,b,Y,n,LR,bmin,kmax);
disp("Final a values=");
disp(strcat(num2str(a(1)),", ",num2str(a(2)),", ",num2str(a(3))));
decision_boundary(a,y1,y2,"w4","w2","Problem 3(b)");



function [a,iter] = Ho_Kashyap(a,b,Y,n,LR,bmin,kmax)
iter = 0;

while (iter < kmax)
    iter=iter+1;
e = Y*a - b;
e_p = (1/2)*(e + abs(e));
b = b + 2*LR*e_p;
a = inv(Y'*Y)*Y'*b;
if norm(abs(e)) <= bmin
   disp(strcat('solution found for iterations=',num2str(iter)))
break;
end
if iter==kmax
    disp(strcat('no solution upto iterations=',num2str(iter)))
end

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