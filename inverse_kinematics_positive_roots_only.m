% README: Run this file after running forward kinematics; this file will
% produce results with all positive roots of each theta
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
py = -290.5215;
pz = 55.3220;

% The values of mx, my and mz are taken from the first
% column of H0_6 except last row element 
mx =  1;
my =  0;
mz =  0;

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

% Finding out the positive root of theta1 after solving the equations from
% solving_equations_iteration_1
A = a1-a3+a5;
B = px + a7 * ox;
C = py + a7 * oy;
sinTheta1 = ((A*C)+ sqrt(sq(A*C)-(sq(B)+sq(C))*(sq(A)-sq(B))))/(sq(B)+sq(C));
theta1 = asind(sinTheta1);
disp('theta1');
disp(theta1);

% Calculating positive roots of theta5 which is dependent on theta1 value
theta5=acosd(-cosd(theta1)*ox-oy*sind(theta1));
disp('theta5');
disp(theta5);

% Finding positive theta6 value which is dependent on theta1
if (cosd(theta1)*nx+ny*sind(theta1)==0) && (cosd(theta1)*mx+my*sind(theta1)==0)
   theta6 = 45;
   disp('theta6');
   disp(theta6);
else
   disp('theta6');
   theta6 = atand(-(cosd(theta1)*nx+ny*sind(theta1))/(cosd(theta1)*mx+my*sind(theta1))); 
   disp(theta6);
end

% Finding out the positive root of theta3 after solving the equations from
% solving_equations_iteration_2
% Computing positive roots of theta3 value based on theta1 and theta6
L = (pz + a7*oz +a6*(cosd(theta6)*nz + mz*sind(theta6)));
K = a7*(cosd(theta1)*oy - ox*sind(theta1)) + a6*((cosd(theta6)*(cosd(theta1)*ny - nx*sind(theta1))) + (sind(theta6)*(cosd(theta1)*my - mx*sind(theta1)))) + cosd(theta1)*py - px*sind(theta1);
K = -K;
theta3 = acosd((sq(K)+sq(L)-sq(a2)-sq(a4))/(2*a2*a4))

% Computing positive roots of theta2 which is based on theta1 and theta6
T = (sq(a4) - sq(K) -sq(L)-sq(a2))/(2*a2);
theta2 = acosd(((-2*L*T + sqrt(4*sq(L*T) - 4*(sq(K)+sq(L))*(sq(T)-sq(K))))/(2*(sq(K)+sq(L)))))

% Computing positive roots of theta4 which is based on theta2, theta3, theta5 and theta6
R = - (cosd(theta5)*(cosd(theta6)*mz - nz*sind(theta6))) - (oz*sind(theta5));
theta4 = asind(R) + theta2 + theta3

function q = sq(val)
    q = val*val;
end