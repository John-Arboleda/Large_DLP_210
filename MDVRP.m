function finalPop = MDVRP(depotConfig, N_Gen, N_Indivs, DIST, CUSTOMERS, HUBS, TRUCKS)
    tic
    initPop = ParGen0_MDVRP(depotConfig, N_Indivs, DIST, CUSTOMERS, HUBS);

    evaluatedPop = Evaluate_MDVRP(initPop, N_Indivs, DIST, TRUCKS);

    rankedPop = Rank_MDVRP(evaluatedPop, N_Indivs, HUBS, TRUCKS);
    toc
    
    
    
end