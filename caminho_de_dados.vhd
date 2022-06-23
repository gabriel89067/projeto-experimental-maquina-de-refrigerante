library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use ieee.numeric_std.all;


entity caminho_de_dados is

    port (
    clock         : in std_logic;  -- entrada do time
    
    L             : out std_logic_vector(31 downto 0);  -- saida do lucro total da maquina 
    L_count_rst   : in std_logic; -- reseta o lucro total da maquina
    L_count_ld    : in std_logic; -- permite a leitura da entrada 

    V             : in std_logic_vector(31 downto 0); -- valor do dinheiro inserido
    V_count_rst   : in std_logic; -- reseta o dinheiro inserido
    V_count_ld    : in std_logic; -- permite a leitura da entrad
 
    Q             : in std_logic_vector(15 downto 0); -- quantidade de refrigerante selecionada
    Q_count_rst   : in std_logic; -- reseta a quantidade de refrigerante selecionada
    Q_count_ld    : in std_logic; -- permite a leitura da entrad
    
    P             : out std_logic_vector(31 downto 0);  -- Preço do refrigerante selecionado
    P_count_rst   : in std_logic; -- reseta o Preço do refrigerante selecionado
    P_count_ld    : in std_logic; -- permite a leitura da entrad

    T             : out std_logic_vector(31 downto 0); -- Troco calculado             
    T_count_rst   : in std_logic; -- reseta o Troco calculado
    T_count_ld    : in std_logic; -- permite a leitura da entrad

    LeP1          : in std_logic; -- chave seletora entre P1 ou P2
    P1            : in std_logic_vector(15 downto 0); -- Preço por ml do refrigerante 1
    P2            : in std_logic_vector(15 downto 0); -- Preço por ml do refrigerante 2

    V_gt_P        : out std_logic;  -- Comparador 32 bit (A>B)
    Q_gt_zero     : out std_logic   -- comparador 16 bit (A>0)
    
    );
end caminho_de_dados;

    architecture union of caminho_de_dados is
       
        component Comparador_16 is
         port(  
            A   : in std_logic_vector(15 downto 0);
            B   : in std_logic_vector(15 downto 0);
            maior   : out std_logic
          ) ;  
        end component;
    

       component Comparador_32 is
        port (
            A   : in std_logic_vector(31 downto 0);
            B   : in std_logic_vector(31 downto 0);
            maior   : out std_logic    
        ) ;
      end component;
   

      component Multiplicador is
        port (
            A,B		  :   in  std_logic_vector(15 downto 0); 
            Mult      :   out std_logic_vector(31 downto 0) 
        ) ;
      end component;
   
      component Mux is
        port (
            In0, In1            : in std_logic_vector(15 downto 0);
            S                   : in std_logic;
            Saida               : out std_logic_vector(15 downto 0) 
        ) ;
      end component;

      component Registrador_16 is
        port (
            clk		:	in	std_logic;							
			rst		:	in	std_logic;
		    ld		:	in	std_logic;	
			D	    :	in  std_logic_vector(15 downto 0);	
			Q		:	out	std_logic_vector(15 downto 0)  
        ) ;
      end component;

      component Registrador_32 is
        port (
            clk		:	in	std_logic;							
			rst		:	in	std_logic;
		    ld	    :	in	std_logic;	
			D	    :	in	std_logic_vector(31 downto 0);	
			Q		:	out	std_logic_vector(31 downto 0)  
        ) ;
      end component;

      component Somador is
        port (
            A	   : in  std_logic_vector(31 downto 0);
            B	   : in  std_logic_vector(31 downto 0);
            Sum   : out  std_logic_vector(31 downto 0) 
        ) ;
      end component;

      component Subtrator is
        port (
            A	   : in  std_logic_vector(31 downto 0);
            B	   : in  std_logic_vector(31 downto 0);
            Sub   : out  std_logic_vector(31 downto 0) 
        ) ;
      end component;

      signal  V_count_out       : std_logic_vector(31 downto 0);
      signal  L_count_out       : std_logic_vector(31 downto 0);
      signal  P_count_out       : std_logic_vector(31 downto 0);
      signal  Q_count_out       : std_logic_vector(15 downto 0);
      signal  Mux_out           : std_logic_vector(15 downto 0);
      signal  Multiplicador_out : std_logic_vector(31 downto 0);
      signal  Somador_out       : std_logic_vector(31 downto 0);
      signal  Subtrator_out     : std_logic_vector(31 downto 0);
      

       begin
    
        IN_Registrador_32_V  : Registrador_32 port map (clock,V_count_rst,V_count_ld,V,V_count_out);
        IN_Registrador_16_Q  : Registrador_16 port map (clock,Q_count_rst,Q_count_ld,Q,Q_count_out);
        IN_Registrador_32_L  : Registrador_32 port map (clock,L_count_rst,L_count_ld,Somador_out,L_count_out);
        IN_Registrador_32_P  : Registrador_32 port map (clock,P_count_rst,P_count_ld,Multiplicador_out,P_count_out);
        IN_Registrador_32_T  : Registrador_32 port map (clock,T_count_rst,T_count_ld,Subtrator_out,T);
        IN_Mux               : Mux port map (P1,P2,LeP1,Mux_out);
        IN_Multiplicador     : Multiplicador port map (Mux_out,Q_count_out,Multiplicador_out);
        IN_Somador           : Somador port map (L_count_out,P_count_out,Somador_out);
        IN_Subtrator         : Subtrator port map (V_count_out,P_count_out,Subtrator_out);
        IN_Comparador_32     : Comparador_32 port map (V_count_out,P_count_out,V_gt_P);
        IN_Comparador_16     : Comparador_16 port map(Q_count_out,"0000000000000000",Q_gt_zero);

        P <= P_count_out; 
        L <= L_count_out;

    end union; 