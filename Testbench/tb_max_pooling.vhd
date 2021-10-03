--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

library work;
use work.cnn_types.all;
 
ENTITY tb_max_pooling IS
END tb_max_pooling;
 
ARCHITECTURE behavior OF tb_max_pooling IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT max_pooling
    PORT(
         --- input ports
         clk          : in std_logic;
         pool_en      : in std_logic := '0';
         result_one   : in signed(13 downto 0);
         result_two   : in signed(13 downto 0);
         result_three : in signed(13 downto 0);
         result_four  : in signed(13 downto 0);
         
         -- output ports
         pooling_result_one   : out signed(13 downto 0);
         pooling_result_two   : out signed(13 downto 0);
         pooling_result_three : out signed(13 downto 0);
         pooling_result_four  : out signed(13 downto 0);
         pooling_result_en : out state
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal pool_en : std_logic := '0';
   signal result_one : signed(13 downto 0) := (others => '0');
   signal result_two : signed(13 downto 0) := (others => '0');
   signal result_three : signed(13 downto 0) := (others => '0');
   signal result_four : signed(13 downto 0) := (others => '0');

 	--Outputs
   signal pooling_result_one : signed(13 downto 0);
   signal pooling_result_two : signed(13 downto 0);
   signal pooling_result_three : signed(13 downto 0);
   signal pooling_result_four : signed(13 downto 0);
   signal pooling_result_en :  state;

   -- Clock period definitions
   constant clk_period : time := 1 us;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: max_pooling PORT MAP (
          clk => clk,
          pool_en => pool_en,
          result_one => result_one,
          result_two => result_two,
          result_three => result_three,
          result_four => result_four,

          pooling_result_one => pooling_result_one,
          pooling_result_two => pooling_result_two,
          pooling_result_three => pooling_result_three,
          pooling_result_four => pooling_result_four,

          pooling_result_en => pooling_result_en
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   pool_en <= '1';
   -- Stimulus process
   stim_proc: process
   begin		
      for j in 1 to 100 loop
         result_one				<= to_signed(j,14);
         result_two				<= to_signed(j,14);
         result_three			<= to_signed(j,14);
         result_four				<= to_signed(j,14);
         wait for clk_period;
      end loop;

  

      wait;
   end process;

END;
