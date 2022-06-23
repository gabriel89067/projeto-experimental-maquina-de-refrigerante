library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Mux is

    port(
    
    In0, In1            : in std_logic_vector(15 downto 0);
    S                  : in std_logic;
    Saida               : out std_logic_vector(15 downto 0)

    );
   
    end entity Mux;


    architecture main of Mux is
    
    begin
       
      

        Saida <= In0 when S = '0' else
                 In1 ;

    end main ; -- main