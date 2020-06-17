% README: Run this file after running forward kinematics; this file will
% produce results with all positive as well as negative roots of each theta
a1=140.5;
a2=408;
a3= 121.5;
a4 = 376;
a5 = 102.5;
a6 = 102.5;
a7 = 94;

% These values are same as the ones from H0_6 (last matrix) of Forward
% Kinematics result. The values of px, py and pz are taken from the last
% column of H0_6 except last row element
px = 626.7365;
py =-290.5215;
pz = 55.3220;

% The values of mx, my and mz are taken from the first
% column of H0_6 except last row element
mx =  1;
my =  0;
mz = 0;

% The values of nx, ny and nz are taken from the second
% column of H0_6 except last row element
nx = 0;
ny = 1;
nz = 0;

% The values of ox, oy and oz are taken from the third
% column of H0_6 except last row element 
ox =0;
oy =0;
oz =1;

% Finding out the positive and negative roots of theta1, theta5 and theta6 after solving the equations from
% solving_equations_iteration_1
A = a1-a3+a5;
B = px + a7 * ox;
C = py + a7 * oy;

% Calculating all the roots of theta1 from the equation 
sinTheta1 = ((A*C)+ sqrt(sq(A*C)-(sq(B)+sq(C))*(sq(A)-sq(B))))/(sq(B)+sq(C));
theta1 = asind(sinTheta1);

sinTheta1 = ((A*C)- sqrt(sq(A*C)-(sq(B)+sq(C))*(sq(A)-sq(B))))/(sq(B)+sq(C));
theta1_negative_root = asind(sinTheta1);

% displaying unique positive and negative roots of theta1
disp('theta1 roots');
theta1array=[theta1 theta1_negative_root];
theta1array=unique(theta1array);
disp(theta1array);

% Calculating all roots of theta5 which is dependent on theta1 value
theta5 = acosd(-cosd(theta1)*ox-oy*sind(theta1));
theta5_negative_root = acosd(-cosd(theta1_negative_root)*ox-oy*sind(theta1_negative_root));
disp('theta5 roots');
theta5_array=[theta5 theta5_negative_root];
theta5_array=unique(theta5_array);

% Displaying unique positive and negative roots of theta5
disp(theta5_array);

% Finding positive and negative theta6 roots which is dependent on theta1
if (cosd(theta1)*nx+ny*sind(theta1)==0) && (cosd(theta1)*mx+my*sind(theta1)==0)
   theta6 = 45;
else
   theta6 = atand(-(cosd(theta1)*nx+ny*sind(theta1))/(cosd(theta1)*mx+my*sind(theta1))); 
end

if (cosd(theta1_negative_root)*nx+ny*sind(theta1_negative_root)==0) && (cosd(theta1_negative_root)*mx+my*sind(theta1_negative_root)==0)
   theta6_negative_root = 45;
else
   theta6_negative_root = atand(-(cosd(theta1_negative_root)*nx+ny*sind(theta1_negative_root))/(cosd(theta1_negative_root)*mx+my*sind(theta1_negative_root))); 
end

disp('theta6 roots');
theta6array=[theta6 theta6_negative_root];
theta6array=unique(theta6array);
% displaying unique positive and negative roots of theta6
disp(theta6array);

% Finding out the positive root of theta3, theta2 and theta4 after solving the equations from
% solving_equations_iteration_2
% Computing all the roots of theta3 value based on theta1 and theta6
L = (pz + a7*oz +a6*(cosd(theta6)*nz + mz*sind(theta6)));
K = a7*(cosd(theta1)*oy - ox*sind(theta1)) + a6*((cosd(theta6)*(cosd(theta1)*ny - nx*sind(theta1))) + (sind(theta6)*(cosd(theta1)*my - mx*sind(theta1)))) + cosd(theta1)*py - px*sind(theta1);
K = -K;
theta3 = acosd((sq(K)+sq(L)-sq(a2)-sq(a4))/(2*a2*a4));

L1 = (pz + a7*oz +a6*(cosd(theta6_negative_root)*nz + mz*sind(theta6_negative_root)));
K1 = a7*(cosd(theta1_negative_root)*oy - ox*sind(theta1_negative_root)) + a6*((cosd(theta6_negative_root)*(cosd(theta1_negative_root)*ny - nx*sind(theta1_negative_root))) + (sind(theta6_negative_root)*(cosd(theta1_negative_root)*my - mx*sind(theta1_negative_root)))) + cosd(theta1_negative_root)*py - px*sind(theta1_negative_root);
K1 = -K1;
theta3_second_root = acosd((sq(K1)+sq(L1)-sq(a2)-sq(a4))/(2*a2*a4));

L2 = (pz + a7*oz +a6*(cosd(theta6)*nz + mz*sind(theta6)));
K2 = a7*(cosd(theta1_negative_root)*oy - ox*sind(theta1_negative_root)) + a6*((cosd(theta6)*(cosd(theta1_negative_root)*ny - nx*sind(theta1_negative_root))) + (sind(theta6)*(cosd(theta1_negative_root)*my - mx*sind(theta1_negative_root)))) + cosd(theta1_negative_root)*py - px*sind(theta1_negative_root);
K2 = -K2;
theta3_third_root = acosd((sq(K2)+sq(L2)-sq(a2)-sq(a4))/(2*a2*a4));

L3 = (pz + a7*oz +a6*(cosd(theta6_negative_root)*nz + mz*sind(theta6_negative_root)));
K3 = a7*(cosd(theta1)*oy - ox*sind(theta1)) + a6*((cosd(theta6_negative_root)*(cosd(theta1)*ny - nx*sind(theta1))) + (sind(theta6_negative_root)*(cosd(theta1)*my - mx*sind(theta1)))) + cosd(theta1)*py - px*sind(theta1);
K3 = -K3;
theta3_fourth_root = acosd((sq(K3)+sq(L3)-sq(a2)-sq(a4))/(2*a2*a4));

% Displaying all the roots of theta3
disp('theta 3 array');
theta3array=[theta3 theta3_second_root theta3_third_root theta3_fourth_root];
theta3array=unique(theta3array);
disp(theta3array);

% Calculating and Displaying all the roots of theta2 which is based on theta1 and theta6
disp('--------now we are displaying 16 roots of theta2-------------');
g = [K K1 K2 K3]; % K
h = [L L1 L2 L3]; % L
T = [];
theta = [];

for i=1:4
    for j=1:4
         T(i) = (sq(a4) - sq(g(i)) -sq(h(j))-sq(a2))/(2*a2);
         theta(i) = acosd(((-2*h(j)*T(i) + sqrt(4*sq(h(j)*T(i)) - 4*(sq(g(i))+sq(h(j)))*(sq(T(i))-sq(g(i)))))/(2*(sq(g(i))+sq(h(j))))));     
    end
end

theta=unique(theta);
disp(theta);

% Displaying all the roots of theta4 which is based on theta2, theta3, theta5 and theta6
l = [theta5 theta5_negative_root];
m = [theta6 theta6_negative_root];
n = theta;
o =[theta3 theta3_second_root theta3_third_root theta3_fourth_root];
theta4array = [];
R = [];

disp('-----------We are now displaying theta4 values-----------');
 for i=1:2
    for j=1:2
        for k=1:4 
                    R(i) = - (cosd(l(i))*(cosd(m(i))*mz - nz*sind(m(i)))) - (oz*sind(m(i)));
                    theta4 = asind(R(i)) + n(k) + o(k);
                    disp(theta4);
        end
    end
 end

function q = sq(val)
    q = val*val;
end