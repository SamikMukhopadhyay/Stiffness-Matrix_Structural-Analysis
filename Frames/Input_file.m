function [nodes, elements, E, A, I, bcs, loads] = Input_file()
  nodes = [0 6 4 6 5; ... {x-coord y-coord x-dof y-dof moment-dof]
           6 6 1 2 3; 6 0 7 8 9];
  elements = [1 2; 2 3];
  E(1:size(elements))=200*(10**3);
  A(1:size(elements))=0.006;
  I(1:size(elements))=0.00018;
  bcs = [1 2 0; 3 1 0; 3 2 0; 3 3 0];
  loads = [2 1 20];
endfunction
