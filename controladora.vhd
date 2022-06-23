library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use ieee.numeric_std.all;

entity controladora is
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
     	P_count_rst   : out std_logic; -- reseta o PreÃ§o do refrigerante selecionado
        P_count_ld    : out std_logic; -- permite a leitura da entrad
    	T_count_rst   : out std_logic; -- reseta o Troco calculado
        T_count_ld    : out std_logic; -- permite a leitura da entrad
		F1            : out std_logic;  -- saida refrigerante 1
		F2            : out std_logic;  -- saida refrigerante 2
		LeP1          : out std_logic   -- chave seletora entre P1 ou P2
    );
end controladora;

architecture arch of controladora is
  
  type estados is (inicio, espera,selecionar_quantidade,escolher_refrigerante,atualizar_troco,saida_refrigerante_2,saida_refrigerante_1,esperar_dinheiro_1,esperar_dinheiro_2,calculo_troco_1,calculo_troco_2,calculo_preco_1,calculo_preco_2);
  signal estado_atual : estados; 
  signal proximo_estado : estados;

begin

 sequencial:
 process(reset,clock)is
 
  begin
	if(reset ='1')  then
	estado_atual <= inicio;

      elsif(rising_edge(clock)) then
		estado_atual <= proximo_estado;
		end if;

  end process;
		
  
  combinacional:
	process(estado_atual,I,S1,S2,V_gt_P,Q_gt_zero) is
	
	begin
	     
	     case estado_atual is

		          when inicio =>
				  L_count_rst  <='1';
                  L_count_ld   <='0';
	              V_count_rst  <='1';
                  V_count_ld   <='0';
     	          Q_count_rst  <='1';
                  Q_count_ld   <='0';
            	  P_count_rst  <='1';
                  P_count_ld   <='0';
            	  T_count_rst  <='1';
                  T_count_ld   <='0';
				     F1           <='0';          
		          F2           <='0';           
		          LeP1         <='0'; 
				  proximo_estado<=espera;


				  when espera =>
				  L_count_rst  <='0';
                  L_count_ld   <='0';
	              V_count_rst  <='1';
                  V_count_ld   <='0';
     	          Q_count_rst  <='1';
                  Q_count_ld   <='0';
            	  P_count_rst  <='1';
                  P_count_ld   <='0';
            	  T_count_rst  <='1';
                  T_count_ld   <='0';
				  F1           <='0';          
		          F2           <='0';           
		          LeP1         <='0';   
					 
				  if(I ='1')then
				  proximo_estado<=selecionar_quantidade;
				  else
				  proximo_estado<=espera;
				  end if;
				  

				  when selecionar_quantidade =>
				  L_count_rst  <='0';
                  L_count_ld   <='0';
	              V_count_rst  <='0';
                  V_count_ld   <='0';
     	          Q_count_rst  <='0';
                  Q_count_ld   <='1';
            	  P_count_rst  <='0';
                  P_count_ld   <='0';
            	  T_count_rst  <='0';
                  T_count_ld   <='0';
				  F1           <='0';          
		          F2           <='0';           
		          LeP1         <='0'; 
				  if(Q_gt_zero ='1')then
				  proximo_estado<=escolher_refrigerante;
				  else
				  proximo_estado<=selecionar_quantidade;
				  end if;
				  

				  when escolher_refrigerante =>
				    LeP1         <='0';
				  L_count_rst  <='0';
                  L_count_ld   <='0';
	              V_count_rst  <='0';
                  V_count_ld   <='0';
     	          Q_count_rst  <='0';
                  Q_count_ld   <='0';
            	  P_count_rst  <='0';
                  P_count_ld   <='0';
            	  T_count_rst  <='0';
                  T_count_ld   <='0';
				  F1           <='0';          
		          F2           <='0'; 
				  if ((S1 ='1') and (S2 ='1')) then
				    proximo_estado<=escolher_refrigerante;

				  else
				    proximo_estado<=escolher_refrigerante;
				  end if;
				  
				  if ((S1 ='1') and (S2 ='0'))then
				    proximo_estado<=calculo_preco_1;
				   end if;
					
					if ((S1 ='0') and (S2 ='1'))then
				    proximo_estado<=calculo_preco_2;
				  end if;
				  

				  when calculo_preco_1 =>
				  LeP1         <='0'; 
				  L_count_rst  <='0';
                  L_count_ld   <='0';
	              V_count_rst  <='0';
                  V_count_ld   <='0';
     	          Q_count_rst  <='0';
                  Q_count_ld   <='1';
            	  P_count_rst  <='0';
                  P_count_ld   <='1';
            	  T_count_rst  <='0';
                  T_count_ld   <='0';
				  F1           <='0';          
		          F2           <='0';           
				  proximo_estado<=esperar_dinheiro_1;
				 
				  
				  when calculo_preco_2 =>
				  LeP1         <='1';
				  L_count_rst  <='0';
                  L_count_ld   <='0';
	              V_count_rst  <='0';
                  V_count_ld   <='0';
     	          Q_count_rst  <='0';
                  Q_count_ld   <='1';
            	  P_count_rst  <='0';
                  P_count_ld   <='1';
            	  T_count_rst  <='0';
                  T_count_ld   <='0';
				  F1           <='0';          
		          F2           <='0';           
				  proximo_estado<=esperar_dinheiro_2;
			
				 
                  when esperar_dinheiro_1 =>
				  LeP1         <='0';
				  L_count_rst  <='0';
                  L_count_ld   <='0';
	              V_count_rst  <='0';
                  V_count_ld   <='1';
     	          Q_count_rst  <='0';
                  Q_count_ld   <='0';
            	  P_count_rst  <='0';
                  P_count_ld   <='0';
            	  T_count_rst  <='0';
                  T_count_ld   <='0';
				  F1           <='0';          
		          F2           <='0';
				  if(V_gt_P='1')then
				  proximo_estado<=calculo_troco_1;
				  else
				  proximo_estado<=esperar_dinheiro_1;
				  end if;

            
				  when esperar_dinheiro_2 =>
				  LeP1         <='0';
				  L_count_rst  <='0';
                  L_count_ld   <='0';
	              V_count_rst  <='0';
                  V_count_ld   <='1';
     	          Q_count_rst  <='0';
                  Q_count_ld   <='0';
            	  P_count_rst  <='0';
                  P_count_ld   <='0';
            	  T_count_rst  <='0';
                  T_count_ld   <='0';
				      F1           <='0';          
		            F2           <='0';
					 
				  if(V_gt_P='1')then
				  proximo_estado<=calculo_troco_2;
				  else
				  proximo_estado<=esperar_dinheiro_2;
				  end if;


                  when calculo_troco_1 =>
				  LeP1         <='0';
				  L_count_rst  <='0';
                  L_count_ld   <='0';
	              V_count_rst  <='0';
                  V_count_ld   <='0';
     	          Q_count_rst  <='0';
                  Q_count_ld   <='0';
            	  P_count_rst  <='0';
                  P_count_ld   <='0';
            	  T_count_rst  <='0';
                  T_count_ld   <='1';
				  F1           <='0';          
		          F2           <='0'; 
				  proximo_estado<=saida_refrigerante_1;
				 

				  when calculo_troco_2 =>
				  LeP1         <='0';
				  L_count_rst  <='0';
                  L_count_ld   <='0';
	              V_count_rst  <='0';
                  V_count_ld   <='0';
     	          Q_count_rst  <='0';
                  Q_count_ld   <='0';
            	  P_count_rst  <='0';
                  P_count_ld   <='0';
            	  T_count_rst  <='0';
                  T_count_ld   <='1';
				  F1           <='0';          
		          F2           <='0';  
				  proximo_estado<=saida_refrigerante_2;


                  when saida_refrigerante_1 =>
				  LeP1         <='0';
				  L_count_rst  <='0';
                  L_count_ld   <='0';
	              V_count_rst  <='0';
                  V_count_ld   <='0';
     	          Q_count_rst  <='0';
                  Q_count_ld   <='0';
            	  P_count_rst  <='0';
                  P_count_ld   <='0';
            	  T_count_rst  <='0';
                  T_count_ld   <='0';
				  F1           <='1';          
		          F2           <='0'; 
				  proximo_estado<=atualizar_troco;
				 

                  when saida_refrigerante_2 =>
				  LeP1         <='0';
				  L_count_rst  <='0';
                  L_count_ld   <='0';
	              V_count_rst  <='0';
                  V_count_ld   <='0';
     	          Q_count_rst  <='0';
                  Q_count_ld   <='0';
            	  P_count_rst  <='0';
                  P_count_ld   <='0';
            	  T_count_rst  <='0';
                  T_count_ld   <='0';
				  F1           <='0';          
		          F2           <='1';
				  proximo_estado<=atualizar_troco;
				  

				  when others =>
				  LeP1         <='0';
				  L_count_rst  <='0';
                  L_count_ld   <='1';
	              V_count_rst  <='0';
                  V_count_ld   <='0';
     	          Q_count_rst  <='0';
                  Q_count_ld   <='0';
            	  P_count_rst  <='0';
                  P_count_ld   <='0';
            	  T_count_rst  <='0';
                  T_count_ld   <='0';
				  F1           <='0';          
		          F2           <='0';
				  proximo_estado<=espera;
                 

			end case;
				  
	end process;
				 


  
end arch;