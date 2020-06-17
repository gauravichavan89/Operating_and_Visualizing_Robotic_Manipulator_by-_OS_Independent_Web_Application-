
% README: Run this file before everything else. This file should be
% followed by Inverse Kinematics
% Copy the values from H0_6 of output to the Inverse Kinematics
syms theta1 theta2 theta3 theta4 theta5 theta6 a1 a2 a3 a4 a5 a6 a7

% pre setting theta  orientation values
theta1 = 55;
theta2 = 37;
theta3 = 81;
theta4 = 28;
theta5 = 90;
theta6 = -55;

% fixed perpendicular distance between each succesive joints
a1=140.5;
a2=408;
a3= 121.5;
a4 = 376;
a5 = 102.5;
a6 = 102.5;
a7 = 94;

% Forming homogeneous transform matrix from designed DH Parameters
% joint 1 with respect to joint 0
H0_1 = homogenous_trabsform_matrix(theta1+90,90,0,0);
disp('H0_1= ');
disp(H0_1);

% joint 2 with respect to joint 1
H1_2 = homogenous_trabsform_matrix(theta2+90,0,a2,a1);
disp('H1_2= ');
disp(H1_2);

% joint 3 with respect to joint 2
H2_3 = homogenous_trabsform_matrix(theta3,180,a4,-a3);
disp('H2_3= ');
disp(H2_3);

% joint 4 with respect to joint 3
H3_4 = homogenous_trabsform_matrix(theta4-90,90,0,-a5);
disp('H3_4= ');
disp(H3_4);

% joint 5 with respect to joint 4
H4_5 = homogenous_trabsform_matrix(theta5+180,90,0,-a6);
disp('H4_5= ');
disp(H4_5);

% joint 6 with respect to joint 5
H5_6 = homogenous_trabsform_matrix(theta6,0,0,-a7);
disp('H5_6= ');
disp(H5_6);

% Computing the state of the end detector with respect to joint 0
% Here the final joint will be affected by each of the previous joint
% serially
H0_2 = H0_1* H1_2;
H0_3 = H0_2* H2_3;
H0_4 = H0_3* H3_4;
H0_5 = H0_4* H4_5;
H0_6 = H0_5* H5_6;
disp("H0_6");
disp(H0_6);

% from literature we get the following generalized formula to generate
% homogeneous transform matrix
function W = homogenous_trabsform_matrix(THETA, alpha, r, d)
    W = [
            (cosd(THETA)), (-sind(THETA)) * (cosd(alpha)), (sind(THETA)) * (sind(alpha)), r * (cosd(THETA));
            (sind(THETA)),((cosd(THETA) * cosd(alpha))), ((-cosd(THETA) * sind(alpha))), r * (sind(THETA));
            0,(sind(alpha)),(cosd(alpha)),d;
            0,0,0,1;
            
        ];
end


