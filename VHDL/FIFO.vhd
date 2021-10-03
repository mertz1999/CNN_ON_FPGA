-------------------------------------------------------------
--             Design a FIFO component in VHDL
-- Reza Tanakizadeh
--
------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity FIFO is
    --- Generic Values
    generic(
        g_width : natural := 4;
        g_depth : integer := 5
    );

    --- Define all ports
    port(
        --- Reset and Clock
        i_rst_sync : in std_logic;
        i_clk      : in std_logic;

        --- FIFO Write Interface
        i_wr_en   : in std_logic;
        i_wr_data : in std_logic_vector(g_width-1 downto 0);

        --- Reading Data
        o_rd_data_1,o_rd_data_2,o_rd_data_3 : out std_logic_vector(g_width-1 downto 0)
    );
end FIFO;

architecture Behavioral of FIFO is
    --- Define an array type 
    type t_fifo_data is array (0 to g_depth+1) of std_logic_vector(g_width-1 downto 0);
    signal r_fifo_data : t_fifo_data := (others => (others => '0'));

    --- Define indexes
    signal r_wr_index : integer range 0 to g_depth-1 := 0;
    


begin
    
    p_control : process (i_clk)
        begin
            if rising_edge(i_clk) then
                if i_rst_sync = '1' then
                    r_wr_index   <= 0;
                else
                    --- traking write index
                    if (i_wr_en = '1') then
                        if r_wr_index = g_depth-1 then
                            r_wr_index <= 0;
                        else
                            r_wr_index <= r_wr_index + 1;
                        end if;
                    end if;

                    --- pushing data
                    if i_wr_en = '1' then
                        r_fifo_data(r_wr_index) <= i_wr_data;
                    end if; 
                end if; --- for sync reset
            end if;     --- for rising edge
            
        end process p_control;
    
    o_rd_data_1  <= r_fifo_data(r_wr_index);
    o_rd_data_2  <= r_fifo_data(r_wr_index+1);
    o_rd_data_3  <= r_fifo_data(r_wr_index+2);

end Behavioral;