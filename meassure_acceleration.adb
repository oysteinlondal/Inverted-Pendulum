package body Meassure_Acceleration is
	procedure Retrieve_Acceleration (Acc_X, Acc_y : out Float) is
    begin
   		--if Imu.Acc.Read.Available() not true then
		--   raise Acc_Not_Available ;
		--end if;
		--Imu.acc.read(data); 
        X_Coordinate := 9.8;
        Y_Coordinate := 0.0;
        Acc_X        := X_Coordinate;
        Acc_Y        := Y_Coordinate;
	end Retrieve_Acceleration;
end Meassure_Acceleration;
