package body Task_Scheduling is

    protected body Epoch is

        procedure Get_Start_Time(Start_Time : out Ada.Real_Time.Time) is 

        begin

            if First then
                First := False;
                Start := Ada.Real_Time.Clock;
            end if;
                Start_Time := Start;

        end Get_Start_Time;

    end Epoch;

end Task_Scheduling;