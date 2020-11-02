-- Profiles
--pragma Profile(Ravenscar);                               -- Safety-Critical Policy
pragma Task_Dispatching_Policy (FIFO_Within_Priorities); -- Fixed Priority Scheduling
pragma Locking_Policy (Ceiling_Locking);                 -- ICCP 
-- Standard Packages

-- Project-Defined Packages
with Task_Implementations;
-- Main 
procedure main is

begin
    null;
end main;