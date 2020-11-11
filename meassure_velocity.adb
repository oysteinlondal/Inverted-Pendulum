package body Meassure_Velocity is
	procedure Retrieve_Velocity (Velocity_Z : out Float) is
    begin
		--if Imu.Gyro.Read.Available() not true then
		--   raise Gyro_Not_Available ;
		--end if;
		--Imu.gyro.read(data); 
		--z_gyro = gyro.data(z_angle);
		--return z_gyro;
        Z_Coordinate := 2.0;
        Velocity_Z   := Z_Coordinate;
	end Retrieve_Velocity;
end Meassure_Velocity;
