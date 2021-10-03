LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

use ieee.std_logic_textio.all;
use std.textio.all;

ENTITY tb_three_FIFO IS
generic(
   g_width : natural := 8;
   g_depth : integer := 10
);
END tb_three_FIFO;
 
ARCHITECTURE behavior OF tb_three_FIFO IS 
 
 
    COMPONENT three_FIFO
    generic(
      g_width : natural ;
      g_depth : integer
     );
    PORT(
         clk : IN  std_logic;
         wr_data : IN  std_logic_vector(g_width-1 downto 0);
         wr_en : IN  std_logic;
         i_rst_sync : IN  std_logic;
         a00 : OUT  std_logic_vector(g_width-1 downto 0);
         a01 : OUT  std_logic_vector(g_width-1 downto 0);
         a02 : OUT  std_logic_vector(g_width-1 downto 0);
         a10 : OUT  std_logic_vector(g_width-1 downto 0);
         a11 : OUT  std_logic_vector(g_width-1 downto 0);
         a12 : OUT  std_logic_vector(g_width-1 downto 0);
         a20 : OUT  std_logic_vector(g_width-1 downto 0);
         a21 : OUT  std_logic_vector(g_width-1 downto 0);
         a22 : OUT  std_logic_vector(g_width-1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal wr_data : std_logic_vector(g_width-1 downto 0) := (others => '0');
   signal wr_en : std_logic := '0';
   signal i_rst_sync : std_logic := '0';

 	--Outputs
   signal a00 : std_logic_vector(g_width-1 downto 0);
   signal a01 : std_logic_vector(g_width-1 downto 0);
   signal a02 : std_logic_vector(g_width-1 downto 0);
   signal a10 : std_logic_vector(g_width-1 downto 0);
   signal a11 : std_logic_vector(g_width-1 downto 0);
   signal a12 : std_logic_vector(g_width-1 downto 0);
   signal a20 : std_logic_vector(g_width-1 downto 0);
   signal a21 : std_logic_vector(g_width-1 downto 0);
   signal a22 : std_logic_vector(g_width-1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: three_FIFO 
   GENERIC MAP(g_width => g_width, g_depth => g_depth)
   PORT MAP (
          clk => clk,
          wr_data => wr_data,
          wr_en => wr_en,
          i_rst_sync => i_rst_sync,
          a00 => a00,
          a01 => a01,
          a02 => a02,
          a10 => a10,
          a11 => a11,
          a12 => a12,
          a20 => a20,
          a21 => a21,
          a22 => a22
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

 
   -- Stimulus process
   -- stim_proc: process
   -- begin		
   --    for j in 1 to 100 loop
   --       wr_data <= std_logic_vector(to_unsigned(j,g_width));
   --       wait for clk_period;
   --    end loop;

   --    wait;
   -- end process;


   -- Stimulus process
   wr_en <= '1';
   stim_proc: process
   file		input_text	: text open read_mode is "D:\FPGA\CNN_FPGA\python\temp.txt";
   variable LI1			: line;
   variable LI1_var		: integer;
   begin		
      for j in 1 to 117 loop
         readline(input_text,LI1);
         read(LI1,LI1_var);
         wr_data				<= std_logic_vector(to_unsigned(LI1_var,g_width));
         wait for clk_period;
      end loop;

      wait;
   end process;

END;
