clear

load DLP_210_complete.mat

% N_nodes = height(COORD); %Number of nodes (includes depots)
% N_Indivs = 1; % Size of populations
% N_gen = 0; % number of generations
% arcs = Inf(N_nodes); %non-euclidean arches of a directed graph
% unassigned_arcs = false(N_nodes); %matrix of arches never treveled by before

% for a = 1:height(ARCS)
%     arcs(ARCS.From(a),ARCS.To(a)) = ARCS.Longueur(a);
%     unassigned_arcs(ARCS.From(a),ARCS.To(a)) = true;
% end

%euclidean distances matrix
dist = squareform(pdist(COORD{1:end,2:3}));
DIST_RAND = dist.*(rand(length(dist))*0.5+0.75);
DIST = DIST_RAND([CUSTOMERS{:,1};HUBS{:,1}],[CUSTOMERS{:,1};HUBS{:,1}]);
%rand(42)+0.5
clear dist DIST_RAND ARCS

N_depots = height(HUBS); %Número de depósitos
N_Customers = height(CUSTOMERS); %Número de clientes
N_nodes = N_depots + N_Customers; %Number of nodes (includes depots)

%HUB_DIST = dist(HUBS{:,1},CUSTOMERS{:,1});
%CUSTOMER_DIST = dist(CUSTOMERS{:,1},CUSTOMERS{:,1});
COOR = COORD([CUSTOMERS{:,1};HUBS{:,1}],:);
COOR{:,1} = [1:N_nodes]';
% HUB_COOR = COORD(HUBS{:,1},:);
% HUB_COOR{:,1}=[19:21]';
% CUSTOMER_COOR = COORD(CUSTOMERS{:,1},:);
% CUSTOMER_COOR{:,1}=[1:18]';
HUBS{:,1}=[N_Customers+1:N_nodes]';
CUSTOMERS{:,1}=[1:N_Customers]'; 

clear COORD

% unassigned_arcs(1,2) = false;
% [A,unassigned_arcs] = chooseTrayectory([1,2],arcs,10,unassigned_arcs);
