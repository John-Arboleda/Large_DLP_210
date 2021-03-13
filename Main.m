clear

load DLP_210_data.mat

N_Indivs = 32; % Size of populations
N_Gen = 10; % number of generations
N_Config = 20; %Número de configuraciones de depósito

finalPop = LRP(N_Indivs, N_Gen, N_Config, DIST, CUSTOMERS, HUBS, TRUCKS);

