--with Imu.Library; use Imu.Library

package Meassure_Velocity is
    procedure Retrieve_Velocity (Velocity_Z : out Float);
private
    X_Coordinate : Float;
    Y_Coordinate : Float;
    Z_Coordinate : Float;
end Meassure_Velocity;