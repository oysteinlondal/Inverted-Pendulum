package body Task_Implementations is
   
   task body Gyroscope_Reader is
      -- Timing Constraints
      Next_Period                 : Ada.Real_Time.Time;
      Start_Point                 : Ada.Real_Time.Time;
      Offset                      : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(0);
      Period                      : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(20);
      -- Worst-Case Computation Time Analysis
      Execution_Start             : Ada.Real_Time.Time;
      Execution_End               : Ada.Real_Time.Time;
      Total_Computation_Time      : Ada.Real_Time.Time_Span;
      Total_Computation_Time_Limit: Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(5);
      Worst_Case_Computation_Time : Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(0);
      -- Task Specific Variable Declarations
      Velocity                    : Float;
      --Exception variables
      Velocity_Max                : Float := 6.0;
      Velocity_Min                : Float := -6.0;
      Recoveryblock_Count         : Integer := 0; 
      begin
            Motor_Setup.Calibrate_Motors_If_Required;
            Epoch.Get_Start_Time(Start_Point);
            -- Define next time to run
            Next_Period   := Start_Point + Offset;
            loop
                  begin
                        -- Wait for new period 
                        delay until Next_Period;

                        -- START OF EXECUTION

                        Execution_Start := Ada.Real_Time.Clock;
                        Meassure_Velocity.Retrieve_Velocity(Velocity);
                        Velocity := To_Radians(Velocity);
                        Gyroscope_SR.Set(Velocity);
                        -- Define next time to run
                        Next_Period   := Next_Period + Period;

                        -- END OF EXECUTION

                        Execution_End := Ada.Real_Time.Clock;   
                        -- Calculation of Total Computation Time
                        Total_Computation_Time := Execution_End - Execution_Start;
                        -- Set a new worst-case if current execution time is the largest
                        if Total_Computation_Time > Worst_Case_Computation_Time then
                              Worst_Case_Computation_Time := Total_Computation_Time;
                        end if;
                        Ada.Text_IO.Put_Line("A" & Duration'Image(To_Duration(Worst_Case_Computation_Time)));
                        -- Acceptance Test
                        Acceptance_Test(Velocity_Max, Velocity_Min, Velocity, Total_Computation_Time, Total_Computation_Time_Limit, Recoveryblock_Count);
                  exception
                        when Value_Exceed_Max =>
                              Recoveryblock_Count := Recoveryblock_Count + 1;
                              Velocity := 3.0;
                              Gyroscope_SR.Set(Velocity);
                              Acceptance_Test(Velocity_Max, Velocity_Min, Velocity, Total_Computation_Time, Total_Computation_Time_Limit, Recoveryblock_Count);

                        when Value_Exceed_Min =>
                              Recoveryblock_Count := Recoveryblock_Count + 1;
                              Velocity := -3.0;
                              Gyroscope_SR.Set(Velocity);
                              Acceptance_Test(Velocity_Max, Velocity_Min, Velocity, Total_Computation_Time, Total_Computation_Time_Limit, Recoveryblock_Count);

                        When Excecution_Time_Overun =>
                              ada.Text_IO.Put_Line("Gyroscope read: Execution time error");
                        
                        when Recovery_Block_Overload =>
                              ada.Text_IO.Put_Line("Gyroscope read: Recovery Block Overload");

                        when Unknown_Error =>
                              Ada.Text_IO.Put_Line("Gyroscope read: Unknown error!!!");
                  end;
            end loop;
   end Gyroscope_Reader;
   
   task body Accelerometer_Reader is 
      -- Timing Constraints
      Offset                     : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(0);
      Period                     : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(20);
      Next_Period                : Ada.Real_Time.Time;
      Start_Point                : Ada.Real_Time.Time;
      -- I/O Jitter Constraints Of Accelorometer
      Next_Reading               : Ada.Real_Time.Time;
      Read_Period                : Ada.Real_Time.Time_Span := Ada.Real_Time.Microseconds(100);
      -- Worst-Case Computation Time Analysis
      Execution_Start             : Ada.Real_Time.Time;
      Execution_End               : Ada.Real_Time.Time;
      Total_Computation_Time      : Ada.Real_Time.Time_Span;
      Total_Computation_Time_Limit: Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(5);
      Worst_Case_Computation_Time : Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(0);
      -- Task Specific Variable Declarations
      Angle                      : Float;
      -- Summation Of Meassured Coordinates
      Sum_Accelerometer_Xvalues  : Float := 0.0;
      Sum_Accelerometer_Yvalues  : Float := 0.0;
      -- Average Meassured Value For Each Coordinate
      Avg_Accelerometer_Xvalue   : Float := 0.0;
      Avg_Accelerometer_Yvalue   : Float := 0.0;
      -- New Meassurement For Each Coordinate
      Acceleration_X             : Float;
      Acceleration_Y             : Float;
      -- Current Number Of Meassurements And Maximum Number Of Meassurements
      Count_Accelerometer_Reads  : Natural := 0;
      Max_Accelerometer_Reads    : Natural := 5;
      -- Indicates When Meassuring Is Done According To The Max Counts
      Done                       : Boolean;
      -- Exception variables
      Angle_Max                   : Float := 6.0;
      Angle_Min                   : Float := -6.0;
      Recoveryblock_Count         : Integer := 0; 
      begin
            Motor_Setup.Calibrate_Motors_If_Required;
            Epoch.Get_Start_Time(Start_Point);
            -- Define next time to run
            Next_Period := Start_Point + Offset; 
            loop
                  begin
                        -- Wait for new period 
                        delay until Next_Period; 
                        Execution_Start := Ada.Real_Time.Clock;

                        -- START OF EXECUTION

                        Done := False;
                        -- Define next time to read from sensor (jitter)
                        Next_Reading := Next_Period;
                        -- Loop over number of meassurements needed to find the average
                        loop
                              delay until Next_Reading;
                              -- Count is zero when number of readings is equal to the value of max count
                              Count_Accelerometer_Reads := (Count_Accelerometer_Reads + 1) mod Max_Accelerometer_Reads;
                              -- Read from sensor
                              Meassure_Acceleration.Retrieve_Acceleration(Acceleration_X, Acceleration_Y);
                              -- Adde reading to the sum
                              Sum_Accelerometer_Xvalues := Sum_Accelerometer_Xvalues + Acceleration_X;
                              Sum_Accelerometer_Yvalues := Sum_Accelerometer_Yvalues + Acceleration_Y;
                              -- Check when number of readings is sufficient
                              if Count_Accelerometer_Reads = 0 then
                                    Done := True;
                                    -- Calculate the average values
                                    Avg_Accelerometer_Xvalue := Sum_Accelerometer_Xvalues / Float(Max_Accelerometer_Reads);
                                    Avg_Accelerometer_Yvalue := Sum_Accelerometer_Yvalues / Float(Max_Accelerometer_Reads);
                                    -- Calculate the angle
                                    Angle := Find_Angle(Avg_Accelerometer_Xvalue, Avg_Accelerometer_Yvalue);
                                    -- Store the angle in a shared protected object
                                    Accelerometer_SR.Set(Angle);
                                    -- Reset
                                    Sum_Accelerometer_Xvalues := 0.0;
                                    Sum_Accelerometer_Yvalues := 0.0;
                              end if;
                              -- Exit when we have found an average sensor value
                              exit when Done;
                              -- Define the next time to run (Period T)
                              Next_Reading := Next_Reading + Read_Period;
                        end loop;
                        Next_Period := Next_Period + Period;

                        -- END OF EXECUTION

                        Execution_End := Ada.Real_Time.Clock;
                        -- Calculation of Total Computation Time
                        Total_Computation_Time := Execution_End - Execution_Start;
                        -- Set a new worst-case if current execution time is the largest
                        if Total_Computation_Time > Worst_Case_Computation_Time then
                              Worst_Case_Computation_Time := Total_Computation_Time;
                        end if;
                        Ada.Text_IO.Put_Line("B" & Duration'Image(To_Duration(Worst_Case_Computation_Time)));  
                        -- Acceptance Test
                        Acceptance_Test(Angle_Max, Angle_Min, Angle, Total_Computation_Time, Total_Computation_Time_Limit, Recoveryblock_Count);
                  exception
                        when Value_Exceed_Max =>
                              Recoveryblock_Count := Recoveryblock_Count + 1;
                              Angle := 0.01;
                              Accelerometer_SR.Set(Angle);
                              Acceptance_Test(Angle_Max, Angle_Min, Angle, Total_Computation_Time, Total_Computation_Time_Limit, Recoveryblock_Count);

                        when Value_Exceed_Min =>
                              Recoveryblock_Count := Recoveryblock_Count + 1;
                              Angle := -0.01;
                              Accelerometer_SR.Set(Angle);
                              Acceptance_Test(Angle_Max, Angle_Min, Angle, Total_Computation_Time, Total_Computation_Time_Limit, Recoveryblock_Count);
                        
                        When Excecution_Time_Overun =>
                              Ada.Text_IO.Put_Line("Accelerometer read: Execution time error");
                        
                        when Recovery_Block_Overload =>
                              Ada.Text_IO.Put_Line("Accelerometer read: Recovery Block Overload");

                        when Unknown_Error =>
                              Ada.Text_IO.Put_Line("Accelerometer read: Unknown error!!!");
                  end;
            end loop;
   end Accelerometer_Reader;

   task body Cascade_Controller is 
      -- Timing Constraints
      Offset                      : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(0);
      Period                      : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(20);
      Next_Period                 : Ada.Real_Time.Time;
      Start_Point                 : Ada.Real_Time.Time;
      -- Worst-Case Computation Time Analysis
      Execution_Start             : Ada.Real_Time.Time;
      Execution_End               : Ada.Real_Time.Time;
      Total_Computation_Time      : Ada.Real_Time.Time_Span;
      Total_Computation_Time_Limit: Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(5);
      Worst_Case_Computation_Time : Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(0);
      -- Exception Detection Variables
      Actuator_Value_Max          : Float := 2000.0;
      Actuator_Value_Min          : Float := 1000.0;
      Recoveryblock_Count         : Integer := 0; 
      -- Task Specific Variable Declarations
      Current_Angle               : Float;
      Current_Velocity            : Float;
      Actuator_Value              : RPM;
      -- PID Variables
      Position_Reference          : Constant Float := 0.0;
      Velocity_Reference          : Float;
      Torque_Reference            : Float;
      Position_Error              : Float;
      Velocity_Error              : Float;
      K_PP                        : Constant Float := 1.0;
      K_PV                        : Constant Float := 10.0;
      begin
            Motor_Setup.Calibrate_Motors_If_Required;
            Epoch.Get_Start_Time(Start_Point);
            -- Define next time to run
            Next_Period := Start_Point + Offset;
            loop
                  begin
                        delay until Next_Period; -- Wait for new period 

                        -- START OF EXECUTION

                        Execution_Start := Ada.Real_Time.Clock; 
                        -- Get current angle from accelerometer
                        Gyroscope_SR.Get(Current_Velocity);
                        Accelerometer_SR.Get(Current_Angle);
                        Position_Error := Position_Reference - Current_Angle;
                        Position_Controller(K_PP, Position_Error, Velocity_Reference);
                        -- Get current angle from gyroscope
                        Velocity_Error := Velocity_Reference - Current_Velocity;
                        Velocity_Controller(K_PV, Velocity_Error, Torque_Reference);
                        Map_To_RPM(Torque_Reference, Actuator_Value);
                        -- Set RPM value to protected object
                        Motor_AW.Set(Actuator_Value);
                        -- Define next time to run
                        Next_Period := Next_Period + Period;

                        -- END OF EXECUTION

                        Execution_End := Ada.Real_Time.Clock;
                        -- Calculation of Total Computation Time
                        Total_Computation_Time := Execution_End - Execution_Start;
                        -- Set a new worst-case if current execution time is the largest
                        if Total_Computation_Time > Worst_Case_Computation_Time then
                              Worst_Case_Computation_Time := Total_Computation_Time;
                        end if;
                        Ada.Text_IO.Put_Line("C" & Duration'Image(To_Duration(Worst_Case_Computation_Time)));
                        -- Acceptance Test
                        Acceptance_Test(Actuator_Value_Max, Actuator_Value_Min, Float(Actuator_Value), Total_Computation_Time, Total_Computation_Time_Limit, Recoveryblock_Count);
                  exception
                        when Value_Exceed_Max =>
                              Recoveryblock_Count := Recoveryblock_Count + 1;
                              Actuator_Value := 2000;
                              Motor_AW.Set(Actuator_Value);
                              Acceptance_Test(Actuator_Value_Max, Actuator_Value_Min, Float(Actuator_Value), Total_Computation_Time, Total_Computation_Time_Limit, Recoveryblock_Count);
               
                        when Value_Exceed_Min =>
                              Recoveryblock_Count := Recoveryblock_Count + 1;
                              Actuator_Value := 1000;
                              Motor_AW.Set(Actuator_Value);
                              Acceptance_Test(Actuator_Value_Max, Actuator_Value_Min, Float(Actuator_Value), Total_Computation_Time, Total_Computation_Time_Limit, Recoveryblock_Count);
                  
                        When Excecution_Time_Overun =>
                              Ada.Text_IO.Put_Line("Cascade controller: Execution time error");
                        
                        when Recovery_Block_Overload =>
                              Ada.Text_IO.Put_Line("Cascade controller: Recovery Block Overload");

                        when Unknown_Error =>
                              Ada.Text_IO.Put_Line("Cascade controller: Unknown error!!!");
                  end;
            end loop;
   end Cascade_Controller;

   task body Actuator_Writer is 
      -- Timing Constraints
      Offset                     : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(0);
      Period                     : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(20);
      Next_Period                : Ada.Real_Time.Time;
      Start_Point                : Ada.Real_Time.Time;
      -- We do not wish to write to the motor to early
      Min_Start_Time             : Ada.Real_Time.Time_Span          := Ada.Real_Time.Milliseconds(15);
      -- Worst-Case Computation Time Analysis
      Execution_Start             : Ada.Real_Time.Time;
      Execution_End               : Ada.Real_Time.Time;
      Total_Computation_Time      : Ada.Real_Time.Time_Span;
      Worst_Case_Computation_Time : Ada.Real_Time.Time_Span         := Ada.Real_Time.Milliseconds(0);
      -- Task Specific Variable Declarations
      Actuator_Value             : RPM;
      begin
            Motor_Setup.Calibrate_Motors_If_Required;
            Epoch.Get_Start_Time(Start_Point);
            -- Define next time to run
            Next_Period := Start_Point + Offset;
            loop
                  -- Wait for new period
                  delay until Next_Period + Min_Start_Time; 

                  -- START OF EXECUTION

                  Execution_Start := Ada.Real_Time.Clock; 
                  Motor_AW.Get(Actuator_Value);
                  Next_Period := Next_Period + Period;

                  -- END OF EXECUTION

                  Execution_End := Ada.Real_Time.Clock;   
                  -- Calculation of Total Computation Time
                  Total_Computation_Time := Execution_End - Execution_Start;
                  -- Set a new worst-case if current execution time is the largest
                  if Total_Computation_Time > Worst_Case_Computation_Time then
                  Worst_Case_Computation_Time := Total_Computation_Time;
                  end if;
                  Ada.Text_IO.Put_Line("D" & Duration'Image(To_Duration(Worst_Case_Computation_Time)));
            end loop;
   end Actuator_Writer;
  
end Task_Implementations;
