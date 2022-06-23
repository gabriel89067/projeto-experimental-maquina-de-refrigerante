library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Comparador_16 is

    port(
    
    A   : in std_logic_vector(15 downto 0);
	 B   : in std_logic_vector(15 downto 0);
    maior   : out std_logic
	 

    );
    
    end Comparador_16;
   
  architecture main of Comparador_16 is
  signal A_temp : unsigned(15 downto 0);
  signal B_temp : unsigned(15 downto 0);
  
  begin
  
  A_temp <= unsigned(A);
  B_temp <= unsigned(B);
  
      maior <= '1' when (A_temp > B_temp) else '0';

  end main ; 
