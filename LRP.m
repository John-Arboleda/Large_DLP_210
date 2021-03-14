function finalPop = LRP(N_Indivs, N_Gen, N_Config, extraCap, DIST, CUSTOMERS, HUBS, TRUCKS)
%Generación de configuraciones iniciales
groupDepotConfig = GenConfig_LRP(N_Config, extraCap, CUSTOMERS, HUBS);
tic
%Población incial para la primera asignación
initPop = MDVRP(groupDepotConfig(1,:), N_Gen, N_Indivs, DIST, CUSTOMERS, HUBS, TRUCKS);
toc









end