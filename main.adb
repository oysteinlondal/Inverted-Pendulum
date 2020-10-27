-- Profiles
pragma Profile(Ravenscar);                               -- Safety-Critical Policy
pragma Task_Dispatching_Policy (FIFO_Within_Priorities); -- Fixed Priority Scheduling
pragma Locking_Policy (Ceiling_Locking);                 -- ICCP 

-- Standard Packages

-- Project-Defined Packages
with Accelorometer_Reader;

procedure main is

begin
    null;
end main;