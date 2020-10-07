function [Infected_Pop,FEL,ICU_Beds_Status,Public_Beds_Status,N_Mosallah,N_Stadium,N_ICU_Beds,N_Public_Beds,N_Recovery,N_Death] = Outof_Hospital(Infected_Pop,FEL,ICU_Beds_Status,Public_Beds_Status,N_Mosallah,N_Stadium,N_ICU_Beds,N_Public_Beds,N_Recovery,N_Death,Simulation_Duration,Current_Simulation_Time,Event)
if Event == 5
    n = find(FEL(:,1)==Event & FEL(:,2)==Current_Simulation_Time);
    a = size(n,1);
    for i = 1:a
        if FEL(n(i,1),3) ~= 0
            ICU_Beds_Status(1,FEL(n(i,1),3)) = 0;
            N_ICU_Beds = N_ICU_Beds - 1;
        else
            N_Mosallah = N_Mosallah - 1;
        end
        if rand() < 0.5
        N_Death = N_Death + 1;
        else
        N_Recovery = N_Recovery + 1; 
        end
        FEL(n(i,1),2) = Simulation_Duration+1;
    end
else
    n = find(FEL(:,1)==Event & FEL(:,2)==Current_Simulation_Time);
    a = size(n,1);
    for i = 1:a
        if FEL(n(i,1),3) ~= 0
            Public_Beds_Status(1,FEL(n(i,1),3)) = 0;
            N_Public_Beds = N_Public_Beds - 1;
        else
            N_Stadium = N_Stadium - 1;
        end
        if rand() < 0.1
        N_Death = N_Death + 1;
        else
        N_Recovery = N_Recovery + 1; 
        end
        FEL(n(i,1),2) = Simulation_Duration+1;
    end    
end
end