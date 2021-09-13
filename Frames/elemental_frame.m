function k = elemental_frame(coord,E,A,I)
  x1 = coord(1,1);
  x2 = coord(2,1);
  y1 = coord(1,2);
  y2 = coord(2,2);
  l = sqrt((x1-x2)**2 + (y1-y2)**2);  ...length
  k_dash = E*[A/l    0          0         -A/l     0           0; ...
              0      12*I/l**3  6*I/l**2  0        -12*I/l**3  6*I/l**2; ...
              0      6*I/l**2   4*I/l     0        -6*I/l**2   2*I/l; ...
              -A/l   0          0         A/l      0           0;    ...
              0      -12*I/l**3 -6*I/l**2 0        12*I/l**3   -6*I/l**2; ...
              0      6*I/l**2   2*I/l     0        -6*I/l**2   4*I/l]; 
  c = (x2-x1)/l;
  s = (y2-y1)/l;
  T = [c  s 0 0  0 0 ; ... Transformation Matrix
       -s c 0 0  0 0 ;
       0  0 1 0  0 0 ;
       0  0 0 c  s 0 ;
       0  0 0 -s c 0 ; 
       0  0 0  0 0 1] ;
  k = T'*k_dash*T; 
endfunction
