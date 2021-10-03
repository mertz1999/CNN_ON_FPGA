----------------------------------------------------------------------------------
---                          Relu Activation function
--- Mertz.
--- Tir 1400
--- desc:
--- این طراحی برای تابع رلو هست که میشه به سادگی با بررسی کردن 
--- بیت آخر به خروجی این تابع رسید
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;



entity Relu is
    --- define all ports
    port(
        --- inputs
        result_one   : in signed(13 downto 0);
        result_two   : in signed(13 downto 0);
        result_three : in signed(13 downto 0);
        result_four  : in signed(13 downto 0);

        --- outputs
        relu_one   : out signed(13 downto 0);
        relu_two   : out signed(13 downto 0);
        relu_three : out signed(13 downto 0);
        relu_four  : out signed(13 downto 0)
    );
end Relu;

architecture Behavioral of Relu is

begin
    --- Mux for Filter number one
    WITH result_one(13) SELECT 
        relu_one   <= to_signed(0,14)  WHEN '1',     
                      result_one       WHEN '0',
                      to_signed(0,14)  WHEN others;
    
    --- Mux for Filter number one
    WITH result_two(13) SELECT 
        relu_two   <= to_signed(0,14)  WHEN '1',     
                      result_two       WHEN '0',
                      to_signed(0,14)  WHEN others;
    
    --- Mux for Filter number one
    WITH result_three(13) SELECT 
        relu_three <= to_signed(0,14)  WHEN '1',     
                      result_three     WHEN '0',
                      to_signed(0,14)  WHEN others;
    
    --- Mux for Filter number one
    WITH result_four(13) SELECT 
        relu_four  <= to_signed(0,14)  WHEN '1',     
                      result_four      WHEN '0',
                      to_signed(0,14)  WHEN others;
    
    



end Behavioral;

