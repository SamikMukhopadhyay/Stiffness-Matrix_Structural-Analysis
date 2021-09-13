clc; clear; %initialization 

%---------- Input file imported ----------------
[nodes, elements, E, A, I, bcs, loads] = SA_project();

%--------declaration of basic variables -----------
n = size(nodes,1);
num_element = size(elements,1);
ndof =3*n;

%--------- initialization of Stiffness matrix, Loads and Displacements -------
K = zeros(ndof);
Q = zeros(ndof,1);
D = zeros(ndof,1);

%---------constrained dof-----------------
constrained_dof = [];
for i = 1:length(bcs)
  cdof = nodes(bcs(i,1), bcs(i,2)+2);
  constrained_dof = [constrained_dof,cdof];
  D(cdof) = bcs(i,3);
endfor

%--------------free dofs-----------------------
free_dof = [];
for i = 1:3*n
  if i<min(constrained_dof)
   free_dof = [free_dof,i]; 
  end
endfor 

%----------------update loads vector-------------------
for i = 1:size(loads,1)
  load_dof = nodes(loads(i,1), loads(i,2)+2);
  Q(load_dof) = loads(i,3);
endfor

%---------------------Global Stiffness Matrix--------------
concernedDof = [];

for i = 1:num_element
  near_end = elements(i,1);
  near_one = nodes(near_end,3);
  near_two = nodes(near_end,4);
  near_three = nodes(near_end,5);
  far_end = elements(i,2);
  far_one = nodes(far_end,3);
  far_two = nodes(far_end,4);
  far_three = nodes(far_end,5);
  coord = [nodes(near_end,1:2); nodes(far_end,1:2)];
  k = elemental_frame(coord,E(i),A(i),I(i));
  concernedDof = [near_one near_two near_three far_one far_two far_three];
  for j =1:6
    for l=1:6
      K(concernedDof(1,j),concernedDof(1,l)) += k(j,l);
    endfor
  endfor
endfor

disp('The Global Stiffness Matrix is :');
K

%-----------------------------solution--------------------
loads_known = Q(1:length(free_dof));
K_first = K([1:length(free_dof)],[1:length(free_dof)]);
K_second = K([1:length(free_dof)],[length(free_dof)+1:end]);
unknown_dof = inv(K_first)*(loads_known-(K_second*D([length(free_dof)+1:end])));

D(1:length(free_dof)) = unknown_dof;
Q(length(free_dof)+1:end) = K(length(free_dof)+1:end,:)*D;

disp('The loads are :');
Q

disp('The displacements are :');
D 






