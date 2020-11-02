package body Meassure_Velocity is
	procedure Retrieve_Velocity (Velocity_Z : out Float) is
    begin
		--Imu.gyro.read(data); 
		--z_gyro = gyro.data(z_angle);
		--return z_gyro;
        Z_Coordinate := 13.0;
        Velocity_Z   := Z_Coordinate;
	end Retrieve_Velocity;
end Meassure_Velocity;