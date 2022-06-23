library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use ieee.numeric_std.all;

entity maquina_de_refrigerante is
    port (

    I             : in std_logic; -- inicia maquina
    S1            : in std_logic; -- refrigerante 1 selecionando
    S2            : in std_logic; -- refrigerante 2 selecionando
    clock         : in std_logic; -- entrada do time
    reset         : in std_logic; -- entrada do reset
    F1            : out std_logic;  -- saida refrigerante 1
	F2            : out std_logic;  -- saida refrigerante 2


    P1            : in std_logic_vector(15 downto 0); -- Preço por ml do refrigerante 1
    P2            : in std_logic_vector(15 downto 0); -- Preço por ml do refrigerante 2
    V             : in std_logic_vector(31 downto 0); -- valor do dinheiro inserido
    Q             : in std_logic_vector(15 downto 0); -- quantidade de refrigerante selecionada
    L             : out std_logic_vector(31 downto 0);  -- saida do lucro total da maquina 
    P             : out std_logic_vector(31 downto 0);  -- Preço do refrigerante selecionado
    T             : out std_logic_vector(31 downto 0) -- Troco calculado             

    );
    end maquina_de_refrigerante;

    architecture rtl of maquina_de_refrigerante is
        signal L_count_rst   : std_logic; -- reseta o lucro total da maquina
        signal L_count_ld    : std_logic; -- permite a leitura da entrada 
	     signal V_count_rst   : std_logic; -- reseta o dinheiro inserido
        signal V_count_ld    : std_logic; -- permite a leitura da entrad
     	  signal Q_count_rst   : std_logic; -- reseta a quantidade de refrigerante selecionada
        signal Q_count_ld    : std_logic; -- permite a leitura da entrad
     	  signal P_count_rst   : std_logic; -- reseta o Preço do refrigerante selecionado
        signal P_count_ld    : std_logic; -- permite a leitura da entrad
    	  signal T_count_rst   : std_logic; -- reseta o Troco calculado
        signal T_count_ld    : std_logic; -- permite a leitura da entrad
        signal V_gt_P        : std_logic; -- Comparador 32 bit (A>B)
        signal Q_gt_zero     : std_logic; -- comparador 16 bit (A>0)
        signal LeP1          : std_logic; -- chave seletora entre P1 ou P2
     
        component controladora is
            port (
                I             : in std_logic; -- inicia maquina
        S1            : in std_logic; -- refrigerante 1 selecionando
		S2            : in std_logic; -- refrigerante 2 selecionando
        V_gt_P        : in std_logic; -- Comparador 32 bit (A>B)
        Q_gt_zero     : in std_logic; -- comparador 16 bit (A>0)
		clock         : in std_logic; -- entrada do time
	    reset         : in std_logic; -- entrada do reset
		
		L_count_rst   : out std_logic; -- reseta o lucro total da maquina
        L_count_ld    : out std_logic; -- permite a leitura da entrada 
	    V_count_rst   : out std_logic; -- reseta o dinheiro inserido
        V_count_ld    : out std_logic; -- permite a leitura da entrad
     	Q_count_rst   : out std_logic; -- reseta a quantidade de refrigerante selecionada
        Q_count_ld    : out std_logic; -- permite a leitura da entrad
     	P_count_rst   : out std_logic; -- reseta o Preço do refrigerante selecionado
        P_count_ld    : out std_logic; -- permite a leitura da entrad
    	T_count_rst   : out std_logic; -- reseta o Troco calculado
        T_count_ld    : out std_logic; -- permite a leitura da entrad
		F1            : out std_logic;  -- saida refrigerante 1
		F2            : out std_logic;  -- saida refrigerante 2
		LeP1          : out std_logic   -- chave seletora entre P1 ou P2
            );
        end component;

        component caminho_de_dados is

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
        end component;
    
    begin
	 

        IN_controladora : controladora port map ( I, S1, S2, V_gt_P, Q_gt_zero, clock, reset, L_count_rst, L_count_ld,
                                               V_count_rst, V_count_ld, Q_count_rst, Q_count_ld, P_count_rst, 
                                               P_count_ld, T_count_rst, T_count_ld, F1, F2, LeP1);
    
        IN_caminho_de_dados : caminho_de_dados port map(clock, L, L_count_rst, L_count_ld, V, V_count_rst, V_count_ld, 
                                                       Q, Q_count_rst, Q_count_ld, P, P_count_rst, P_count_ld, 
                                                       T, T_count_rst, T_count_ld, LeP1, P1, P2, V_gt_P, Q_gt_zero);

    end rtl ; -- rtl
    