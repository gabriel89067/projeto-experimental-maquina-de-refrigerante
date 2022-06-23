library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use ieee.numeric_std.all;

entity maquina_de_refrigerante_tb is
end maquina_de_refrigerante_tb;


    architecture rtl of maquina_de_refrigerante_tb is
       
      component maquina_de_refrigerante is
    port (

      I             : in std_logic; -- inicia maquina
      S1            : in std_logic; -- refrigerante 1 selecionando
      S2            : in std_logic; -- refrigerante 2 selecionando
      clock         : in std_logic; -- entrada do time
      reset         : in std_logic; -- entrada do reset
      F1            : out std_logic;  -- saida refrigerante 1
      F2            : out std_logic;  -- saida refrigerante 2
  
  
      P1            : in std_logic_vector(15 downto 0); -- PreÃ§o por ml do refrigerante 1
      P2            : in std_logic_vector(15 downto 0); -- PreÃ§o por ml do refrigerante 2
      V             : in std_logic_vector(31 downto 0); -- valor do dinheiro inserido
      Q             : in std_logic_vector(15 downto 0); -- quantidade de refrigerante selecionada
      L             : out std_logic_vector(31 downto 0);  -- saida do lucro total da maquina 
      P             : out std_logic_vector(31 downto 0);  -- PreÃ§o do refrigerante selecionado
      T             : out std_logic_vector(31 downto 0) -- Troco calculado 
    );
    end component;
  

        signal clk         :  std_logic; -- entrada do time
        signal rst         :  std_logic; -- entrada do reset 
      --  constant PERIOD     : time := 10 ns;
      --  constant DUTY_CYCLE : real := 0.5;
      --  constant OFFSET     : time := 5 ns;

        signal i             :  std_logic; -- inicia maquina
        signal s1            :  std_logic; -- refrigerante 1 selecionando
        signal s2            :  std_logic; -- refrigerante 2 selecionando
        
        signal f1            :  std_logic;  -- saida refrigerante 1
        signal f2            :  std_logic;  -- saida refrigerante 
        -- signal   t_out  :  std_logic_vector(31 downto 0);
        signal p1            :  std_logic_vector(15 downto 0); -- PreÃƒÂ§o por ml do refrigerante 1
        signal p2            :  std_logic_vector(15 downto 0); -- PreÃƒÂ§o por ml do refrigerante 2
        signal v             :  std_logic_vector(31 downto 0); -- valor do dinheiro inserido
        signal q             :  std_logic_vector(15 downto 0); -- quantidade de refrigerante selecionada
        signal l             :  std_logic_vector(31 downto 0);  -- saida do lucro total da maquina 
        signal p             :  std_logic_vector(31 downto 0);  -- PreÃƒÂ§o do refrigerante selecionado
       
        signal t             :  std_logic_vector(31 downto 0); -- Troco calculado 

       -- file   outputs         : text open write_mode is "outputs.txt";
        --constant max_value      : natural := 4;
       --	constant mim_value		: natural := 1;
       --  signal flag_write      : std_logic:='1'; 


        begin
       
------------------------------------------------------------------------------------
----------------- processo para gerar o sinal de clock 
------------------------------------------------------------------------------------		
       --PROCESS    -- clock process for clock
        --BEGIN
        --   WAIT for OFFSET;
         --   CLOCK_LOOP : LOOP
         --   clk <= '0';
          --      WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
          --      clk <= '1';
          --     WAIT FOR (PERIOD * DUTY_CYCLE);
        -- END LOOP CLOCK_LOOP;
       -- END PROCESS;  

        IN_maquina_de_refrigerante: maquina_de_refrigerante port map(i,s1,s2,clk,rst,f1  ,f2  ,p1 ,p2,v,q, l ,p ,t);
        rst <= '1','0' after 5 ns;
--process(i,p1,p2,q,v,clk,s1,s2)
  --  begin
      
     -- p1 <= "0000000000000101";  -- Pr por ml do refrigerante 1 R$5,00 ----------
     -- p2 <= "0000000000010100";  -- Pre por ml do refrigerante 2 R$20,00 ---------
       
     -- q<= "0000000000000010"; -- quantidade de refrigerante selecionada 2 ml --------
     -- v<= "00000000000000000000100000100101";
      --"00000000000000000000000000000011"after 70 ns,"00000000000000000000000000000011"after 80 ns,"00000000000000000000000000000001"after 90 ns,"00000000000000000000100000100101"after 100 ns ;
     --  clk <= '1';
     --   s1<='0';
     --   s2<='0';
     --   i<='0';
   -- end process;
        ------------------------------------------------------------------------------------
------ processo para gerar os estimulos de escrita do arquivo de saida
------------------------------------------------------------------------------------   
   
 --   escreve_outputs : PROCESS
   -- BEGIN
     --    WAIT FOR (OFFSET + 4*PERIOD);
       --      flag_write <= '1';
			-- for i in mim_value to max_value loop
		       --  wait for PERIOD;
		     --end loop;
             --flag_write <= '0';			
		 --WAIT;
    --END PROCESS escreve_outputs;   
   
-- ------------------------------------------------------------------------------------
-- ------ processo para escriber os dados de saida no arquivo .txt
-- ------------------------------------------------------------------------------------   
   
	 --write_outputs:process
		 --variable linea  : line;
		-- variable output : std_logic_vector (31 downto 0);
	 --begin
	  --   wait until clk ='0';
		-- while true loop
		--	 if (flag_write ='1')then
		--		 output := t_out;
		--		 write(linea,output);
		--		 writeline(outputs,linea);
		--	 end if;
		---	 wait for PERIOD;
		-- end loop; 
	-- end process write_outputs;   	

        end rtl;