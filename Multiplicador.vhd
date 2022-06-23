library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Multiplicador is
	
    port (
        A,B		  :   in  std_logic_vector(15 downto 0); 
        Mult    :   out std_logic_vector(31 downto 0)
    ) ;
	 
end entity;

architecture main of Multiplicador is
      signal med : unsigned(31 downto 0);
begin
     
	  
	 med <= to_unsigned((to_integer(unsigned(A))*to_integer(unsigned(B))),32);
    Mult <= std_logic_vector(med);
	  
	  
	  
end architecture;
