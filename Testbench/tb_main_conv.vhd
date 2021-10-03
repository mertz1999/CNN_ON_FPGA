--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

use ieee.std_logic_textio.all;
use std.textio.all;
 
ENTITY tb_main_conv IS
generic(
   g_width : natural := 8;
   g_depth : integer := 10
);
END tb_main_conv;
 
ARCHITECTURE behavior OF tb_main_conv IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT main_conv
    generic(
      g_width : natural ;
      g_depth : integer 
    );
    PORT(
         clk : IN  std_logic;
         wr_data : IN  std_logic_vector(g_width-1 downto 0);
         wr_en : IN  std_logic;
         i_rst_sync   : IN  std_logic;
         result_one   : OUT  signed(13 downto 0);
         result_two   : OUT  signed(13 downto 0);
         result_three : OUT  signed(13 downto 0);
         result_four  : OUT  signed(13 downto 0);
         conv_en      : out std_logic := '0'
        );
    END COMPONENT;
    

   --Inputs
   signal clk        : std_logic := '0';
   signal wr_data    : std_logic_vector(g_width-1 downto 0) := (others => '0');
   signal wr_en      : std_logic := '0';
   signal i_rst_sync : std_logic := '0';

 	--Outputs
   signal result_one   : signed(13 downto 0);
   signal result_two   : signed(13 downto 0);
   signal result_three : signed(13 downto 0);
   signal result_four  : signed(13 downto 0);
   signal conv_en      : std_logic;

   -- Clock period definitions
   constant clk_period : time := 1 us;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: main_conv 
   GENERIC MAP(g_width => g_width, g_depth => g_depth)
   PORT MAP (
          clk => clk,
          wr_data => wr_data,
          wr_en => wr_en,
          i_rst_sync => i_rst_sync,
          result_one   => result_one,
          result_two   => result_two,
          result_three => result_three,
          result_four  => result_four,
          conv_en      => conv_en
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
      file		input_text	: text open read_mode is "D:\Final_bachelor\FPGA\Final-2\Python-model\inc\image_stream.txt";
      variable LI1			: line;
      variable LI1_var		: integer;
   begin		
      for j in 1 to 118 loop
         readline(input_text,LI1);
         read(LI1,LI1_var);
         wr_data				<= std_logic_vector(to_signed(LI1_var,g_width));
         wait for clk_period;
      end loop;

      wait;
   end process;

   -- writing: process(clk)
   --    file 		output_text	: text open write_mode is "D:\Final_bachelor\FPGA\Final-2\Python-model\inc\result_conv.txt";
   --    variable LO1			: line;
   -- begin		
   --    if rising_edge(clk) then
   --       write(LO1, to_integer(result));
   --       writeline(output_text , LO1);
   --    end if;
   -- end process;


END;