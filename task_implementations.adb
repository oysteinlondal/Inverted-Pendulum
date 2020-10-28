package body Task_Implementations is

   task body Gyroscope_Reader is 

      -- Timing Constraints
      Offset                      : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(0);
      Period                      : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(2000);
      Next_Period                 : Ada.Real_Time.Time;
      Start_Point                 : Ada.Real_Time.Time;

      Velocity                    : Float := 48.0;

      -- Worst-Case Computation Time Analysis

      Execution_Start             : Ada.Real_Time.Time;
      Execution_End               : Ada.Real_Time.Time;
      Total_Computation_Time      : Ada.Real_Time.Time_Span;
      Worst_Case_Computation_Time : Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(0);

      begin

         Epoch.Get_Start_Time(Start_Point);
         Next_Period := Start_Point + Offset; -- Define next time to run

         loop
            delay until Next_Period; -- Wait for new period 

            Execution_Start := Ada.Real_Time.Clock; -- Start of execution

            Shared_Data.Gyroscope_SR.Set(Velocity);
            Next_Period   := Next_Period + Period;

            Execution_End := Ada.Real_Time.Clock;   -- End of execution
            -- Calculation of Total Computation Time
            Total_Computation_Time := Execution_End - Execution_Start;

            if Total_Computation_Time > Worst_Case_Computation_Time then
                  Worst_Case_Computation_Time := Total_Computation_Time;
            end if;

            Ada.Text_IO.Put_Line("A" & Duration'Image(To_Duration(Worst_Case_Computation_Time)));

         end loop;

   end Gyroscope_Reader;

   task body Accelerometer_Reader is 

      -- Timing Constraints
      Offset                     : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(0);
      Period                     : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(2000);
      Next_Period                : Ada.Real_Time.Time;
      Start_Point                : Ada.Real_Time.Time;

      -- Worst-Case Computation Time Analysis

      Execution_Start             : Ada.Real_Time.Time;
      Execution_End               : Ada.Real_Time.Time;
      Total_Computation_Time      : Ada.Real_Time.Time_Span;
      Worst_Case_Computation_Time : Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(0);

      Angle                      : Float;

      Sum_Accelerometer_Xvalues  : Float := 0.0;
      Sum_Accelerometer_Yvalues  : Float := 0.0;

      Avg_Accelerometer_Xvalue   : Float := 0.0;
      Avg_Accelerometer_Yvalue   : Float := 0.0;

      New_Xvalue                 : Float;
      New_Yvalue                 : Float;

      Count_Accelerometer_Reads  : Natural := 0;
      Max_Accelerometer_Reads    : Natural := 5;

      Done                       : Boolean;

      begin

            Epoch.Get_Start_Time(Start_Point);
            Next_Period := Start_Point + Offset; -- Define next time to run
            loop
                  delay until Next_Period; -- Wait for new period 

                  Execution_Start := Ada.Real_Time.Clock; -- Start of execution

                  Done := False;
                  loop
                        Count_Accelerometer_Reads := (Count_Accelerometer_Reads + 1) mod Max_Accelerometer_Reads;

                        New_Xvalue := 3.0;--NANO.AccX;
                        New_Yvalue := 2.0;--NANO.AccY;

                        Sum_Accelerometer_Xvalues := Sum_Accelerometer_Xvalues + New_Xvalue;
                        Sum_Accelerometer_Yvalues := Sum_Accelerometer_Yvalues + New_Yvalue;

                        if Count_Accelerometer_Reads = 0 then
                              Done := True;

                              Avg_Accelerometer_Xvalue := Sum_Accelerometer_Xvalues / Float(Max_Accelerometer_Reads);
                              Avg_Accelerometer_Yvalue := Sum_Accelerometer_Yvalues / Float(Max_Accelerometer_Reads);

                              Angle := Find_Angle(Avg_Accelerometer_Xvalue, Avg_Accelerometer_Yvalue);

                              Shared_Data.Accelerometer_SR.Set(Angle);

                              -- Reset

                              Sum_Accelerometer_Xvalues := 0.0;
                              Sum_Accelerometer_Yvalues := 0.0;
                        end if;

                        exit when Done;

                  end loop;

                  Next_Period := Next_Period + Period;

                  Execution_End := Ada.Real_Time.Clock;   -- End of execution
                  -- Calculation of Total Computation Time
                  Total_Computation_Time := Execution_End - Execution_Start;

                  if Total_Computation_Time > Worst_Case_Computation_Time then
                        Worst_Case_Computation_Time := Total_Computation_Time;
                  end if;

                  Ada.Text_IO.Put_Line("B" & Duration'Image(To_Duration(Worst_Case_Computation_Time)));

                  end loop;

   end Accelerometer_Reader;

   task body Cascade_Controller is 

      -- Timing Constraints
      Offset                     : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(0);
      Period                     : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(2000);
      Next_Period                : Ada.Real_Time.Time;
      Start_Point                : Ada.Real_Time.Time;

      -- Worst-Case Computation Time Analysis

      Execution_Start             : Ada.Real_Time.Time;
      Execution_End               : Ada.Real_Time.Time;
      Total_Computation_Time      : Ada.Real_Time.Time_Span;
      Worst_Case_Computation_Time : Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(0);

      Angle                      : Float;
      Velocity                   : Float;
      Actuator_Value             : Natural := 1500;

      begin

         Epoch.Get_Start_Time(Start_Point);
         Next_Period := Start_Point + Offset; -- Define next time to run

         loop
               delay until Next_Period; -- Wait for new period 

               Execution_Start := Ada.Real_Time.Clock; -- Start of execution

               Shared_Data.Accelerometer_SR.Get(Angle);
               Shared_Data.Gyroscope_SR.Get(Velocity);
               Shared_Data.Actuator_Write.Set(Actuator_Value);
               Next_Period := Next_Period + Period;

               Execution_End := Ada.Real_Time.Clock;   -- End of execution
               -- Calculation of Total Computation Time
               Total_Computation_Time := Execution_End - Execution_Start;

               if Total_Computation_Time > Worst_Case_Computation_Time then
                  Worst_Case_Computation_Time := Total_Computation_Time;
               end if;

               Ada.Text_IO.Put_Line("C" & Duration'Image(To_Duration(Worst_Case_Computation_Time)));

         end loop;

   end Cascade_Controller;

   task body Actuator_Writer is 

      -- Timing Constraints
      Offset                     : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(0);
      Period                     : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(2000);
      Next_Period                : Ada.Real_Time.Time;
      Start_Point                : Ada.Real_Time.Time;

      -- Worst-Case Computation Time Analysis

      Execution_Start             : Ada.Real_Time.Time;
      Execution_End               : Ada.Real_Time.Time;
      Total_Computation_Time      : Ada.Real_Time.Time_Span;
      Worst_Case_Computation_Time : Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(0);

      Actuator_Value             : Natural;

      begin

         Epoch.Get_Start_Time(Start_Point);
         Next_Period := Start_Point + Offset; -- Define next time to run

         loop
               delay until Next_Period; -- Wait for new period 

               Execution_Start := Ada.Real_Time.Clock; -- Start of execution

               Shared_Data.Actuator_Write.Get(Actuator_Value);
               Next_Period := Next_Period + Period;

               Execution_End := Ada.Real_Time.Clock;   -- End of execution
               -- Calculation of Total Computation Time
               Total_Computation_Time := Execution_End - Execution_Start;

               if Total_Computation_Time > Worst_Case_Computation_Time then
                  Worst_Case_Computation_Time := Total_Computation_Time;
               end if;

               Ada.Text_IO.Put_Line("D" & Duration'Image(To_Duration(Worst_Case_Computation_Time)));

         end loop;

   end Actuator_Writer;

   
end Task_Implementations;