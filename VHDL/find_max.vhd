----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

library work;
use work.cnn_types.all;

entity find_max is
    port(
        --- input ports
        max_en    : in state;
        Reg1      : in signed(13 downto 0);
        Reg2      : in signed(13 downto 0);
        Reg11     : in signed(13 downto 0);
        Reg12     : in signed(13 downto 0);

        --- output ports
        max_value : out signed(13 downto 0) := (others => '0')
    );
end find_max;

architecture Behavioral of find_max is
    
begin

core : process(max_en, reg1, reg2, reg11, reg12)
    begin
        if max_en = H_ok then
            if reg1 >= reg2 and reg1 >= reg11 and reg1 >= reg12 then
                max_value <= reg1;
            elsif reg2 >= reg1 and reg2 >= reg11 and reg2 >= reg12 then
                max_value <= reg2;
            elsif reg11 >= reg1 and reg11 >= reg2 and reg11 >= reg12 then
                max_value <= reg11;
            elsif reg12 >= reg1 and reg12 >= reg11 and reg12 >= reg2 then
                max_value <= reg12;
            else
                max_value <= reg1;
            end if;
        else 
            max_value <= to_signed(0,14);
        end if;
end process;
end Behavioral;

