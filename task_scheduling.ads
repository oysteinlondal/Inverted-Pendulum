with Ada.Real_Time; use Ada.Real_Time;

package Task_Scheduling is

    protected Epoch with Priority => 25 is
        procedure Get_Start_Time(Start_Time : out Ada.Real_Time.Time);
    private
        Start : Ada.Real_Time.Time;
        First : Boolean := True;
    end Epoch;

end Task_Scheduling;