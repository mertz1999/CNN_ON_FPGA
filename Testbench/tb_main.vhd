--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

library work;
use work.cnn_types.all;

use ieee.std_logic_textio.all;
use std.textio.all;
 
ENTITY tb_main IS
END tb_main;
 
ARCHITECTURE behavior OF tb_main IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT main
    PORT(
         clk : IN  std_logic;
         wr_data : IN  std_logic_vector(7 downto 0);
         wr_en : IN  std_logic;
         i_rst_sync : IN  std_logic;
         node_one : OUT  signed(21 downto 0);
         node_two : OUT  signed(21 downto 0);
         node_three : OUT  signed(21 downto 0);
         node_four : OUT  signed(21 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal wr_data : std_logic_vector(7 downto 0) := (others => '0');
   signal wr_en : std_logic := '0';
   signal i_rst_sync : std_logic := '0';

 	--Outputs
   signal node_one : signed(21 downto 0);
   signal node_two : signed(21 downto 0);
   signal node_three : signed(21 downto 0);
   signal node_four : signed(21 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1 us;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: main PORT MAP (
          clk => clk,
          wr_data => wr_data,
          wr_en => wr_en,
          i_rst_sync => i_rst_sync,
          node_one => node_one,
          node_two => node_two,
          node_three => node_three,
          node_four => node_four
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   wr_en <= '1';
   -- Stimulus process
   stim_proc: process
      file		input_text	: text open read_mode is "D:\Final_bachelor\FPGA\Final-2\Python-model\inc\image_stream2.txt";
      variable LI1			: line;
      variable LI1_var		: integer;
   begin		
      for j in 1 to 118 loop
         readline(input_text,LI1);
         read(LI1,LI1_var);
         wr_data				<= std_logic_vector(to_signed(LI1_var,8));
         wait for clk_period;
      end loop;

      wait;
   end process;

END;
