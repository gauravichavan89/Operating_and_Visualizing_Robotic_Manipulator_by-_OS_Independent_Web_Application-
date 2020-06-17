% README: This file has been used to compute theta1, theta5 and theta6 

syms s1 s2 s3 s4 s5 s6 c1 c2 c3 c4 c5 c6 a1 a2 a3 a4 a5 a6 a7 mx my mz nx ny nz ox oy oz px py pz

% The resultant matrix is below
T_final=[ mx nx ox px; 
        my ny oy py;
        mz nz oz pz;
        0 0 0 1];

T1=[ -s1 0 c1 0; 
    c1 0 s1 0;
    0 1 0 0;
    0 0 0 1];

% Computing inverse of first matrix for ease of caluculations
T_inv= inv(T1);

T2= [ -s2 -c2 0 -a2*s2;
      c2 -s2 0 a2*c2;
      0 0 1 a1;
      0 0 0 1];

T3 =[c3 s3 0 a4*c3;
    s3 -c3 0 a4*s3;
    0 0 -1 -a3;
    0 0 0 1];

T4 = [s4 0 -c4 0;
    -c4 0 -s4 0;
    0 1 0 -a5;
    0 0 0 1];

T5 = [-c5 0 -s5 0;
    -s5 0 c5 0;
    0 1 0 -a6;
    0 0 0 1];

T6 = [c6 -s6 0 0;
    s6 c6 0 0;
    0 0 1 -a7;
    0 0 0 1];

% Pre multiplying by inverse of first matrix to get simpler equations
T_case1 = T_inv * T_final;
T_case2 = T2 * T3 * T4 * T5 * T6;
disp('LHS');
disp(T_case1);
disp('RHS');
disp(T_case2);