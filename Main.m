clear

load DLP_210_data.mat

N_Indivs = 32; % Size of populations
N_Gen = 10; % number of generations
N_Config = 20; %Número de configuraciones de depósito
extraCap = 0.05; %Configuraciones con capacidad extra total mayor al 5%

finalPop = LRP(N_Indivs, N_Gen, N_Config, extraCap, DIST, CUSTOMERS, HUBS, TRUCKS);

