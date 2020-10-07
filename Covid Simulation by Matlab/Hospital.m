function [Population,Infected_Pop,FEL,ICU_Beds_Status,Public_Beds_Status,N_Mosallah,N_Stadium,N_ICU_Beds,N_Public_Beds] = Hospital(Population,Infected_Pop,FEL,ICU_Beds_Status,Public_Beds_Status,N_Mosallah,N_Stadium,N_ICU_Beds,N_Public_Beds,Current_Simulation_Time,Event)
if Event == 3
n = find(FEL(:,1)==Event & FEL(:,2)==Current_Simulation_Time);
s = size(n,1);
    for i = 1:s
        Infected_Pop = Infected_Pop - 1;
        Population = Population - 1;
        FreeBed = find(ICU_Beds_Status(1,:)==0);
        if FreeBed
            N_ICU_Beds = N_ICU_Beds + 1;
            FreeBed = FreeBed(1,1);
            ICU_Beds_Status(1,FreeBed) = 1;
            FEL(n(i,1),1) = 5;
            FEL(n(i,1),3) = FreeBed;    
            FEL(n(i,1),2) = Current_Simulation_Time + round(7*rand+7);
        else
            N_Mosallah = N_Mosallah + 1;
            FEL(n(i,1),1) = 5;
            FEL(n(i,1),3) = 0;          
            FEL(n(i,1),2) = Current_Simulation_Time + round(7*rand+7);
        end
    end
else
    n = find(FEL(:,1)==Event & FEL(:,2)==Current_Simulation_Time);
    s = size(n,1);
    for i = 1:s
        Infected_Pop = Infected_Pop - 1;
        Population = Population - 1;
        FreeBed = find(Public_Beds_Status(1,:)==0);
        if FreeBed
            N_Public_Beds = N_Public_Beds + 1;
            FreeBed = FreeBed(1,1);
            Public_Beds_Status(1,FreeBed) = 1;
            FEL(n(i,1),1) = 6;
            FEL(n(i,1),3) = FreeBed;    
            FEL(n(i,1),2) = Current_Simulation_Time + round(11*rand + 3);
        else
            if Current_Simulation_Time == 20
                if N_Public_Beds > 310
                    
                end
            end
            N_Stadium = N_Stadium + 1;
            FEL(n(i,1),1) = 6;
            FEL(n(i,1),3) = 0;           
            FEL(n(i,1),2) = Current_Simulation_Time + round(11*rand + 3);
        end
    end
end  
end